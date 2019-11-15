Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727132AbfKOJ7g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 04:59:36 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAF9w2rn022435
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 04:59:36 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w9nv98qq1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 04:59:35 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 15 Nov 2019 09:59:34 -0000
Subject: Re: [RFC 29/37] KVM: s390: protvirt: Sync pv state
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-30-frankja@linux.ibm.com>
 <e60f6e74-2d0f-36a8-cde7-1b6054370ba8@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 15 Nov 2019 10:59:29 +0100
MIME-Version: 1.0
In-Reply-To: <e60f6e74-2d0f-36a8-cde7-1b6054370ba8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GGVcwaYrLGzDsEyLZevegTNu5tPncZo8f"
Message-Id: <b016cee2-18b5-a621-62b0-f230adfc89ce@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GGVcwaYrLGzDsEyLZevegTNu5tPncZo8f
Content-Type: multipart/mixed; boundary="xlz7sHVn2vb8PVMz5aVKx2wSIRfkJDGvy"

--xlz7sHVn2vb8PVMz5aVKx2wSIRfkJDGvy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/19 10:36 AM, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> Indicate via register sync if the VM is in secure mode.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/uapi/asm/kvm.h | 5 ++++-
>>  arch/s390/kvm/kvm-s390.c         | 7 ++++++-
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi=
/asm/kvm.h
>> index 436ec7636927..b44c02426c2e 100644
>> --- a/arch/s390/include/uapi/asm/kvm.h
>> +++ b/arch/s390/include/uapi/asm/kvm.h
>> @@ -231,11 +231,13 @@ struct kvm_guest_debug_arch {
>>  #define KVM_SYNC_GSCB   (1UL << 9)
>>  #define KVM_SYNC_BPBC   (1UL << 10)
>>  #define KVM_SYNC_ETOKEN (1UL << 11)
>> +#define KVM_SYNC_PV	(1UL << 12)
>> =20
>>  #define KVM_SYNC_S390_VALID_FIELDS \
>>  	(KVM_SYNC_PREFIX | KVM_SYNC_GPRS | KVM_SYNC_ACRS | KVM_SYNC_CRS | \
>>  	 KVM_SYNC_ARCH0 | KVM_SYNC_PFAULT | KVM_SYNC_VRS | KVM_SYNC_RICCB | =
\
>> -	 KVM_SYNC_FPRS | KVM_SYNC_GSCB | KVM_SYNC_BPBC | KVM_SYNC_ETOKEN)
>> +	 KVM_SYNC_FPRS | KVM_SYNC_GSCB | KVM_SYNC_BPBC | KVM_SYNC_ETOKEN | \=

>> +	 KVM_SYNC_PV)
>> =20
>>  /* length and alignment of the sdnx as a power of two */
>>  #define SDNXC 8
>> @@ -261,6 +263,7 @@ struct kvm_sync_regs {
>>  	__u8  reserved[512];	/* for future vector expansion */
>>  	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
>>  	__u8 bpbc : 1;		/* bp mode */
>> +	__u8 pv : 1;		/* pv mode */
>>  	__u8 reserved2 : 7;
>=20
> Don't you want to decrease the reserved2 bits to 6 ? ...

Ups

>=20
>>  	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
>=20
> ... otherwise you might mess up the alignment here!
>=20
>>  	__u8 riccb[64];		/* runtime instrumentation controls block */
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index f623c64aeade..500972a1f742 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2856,6 +2856,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>>  		vcpu->run->kvm_valid_regs |=3D KVM_SYNC_GSCB;
>>  	if (test_kvm_facility(vcpu->kvm, 156))
>>  		vcpu->run->kvm_valid_regs |=3D KVM_SYNC_ETOKEN;
>> +	if (test_kvm_facility(vcpu->kvm, 161))
>> +		vcpu->run->kvm_valid_regs |=3D KVM_SYNC_PV;
>>  	/* fprs can be synchronized via vrs, even if the guest has no vx. Wi=
th
>>  	 * MACHINE_HAS_VX, (load|store)_fpu_regs() will work with vrs format=
=2E
>>  	 */
>> @@ -4136,6 +4138,7 @@ static void store_regs_fmt2(struct kvm_vcpu *vcp=
u, struct kvm_run *kvm_run)
>>  {
>>  	kvm_run->s.regs.gbea =3D vcpu->arch.sie_block->gbea;
>>  	kvm_run->s.regs.bpbc =3D (vcpu->arch.sie_block->fpf & FPF_BPBC) =3D=3D=
 FPF_BPBC;
>> +	kvm_run->s.regs.pv =3D 0;
>>  	if (MACHINE_HAS_GS) {
>>  		__ctl_set_bit(2, 4);
>>  		if (vcpu->arch.gs_enabled)
>> @@ -4172,8 +4175,10 @@ static void store_regs(struct kvm_vcpu *vcpu, s=
truct kvm_run *kvm_run)
>>  	/* Restore will be done lazily at return */
>>  	current->thread.fpu.fpc =3D vcpu->arch.host_fpregs.fpc;
>>  	current->thread.fpu.regs =3D vcpu->arch.host_fpregs.regs;
>> -	if (likely(!kvm_s390_pv_is_protected(vcpu->kvm)))
>> +	if (likely(!kvm_s390_pv_handle_cpu(vcpu)))
>=20
> Why change the if-statement now? Should this maybe rather be squashed
> into the patch that introduced the if-statement?

That was part of a cleanup that should have been done in other patches.

>=20
>>  		store_regs_fmt2(vcpu, kvm_run);
>> +	else
>> +		kvm_run->s.regs.pv =3D 1;
>>  }
>> =20
>>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kv=
m_run)
>>
>=20
>  Thomas
>=20



--xlz7sHVn2vb8PVMz5aVKx2wSIRfkJDGvy--

--GGVcwaYrLGzDsEyLZevegTNu5tPncZo8f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3OdwEACgkQ41TmuOI4
ufgPCw//UnI4w96rOGqgcuFfQxLd071cr8WxXwEFqz+qUVYuuKgSTCs+7h2D6ycR
TDUe3VTVz84hvVZU8UojACJruivA37DLLSjPuLq/64kddKFqe17LSc8SPzeQHSt3
iionnE9IPZRRV2CDZm0upaLemmfQ9jeQ3vUvsPI2zyGADAk0lGjTxdJtdZ883HOj
wPrc6A7EJKyELCOdN1luhq1ckJF9/DG0sWnd0u8ngxTVCUy4UsxVJyajJ8KISbQq
SZL+GdUBERKW4R1Aya/7GUTRZicm4lsE0P+6mNL2ZCrsBUcwgesNpUsclaQXJ+nK
dQYfm7RdmzyDDLEzXvTFcPnLYh8BJa7aQbUoLHGsPFlYwZjR1mZsvkjkU7anPPvQ
tVw21quOIwS4rlM7hVpE0zujFg/Lf/bz47fIqH0qc0EIqk0MVn6pWB5+bKf2aZTr
Gbq7NWnAqA/1kt+zSVlXTEhY8QH5fSVmWf0RClI4lErzsaxjB98QbyMbUCfKjEPh
VDSgU+jIgIhigXknNpzTuxG5BBn3kUtflBU2v6IdeGhD+Bt+888Q0XNPvMu2e+NB
dGd8YIjSHcV6GkHQ06I3VkvQlyqpcZCXlzcMatjCzDdvNcBNGClFIZxwEe14zu48
h8GH4bju10+k+72j0RGPscrsYpiy71NkBxC4SR9CSYLzFcVprw0=
=qOXn
-----END PGP SIGNATURE-----

--GGVcwaYrLGzDsEyLZevegTNu5tPncZo8f--
