#!/usr/bin/env python3

import os, sys
from pathlib import Path

import gnupg
import click
import ruamel.yaml
from dotty_dict import dotty

from ruamel.yaml import YAML

class PillarConfig(object):

    def __init__(self, pillar_file):
        """
        """

        self.pillar_file = pillar_file
        self.content = self.load()

    def load(self):
        """
        """

        # if file doesn't exists return a empty dictionary
        if not os.path.exists(self.pillar_file):
            content = {}

        # else we load the configuration
        else:
            with open(self.pillar_file) as f:
                content = ruamel.yaml.safe_load(f.read())

        # return a dotty dictionary for our content
        return dotty(content)

    def keys(self, content='', prefix=[]):
        """
        """

        if not content:
            content = self.content

        for k, v in content.items():
            if isinstance(v, dict):
                self.keys(v, prefix + [k])
            else:
                print('.'.join(prefix + [k]))

    def set(self, key, value, encrypt=False):
        """
        """

        if encrypt:
            gpg = gnupg.GPG(homedir='gpgkeys/', binary='gpg1')
            value = str(gpg.encrypt(value, '7770891AB567D6DA2347620ECB2A239F1173CE3D'))

        self.content[key] = value

    def get(self, key, decrypt=False):
        """
        """

        value = self.content[key]

        if decrypt:
            gpg = gnupg.GPG(homedir='gpgkeys/', binary='gpg1')
            value = str(gpg.decrypt(value))

        return value

    def save(self):
        """
        """

        output = Path(self.pillar_file)

        # save rendered yaml to output file
        yaml = ruamel.yaml.YAML()
        yaml.indent(mapping=4, sequence=4, offset=2)
        yaml.preserve_quotes = True
        yaml.dump(self.content.to_dict(), output)



@click.group()
def cli():
    pass


@click.command()
@click.option('-p', '--pillar_file', required=True, help='Pillar file to read')
def keys(pillar_file, content='', prefix=[]):
    """
    """

    # create new pillar content off config
    pillar = PillarConfig(pillar_file)

    # print out keys
    pillar.keys()


@click.command()
@click.option('-p', '--pillar_file', required=True, help='Pillar file to read')
@click.option('-k', '--key', required=True, help='Pillar key to display')
@click.option('-d', '--decrypt', is_flag=True, help='Decrypt value')
def get(pillar_file, key, decrypt):
    """
    """

    # create new pillar content off config
    pillar = PillarConfig(pillar_file)

    print(pillar.get(key, decrypt))


@click.command()
@click.option('-p', '--pillar_file', required=True, help='Pillar file to read')
@click.option('-k', '--key', required=True, help='Pillar key')
@click.option('-v', '--value', required=True, help='Pillar value')
@click.option('-e', '--encrypt', is_flag=True, help='Encrypt value')
def set(pillar_file, key, value, encrypt):
    """
    """

    # create new pillar content off config
    pillar = PillarConfig(pillar_file)

    pillar.set(key, value, encrypt)
    pillar.save()


if __name__ == '__main__':

    cli.add_command(keys)
    cli.add_command(get)
    cli.add_command(set)

    # execute cli
    cli()
