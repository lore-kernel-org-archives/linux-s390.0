Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC0471CE9;
	Fri, 18 Sep 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754160; cv=none; b=ImB1JdThsWBWQzkruiCPklq4N9nK28SocoYhJX4vdNBV1Sa+/FIMoFuJCnaDqsIFZlKjlEkZalAq+jqcmuDR3lLZbRMV2tOaRYymq3z8ZuTMork7qCMO1cljS8Ke1s8EULpuH1ta9XnCR7n7fR9GhfAAyqioA7Ix+ERxAnvAilA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754160; c=relaxed/simple;
	bh=u6zbyZGrxyPaOukyeq77VIycE0N8x/yRkqNyfpClM8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GCKQFHEX2TZEcHYsst82BhrQFTH7v9+8kSZNJAnfSjEDQJ17imiD8xguGL3orRVlqPF0FsjjZlk3C8h7gDSCJ6WUKB4RhSGRzz2KoUdtUl9B8QYqLETPLVVdBl2i2GdeVgv7Qi2jOhS/1gl+XLeQoDB3G/eXEap/yMu9w8rZ6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpRpBAi/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpRpBAi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2046E1F000FF;
	Fri, 18 Sep 2026 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789754157;
	bh=8BDOxGp6J+0EcMpO+HshK37ct1Infhuo3rpBqPtoTes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JpRpBAi/rYsFSpK56c3wPsbV+dnezrfuSIXkUTt5M9p55aRT2AiewgSKqXG71SWrJ
	 4VFYsngc9x4e3nPIRAfvu+KRM5fY9G7JTc6AuodLF2A/IPLeRxVxGYm1jrts3F7AC6
	 5oR78a6pprz9r76UhGp9qVypFsYrzU44yRdDV9JKyGsauuSfygZKMtDoST4zBrdxhe
	 LOnns01xHD8CQRBHfR/1QkdARkZdKqi+9Xhxj+x6ZApOX6fmkKF1jPPtnjQZr6qJHf
	 nmwF9eQMLYTimf76BPRZAa3b+ZAlESi16iFULs/uEDgS7cHcwEGRL00edWIWegB9Zt
	 Nf8qSAzWJxQUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 27/29] KVM: s390: arm64: Implement basic page fault
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-28-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-28-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:55:56 +0000
Message-Id: <20260918175557.2046E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: arm64: Guest-triggerable KVM_BUG in kvm_handle_pic() causes h=
ost DoS
--

commit 3f769665af940a4bd5628fcd7a471a6e0e436b79
Author: Steffen Eiden <seiden@linux.ibm.com>
KVM: s390: arm64: Implement basic page fault handler

This commit adds host functionality to page in guest memory. If the guest
does something unexpected or illegal, the host aborts guest execution and
returns to userspace.

> --- /dev/null
> +++ b/arch/s390/kvm/arm64/mmu.c

[ ... ]

> +static int kvm_handle_pic(struct kvm_vcpu *vcpu, bool *translation)
> +{
> +	switch (kvm_vcpu_fault_pic(vcpu)) {
> +	/* expected cases: */
> +	case PGM_ASCE_TYPE:
> +	case PGM_REGION_FIRST_TRANS:
> +	case PGM_REGION_SECOND_TRANS:
> +	case PGM_REGION_THIRD_TRANS:
> +	case PGM_SEGMENT_TRANSLATION:
> +	case PGM_PAGE_TRANSLATION:
> +		*translation =3D true;
> +		break;
> +	case PGM_PROTECTION:
> +		break;
> +	/* unexpected cases: */
> +	case 0:
> +		KVM_BUG(1, vcpu->kvm, "On MMU fault path but no fault occurred");

[Severity: High]
Does this allow a guest to trigger a host denial of service?

If the hardware reports an abort without an underlying s390 PIC, such as
non-translation traps like cache maintenance, an untrusted guest could reach
this path.

KVM_BUG triggers a host WARN_ONCE, which panics the host kernel in
environments configured with panic_on_warn. KVM architectural guidelines
forbid assertions that are reachable by untrusted guest inputs.

> +		return -EFAULT;
> +	default:
> +		KVM_BUG(1, vcpu->kvm, "Unexpected program interrupt 0x%x, TEID 0x%016l=
x",
> +			vcpu->arch.sae_block.hai.pic, vcpu->arch.sae_block.hai.teid.val);

[Severity: High]
Could a guest also trigger a host panic by hitting this default case?

A malicious or fuzzing guest might execute instructions that generate an
unexpected ARM abort syndrome or access memory topologies that result in an
unhandled PIC, such as PGM_ADDRESSING.

Similar to the case 0 above, using KVM_BUG here allows an untrusted guest
to reach a warning, potentially crashing the host.

> +		send_sig(SIGSEGV, current, 0);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D27
