Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729605AbgCKOEI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 10:04:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BDv2uh028248
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 10:04:07 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yq05uvbyd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 10:04:03 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 11 Mar 2020 14:03:53 -0000
Subject: Re: [PATCH 2/2] selftests: KVM: s390: fix format strings for access
 reg test
References: <20200311131056.140016-1-borntraeger@de.ibm.com>
 <20200311131056.140016-3-borntraeger@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 11 Mar 2020 15:03:47 +0100
MIME-Version: 1.0
In-Reply-To: <20200311131056.140016-3-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FtYHVWxGF4i4fyYmn6XNr160bU2gKJN5p"
Message-Id: <6c8ac2c1-a4c3-41be-6e9c-0c82f2d7a59d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FtYHVWxGF4i4fyYmn6XNr160bU2gKJN5p
Content-Type: multipart/mixed; boundary="V2XtRiHB3P40G2YCxf6I3QqKiP9h6KvwE"

--V2XtRiHB3P40G2YCxf6I3QqKiP9h6KvwE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/11/20 2:10 PM, Christian Borntraeger wrote:
> acrs are 32 bit and not 64 bit.
>=20
> Reported-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/s390x/sync_regs_test.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools=
/testing/selftests/kvm/s390x/sync_regs_test.c
> index b705637ca14b..70a56580042b 100644
> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> @@ -42,6 +42,13 @@ static void guest_code(void)
>  		    " values did not match: 0x%llx, 0x%llx\n", \
>  		    left->reg, right->reg)
> =20
> +#define REG_COMPARE32(reg) \
> +	TEST_ASSERT(left->reg =3D=3D right->reg, \
> +		    "Register " #reg \
> +		    " values did not match: 0x%x, 0x%x\n", \
> +		    left->reg, right->reg)
> +
> +

One \n too much?

>  static void compare_regs(struct kvm_regs *left, struct kvm_sync_regs *=
right)
>  {
>  	int i;
> @@ -55,7 +62,7 @@ static void compare_sregs(struct kvm_sregs *left, str=
uct kvm_sync_regs *right)
>  	int i;
> =20
>  	for (i =3D 0; i < 16; i++)
> -		REG_COMPARE(acrs[i]);
> +		REG_COMPARE32(acrs[i]);
> =20
>  	for (i =3D 0; i < 16; i++)
>  		REG_COMPARE(crs[i]);
> @@ -155,7 +162,7 @@ int main(int argc, char *argv[])
>  		    "r11 sync regs value incorrect 0x%llx.",
>  		    run->s.regs.gprs[11]);
>  	TEST_ASSERT(run->s.regs.acrs[0]  =3D=3D 1 << 11,
> -		    "acr0 sync regs value incorrect 0x%llx.",
> +		    "acr0 sync regs value incorrect 0x%x.",
>  		    run->s.regs.acrs[0]);
> =20
>  	vcpu_regs_get(vm, VCPU_ID, &regs);
>=20



--V2XtRiHB3P40G2YCxf6I3QqKiP9h6KvwE--

--FtYHVWxGF4i4fyYmn6XNr160bU2gKJN5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5o78MACgkQ41TmuOI4
ufjM/xAAlbSaU5GzAW+zZ7CczqdTv7dgcP8W8d/A7RTuuJeHfTxiEgTYyUGkvgMw
bKtakOaZVUJNKSCHuEiLz15C7qfWcLz1rNj30dORybc0VykNDbgqyG+HlYCjorrt
KYJBezhe7JXbI2kkL6xPbwpb4qOR308v67EiCrilv1drltuQpYqHNgnLMuDaeHeZ
jAtRUsLs13Yx9If0pkVC/4EuY6eaL/VKeyNKYH41Yw9tzn9T6e8Wcd+Y2wywlMV3
xIHSvHoiw3HJBc9J1895iPHI3qenUE2Be1jbe55xpvvFZL0Wx7lsnCxMxpaKmtSH
u+qfzvVmItgxd82nnjmCBMO6j3ZGwDWsAQnthW20Rlf8yC1lEpj/xLjXexnhk8Df
sV/zDPujAofk4uyph1UeyeSCTi1wLWIzkE2hlXf07EaJ/KtPsCm8zUHcpu+fD92m
iR+kHDpOIx+BFkYQhySDvJcRypa2gxZ+U53X0Vv4p33xYAPHoytttKSmRUqsbabd
KEzHdc91ymxX2UNrJqPqLKpMnW21tO4yAq56Bhqj+IdSJ13H4K1ebxJAzPq7PbTK
Rih3ewfFansILy7KKAFqBk5VMMb/0ptEAKOsclCt3lMsxelEoJfP1WxqG7l2Vs+9
YlD+1ufw1Jh319kDi/vSrk1Sxe9qK3Hfxiw12noG6DAc/FwFoUQ=
=GQCE
-----END PGP SIGNATURE-----

--FtYHVWxGF4i4fyYmn6XNr160bU2gKJN5p--
