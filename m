Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F06390C9E;
	Wed, 12 Aug 2026 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551791; cv=none; b=qUlji7Ou/J26sfHYP9o5YV4uuLZUtyyMowBuMFTXN/hgtqg6AjmIa2ibgKzg/tX9p8Mm7BsVAaPrCSSsuwhKoAmBlXsvaJpayAqqxoKJn7b5oze2GAc3mEm4RPrY9JSojTUUIzC6W20duLcx6Z5fwHnGnv0BEuT+HR2brtB5sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551791; c=relaxed/simple;
	bh=GsPIXN+Cdb7dAyWMqyUdrbobMPl8QFUvZt9VouzJBfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m2SbZUem9MWKD/hzSkYuEsSHNUsgm3+nEY+vbFTFS1KxOHFss8UEIwZ4HO+7MCFRoBy5bmeD8vcnQrrbEOy08Ot8LeI6/9L8nA0Xv3I9zwotS3HCMaISZIUBPhzWZSmrO4QHApYE3LC8QnVsBevtJmwAKqCLNzLqUSheCAaQuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktTNEVrh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktTNEVrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D421F00A3A;
	Wed, 12 Aug 2026 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551790;
	bh=6+BIX1UqWE/IyyvWHrWwS4BMZ6hGtjYxu8C2kdXlI38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktTNEVrhrsETeppWbEGVKg7WSENh2YzsNCc5mSgPc2y+lUmRiHMnRK6miHTANF86s
	 WipZ4wRWEpeMTIzOntJv17CIrjRP7KouQId+8mN3+8FHc6tbXf6yvlz0v2RoNQNDkc
	 UrTfrxmd1YP8EJmNCB9xzizBoHPx1CwXutJL27taW+Baoisivyav+m5Dzeq/YyQeca
	 XVD6aestqfxJlZYvi7rOnEokMvzyzlL5cIeX3srW3GPW7A6h3x1KAqffDbL30u8J29
	 AtN+K9YniTkIgJFQFu2HwD1N2dB5HBdsukcnzm7rjLCUJe711kdCm9wTjIN7nMHI7H
	 p16LUGamcfj5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 28/33] KVM: s390: Add basic arm64 kvm module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvmarm@lists.linux.dev
In-Reply-To: <20260812153631.3376090-29-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-29-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:23:09 +0000
Message-Id: <20260812162309.98D421F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Integer underflow in `kvm_max_guest_address()` bypasses KVM IPA li=
mit validation for systems with less than 1GB of max address.
--

--- Patch [28]: [PATCH v6 28/33] KVM: s390: Add basic arm64 kvm module ---
commit 57ce89696f07b8212cf2fc85a369b60b1ec4f89b
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Add basic arm64 kvm module

This commit adds the initial architecture-specific KVM infrastructure for
supporting arm64 guests on s390 hosts. It includes basic module
initialization, tracepoint scaffolding, and API skeleton functions.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> new file mode 100644
> index 0000000000000..8e17b7eef8131
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/arm.c

[ ... ]

> +static u64 kvm_max_guest_address(void)
> +{
> +	u64 max_addr;
> +
> +	if (sclp.hamax =3D=3D U64_MAX)
> +		max_addr =3D TASK_SIZE_MAX;
> +	else
> +		max_addr =3D min_t(u64, TASK_SIZE_MAX, sclp.hamax);
> +	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;

[Severity: High]
Can this underflow if max_addr + 1 is less than 1GB (1 << 30)?

On a system with a small maximum address limit, ALIGN_DOWN() will evaluate=
=20
to 0. Subtracting 1 from 0 will result in a U64_MAX return value, bypassing=
=20
the intended limit.

> +}

[ ... ]

> +u32 get_kvm_ipa_limit(void)
> +{
> +	return fls64(kvm_max_guest_address() + 1) - 1;

[Severity: High]
If kvm_max_guest_address() underflows to U64_MAX as mentioned above, does=20
this cause get_kvm_ipa_limit() to return U32_MAX?

Adding 1 to U64_MAX wraps to 0. Calling fls64(0) - 1 would then evaluate
to U32_MAX. This effectively disables the IPA size limit validation in
kvm_vm_type_ipa_size_shift(), allowing userspace to request unsupported
IPA sizes during VM creation.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D28
