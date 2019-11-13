Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbfKMPyh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 10:54:37 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADFfTGG117654
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 10:54:36 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8krcb0km-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 10:54:35 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 13 Nov 2019 15:54:34 -0000
Subject: Re: [RFC v2] KVM: s390: protvirt: Secure memory is not mergeable
References: <20191024114059.102802-8-frankja@linux.ibm.com>
 <20191025082446.754-1-frankja@linux.ibm.com>
 <621d0191-1490-d8d3-c7be-11466243f63f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 13 Nov 2019 16:54:29 +0100
MIME-Version: 1.0
In-Reply-To: <621d0191-1490-d8d3-c7be-11466243f63f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C67lVgB9KcMhHeTJn6Zy1ej9JfO0gnp6B"
Message-Id: <9c89ff61-bc62-9ff6-0c1c-f1a6ba69a2fc@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C67lVgB9KcMhHeTJn6Zy1ej9JfO0gnp6B
Content-Type: multipart/mixed; boundary="GvEdhkrLa1VnXk1hv1ISpLYeXgbJzk1sq"

--GvEdhkrLa1VnXk1hv1ISpLYeXgbJzk1sq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/13/19 1:23 PM, Thomas Huth wrote:
> On 25/10/2019 10.24, Janosch Frank wrote:
>> KSM will not work on secure pages, because when the kernel reads a
>> secure page, it will be encrypted and hence no two pages will look the=

>> same.
>>
>> Let's mark the guest pages as unmergeable when we transition to secure=

>> mode.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
> [...]
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index edcdca97e85e..faecdf81abdb 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -2548,6 +2548,23 @@ int s390_enable_sie(void)
>>  }
>>  EXPORT_SYMBOL_GPL(s390_enable_sie);
>> =20
>> +int gmap_mark_unmergeable(void)
>> +{
>> +	struct mm_struct *mm =3D current->mm;
>> +	struct vm_area_struct *vma;
>> +
>> +
>=20
> Please remove one of the two empty lines.

Already gone

>=20
>> +	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
>> +		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
>> +				MADV_UNMERGEABLE, &vma->vm_flags))
>> +			return -ENOMEM;
>> +	}
>> +	mm->def_flags &=3D ~VM_MERGEABLE;
>> +

Also this one was removed

>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
>> +
> [...]
>=20
> Apart from the cosmetic nit, the patch looks fine to me.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20
Thanks!



--GvEdhkrLa1VnXk1hv1ISpLYeXgbJzk1sq--

--C67lVgB9KcMhHeTJn6Zy1ej9JfO0gnp6B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3MJzUACgkQ41TmuOI4
ufhdpA//fJwk03H4vKIEyUPdoKf8E3Oz2wv+Ejh/aMs7+5tNTd1K/Oic/7onvKNm
j+MyhUyC/BkjYC5fyVwB+Daac+YoR8KRZ8Mb86lsICQqbClRxRN3+yiKnk5/OTCw
zkEr/4wdvEnl/LbX9r7p/D1zmF7e5fYPX6uJF110hIBXc7VzujMZ4U0htXbSjt1a
XKVm6icP9KmtZ6o1Natf9cr4hEo9Ni5wprZLLTlqXhK/1xlUzGv6fY6/ugmIyQaC
4NQcUjA2mixW0nsZ5ddfEYoGgYxBs38nyfWBwf6Ckaml8lfI/+9cdU1dzdW4LKMX
p1xtvfgR/acjxNZlIjsC8P7Zn94jcI6FturPvC1HZWraD1FSpf1CcfUYF4zF1uQD
e4K34H6thUSrtItq5GEt2SITq+JMSbVs7C6KPP3vAn5Vk8dAIwgPur7A3pbU0cGB
hO3LE84QW4ruYsg/pGShbzq/lfB6wmIi64vnrnsRu3XK3VKtoz4X9pFkRiT/lBZv
RvDROg/CYzqlO8LxJkhLjThana8h3fHvET2wZ7pZjwwOQv40Y3CMFGL3y9E1lUgU
dlvTZ8VcHEtM+5AjeZe/05L5g13aNp4VkIBBlpUDsvZqUTA7d4XgnXQqzxgeKS2E
AmXcZLmJ4vzsDHafN2eOyHI5Q06W/JEtSU5H4Bsrfz4xabJa3vs=
=CT0p
-----END PGP SIGNATURE-----

--C67lVgB9KcMhHeTJn6Zy1ej9JfO0gnp6B--
