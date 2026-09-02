Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D7314D34;
	Wed,  2 Sep 2026 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330363; cv=none; b=M8y57igzkMCIdvUlAjfg6q04KYFqe1ybxgxgiCbe7iGZ6NMO8j3VhyhDfmTV+QIHZwt4rHT71JahNctMsBOzIYhjF1P9/QeluXsWkm1+q4W4jF13G1lDLJVofd1FU5HIbJrKtnGs4hQ6U0oCJHDLZRYUWezyqopdRxxNbWckKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330363; c=relaxed/simple;
	bh=cmBdgpBCDt6+Cw5E5zbEhPukdgSxBOlBKAiKAHgyWoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G8vsaIc1scIWtqLeCrNiHJVgZwZAtiIAiimpFeQyQNmYs/OSLJJL+Le5b7cRR+FNBn/pULDWZjmxY14qavAqKJk4TNXe+eErSZa5mU5osClQX70j99s4XHssVYxwhGRXhHaQcggB/1ZR1RprWtmj62Zyl5Z4z1M+Lodj/PkYfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nck/U1Y3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nck/U1Y3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043D51F000E9;
	Wed,  2 Sep 2026 06:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788330361;
	bh=vkrGUJpY8Glplvp34/zjSgW/Ni6b3UzBiaGYnfvY0oM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nck/U1Y37zF2+MclaYf91rlCOvgyQhSebM1dYuMXWu6e13h5Ow20Hfm6I0c33iEXL
	 DW74SAgYVza8TVBm4oajv1oIYTGfFUpB/tulI14UoEODDWfDu0WSzi9YLZCXBR6e5L
	 otzrQnSV3Z5rT4ZavYyQRrhDVJkm9zlrFQpPmviN+a4qzntDCUNZ7fUKTYaAebtpgb
	 odH98r65x8PhRs6eUpxqapo6IFvXE3zs6Tny8POqD9LVfDdhHcKEsWfTOZPbC+2iIg
	 T6AMsslzboY61bW7QO//ZgcV/enCeQ29KT4DebevOj2bCG1SjABUb1/q3rfq99Jjam
	 YghPNztptVocQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] KVM: s390: Replace get_zeroed_page() with kzalloc()
 for sie_page2 and CMMA
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260902-s390-kvm-v1-4-3bc0986550b1@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
 <20260902-s390-kvm-v1-4-3bc0986550b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:26:00 +0000
Message-Id: <20260902062601.043D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Invalid free in SLUB allocator due to passing an unaligned interio=
r pointer containing hardware-injected offset bits.
--

commit 7888b46f989fd0725fe9f7dbcee943460aa8c059
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

KVM: s390: Replace get_zeroed_page() with kzalloc() for sie_page2 and CMMA

This commit replaces usages of get_zeroed_page() with kzalloc() and
free_page() with kfree() for allocating sie_page2 and CMMA blocks in the
s390 KVM subsystem. It aims to simplify the API usage since power-of-two
sized kmalloc() allocations are aligned to their size.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index b0839e887221e..8ec505060f8c0 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c

[ ... ]

> @@ -3657,13 +3657,13 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm=
_vcpu *vcpu)
>  void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu->arch.sie_block->cbrlo)
> -		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
> +		kfree(phys_to_virt(vcpu->arch.sie_block->cbrlo));

[Severity: High]
Does this code pass an unaligned interior pointer to the SLUB allocator?

During execution, the SIE hardware modifies the lower 12 bits of cbrlo to
store the Next CBR Entry Offset (NCEO). On VM teardown, if the hardware
has updated this count and it wasn't explicitly reset, the unmasked cbrlo
value is passed to kfree().

The previous free_page() implementation safely dropped these offset bits
because virt_to_page() implicitly applies PAGE_SHIFT. However, kfree()
requires the exact, unmodified pointer originally returned by the allocator.
Passing an interior pointer can lead to immediate freelist corruption and a
subsequent kernel panic.

>  	vcpu->arch.sie_block->cbrlo =3D 0;
>  }
> =20
>  int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu)
>  {
> -	void *cbrlo_page =3D (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
> +	void *cbrlo_page =3D kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
> =20
>  	if (!cbrlo_page)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-s390-kvm-v=
1-0-3bc0986550b1@kernel.org?part=3D4
