Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 11 Mar 2020 09:01:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: Fixes tag needs some work in the kvms390-fixes tree
Message-ID: <20200311090115.3967bbc6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kv.9uJJpUfaryogAyL3K1zT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, KVM <kvm@vger.kernel.org>, S390 <linux-s390@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

--Sig_/kv.9uJJpUfaryogAyL3K1zT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b5de9eede579 ("KVM: s390: Also reset registers in sync regs for initial c=
pu reset")

Fixes tag

  Fixes: 7de3f1423ff ("KVM: s390: Add new reset vcpu API")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/kv.9uJJpUfaryogAyL3K1zT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5oDisACgkQAVBC80lX
0GzYaAf9FXBdN/sPL0m1wS/M8NvQrp0wWqykM2mze0kNV+wY77eqasWuk3dSkCZQ
YOWpjCN/T6FTBwJpiNLZMtgoKYOKFwkPToNXjCNkl+3sXrp/8xhKREmnobTSpqyP
XWhIzMfqyXRn5/5gWg44M/pVIE5KIDeDxZzeU4tbcDCCsoHOeqkdne1n7KOkRk+L
yTw1hgzfqPeT6uegHLvSwgO1K1XwLDZagZJrPzdMgr5wGvMMEe6J4gk7msoXBpia
3n+gZjDjDeYb8erVrRxqR7niqGb7vIPeeKkP4PNVKxnVoIg2N0/kLrQHHvnZGEaU
prhFRX7EBNh0WELfnGmQDRa/L3c75Q==
=IiMa
-----END PGP SIGNATURE-----

--Sig_/kv.9uJJpUfaryogAyL3K1zT--
