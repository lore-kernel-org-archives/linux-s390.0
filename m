Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725835AbgAJHOb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 02:14:31 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00A7DH5l010078
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 02:14:30 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xef1u0c9v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 02:14:29 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 10 Jan 2020 07:14:28 -0000
Subject: Re: [PATCH v4] KVM: s390: Add new reset vcpu API
References: <20200109155602.18985-1-frankja@linux.ibm.com>
 <20200109180841.6843cb92.cohuck@redhat.com>
 <f79b523e-f3e8-95b8-c242-1e7ca0083012@linux.ibm.com>
 <f18955c0-4002-c494-b14e-1b9733aad20e@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 10 Jan 2020 08:14:23 +0100
MIME-Version: 1.0
In-Reply-To: <f18955c0-4002-c494-b14e-1b9733aad20e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AqH1wuTRzmS75vwvntMdCDwO6DiXpSWSb"
Message-Id: <c0049bfb-9516-a382-c69c-0693cb0fbfda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AqH1wuTRzmS75vwvntMdCDwO6DiXpSWSb
Content-Type: multipart/mixed; boundary="ROCfofvATjlT9lp6GFcdErWzQ269k0nhI"

--ROCfofvATjlT9lp6GFcdErWzQ269k0nhI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/10/20 8:03 AM, Thomas Huth wrote:
> On 09/01/2020 18.51, Janosch Frank wrote:
>> On 1/9/20 6:08 PM, Cornelia Huck wrote:
>>> On Thu,  9 Jan 2020 10:56:01 -0500
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>
>>>> The architecture states that we need to reset local IRQs for all CPU=

>>>> resets. Because the old reset interface did not support the normal C=
PU
>>>> reset we never did that on a normal reset.
>>>>
>>>> Let's implement an interface for the missing normal and clear resets=

>>>> and reset all local IRQs, registers and control structures as stated=

>>>> in the architecture.
>>>>
>>>> Userspace might already reset the registers via the vcpu run struct,=

>>>> but as we need the interface for the interrupt clearing part anyway,=

>>>> we implement the resets fully and don't rely on userspace to reset t=
he
>>>> rest.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>
>>>> I dropped the reviews, as I changed quite a lot. =20
>>>>
>>>> Keep in mind, that now we'll need a new parameter in normal and
>>>> initial reset for protected virtualization to indicate that we need =
to
>>>> do the reset via the UV call. The Ultravisor does only accept the
>>>> needed reset, not any subset resets.
>>>
>>> In the interface, or externally?
>>
>> ?
>>
>>>
>>> [Apologies, but the details of the protected virt stuff are no longer=

>>> in my cache.
>> Reworded explanation:
>> I can't use a fallthrough, because the UV will reject the normal reset=

>> if we do an initial reset (same goes for the clear reset). To address
>> this issue, I added a boolean to the normal and initial reset function=
s
>> which tells the function if it was called directly or was called becau=
se
>> of the fallthrough.
>>
>> Only if called directly a UV call for the reset is done, that way we c=
an
>> keep the fallthrough.
>=20
> Sounds complicated. And do we need the fallthrough stuff here at all?
> What about doing something like:

That would work and I thought about it, it just comes down to taste :-)
I don't have any strong feelings for a specific implementation.

>=20
> static int kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
> {
> 	...
> }
>=20
> static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
> {
> 	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
> 	...
> }
>=20
> static int kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
> {
> 	kvm_arch_vcpu_ioctl_initial_reset(vcpu);
> 	...
> }
>=20
> ...
>=20
> 	case KVM_S390_CLEAR_RESET:
> 		r =3D kvm_arch_vcpu_ioctl_clear_reset(vcpu);
> 		if (!r && protected) {
> 			r =3D uv_cmd_nodata(...,
>  				UVC_CMD_CPU_RESET_CLEAR, ...);
> 		}
> 		break;
>  	case KVM_S390_INITIAL_RESET:
>  		r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
> 		if (!r && protected) {
> 			r =3D uv_cmd_nodata(...,
>  				UVC_CMD_CPU_RESET_INITIAL, ...);
> 		}
> 	case KVM_S390_NORMAL_RESET:
> 		r =3D kvm_arch_vcpu_ioctl_normal_reset(vcpu);
> 		if (!r && protected) {
> 			r =3D uv_cmd_nodata(...,
>  				UVC_CMD_CPU_RESET, ...);
> 		}
>  		break;
>=20
> ... or does that not work due to some other constraints that I've misse=
d?
>=20
>  Thomas
>=20



--ROCfofvATjlT9lp6GFcdErWzQ269k0nhI--

--AqH1wuTRzmS75vwvntMdCDwO6DiXpSWSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4YJE8ACgkQ41TmuOI4
ufjcqA/+InBBT1PKzfrVe7smdEC70krE1wjBP2yuGeIEx2DXVEFOQjhZHYIFKW5y
DkVfdl3h+JU9m90Xl+qXtYdgol2pqpxq7/MfJW0lQwkcmwKaWADcSO7M+s6FSgQ6
zt/JI+rXUR7DNRbB/IJE15f8TcOn5ZHH+fsrpqlZ0cU1yk8CdwMdZpebWptY50l0
O/2DNQcix2AqsrQIaAInRylRrW6WB9yekpZfXJ4I7qyF+5KoIlsfqVVpsVb+UgGV
vCzSVBKtg+y3kbY5P6gAZNEPvIN58xRqIOjsNz+hTg9CAezaKMsoFXaYoLPqGbOJ
2LzI1ztQ9etXF4FbA0KMLsmNKbAW+qW/gVFFARuoyAXkNkDg1kc55lgez6wFV9Yt
leHJJJuaoL+0iUzRxLXZoy/Hcljgd4KwRHETvDFpCv4fs1afQ3+hDM5pNZPZFYd9
AEidNM1NhEhsq6xoIrR3yNXMMqYUzvh7PCDLkjl/YBPBBlgw5lv9cEPuLfs3xKyc
qiDBbWdQ4mJ3hM+Bx73CFEZjPv5STxLim0fzFImTGZDNsb+Q0nC8a2Glt3Xlz4y4
qyvacycQVlZDLlBMcbXFVq0r2OsKO3LRiB9saohQfznIzQ1WC+at38cEbsN/fGFb
6ZnDxRMPF4hu4wK+lckEJ6sig37Wjf1vbf8EFJbEcDaN2LSsKt8=
=zU4D
-----END PGP SIGNATURE-----

--AqH1wuTRzmS75vwvntMdCDwO6DiXpSWSb--
