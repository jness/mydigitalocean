# GPG Keys

We use gpg keys to encrypt certain pillar data:

https://docs.saltstack.com/en/latest/ref/renderers/all/salt.renderers.gpg.html

# Requirements

  * GNUPG Version of 1.x

This can be done on OSX with brew:

```
brew install gnupg@1.4
```

# Create new key pair

To create a new key pair run the following with **homedir** pointed and the repo's **gpgkeys** directory,
be sure to name the key **saltstack**:

```
gpg1 --gen-key --homedir gpgkeys/
```

# Create a secret

Use the same **homedir** to encrypt your secret:

```
echo -n "supersecret" | gpg1 --armor --batch --trust-model always --encrypt --homedir gpgkeys/ -r saltstack
```
