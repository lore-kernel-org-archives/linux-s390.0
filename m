Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781423EAAD;
	Thu,  2 Jul 2026 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006961; cv=none; b=ZmmJWpZuUGJSTQPXV6xdoHjbZIqqcoJ/mPHgHqdcg773qeucGawjgnQiQSEgupgDkUr4+gF1IKD3kOYZGb4LsOMEMqQY+rhsT+qr3UVvOOvrFZni9fUosV5CsSKScYSxD3fYwLS4sXStwqFIlILijDbZcLctk6XcxPWtfqmLP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006961; c=relaxed/simple;
	bh=fv8QKjjNUYkRFKY1rXprhyqajYSrSAEh/XgyvF6PyhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0Xn2mXEPzjusGeCNtWeC4fhScLeQImrUEIZVa4lzTsuQprju+x6MGbWFzY9Qhbc7lsjy0xE2OHI2uyV29NmvkdmKPcBDMMh1ZtCNVQ/DgWIqEmu19PmjMiayGt2tfX69b8UKER69j/Dnwn12JEEkKw1/OJ4qhbArB1MseMAlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeDapC4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeDapC4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8771F000E9;
	Thu,  2 Jul 2026 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006960;
	bh=EIGbTe1EaJ/Lhm6nKYxTHi3qCLndVlOvs3TvoSkkWMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XeDapC4WVKeF9fkXZgyQnJjv/t+zty7ZMIbyvJe+h0dfPWUcqBilbKY62jwDc6tOL
	 qrw7le2tLld3f7Q93TAvsk5gK4pAwZs89DT6N2lBJxH28Hl2Yta1hazCaCM9gDmRpn
	 /O/+cS14zabMWtKn2q9zGK/l2SKy+3Z+UREjdMBz/tcllMGbku4Q++zJ8E0UYASin0
	 rKacIlwJ+3sqk1nYvH5kBpMGBBy+jhg82u83brMLUFGZtjLzD8vJBmHb4ZIex3VoWJ
	 +MRchNgM/ALnTb/kibKa1JZY1t96rUskU3WNHQOTmy0njyKkjrBSyvpuKVX2/V8qEd
	 fbskv14S/cOXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/8] KVM: s390: Fix unlikely race with
 KVM_CAP_S390_USER_OPEREXEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260702152406.204782-4-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
 <20260702152406.204782-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:42:39 +0000
Message-Id: <20260702154240.0B8771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The WRITE_ONCE() fix for KVM_CAP_S390_USER_OPEREXEC is architectur=
ally insufficient to prevent hardware Store-Load reordering, leaving the co=
ncurrency race exploitable.
- [High] KVM_CAP_S390_USER_INSTR0 suffers from the identical concurrency vu=
lnerability as USER_OPEREXEC, but was completely missed by the patch.
--

commit d2c961d1e461c8babbad1df33fbe8ed3bddfddba
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix unlikely race with KVM_CAP_S390_USER_OPEREXEC

This commit attempts to fix a race condition when enabling
KVM_CAP_S390_USER_OPEREXEC concurrently with vCPU creation. It uses
WRITE_ONCE() to ensure the capability flag is set before updating all
vCPUs.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4a6d903e35231..784f7d9c79c74 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -955,7 +955,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct k=
vm_enable_cap *cap)
>  		break;
>  	case KVM_CAP_S390_USER_OPEREXEC:
>  		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_OPEREXEC");
> -		kvm->arch.user_operexec =3D 1;
> +		WRITE_ONCE(kvm->arch.user_operexec, 1);
>  		icpt_operexc_on_all_vcpus(kvm);

[Severity: High]
This isn't a bug introduced by this patch, but is WRITE_ONCE() sufficient h=
ere
to prevent hardware Store-Load reordering?

On s390x, hardware Store-Load reordering is permitted. When Thread A enables
the capability, it stores to user_operexec and then loads online_vcpus insi=
de
icpt_operexc_on_all_vcpus():

Thread A:
    WRITE_ONCE(kvm->arch.user_operexec, 1);
    // icpt_operexc_on_all_vcpus()
    kvm_for_each_vcpu(i, vcpu, kvm) { ... }=20

Thread B concurrently creates a vCPU, incrementing online_vcpus and then
loading user_operexec in kvm_arch_vcpu_postcreate():

Thread B:
    atomic_inc(&kvm->online_vcpus);
    if (... || vcpu->kvm->arch.user_operexec)
        vcpu->arch.sie_block->ictl |=3D ICTL_OPEREXC;

Without a full memory barrier (smp_mb()), Thread A's CPU can execute the lo=
ad
of online_vcpus before the store to user_operexec is globally visible. Thre=
ad
A might miss the new vCPU, and Thread B might read user_operexec =3D=3D 0. =
Does
this require an explicit smp_mb() between the store and the loop?

[Severity: High]
This is a pre-existing issue, but does KVM_CAP_S390_USER_INSTR0 suffer from=
 the
exact same concurrency vulnerability?

In the same kvm_vm_ioctl_enable_cap() function, KVM_CAP_S390_USER_INSTR0 us=
es
the identical pattern:

    kvm->arch.user_instr0 =3D 1;
    icpt_operexc_on_all_vcpus(kvm);

Since kvm_arch_vcpu_postcreate() also reads user_instr0:

    if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
        vcpu->kvm->arch.user_operexec)
        vcpu->arch.sie_block->ictl |=3D ICTL_OPEREXC;

Could a concurrent vCPU creation fail to enable the ICTL_OPEREXC intercept =
if
it reads user_instr0 =3D=3D 0 while the enablement loop misses the new vCPU?

>  		r =3D 0;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702152406.2047=
82-1-imbrenda@linux.ibm.com?part=3D3
