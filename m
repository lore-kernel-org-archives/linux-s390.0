Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgDTIZf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 04:25:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K83vDj050565
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 04:25:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmux6hhp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 04:25:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 20 Apr 2020 09:25:08 +0100
Subject: Re: [PATCH 1/7] KVM: s390: clean up redundant 'kvm_run' parameters
References: <20200419075106.16248-1-tianjia.zhang@linux.alibaba.com>
 <20200419075106.16248-2-tianjia.zhang@linux.alibaba.com>
 <7a783487-2f9b-08a6-0ff6-f57bb90495a1@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 20 Apr 2020 10:25:16 +0200
MIME-Version: 1.0
In-Reply-To: <7a783487-2f9b-08a6-0ff6-f57bb90495a1@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k9RSmBqTWYAbaP5rKw62ccEG7ES4hYhub"
Message-Id: <d6e522e2-187e-04f3-440d-62b9d6d3b71f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k9RSmBqTWYAbaP5rKw62ccEG7ES4hYhub
Content-Type: multipart/mixed; boundary="7j45kMn58mnq4gXwEhb4vbWa5qGQ5JsDC"

--7j45kMn58mnq4gXwEhb4vbWa5qGQ5JsDC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/20/20 9:07 AM, Christian Borntraeger wrote:
>=20
>=20
> On 19.04.20 09:51, Tianjia Zhang wrote:
>> In the current kvm version, 'kvm_run' has been included in the 'kvm_vc=
pu'
>> structure. Earlier than historical reasons, many kvm-related function
>> parameters retain the 'kvm_run' and 'kvm_vcpu' parameters at the same =
time.
>> This patch does a unified cleanup of these remaining redundant paramet=
ers.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 127 +++++++++++++++++++++-----------------=
-
>>  1 file changed, 67 insertions(+), 60 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 443af3ead739..cf420d013ba3 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4173,24 +4173,25 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>>  	return rc;
>>  }
>> =20
>> -static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm=
_run)
>> +static void sync_regs_fmt2(struct kvm_vcpu *vcpu)
>>  {
>> +	struct kvm_run *run =3D vcpu->run;
>=20
> Please use kvm_run as variable name. This makes all of the changes belo=
w go away.

Definitely

@Tianjia
This patch produces way to much churn to be picked up as is.
I do not want patches that touch so much for small cosmetic changes.

>=20
>=20
>>  	struct runtime_instr_cb *riccb;
>>  	struct gs_cb *gscb;
>> =20
>> -	riccb =3D (struct runtime_instr_cb *) &kvm_run->s.regs.riccb;
>> -	gscb =3D (struct gs_cb *) &kvm_run->s.regs.gscb;
>> -	vcpu->arch.sie_block->gpsw.mask =3D kvm_run->psw_mask;
>> -	vcpu->arch.sie_block->gpsw.addr =3D kvm_run->psw_addr;
>> -	if (kvm_run->kvm_dirty_regs & KVM_SYNC_ARCH0) {
>> -		vcpu->arch.sie_block->todpr =3D kvm_run->s.regs.todpr;
>> -		vcpu->arch.sie_block->pp =3D kvm_run->s.regs.pp;
>> -		vcpu->arch.sie_block->gbea =3D kvm_run->s.regs.gbea;
>> -	}
>> -	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PFAULT) {
>> -		vcpu->arch.pfault_token =3D kvm_run->s.regs.pft;
>> -		vcpu->arch.pfault_select =3D kvm_run->s.regs.pfs;
>> -		vcpu->arch.pfault_compare =3D kvm_run->s.regs.pfc;
>> +	riccb =3D (struct runtime_instr_cb *) &run->s.regs.riccb;
>> +	gscb =3D (struct gs_cb *) &run->s.regs.gscb;
>> +	vcpu->arch.sie_block->gpsw.mask =3D run->psw_mask;
>> +	vcpu->arch.sie_block->gpsw.addr =3D run->psw_addr;
>> +	if (run->kvm_dirty_regs & KVM_SYNC_ARCH0) {
>> +		vcpu->arch.sie_block->todpr =3D run->s.regs.todpr;
>> +		vcpu->arch.sie_block->pp =3D run->s.regs.pp;
>> +		vcpu->arch.sie_block->gbea =3D run->s.regs.gbea;
>> +	}
>> +	if (run->kvm_dirty_regs & KVM_SYNC_PFAULT) {
>> +		vcpu->arch.pfault_token =3D run->s.regs.pft;
>> +		vcpu->arch.pfault_select =3D run->s.regs.pfs;
>> +		vcpu->arch.pfault_compare =3D run->s.regs.pfc;
>>  		if (vcpu->arch.pfault_token =3D=3D KVM_S390_PFAULT_TOKEN_INVALID)
>>  			kvm_clear_async_pf_completion_queue(vcpu);
>>  	}
>> @@ -4198,7 +4199,7 @@ static void sync_regs_fmt2(struct kvm_vcpu *vcpu=
, struct kvm_run *kvm_run)
>>  	 * If userspace sets the riccb (e.g. after migration) to a valid sta=
te,
>>  	 * we should enable RI here instead of doing the lazy enablement.
>>  	 */
>> -	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_RICCB) &&
>> +	if ((run->kvm_dirty_regs & KVM_SYNC_RICCB) &&
>>  	    test_kvm_facility(vcpu->kvm, 64) &&
>>  	    riccb->v &&
>>  	    !(vcpu->arch.sie_block->ecb3 & ECB3_RI)) {
>> @@ -4209,7 +4210,7 @@ static void sync_regs_fmt2(struct kvm_vcpu *vcpu=
, struct kvm_run *kvm_run)
>>  	 * If userspace sets the gscb (e.g. after migration) to non-zero,
>>  	 * we should enable GS here instead of doing the lazy enablement.
>>  	 */
>> -	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_GSCB) &&
>> +	if ((run->kvm_dirty_regs & KVM_SYNC_GSCB) &&
>>  	    test_kvm_facility(vcpu->kvm, 133) &&
>>  	    gscb->gssm &&
>>  	    !vcpu->arch.gs_enabled) {
>> @@ -4218,10 +4219,10 @@ static void sync_regs_fmt2(struct kvm_vcpu *vc=
pu, struct kvm_run *kvm_run)
>>  		vcpu->arch.sie_block->ecd |=3D ECD_HOSTREGMGMT;
>>  		vcpu->arch.gs_enabled =3D 1;
>>  	}
>> -	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_BPBC) &&
>> +	if ((run->kvm_dirty_regs & KVM_SYNC_BPBC) &&
>>  	    test_kvm_facility(vcpu->kvm, 82)) {
>>  		vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
>> -		vcpu->arch.sie_block->fpf |=3D kvm_run->s.regs.bpbc ? FPF_BPBC : 0;=

>> +		vcpu->arch.sie_block->fpf |=3D run->s.regs.bpbc ? FPF_BPBC : 0;
>>  	}
>>  	if (MACHINE_HAS_GS) {
>>  		preempt_disable();
>> @@ -4232,45 +4233,47 @@ static void sync_regs_fmt2(struct kvm_vcpu *vc=
pu, struct kvm_run *kvm_run)
>>  		}
>>  		if (vcpu->arch.gs_enabled) {
>>  			current->thread.gs_cb =3D (struct gs_cb *)
>> -						&vcpu->run->s.regs.gscb;
>> +						&run->s.regs.gscb;
>>  			restore_gs_cb(current->thread.gs_cb);
>>  		}
>>  		preempt_enable();
>>  	}
>> -	/* SIE will load etoken directly from SDNX and therefore kvm_run */
>> +	/* SIE will load etoken directly from SDNX and therefore run */
>>  }
>> =20
>> -static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)=

