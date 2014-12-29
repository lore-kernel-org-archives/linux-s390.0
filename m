From: Ben Hutchings <ben@decadent.org.uk>
Date: Mon, 29 Dec 2014 18:54:15 +0000
Subject: [stable] 3215 fixes for 3.16 and earlier
Message-Id: <1419879255.5686.31.camel@decadent.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--=-FZny5iNNY+7CqbmGb3Hv"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


--=-FZny5iNNY+7CqbmGb3Hv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I cherry-picked these commits from 3.17 for Debian's 3.16 branch, but
they should also apply to some earlier versions:

commit 26d766c60f4ea08cd14f0f3435a6db3d6cc2ae96
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Tue Jul 15 17:53:12 2014 +0200

    s390/3215: fix hanging console issue
[Stephen reported this against 3.10 initially]

commit e512d56c799517f33b301d81e9a5e0ebf30c2d1e
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Wed Aug 13 12:01:30 2014 +0200

    s390/3215: fix tty output containing tabs
[the commit message mentions a regression in 2.6.31]

Ben.

--=20
Ben Hutchings
Anthony's Law of Force: Don't force it, get a larger hammer.

--=-FZny5iNNY+7CqbmGb3Hv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVKGjXOe/yOyVhhEJAQpTmBAAzJZroGHQhAcadsnhtKCaoCk2Pn9iKKVe
yPAaWYr5ufBCVT76XSmmdGe3eJmqH+PTDiH9gdOXID3McixlT3h2EZOm62r0kynr
SsMChQ6538bCYFr2CY/0PtLHIu2C+bkKUUsSwkSA79HGUwf7Fopjf9wSmgb3RiKg
ILRiw1TAJbK3onSNncPoV5eFklUcJ3XmgQSK23wBVCMFA4ME5KNvYiINIlYHlPPp
jM3p5dMkrKK5onBaN3S4gMKX/+e6f27qMVH6njskqyoTxrDcPZRlCKbiHLspGWQZ
m3F9VM0qQGnGUfVClYa24NrN7mkZSTHW6BfKZwWxjKZw1O8S3DDSiWJsW6RrK/jI
3yQbFNBTULUdAjbXmt36w4231js89Vby7UKxKM8P0AVnaTbmjCHt4tMnBLyMp61f
SQcKW++E5whbk7hT5qWW4B0drXZbY+GaVwzZporjyxTKgzBUvY+MYV7YcCtkLT1H
bA3iWCosfqVJMCxaMKJcaXuNDgRoMQCLid7y4ShUyfA/rKXrYCN8Av+gsiFi7FgU
NMVqYNQmbOINbV9TBJ8mC+qTPtO4tfy8V3CzXNf/gPhLxJU2Q6zOa43d8kl0wlkH
O/jiJi7/mPRSWC8DM5mzPZ7fIcYry94C8+VSgE2RBW2tdWKaGLyp7f/pIhdOuxcQ
yAoB1xzg6R0=
=SyHN
-----END PGP SIGNATURE-----

--=-FZny5iNNY+7CqbmGb3Hv--
