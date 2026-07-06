Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0251942B75F;
	Mon,  6 Jul 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332230; cv=none; b=eriXxXjeNDxWFeAOiDpQJbkDRArKxfcgUfFXYI7HZDsPMoIhdDjeH1K3WfJZnrecXJGvoj4645K6SIClCV1hK0iKd4nhAuZuN3j6RvAqg4srMCHNrJ9dyvU8H/1jiz/i1S6sy+TNDkrwZKYk75KfuYtPedapjVavu6ONyelL60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332230; c=relaxed/simple;
	bh=14CgzCBC528nOz8p/uB5jnckHx1X2ebMWmllb+YAGKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o+mztgrQDE7koirlOO/bXc63PIWgQcJ1VcsFl0aXVCcaQFI4R+LgVrDm94KKi72wjYrpMH5xZDLL4fMOtjdBGijr6OXJxoQBjWdIT4uepr0HQH2KszZEXQ01/Tu4D4Z5N+51G1NjJw3W23of6AUaXpWZ4G9CBqINuo02J4ODPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMANu4CP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMANu4CP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199231F000E9;
	Mon,  6 Jul 2026 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332228;
	bh=lx6mNqJUpquhOOKngb/4voMRxVSOqlbCrnGWNIlU4V8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XMANu4CPsl1FJEoQ5YO6SU6QTAWJSy/NXYY1jCffL48wQcNRVp5ERyNiwY4edKWJp
	 ssOC8ph8Xw4Z1chImLeNT3xW/SAG/8Xuq6cexCKoRivkvg5sl5o4qBw09f4YBOL+US
	 TAb/SHLe/znn+H5AP7F2nDGpYF6+hIzezxI9GFvlmZX0WzoDuHmMG5V2miMdzdWtan
	 Rqwgc4Ll0UztPC5yRiS2SNtSXfI7wpdZ2qbrakq/RSwTzpv1GL5TpVeEDR2iKAInIU
	 rCj+lRm1/tlCMxuw+zkoVmalgx/3aLcN3mBbjiuguIpQu76JInS7vurHAPWMdS7E0F
	 /B/TJN8zz1Sig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 26/27] KVM: s390: arm64: Implement basic page fault
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20260706085229.979525-27-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-27-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:03:47 +0000
Message-Id: <20260706100348.199231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Guest-triggerable WARN_ONCE via KVM_BUG in kvm_handle_pic leading =
to host DoS
- [Low] Unused parameters in user_mem_abort function signature
- [Low] Type mismatch: Assigning macro FOLL_WRITE to a boolean variable
--

commit d14fe466e599e9b62bd9a5838ffa35d7c0a359d1
Author: Steffen Eiden <seiden@linux.ibm.com>
Subject: KVM: s390: arm64: Implement basic page fault handler

This patch adds host functionality to page in guest memory and aborts
guest execution if the guest does something unexpected or illegal.

> diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> new file mode 100644
> index 0000000000000..d5acabd762ba4
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/mmu.c
> @@ -0,0 +1,178 @@

[ ... ]

> +static int user_mem_abort(struct kvm_vcpu *vcpu, gpa_t fault_ipa,
> +			  struct kvm_memory_slot *slot, hva_t hva)
> +{

[Severity: Low]
Are the slot and hva parameters needed here? They appear to be unused in
the function body.

> +	struct guest_fault f =3D { };
> +	int ret;
> +
> +	if (kvm_s390_cur_gmap_fault_is_write(vcpu))
> +		f.write_attempt =3D FOLL_WRITE;

[Severity: Low]
Is it intentional to assign the FOLL_WRITE integer macro directly to the
write_attempt boolean field?=20

Would it be clearer to assign this to true instead?

> +	f.gfn =3D gpa_to_gfn(fault_ipa);

[ ... ]

> +static int kvm_handle_pic(struct kvm_vcpu *vcpu, bool *translation)
> +{
> +	switch (kvm_vcpu_fault_pic(vcpu)) {
> +	/* expected cases: */
> +	case PGM_ASCE_TYPE:

[ ... ]

> +	case PGM_PROTECTION:
> +		break;
> +	/* unexpected cases: */
> +	case 0:
> +		KVM_BUG(1, vcpu->kvm, "On MMU fault path but no fault occurred");
> +		return -EFAULT;
> +	default:
> +		KVM_BUG(1, vcpu->kvm, "Unexpected program interrupt 0x%x, TEID 0x%016l=
x",
> +			vcpu->arch.sae_block.hai.pic, vcpu->arch.sae_block.hai.teid.val);
> +		send_sig(SIGSEGV, current, 0);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Does this allow a guest to trigger a host WARN_ONCE and potentially a kernel
panic?

For faults like Alignment Faults or Synchronous External Aborts, S390 hardw=
are
might not report a DAT exception, meaning hai.pic could be 0 or an unrelated
code.

Can an unprivileged guest performing an unaligned memory access hit these
KVM_BUG() paths and crash the host if panic_on_warn is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D26
