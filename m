Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727089AbfKOKBZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:01:25 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAF9waUO087259
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 05:01:24 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nux88aj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 05:01:24 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 15 Nov 2019 10:01:22 -0000
Subject: Re: [RFC 26/37] KVM: s390: protvirt: Only sync fmt4 registers
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-27-frankja@linux.ibm.com>
 <197c1218-3171-3e22-caf8-47cdab58caf8@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 15 Nov 2019 11:01:16 +0100
MIME-Version: 1.0
In-Reply-To: <197c1218-3171-3e22-caf8-47cdab58caf8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PdhOTjLoZjYXjs1szoQtZlknVfAmDU2P3"
Message-Id: <c89c28a9-15f9-0a40-4815-4f50883c93d3@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PdhOTjLoZjYXjs1szoQtZlknVfAmDU2P3
Content-Type: multipart/mixed; boundary="1guMIYcNAznUAlPhQ2sQsZhbgu0Qy4zZn"

--1guMIYcNAznUAlPhQ2sQsZhbgu0Qy4zZn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/19 10:02 AM, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> A lot of the registers are controlled by the Ultravisor and never
>> visible to KVM. Also some registers are overlayed, like gbea is with
>> sidad, which might leak data to userspace.
>>
>> Hence we sync a minimal set of registers for both SIE formats and then=

>> check and sync format 2 registers if necessary.
>>
>> Also we disable set/get one reg for the same reason. It's an old
>> interface anyway.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 138 +++++++++++++++++++++++---------------=
-
>>  1 file changed, 82 insertions(+), 56 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 17a78774c617..f623c64aeade 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2997,7 +2997,8 @@ static void kvm_s390_vcpu_initial_reset(struct k=
vm_vcpu *vcpu)
>>  	/* make sure the new fpc will be lazily loaded */
>>  	save_fpu_regs();
>>  	current->thread.fpu.fpc =3D 0;
>> -	vcpu->arch.sie_block->gbea =3D 1;
>> +	if (!kvm_s390_pv_is_protected(vcpu->kvm))
>> +		vcpu->arch.sie_block->gbea =3D 1;
>>  	vcpu->arch.sie_block->pp =3D 0;
>>  	vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
>>  	vcpu->arch.pfault_token =3D KVM_S390_PFAULT_TOKEN_INVALID;
>> @@ -3367,6 +3368,10 @@ static int kvm_arch_vcpu_ioctl_get_one_reg(stru=
ct kvm_vcpu *vcpu,
>>  			     (u64 __user *)reg->addr);
>>  		break;
>>  	case KVM_REG_S390_GBEA:
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			r =3D 0;
>> +			break;
>> +		}
>>  		r =3D put_user(vcpu->arch.sie_block->gbea,
>>  			     (u64 __user *)reg->addr);
>>  		break;
>> @@ -3420,6 +3425,10 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(stru=
ct kvm_vcpu *vcpu,
>>  			     (u64 __user *)reg->addr);
>>  		break;
>>  	case KVM_REG_S390_GBEA:
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			r =3D 0;
>> +			break;
>> +		}
>=20
> Wouldn't it be better to return EINVAL in this case? ... the callers
> definitely do not get what they expected here...
>=20
>  Thomas
>=20

Hrm, new QEMUs will use cpu run anyway and hence I guess it would make
sense as old QEMUs hopefully won't have pv support.


--1guMIYcNAznUAlPhQ2sQsZhbgu0Qy4zZn--

--PdhOTjLoZjYXjs1szoQtZlknVfAmDU2P3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3Od2wACgkQ41TmuOI4
ufhyng//U7oBygOGsq1WSOMtR5WkCWlExYl0QexBSk80lP1Q41AjlFBEd/agzo8F
e3CORr53g+xNdle1TX4cAr+jpu5cJ/hFv/pAFyU4GqT5/H97DOotV7FXYEZHqXKj
tih9O5b1CMw2+s5ZAtAda3Z0LbhP0B+nAitXQ8Jeoj7Kb/cDAJftcZbKZ7MbD1Jw
l0JoGDDeo1Xp5MuqcL06j1yMrDRGGVUZPsh6UFJjarC44oolJLA5Mi6FIgYP9PKr
uw+Sl9NGk+y9u5kPH1SlxQKFsGryLsrs1ooJuT/JndDJMw/nO+34ZjeXS/CoNnSG
fQwBbE2M3zYvfLWR9UmjSHRYi+za/0YNwwgcBrgHPifdpuhK5EOAnlinmT0NmMyE
B2t93rAa2mskyRN/YGVU66XZ3TUSGxZiZ5tn4BeR+/HNVX44+U9T0Ct/xAVvArLV
JrGwOgGbuPu/hsRnLrUeSa6dmldHR3zGExKuAHyFNwwcBhQbQpPBzD69Bqs0QKer
/k+v0WsaWULWP8o8/WG0CghWmJqJGioWpXFEB+sYQGz10vkHax9W0fgvPUKbPW+3
0NDXks99lWClSOzloAchvuOqxJwwkinUoc/uM8WfT2DiFV1Fh8Qu9oIiIDeEfQEO
Dim9UaRRremdSFG7XAamqmVyzlGuWeBxsPKn3hDGUSLkDUYZE4E=
=k+mg
-----END PGP SIGNATURE-----

--PdhOTjLoZjYXjs1szoQtZlknVfAmDU2P3--
