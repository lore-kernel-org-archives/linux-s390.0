Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726847AbgBQPiY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:38:24 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HFW7ev032529
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:38:23 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6dnsrfw2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:38:23 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 17 Feb 2020 15:38:21 -0000
Subject: Re: [PATCH v2 20/42] KVM: S390: protvirt: Introduce instruction data
 area bounce buffer
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-21-borntraeger@de.ibm.com>
 <ad84934a-3d18-d56e-5658-1d8b8292f6b3@redhat.com>
 <d16b7ba2-38fc-5128-bd40-587d96e7936f@linux.ibm.com>
 <f98d702f-1e71-c051-6bd0-efb639658822@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 17 Feb 2020 16:38:13 +0100
MIME-Version: 1.0
In-Reply-To: <f98d702f-1e71-c051-6bd0-efb639658822@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PxVEJGBXDqaTjsKXym4MNK2zGI1jn7SFx"
Message-Id: <17ed7342-0bf9-2697-8475-813de72d30b1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PxVEJGBXDqaTjsKXym4MNK2zGI1jn7SFx
Content-Type: multipart/mixed; boundary="02GUYYd1Ws0ow40DslifhwNU77OMKBRK0"

--02GUYYd1Ws0ow40DslifhwNU77OMKBRK0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/17/20 4:00 PM, Christian Borntraeger wrote:
>=20
>=20
> On 17.02.20 15:47, Janosch Frank wrote:
>> On 2/17/20 12:08 PM, David Hildenbrand wrote:
>>>> @@ -4460,6 +4489,10 @@ static long kvm_s390_guest_mem_op(struct kvm_=
vcpu *vcpu,
>>>> =20
>>>>  	switch (mop->op) {
>>>>  	case KVM_S390_MEMOP_LOGICAL_READ:
>>>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>>>> +			r =3D -EINVAL;
>>>> +			break;
>>>> +		}
>>>
>>> Could we have a possible race with disabling code, especially while
>>> concurrently freeing? (sorry if I ask again, there was just a flood o=
f
>>> emails)
>=20
> see my other reply. Hopefully fixed soon.[...]
>=20
>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>> index 207915488502..0fdee1bc3798 100644
>>>> --- a/include/uapi/linux/kvm.h
>>>> +++ b/include/uapi/linux/kvm.h
>>>> @@ -475,11 +475,15 @@ struct kvm_s390_mem_op {
>>>>  	__u32 op;		/* type of operation */
>>>>  	__u64 buf;		/* buffer in userspace */
>>>>  	__u8 ar;		/* the access register number */
>>>> -	__u8 reserved[31];	/* should be set to 0 */
>>>> +	__u8 reserved21[3];	/* should be set to 0 */
>>>> +	__u32 sida_offset;	/* offset into the sida */
>>>> +	__u8 reserved28[24];	/* should be set to 0 */
>>>>  };
>>>
>>> As discussed, I'd prefer an overlaying layout for the sida, as the ar=

>>> does not make any sense (correct me if I'm wrong :) )
>>
>> That wouldn't work, because we still check mop->ar < 16 in
>> kvm_s390_guest_mem_op(). Also we currently check mop contents twice
>> because we overload mem_op() with the SIDA operations.
>>
>> Using a separate IOCTL is cleaner...
>=20
> I would rather use the current patch instead of adding a new ioctl.
>=20

Well, then I'd suggest moving the normal memop ops into an own function
and also move the ar check into there.


--02GUYYd1Ws0ow40DslifhwNU77OMKBRK0--

--PxVEJGBXDqaTjsKXym4MNK2zGI1jn7SFx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5Ks2UACgkQ41TmuOI4
ufhKuxAAsO2ZBbJEip0Fp9U503WSqbKx33pab/DktprmCihGIdaTRn+FD3g/iRh2
lWbRFSjT3yE9FfY1xI+geBb+hP7fym3GEVZDr599sbzJU1V1TvaTEwWWIGcRRoOq
eJp+31+GMin0HCzK7+IAlJ8ZQ/Somn7mQ9tnnZgY6UanzHg0u3Ua2farEsB4ZElZ
Z5dnB+xiqqkmhezsNHNAKgKvHeSNlBuq5BZRK+zgVFahDiZENDtZl/ZI7fTAsU0K
vqIiyikiAIla7tz12NLijk35C/A3QkkwoEqvFFecikazZxwH8NReyrlnqc6C5I0/
F1VgAHQwBmxaZDygBNEC3mxWMcTD/78lSZ/OPunnE5nrEUKqT0wGc7gvessvxmHM
5f0Fequc5QqO9hkKqeBVGoJtnFIJJ8Bi+HeRZb50/1X7bp/6XYkhGorIL1Gu5fgo
y2iObT78hZ6tN0ywrO2mr0yFyn/VmevkQpGNJGQeM9rHTqJPAOg5tKltlvUhywIk
mUwB/7SmT5lncx8rw4FcpVdicFHqu8Pt0Qfr0c2hNkdWNDRX97AaZfclCyT3yII+
ZapdPB/BxK/ZT2lv41YHANpsWReCpMO2XGeemXDnFRg16MhX90b8ZpUuRssXfYgZ
RpEvESwcrVdGwBCkT99gWtBAMkn7Z0tO5qA/isdL8za/jed2W3o=
=1eVJ
-----END PGP SIGNATURE-----

--PxVEJGBXDqaTjsKXym4MNK2zGI1jn7SFx--