>> +static void sync_regs(struct kvm_vcpu *vcpu)
>>  {
>> -	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
>> -		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
>> -	if (kvm_run->kvm_dirty_regs & KVM_SYNC_CRS) {
>> -		memcpy(&vcpu->arch.sie_block->gcr, &kvm_run->s.regs.crs, 128);
>> +	struct kvm_run *run =3D vcpu->run;
>> +
>> +	if (run->kvm_dirty_regs & KVM_SYNC_PREFIX)
>> +		kvm_s390_set_prefix(vcpu, run->s.regs.prefix);
>> +	if (run->kvm_dirty_regs & KVM_SYNC_CRS) {
>> +		memcpy(&vcpu->arch.sie_block->gcr, &run->s.regs.crs, 128);
>>  		/* some control register changes require a tlb flush */
>>  		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
>>  	}
>> -	if (kvm_run->kvm_dirty_regs & KVM_SYNC_ARCH0) {
>> -		kvm_s390_set_cpu_timer(vcpu, kvm_run->s.regs.cputm);
>> -		vcpu->arch.sie_block->ckc =3D kvm_run->s.regs.ckc;
>> +	if (run->kvm_dirty_regs & KVM_SYNC_ARCH0) {
>> +		kvm_s390_set_cpu_timer(vcpu, run->s.regs.cputm);
>> +		vcpu->arch.sie_block->ckc =3D run->s.regs.ckc;
>>  	}
>>  	save_access_regs(vcpu->arch.host_acrs);
>> -	restore_access_regs(vcpu->run->s.regs.acrs);
>> +	restore_access_regs(run->s.regs.acrs);
>>  	/* save host (userspace) fprs/vrs */
>>  	save_fpu_regs();
>>  	vcpu->arch.host_fpregs.fpc =3D current->thread.fpu.fpc;
>>  	vcpu->arch.host_fpregs.regs =3D current->thread.fpu.regs;
>>  	if (MACHINE_HAS_VX)
>> -		current->thread.fpu.regs =3D vcpu->run->s.regs.vrs;
>> +		current->thread.fpu.regs =3D run->s.regs.vrs;
>>  	else
>> -		current->thread.fpu.regs =3D vcpu->run->s.regs.fprs;
>> -	current->thread.fpu.fpc =3D vcpu->run->s.regs.fpc;
>> +		current->thread.fpu.regs =3D run->s.regs.fprs;
>> +	current->thread.fpu.fpc =3D run->s.regs.fpc;
>>  	if (test_fp_ctl(current->thread.fpu.fpc))
>>  		/* User space provided an invalid FPC, let's clear it */
>>  		current->thread.fpu.fpc =3D 0;
>> =20
>>  	/* Sync fmt2 only data */
>>  	if (likely(!kvm_s390_pv_cpu_is_protected(vcpu))) {
>> -		sync_regs_fmt2(vcpu, kvm_run);
>> +		sync_regs_fmt2(vcpu);
>>  	} else {
>>  		/*
>>  		 * In several places we have to modify our internal view to
>> @@ -4282,19 +4285,21 @@ static void sync_regs(struct kvm_vcpu *vcpu, s=
truct kvm_run *kvm_run)
>>  		 * do only accept the condition code from userspace.
>>  		 */
>>  		vcpu->arch.sie_block->gpsw.mask &=3D ~PSW_MASK_CC;
>> -		vcpu->arch.sie_block->gpsw.mask |=3D kvm_run->psw_mask &
>> +		vcpu->arch.sie_block->gpsw.mask |=3D run->psw_mask &
>>  						   PSW_MASK_CC;
>>  	}
>> =20
>> -	kvm_run->kvm_dirty_regs =3D 0;
>> +	run->kvm_dirty_regs =3D 0;
>>  }
>> =20
>> -static void store_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kv=
m_run)
>> +static void store_regs_fmt2(struct kvm_vcpu *vcpu)
>>  {
>> -	kvm_run->s.regs.todpr =3D vcpu->arch.sie_block->todpr;
>> -	kvm_run->s.regs.pp =3D vcpu->arch.sie_block->pp;
>> -	kvm_run->s.regs.gbea =3D vcpu->arch.sie_block->gbea;
>> -	kvm_run->s.regs.bpbc =3D (vcpu->arch.sie_block->fpf & FPF_BPBC) =3D=3D=
 FPF_BPBC;
>> +	struct kvm_run *run =3D vcpu->run;
>> +
>> +	run->s.regs.todpr =3D vcpu->arch.sie_block->todpr;
>> +	run->s.regs.pp =3D vcpu->arch.sie_block->pp;
>> +	run->s.regs.gbea =3D vcpu->arch.sie_block->gbea;
>> +	run->s.regs.bpbc =3D (vcpu->arch.sie_block->fpf & FPF_BPBC) =3D=3D F=
PF_BPBC;
>>  	if (MACHINE_HAS_GS) {
>>  		__ctl_set_bit(2, 4);
>>  		if (vcpu->arch.gs_enabled)
>> @@ -4310,39 +4315,41 @@ static void store_regs_fmt2(struct kvm_vcpu *v=
cpu, struct kvm_run *kvm_run)
>>  	/* SIE will save etoken directly into SDNX and therefore kvm_run */
>>  }
>> =20
>> -static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run=
)
>> +static void store_regs(struct kvm_vcpu *vcpu)
>>  {
>> -	kvm_run->psw_mask =3D vcpu->arch.sie_block->gpsw.mask;
>> -	kvm_run->psw_addr =3D vcpu->arch.sie_block->gpsw.addr;
>> -	kvm_run->s.regs.prefix =3D kvm_s390_get_prefix(vcpu);
>> -	memcpy(&kvm_run->s.regs.crs, &vcpu->arch.sie_block->gcr, 128);
>> -	kvm_run->s.regs.cputm =3D kvm_s390_get_cpu_timer(vcpu);
>> -	kvm_run->s.regs.ckc =3D vcpu->arch.sie_block->ckc;
>> -	kvm_run->s.regs.pft =3D vcpu->arch.pfault_token;
>> -	kvm_run->s.regs.pfs =3D vcpu->arch.pfault_select;
>> -	kvm_run->s.regs.pfc =3D vcpu->arch.pfault_compare;
>> -	save_access_regs(vcpu->run->s.regs.acrs);
>> +	struct kvm_run *run =3D vcpu->run;
>> +
>> +	run->psw_mask =3D vcpu->arch.sie_block->gpsw.mask;
>> +	run->psw_addr =3D vcpu->arch.sie_block->gpsw.addr;
>> +	run->s.regs.prefix =3D kvm_s390_get_prefix(vcpu);
>> +	memcpy(&run->s.regs.crs, &vcpu->arch.sie_block->gcr, 128);
>> +	run->s.regs.cputm =3D kvm_s390_get_cpu_timer(vcpu);
>> +	run->s.regs.ckc =3D vcpu->arch.sie_block->ckc;
>> +	run->s.regs.pft =3D vcpu->arch.pfault_token;
>> +	run->s.regs.pfs =3D vcpu->arch.pfault_select;
>> +	run->s.regs.pfc =3D vcpu->arch.pfault_compare;
>> +	save_access_regs(run->s.regs.acrs);
>>  	restore_access_regs(vcpu->arch.host_acrs);
>>  	/* Save guest register state */
>>  	save_fpu_regs();
>> -	vcpu->run->s.regs.fpc =3D current->thread.fpu.fpc;
>> +	run->s.regs.fpc =3D current->thread.fpu.fpc;
>>  	/* Restore will be done lazily at return */
>>  	current->thread.fpu.fpc =3D vcpu->arch.host_fpregs.fpc;
>>  	current->thread.fpu.regs =3D vcpu->arch.host_fpregs.regs;
>>  	if (likely(!kvm_s390_pv_cpu_is_protected(vcpu)))
>> -		store_regs_fmt2(vcpu, kvm_run);
>> +		store_regs_fmt2(vcpu);
>>  }
>> =20
>>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>  {
>> -	struct kvm_run *kvm_run =3D vcpu->run;
>> +	struct kvm_run *run =3D vcpu->run;
>>  	int rc;
>> =20
>> -	if (kvm_run->immediate_exit)
>> +	if (run->immediate_exit)
>>  		return -EINTR;
>> =20
>> -	if (kvm_run->kvm_valid_regs & ~KVM_SYNC_S390_VALID_FIELDS ||
>> -	    kvm_run->kvm_dirty_regs & ~KVM_SYNC_S390_VALID_FIELDS)
>> +	if (run->kvm_valid_regs & ~KVM_SYNC_S390_VALID_FIELDS ||
>> +	    run->kvm_dirty_regs & ~KVM_SYNC_S390_VALID_FIELDS)
>>  		return -EINVAL;
>> =20
>>  	vcpu_load(vcpu);
>> @@ -4368,14 +4375,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *v=
cpu)
>>  		goto out;
>>  	}
>> =20
>> -	sync_regs(vcpu, kvm_run);
>> +	sync_regs(vcpu);
>>  	enable_cpu_timer_accounting(vcpu);
>> =20
>>  	might_fault();
>>  	rc =3D __vcpu_run(vcpu);
>> =20
>>  	if (signal_pending(current) && !rc) {
>> -		kvm_run->exit_reason =3D KVM_EXIT_INTR;
>> +		run->exit_reason =3D KVM_EXIT_INTR;
>>  		rc =3D -EINTR;
>>  	}
>> =20
>> @@ -4390,7 +4397,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcp=
u)
>>  	}
>> =20
>>  	disable_cpu_timer_accounting(vcpu);
>> -	store_regs(vcpu, kvm_run);
>> +	store_regs(vcpu);
>> =20
>>  	kvm_sigset_deactivate(vcpu);
>> =20
>>



