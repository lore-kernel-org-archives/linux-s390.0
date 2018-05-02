From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 02 May 2018 09:07:40 +0000
Subject: Re: [PATCH v1 0/3] KVM: s390: remaining cleanups
Message-Id: <46843a94-b722-f692-e8ee-d0d87e2fb922@linux.ibm.com>
In-Reply-To: <4a631bc2-7bb4-effc-f7e8-29bde9ddae49@linux.ibm.com>
References: <4a631bc2-7bb4-effc-f7e8-29bde9ddae49@linux.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--rptpLQAWnuCmw7qoXi0CRBFSWh9f6qxxW"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rptpLQAWnuCmw7qoXi0CRBFSWh9f6qxxW
Content-Type: multipart/mixed; boundary="mzjGUzL6qokbtycQBTqhpUY0oTqDIWT1r";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger
 <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>
Message-ID: <46843a94-b722-f692-e8ee-d0d87e2fb922@linux.ibm.com>
Subject: Re: [PATCH v1 0/3] KVM: s390: remaining cleanups
References: <20180427123613.20624-1-david@redhat.com>
In-Reply-To: <20180427123613.20624-1-david@redhat.com>

--mzjGUzL6qokbtycQBTqhpUY0oTqDIWT1r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.04.2018 14:36, David Hildenbrand wrote:
> Some cleanups that were lying around for way too long on my hard drive.=

>=20
> 2 and 3 were already part of "[PATCH RFC 0/6] KVM: s390: Multiple-epoch=

> facility fixes"
>=20

Thanks, tested and applied!

Patch #2 will not be a perfect copy of your mail, as I had to add a
context line for my skf control patch that was forgotten when we did the
last pull request.


--mzjGUzL6qokbtycQBTqhpUY0oTqDIWT1r--

--rptpLQAWnuCmw7qoXi0CRBFSWh9f6qxxW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa6X/cAAoJEBcO/8Q8ZEV5HhsP/0tFy6zCbaozcMLJx+lXwHxw
hHeZLFWYa6+/LQOO2TVH0+1almRq+h3O9RoqvHt280CsB+Twb6I0b36T6OCA7jwA
w0EaIQf4lRJLIv8TU6nw4bToAp7y0vwXOd9toXorc1odt4NZRl5NqMyE73R4YnuC
O34UciVF7Dp4j94ty5yMkzGhVZxSTTuVidNjUmBjZJ14rW5sCS+77p/mx79mDyTK
XRUHSActPC2Crlh/hYwX+6Hzcht0X8HVGEYZLYugNv1UR8xBmJ1kfF4ag4o4gMdl
lRZ9JdGxwGhHUddpqOtDG7cd0mD+0J88RsXn6hFcJJ/7o+eiX3ZtY2uIvysNle+7
jVBGBHTdsigVpmNl1/gzFp+x3wXa00USZkQ+/gcmdoGzrLFpItTm7fq+gxKEEA7j
jlsxYDyfXnmot7mnQHYI0Bxb4YeBV6OoPulhyZa1yxWtJAt+IQ1szJ2izBOYDViX
2sd/hN1Z4/p5g/JaL5J5T/cSUArvgIJ5v6dJLLaR/fyZq+1t/i1AhXiwttJUXQc7
o2WhASrtu8G95nfidZAmBnVgC0agObn5rm1kxTkCfu6paMd6tm93I7T6dnLtolTU
6kZkU6mZtCqtpUWUzTOr2XzQrlaPRHRa3f+BNPsDvwwEBfRoY3uiSiGMjrN3HlDw
CP3bOpz4XE4X0fi7kn7v
=mb+Z
-----END PGP SIGNATURE-----

--rptpLQAWnuCmw7qoXi0CRBFSWh9f6qxxW--
