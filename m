Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733140AbfJYHSQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 03:18:16 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P7H5LZ107588
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 03:18:15 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vusu8v6k2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 03:18:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 25 Oct 2019 08:18:11 +0100
Subject: Re: [RFC 07/37] KVM: s390: protvirt: Secure memory is not mergeable
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-8-frankja@linux.ibm.com>
 <f80519a0-a8da-1a98-c450-b81dfcf2e897@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 25 Oct 2019 09:18:04 +0200
MIME-Version: 1.0
In-Reply-To: <f80519a0-a8da-1a98-c450-b81dfcf2e897@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SoRVdOudvxYJlOh2AU47xiMDhOFyxbUU3"
Message-Id: <3f7cc352-56d8-f0c7-3cb2-7278b8262035@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SoRVdOudvxYJlOh2AU47xiMDhOFyxbUU3
Content-Type: multipart/mixed; boundary="q88LVDfuCAAcL3xALLcX8QyiLWyOxcWlA"

--q88LVDfuCAAcL3xALLcX8QyiLWyOxcWlA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/24/19 6:07 PM, David Hildenbrand wrote:
> On 24.10.19 13:40, Janosch Frank wrote:
>> KSM will not work on secure pages, because when the kernel reads a
>> secure page, it will be encrypted and hence no two pages will look the=

>> same.
>>
>> Let's mark the guest pages as unmergeable when we transition to secure=

>> mode.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/gmap.h |  1 +
>>   arch/s390/kvm/kvm-s390.c     |  6 ++++++
>>   arch/s390/mm/gmap.c          | 28 ++++++++++++++++++----------
>>   3 files changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap=
=2Eh
>> index 6efc0b501227..eab6a2ec3599 100644
>> --- a/arch/s390/include/asm/gmap.h
>> +++ b/arch/s390/include/asm/gmap.h
>> @@ -145,4 +145,5 @@ int gmap_mprotect_notify(struct gmap *, unsigned l=
ong start,
>>  =20
>>   void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_=
bitmap[4],
>>   			     unsigned long gaddr, unsigned long vmaddr);
>> +int gmap_mark_unmergeable(void);
>>   #endif /* _ASM_S390_GMAP_H */
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 924132d92782..d1ba12f857e7 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2176,6 +2176,12 @@ static int kvm_s390_handle_pv(struct kvm *kvm, =
struct kvm_pv_cmd *cmd)
>>   		if (r)
>>   			break;
>>  =20
>> +		down_write(&current->mm->mmap_sem);
>> +		r =3D gmap_mark_unmergeable();
>> +		up_write(&current->mm->mmap_sem);
>> +		if (r)
>> +			break;
>> +
>>   		mutex_lock(&kvm->lock);
>>   		kvm_s390_vcpu_block_all(kvm);
>>   		/* FMT 4 SIE needs esca */
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index edcdca97e85e..bf365a09f900 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -2548,6 +2548,23 @@ int s390_enable_sie(void)
>>   }
>>   EXPORT_SYMBOL_GPL(s390_enable_sie);
>>  =20
>> +int gmap_mark_unmergeable(void)
>> +{
>> +	struct mm_struct *mm =3D current->mm;
>> +	struct vm_area_struct *vma;
>> +
>> +	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
>> +		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
>> +				MADV_UNMERGEABLE, &vma->vm_flags)) {
>> +			mm->context.uses_skeys =3D 0;
>=20
> That skey setting does not make too much sense when coming via=20
> kvm_s390_handle_pv(). handle that in the caller?

Hmm, I think the name of that variable is just plain wrong.
It should be "can_use_skeys" or "uses_unmergeable" (which would fit
better into the mm context anyway) and then we could add a
kvm->arch.uses_skeys to tell that we actually used them for migration
checks, etc..

I had long discussions with Martin over these variable names a long time
ago..



--q88LVDfuCAAcL3xALLcX8QyiLWyOxcWlA--

--SoRVdOudvxYJlOh2AU47xiMDhOFyxbUU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2yoawACgkQ41TmuOI4
ufinRhAAj5YSe7xor8wefoJDpOGf/HBEfbVUj7oyeZ46N++V5/lj8MKobrACYN5d
a/RlUD9gu0zdCnViOjOTi5Y/pFqjLcK0bkB6RCDJvmB80bnmmLk3odyWys88ShKI
0mECo0ygoZnpQt6wcD1kxuZ1rDk5A6GW58Qom/c9aHXh1CTpqkXgaOJlIHY+8HbM
3SpCLG1caRuAJWIwVxLPctEARLEZwgBgvHAUyh8kGrlwLk8akegKauW6RmUYjduf
sSj8wZldklzf36vIM/zaWBSUgxAMBbJcozHV9S79YYBCWWhuUZJ8uFF5iWCPAhnT
kjsfqFoS3vZy5hCcclRBnvinB4tXvC0ckbZ3kwmXGu8Asr2kAv6GyQVSQzos4T1S
OowEo1LkKvakG9dgrCcR6m33NsgohZ4lC6yGYiHpCjAkXgTBJ96fYeh89BBrJoCQ
E+bdEIIHDTjc/h61dc8swcpkMssTfRjjRFOsTgdZrf9aIZ0iGqH8xDiTaO85BezX
TC7O8sOkyM1MFvkCfQqvrxhsq+m5AOeDp7wm8Hsv07kslZHkXCIVTje7swK6u5Pj
gP7aLTt/nnQb2WNO7Bz8TaozwbtphUh70TkYds1Qi+XmObhiLPTNppJaJda2on50
dvvvuKr+UVpE6rC8ZP7D+4JoCKNzFt8vLNS/yaTMBQYP9h4GWNs=
=wKEB
-----END PGP SIGNATURE-----

--SoRVdOudvxYJlOh2AU47xiMDhOFyxbUU3--
