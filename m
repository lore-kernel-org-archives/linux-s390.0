Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEE474255;
	Wed, 12 Aug 2026 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552498; cv=none; b=tGFz3KbiariNgfgcl2f/yBJkoUGE6to6cu2SvK0Y+CpQ+FvQKgywzuxQDN8z9YPglg0LHMbc4d2kVPgNYfkZGpjFcC2oZzry5E1vWojPNxn8XyC5EY4C06jbWagsi3vfOKSf5QkimhcoTTmolG43ISUDBPVhO8le7uSOy4O4ZE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552498; c=relaxed/simple;
	bh=bXPw2zrr3HNv+m8YFn+LFkOKPx459ndG5pwc8rj+GeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MuO5LgYfy3g5fO6dX0flv9X6LPsucUSuC7Nu+8+SqV0XxAUp5ylwUu6RaRDBpXojOKGq4EdHhf/hvl7knXnJMdzLLea+kNDLDJYuwsTZ09JjocxB3WOhaU0GV4F+ccDDuKT/ebP3rkMeejH++DvTDavY5Y8g3z8s3U+G15Qp4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN6B0Pby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN6B0Pby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE411F00A3E;
	Wed, 12 Aug 2026 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552495;
	bh=upbWTzqNqM69HHErB/pnhM+z1EMh2CSTyRgg19hTYik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BN6B0PbykivghP3eIWEIQE6qwIyx/jl+16xazgtlBsUMlKwj8L9ZU4ZMrvIL2Truf
	 CXDnHEirGrH9asaoUM/aBOoT5ANgzlY/eSmPfvHnPRFXlYvxQWkp1V7Uxw2cHANkfS
	 ZsmGOfjQwrJakgeloxJF0ClEJ3AUFDXOcI1AVMthjz2CU8hEOEESoI20AyVYfl+0Jq
	 4dHHsd95UD3eTwpT28qlGHUZpOS+DG0r3dI6f0LunfJ5VDd9YkhzZh512zwfG5Opj9
	 JBYGqyP7bmaiiaLjOuZ0lMw2FaKRUb/8/GDVG0SBwKFadwV27dxqUwbah9rKPbj/M7
	 r5XuUMd/ZNnsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 32/33] KVM: s390: arm64: Implement basic page fault
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-33-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-33-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:34:54 +0000
Message-Id: <20260812163454.AEE411F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Guest-triggerable KVM_BUG on unexpected program interrupt codes (P=
ICs) causes host denial of service.
--

--- Patch [32]: [PATCH v6 32/33] KVM: s390: arm64: Implement basic page fau=
lt handler ---
commit 1cc2a3fc0641697d83c316659559bcf0aaa389a1
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement basic page fault handler

Add host functionality to page in guest memory. If the guest does
something unexpected or illegal exit to userspace abort guest execution.

> diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> new file mode 100644
> index 0000000000000..71cd582f24ff8
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
Does this KVM_BUG() allow a guest to trigger a host warning?

If a guest performs an action that triggers a hardware exit with an
unexpected program interrupt code (like an alignment fault that exits with
pic =3D=3D 0), kvm_handle_pic() falls into these branches.

Since KVM_BUG() expands to a WARN_ONCE in the host kernel, this could
cause a host kernel panic on systems configured with panic_on_warn.

Should this cleanly return -EFAULT to userspace to gracefully abort the
guest without asserting instead?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D32
