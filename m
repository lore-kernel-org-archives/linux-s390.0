From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] KVM: s390: use switch vs jump table in priv.c
Date: Thu, 8 Feb 2018 10:16:33 +0100
Message-ID: <cbed3710-ac13-d538-5a33-b1ec128b3cb9@linux.vnet.ibm.com>
References: <20180206112127.19014-1-borntraeger@de.ibm.com>
 <20180206112127.19014-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GTmJpRWKcqUqaULhWS3kQcfjwCWWhyXe3"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180206112127.19014-2-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GTmJpRWKcqUqaULhWS3kQcfjwCWWhyXe3
Content-Type: multipart/mixed; boundary="kJ939YTlvta6GYHacNEIJ7IWAPL1PX0s5";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
Message-ID: <cbed3710-ac13-d538-5a33-b1ec128b3cb9@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] KVM: s390: use switch vs jump table in priv.c
References: <20180206112127.19014-1-borntraeger@de.ibm.com>
 <20180206112127.19014-2-borntraeger@de.ibm.com>
In-Reply-To: <20180206112127.19014-2-borntraeger@de.ibm.com>

--kJ939YTlvta6GYHacNEIJ7IWAPL1PX0s5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.02.2018 12:21, Christian Borntraeger wrote:
> instead of having huge jump tables for function selection,
> lets use normal switch/case statements for the instruction
> handlers in priv.c
>=20
> bloat-o-meter shows that the saving are even bigger than
> just the removed jump tables.
>=20
> add/remove: 0/11 grow/shrink: 8/0 up/down: 1934/-10246 (-8312)
> Function                                     old     new   delta
> kvm_s390_handle_b2                            42     958    +916
> handle_iske                                  178     558    +380
> handle_rrbe                                  178     546    +368
> kvm_s390_handle_b9                            42     222    +180
> kvm_s390_handle_01                            42      74     +32
> kvm_s390_handle_eb                            42      70     +28
> handle_sckpf                                 176     204     +28
> handle_lctlg                                 628     630      +2
> handle_ptff                                   36       -     -36
> handle_sckpf.part                             78       -     -78
> handle_epsw                                  154       -    -154
> handle_stfl                                  316       -    -316
> handle_rrbe.part                             470       -    -470
> handle_iske.part                             482       -    -482
> handle_io_inst                               518       -    -518
> x01_handlers                                2048       -   -2048
> eb_handlers                                 2048       -   -2048
> b9_handlers                                 2048       -   -2048
> b2_handlers                                 2048       -   -2048
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>

> -
>  int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
>  {
> -	intercept_handler_t handler;
> -
> -	/*
> -	 * A lot of B2 instructions are priviledged. Here we check for
> -	 * the privileged ones, that we can handle in the kernel.
> -	 * Anything else goes to userspace.
> -	 */

Shall we move that to kvm_handle_sie_intercept in a more general way?
Something like:

Here we handle all privileged and performance critical
instructions/interceptions everything else gets handled by userspace via
EOPNOTSUPP.


--kJ939YTlvta6GYHacNEIJ7IWAPL1PX0s5--

--GTmJpRWKcqUqaULhWS3kQcfjwCWWhyXe3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJafBVxAAoJEBcO/8Q8ZEV5OGUP/jfEBHVzGWUbnLyUV1lwWnf0
avMuxHk9zj0d9pHn+lwReqI7ymbkO9Gn1fIBV+hgVGWqpjYl6t9ziumXkc0eLjYX
AfmyIEjAJOC2UPuQFxo54aZJDvK53t9lEFENKGgi3XIGVEQLJSlnrM5BzHKFX7v8
4PTf+YhnNXCWYW3Bv+8wis17gQFrU160wv/NlQ2AXOdzYP3qlLBydzhNBdwGG1Ce
nfXSEwnVEfZHg6hqgAN3X/R1250ZjTNm4xIUTrQXdXE0hEZ2/2V3u9+kCQ7FyErj
Y9LXL9WA+QmNMF/UTMYbd+Ys8mLH8cyms+okj/94ww/TF501GU43gwoo6ilyRfEn
dR3dEfIFwYn+4qbKVlvrnwiWbbCiN+9U9rx0tbktzV/cQURCOxLZayvlAxoqSRDd
VHxhzG4KSX5UwQTsm1srxNd/n0gV/ZA9K+ckAtxhMlyWzNiFmLs65kGkEhAiQfVt
PFcKTXlbS80XlUx1XLjISCoMKhUIXeviRvr5zAimLzmYs2gCCkg/5gc20QdK3AwO
RapidljcHTpZuCxMr/OPb3rbj/QK+mf89lWS7Er6t5dVq7Nz4ZJk12scIloG1jMC
HoCrbth28QfBB4h7BLBxSg8ItuZUqwq18VylMFlkBE670fKNVt9bbLieDp6P+iQ9
qNEWzhfPefsRPkTaSRBg
=Um7m
-----END PGP SIGNATURE-----

--GTmJpRWKcqUqaULhWS3kQcfjwCWWhyXe3--