--7j45kMn58mnq4gXwEhb4vbWa5qGQ5JsDC--

--k9RSmBqTWYAbaP5rKw62ccEG7ES4hYhub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6dXGwACgkQ41TmuOI4
ufjdvQ//YjHAPeQfGQn1w4S0yNXye7v/Jwl2Zaa5286dQDyhsMnYOKtrc3oz/cCM
tZjRocVRfjlExANAaEt6i1pOakrh6iAkTkyPnCEG1fhdC5eRqO9LYqTLBXWnXjhM
IBeJqoajbgCUN8FOJv02mjN52wmXhjxexJXZwtwE9tcGCNDUP+9yU5S6Qgw9Lqqi
R+N66U7na38EcizvZK+BJoJkiO1DnL2Jc+wyQssULWZiqCyGQEIGJNPkW7qvqRV1
IFMUnH5gryrF4tdbuoJk8N5EPkOoYbkMc5mWV/Y6opUuLgtKFaLul9m2eOAmZuKG
dYGsjp9exQq5SXJIDaJaL8n1jpQgmAOodN5420uvdIsOmoyh9GCJ01II3Y0+GUpM
rpMjbleasKzbQwWzGiZt7IGFZSgjo3PoA3JaqbGXrdJGUbtqUolPOWN3EJR4JDvr
37FLPFoXcoAN6hixxGwRv+JF516S9cpSzE6zEeNCcQRiMP/mzK14qUa/k4DSjBss
AdcafuOPOIaC5lfMyTXBJYCzik55V+swgAiI402SY0NFy/uJFEF+obIVA4vau50o
ynlo3RxdSx+oPN8T47PYG3F8F5XfbQIpwAfGmv2AQ42j5wMYWFNFZncacDV+YIhq
+hoIV+bKjILnW2x8yJhrbJnxnMPRQCke+jsqbxhYCCJiE6aPMo0=
=Ye8W
-----END PGP SIGNATURE-----

--k9RSmBqTWYAbaP5rKw62ccEG7ES4hYhub--
