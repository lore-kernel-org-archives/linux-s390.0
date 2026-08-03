Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66EB3B4E8C;
	Mon,  3 Aug 2026 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762306; cv=none; b=IbtQLUJYKvYlOebiAOivfhVRmNZpoFkd8DcJr6w4BeZdeHwvb15Lx37sLk3nkmVlfNggCDXkoem9sjJ2PNDtnP4xCvQkFWBrcFsIfG0WJ6++SMoaWC5jZ3v2cv2aZvgp75su8AmNyKp+5IrQJZ8c5ea6IXCsN2NQbKf19ssf0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762306; c=relaxed/simple;
	bh=Z+7ql9rqxq/rYj/AsAnJTNgyMXTu27kJ/+iYX6nouSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjTnrRCWrCZEkVZjhyf0kdyx6BxrKEtEMthh1sfS/2cWnekEHVZKY9/Aagxl7wVwmu02vbg3MQi8SYsD3tbrDXb99OH+yXAap2/YEqceqF/5E+cL9gpoFHbef0NQiM3L/TsCe44qcePK7vSjnuliQy9pg7g1iBq04+aQSB5a3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo0UrhO+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo0UrhO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977991F000E9;
	Mon,  3 Aug 2026 13:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762304;
	bh=AKZ7f16f4Sq1M970bN/iH1hBFUS7R2GcDh674Ci8KD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jo0UrhO+jrVbIFBTZ0SJmsuntpe7vUP1sJ0g+kJ+UCtZDoj4hCpuEFj935SYc06+B
	 AixbikKLUCAFPdgk3701mnX6dmTIaFHcW9qAf+OrmCf9rF7dQSZP34Hv4IWA3CztF9
	 mQa2QYbA+Ey88mgVv3fTUlsviiWBL1UWPgwNBfoM40EgDozGOcoxnpz6YccjKFiOAB
	 WdkjByyd/wN9Uf76gqf77ZA5T30+TaMbEZfuzzIJRNim9wopWZxJUzrGYyxseSJe/a
	 eBO2YmgXsk2Z7X+elq9YQiqbE7ngkfUUNqRVQEpV8LHhrz8p0j3e9KQd48lGXIbOwe
	 arRLegcjLYoUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/13] KVM: s390: Fix overclearing ESCA in case of
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803124040.126471-5-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:05:02 +0000
Message-Id: <20260803130503.977991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] For KVM_VM_S390_UCONTROL VMs, userspace can trigger an out-of-=
bounds read and write in `sca_clear_ext_call` and `sca_inject_ext_call` by =
creating a vCPU with an ID >=3D 248.
- [High] Memory leak of `vcpu->arch.mc` and its topped-up pages when `kvm_a=
rch_vcpu_create()` fails.
--

--- Patch [4]: [PATCH v8 04/13] KVM: s390: Fix overclearing ESCA in case of=
 error ---
commit 554d58551a2c2c8a2475d02299b28fea5b490098
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix overclearing ESCA in case of error

This commit fixes an issue where destroying a duplicated vCPU clears the ES=
CA
entry of the original vCPU. It skips clearing the ESCA entry if the vCPU
creation was unsuccessful.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 9e3e6b0d72ad6..2acdff130fa6c 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -86,7 +86,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
>  	union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;

[Severity: Critical]
This is a pre-existing issue, but can this out-of-bounds access occur for
ucontrol VMs?

For KVM_VM_S390_UCONTROL VMs, kvm_arch_vcpu_precreate() skips the
sca_can_add_vcpu() check. This allows a user with CAP_SYS_ADMIN to create
vCPUs with IDs up to 254.

However, the sca->cpu array in struct esca_block only has
KVM_S390_ESCA_CPU_SLOTS (248) elements. Because sca_clear_ext_call() is
called unconditionally when destroying the vCPU, it indexes sca->cpu with t=
his
unvalidated vcpu_id before the initialization check.

Would this result in an out-of-bounds read and write to adjacent kernel
memory here, and similarly in sca_inject_ext_call()?

> -	if (!kvm_s390_use_sca_entries())
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
>  		return;
>  	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
> =20

[ ... ]

[Severity: High]
This is a pre-existing issue, but does kvm_arch_vcpu_create() leak the MMU
cache on error paths?

If kvm_s390_new_mmu_cache() succeeds, but a later step fails (such as
gmap_new_child() for a ucontrol VM, or ultravisor PV setup failing), the er=
ror
path jumps to out_free_sie_block:

out_free_sie_block:
        free_page((unsigned long)(vcpu->arch.sie_block));
        return rc;

It appears kvm_s390_free_mmu_cache(vcpu->arch.mc) is never called here. Sin=
ce
the caller kvm_vm_ioctl_create_vcpu() handles the error by freeing the base
vCPU struct without calling kvm_arch_vcpu_destroy(), does this permanently
leak vcpu->arch.mc and its internally topped-up pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D4
