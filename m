Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA512EC57C;
	Wed, 24 Jun 2026 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301252; cv=none; b=hVgkhzKd+7kEZRwJNacQ61kjQBEd2lHQBdL0nnLkor4KflS001/DJH9u1Rre46P8k6yguIZeIvuBaW2CQXEwRPXYueTTK+XA823KpzCziXDH4utGxsJX5m+lJz85G5pF9IOkGZenYqOcPc0w4VBq3AI1iQsJSvrBG1mN25DuSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301252; c=relaxed/simple;
	bh=F/IAXX4dwkECDuMAkY3e6tX7nGAz2NAI8u8D+tgS2+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b/54sJgd+qufK8lmHMI2UOTcA9LpLgR3rWXzF3RCVV+jQ8n1kH9NyUOwTCj0Zsqk4DEEI9LN6PLTyjMy7mnrwXIYl1QviZi+uDLhpOHDgbvGztKIalkrIIwA/x89YpVUsLThhWcV0FI+JLXWrsLeAMo5jwCOMQ0XpaAvfmKSkgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOOdDLTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOOdDLTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDD91F000E9;
	Wed, 24 Jun 2026 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782301251;
	bh=fo60fryRAHrjhVR2+t5KBGtLNiRjD7P/KEfF02Be6Zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TOOdDLTfE5zQ3hmPypXpjCCchroJeTLsCqltEJ3VwQ/aMzqeTY3ydnZQFfn7yYrL9
	 FW2hYdh4y0JFDU2T9FZziii7vDa0mkqpMtMa+9ypDL/euYnbsEvUK+xA4lDddvtJTM
	 btPSbKLaKjXApbsOvpXxuhz9tjc4s+TVrTdgoRC/inSZdASp0uxgpW+arCGoSWLSKa
	 H5UalEvq1y6CskBMyVXm2+Bv1uDGjQ9iytKHiNmzfk21HABK6hxUG3aeksXXzR4Elx
	 KDwDh92g7jNiSkIpIkm3A0EIa5JgYs7NawMDtIC6ga0Q+XJLgTSV97YuVWPxUmqdP7
	 ItkgTeWRtduag==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 01/12] KVM: s390: Fix S390_USER_OPEREXEC
 enablement without STFLE 74
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260624111928.144283-2-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
 <20260624111928.144283-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 11:40:50 +0000
Message-Id: <20260624114050.BEDD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] A lockless data race between concurrent KVM_ENABLE_CAP and KVM_C=
REATE_VCPU can result in a vCPU silently missing the operation exception in=
tercept.

Pre-existing issues:
- [Critical] Missing `vcpu->mutex` in `kvm_arch_vcpu_postcreate` allows a c=
oncurrent `KVM_RUN` ioctl to trigger a host kernel panic via a NULL pointer=
 dereference on `vcpu->arch.gmap`.
--

commit 40c6c07119e484ffc2bb8e5fccec2d6c44c1df03
Author: Eric Farman <farman@linux.ibm.com>

KVM: s390: Fix S390_USER_OPEREXEC enablement without STFLE 74

This commit ensures the USER_OPEREXEC capability is properly enabled
in kvm_arch_vcpu_postcreate() even if the guest disables STFLE.74.
It adds a check for vcpu->kvm->arch.user_operexec alongside the
existing checks for STFLE.74 and user_instr0.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3542,7 +3542,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  		vcpu->arch.gmap =3D vcpu->kvm->arch.gmap;

[Severity: Critical]
This is a pre-existing issue, but does this function need to hold
vcpu->mutex while initializing vcpu->arch.gmap?

When kvm_vm_ioctl_create_vcpu() executes, it unlocks vcpu->mutex and
increments kvm->online_vcpus before calling kvm_arch_vcpu_postcreate():

virt/kvm/kvm_main.c:kvm_vm_ioctl_create_vcpu()
    atomic_inc(&kvm->online_vcpus);
    mutex_unlock(&vcpu->mutex);
    mutex_unlock(&kvm->lock);
    kvm_arch_vcpu_postcreate(vcpu);

If a second thread immediately calls the KVM_RUN ioctl on the new vCPU,
it can acquire vcpu->mutex and proceed to __vcpu_run() before
kvm_arch_vcpu_postcreate() finishes.  Could this result in a NULL pointer
dereference when __vcpu_run() accesses vcpu->arch.gmap->asce.val?

arch/s390/kvm/kvm-s390.c:__vcpu_run()
    sie_return =3D kvm_s390_enter_exit_sie(vcpu->arch.sie_block,
                                         vcpu->run->s.regs.gprs,
                                         vcpu->arch.gmap->asce.val);

>  		sca_add_vcpu(vcpu);
>  	}
> -	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0)
> +	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
> +	    vcpu->kvm->arch.user_operexec)

[Severity: Medium]
Does the lockless read of user_operexec introduce a data race with
KVM_ENABLE_CAP?

If a thread enables KVM_CAP_S390_USER_OPEREXEC concurrently with vCPU
creation, kvm_vm_ioctl_enable_cap() writes to kvm->arch.user_operexec and
iterates over online vCPUs without a full memory barrier:

arch/s390/kvm/kvm-s390.c:kvm_vm_ioctl_enable_cap()
    kvm->arch.user_operexec =3D 1;
    icpt_operexc_on_all_vcpus(kvm);

Meanwhile, kvm_vm_ioctl_create_vcpu() increments online_vcpus before
calling kvm_arch_vcpu_postcreate().

Because of this sequence, is it possible for both threads to observe the
older state of the other's variables? If so, could this cause the newly
created vCPU to silently miss setting the ICTL_OPEREXC bit?

>  		vcpu->arch.sie_block->ictl |=3D ICTL_OPEREXC;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624111928.1442=
83-1-imbrenda@linux.ibm.com?part=3D1
