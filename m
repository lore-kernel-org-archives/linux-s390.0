From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 00/16] KVM/s390: Hugetlbfs enablement
Date: Wed, 14 Feb 2018 16:01:25 +0100
Message-ID: <70de883f-4120-1b36-fb0f-5b940b05aab4@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <16d92e45-97bc-fbbd-55e7-36da8c1a6d73@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z0gVph7RAHHtQOrVDTziEKKkEo5inzznO"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <16d92e45-97bc-fbbd-55e7-36da8c1a6d73@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z0gVph7RAHHtQOrVDTziEKKkEo5inzznO
Content-Type: multipart/mixed; boundary="e554SMCDpHqCbSXTaywpiSSej5RWhf2Eb";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <70de883f-4120-1b36-fb0f-5b940b05aab4@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 00/16] KVM/s390: Hugetlbfs enablement
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <16d92e45-97bc-fbbd-55e7-36da8c1a6d73@redhat.com>
In-Reply-To: <16d92e45-97bc-fbbd-55e7-36da8c1a6d73@redhat.com>

--e554SMCDpHqCbSXTaywpiSSej5RWhf2Eb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.02.2018 15:30, David Hildenbrand wrote:
> On 09.02.2018 10:34, Janosch Frank wrote:
>> Since the z10 s390 does support 1M pages, but whereas hugetlbfs
>> support was added quite fast, KVM always used standard 4k pages for
>> guest backings.
>>
>> This patchset adds full support for 1M huge page backings for s390
>> KVM guests. I.e. we also support VSIE (nested vms) for these guests
>> and are therefore able to run all combinations of backings for all
>> layers of guests.
>>
>> When running a VSIE guest in a huge page backed guest, we need to
>> split some huge pages to be able to set granular protection. This way
>> we avoid a prot/unprot cycle if prefixes and VSIE pages containing
>> level 3 gmap DAT tables share the same segment, as the prefix has to
>> be accessible at all times and the VSIE page has to be write
>> protected.
>>
>> Branch:
>> git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git hlp_vs=
ie
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/=
?h=3Dhlp_vsie
>>
>=20
> A general proposal: We will have split PMDs with fake PGSTE. This is
> nasty but needed. I think we should hinder virtualization from making
> use of these. Just like we already do for vSIE.
>=20
> Should we make the KVM_CAP_S390_HPAGE a configuration option?
>=20
> Without it being set, don't allow mapping huge pages into the GMAP.
> Everything as usual.
>=20
> With it being set (by user space when it thinks we need huge pages),
> allow mapping huge pages into the GMAP AND
> - Explicitly disable CMMA. Right now we trust on user space to do the
>   right thing. ecb2 &=3D ~ECB2_CMMA
> - Disable PFMFI -> ecb2 &=3D ~ECB2_PFMFI
> - Disable SKF by setting scb->ictl |=3D ICTL_ISKE | ICTL_SSKE | ICTL_RR=
BE
>=20
> So user space has to explicitly indicate and allow huge pages. This wil=
l
> result in all instructions that touch the PGSTE getting intercepted, so=

> we can properly work on the huge PMDs instead.

My only concern here is:
Can this coexist with the cpumodels in a coordinated way?


--e554SMCDpHqCbSXTaywpiSSej5RWhf2Eb--

--Z0gVph7RAHHtQOrVDTziEKKkEo5inzznO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJahE9FAAoJEBcO/8Q8ZEV57e0P/igoVhkhJr4f+Kx6O/DYqgGC
MStzIxcJOq4nnSIimm60L2aXD/Kxb3/LN/Ei0/ocvQPCe37vkGt//cKI0xFYN7jB
JR1xkJzW1tWZVWbosi5rwXJXZpsZvSzKsJ65gZpsAY3OHUr8oi0jBXgrZ68XWM1W
wEQnQs7BpT/cdO1p5IdXfG42NUgbbjK67dRdabAm7CuEW1CmFy+JgR3ukwxkc8QC
GGhqCWXdSMzemjfEtcBxFNDM+Ov6PPkJ3VJPeFjZ0+ggQ+Qo437OyAwUtIZfRNT8
z/wQdOwDXn6Dt8HNGINv4qBCDJX/9+/lHi/o9TkQOfgjzDkThuHbQPJY2xQY6kvH
vR6Niqin78MW0WRGBeg225vT1qXWm3PrggmHIPmsuZp4hTwohVUQ3pCVGL2z25pn
epaCrFXA6DfKDs+1yWVMB3vrycD6npEYVz7Ekx1dFZJklVx04qmmxpLy7ydZ1Ruf
eThbhcZG5SZup822dh1SPGHjmlNz/tdDcdp8Jfe8eEGwnJWvIrD7ZFyMyMGVTGU8
qg8Su0WNTfdO20gK5lYFYOSBl5LUTIff3YEACZywBovcN7ckZqHTkwtgHZXPlDVV
02qenRGyJOWKx90zi7MR3fgx+MQSBhX9JsiFp1rA4qI4akPp+8lSfhsivYjkCZP2
XQHRclwiLWQCmlWdwAKU
=FxXN
-----END PGP SIGNATURE-----

--Z0gVph7RAHHtQOrVDTziEKKkEo5inzznO--
