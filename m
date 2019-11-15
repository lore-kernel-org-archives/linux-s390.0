Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbfKOIuZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 03:50:25 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAF8kZ03085343
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 03:50:24 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nunx6sa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 03:50:23 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 15 Nov 2019 08:50:21 -0000
Subject: Re: [PATCH] Fixup sida bouncing
References: <ad0f9b90-3ce4-c2d2-b661-635fe439f7e2@redhat.com>
 <20191114162153.25349-1-frankja@linux.ibm.com>
 <016cea87-9097-ca8b-2d19-9f69cdff3af6@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 15 Nov 2019 09:50:16 +0100
MIME-Version: 1.0
In-Reply-To: <016cea87-9097-ca8b-2d19-9f69cdff3af6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MuO48CUThFw9wy8z6dfRU4EQBFZ79hOSI"
Message-Id: <87488647-8a49-d555-e3fc-3b218dd022d1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MuO48CUThFw9wy8z6dfRU4EQBFZ79hOSI
Content-Type: multipart/mixed; boundary="lT37JmWqnRYov4lxqNJkl1KEBcA24mlnw"

--lT37JmWqnRYov4lxqNJkl1KEBcA24mlnw
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/19 9:19 AM, Thomas Huth wrote:
> On 14/11/2019 17.21, Janosch Frank wrote:
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 0fa7c6d9ed0e..9820fde04887 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4432,13 +4432,21 @@ static long kvm_s390_guest_mem_op(struct kvm_v=
cpu *vcpu,
>>  	if (mop->size > MEM_OP_MAX_SIZE)
>>  		return -E2BIG;
>> =20
>> -	/* Protected guests move instruction data over the satellite
>> +	/*
>> +	 * Protected guests move instruction data over the satellite
>>  	 * block which has its own size limit
>>  	 */
>>  	if (kvm_s390_pv_is_protected(vcpu->kvm) &&
>> -	    mop->size > ((vcpu->arch.sie_block->sidad & 0x0f) + 1) * PAGE_SI=
ZE)
>> +	    mop->size > ((vcpu->arch.sie_block->sidad & 0xff) + 1) * PAGE_SI=
ZE)
>>  		return -E2BIG;
>> =20
>> +	/* We can currently only offset into the one SIDA page. */
>> +	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +		mop->gaddr &=3D ~PAGE_MASK;
>> +		if (mop->gaddr + mop->size > PAGE_SIZE)
>> +			return -EINVAL;
>> +	}
>> +
>>  	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
>>  		tmpbuf =3D vmalloc(mop->size);
>>  		if (!tmpbuf)
>> @@ -4451,6 +4459,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcp=
u *vcpu,
>>  	case KVM_S390_MEMOP_LOGICAL_READ:
>>  		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>>  			if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +				/* We can always copy into the SIDA */
>>  				r =3D 0;
>>  				break;
>>  			}
>> @@ -4461,8 +4470,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcp=
u *vcpu,
>>  		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>>  			r =3D 0;
>>  			if (copy_to_user(uaddr, (void *)vcpu->arch.sie_block->sidad +
>> -					 (mop->gaddr & ~PAGE_MASK),
>> -					 mop->size))
>> +					 mop->gaddr, mop->size))
>>  				r =3D -EFAULT;
>>  			break;
>>  		}
>> @@ -4485,8 +4493,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcp=
u *vcpu,
>>  		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>>  			r =3D 0;
>>  			if (copy_from_user((void *)vcpu->arch.sie_block->sidad +
>> -					   (mop->gaddr & ~PAGE_MASK), uaddr,
>> -					   mop->size))
>> +					   mop->gaddr, uaddr, mop->size))
>>  				r =3D -EFAULT;
>>  			break;
>>  		}
>>
>=20
> That looks better, indeed.
>=20
> Still, is there a way you could also verify that gaddr references the
> right page that is mirrored in the sidad?
>=20
>  Thomas
>=20

I'm not completely sure if I understand your question correctly.
Checking that is not possible here without also looking at the
instruction bytecode and register contents which would make this patch
ridiculously large with no real benefit.


--lT37JmWqnRYov4lxqNJkl1KEBcA24mlnw--

--MuO48CUThFw9wy8z6dfRU4EQBFZ79hOSI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3OZsgACgkQ41TmuOI4
ufjwCA/+LnraTuBnM7cN+Q/BH8hA7Ks2kdYsEsnLo/T7qQQWFDepOmKkePSwTmna
oHBXccxws09lCD6if9PqxNJ5hNXOI9Er8WPqgdbKVCngpbZEMOMRZiLsSl8AqpJN
8qrhylIisEy960pV6t9uSf5jiDsA61hdBqBxTb/oZv0hR5jtAeRXF/bvTGc73KHb
vKB234nOyyR2ImMxef/0THoH7QiUtQ5FFdAEsXH1NeWQnsNt6XvlC2jjO5b3EOYN
xsTIqPizmhcj+CvKuihXww4nTQvJemGqEBmABrP3Q7xBvexfL8ssTwqbf64GJZqS
4p67yJOuPyCZMpQ1t+kAED3l8UTFECa0UYy6B829CXGIUlPm078V6GsfkaPc52WB
WBswH8D1l0D8maPUWJGttoypYAxJohlYD/r2rRa2irvSpJnMMce361MYqet6n9sZ
Ri2pKVwPb7lwiEyTEKxlN+3vomsT48IRbptbbT0PUGhBLfl9mSTYyXyANwl/X7xx
X+06mT8XlPVbXKVEc2/Pzmcjll9xShoREYumu+STRG18ceLLzKxkuHU+Kxt4nbev
efiWWVXNWXHrSnLxnp86eUgVCDDVV/Lfxi8wv6kQXSnl9gxB/7DRdjsEukwfoLxG
tKy5glMifV7gPMryBimmsRiNdcdcvB2I71+NbtQE3VLcTJete8E=
=0tfE
-----END PGP SIGNATURE-----

--MuO48CUThFw9wy8z6dfRU4EQBFZ79hOSI--
