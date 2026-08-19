Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76CC37B41B
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130481; cv=none; b=nirxfqBfHAy8hOqzB/6RlhUqiYdy/fo7eGS7oP0I7j5fcPHWeoe3TLqPVCMZvYdgnf5e1dusWf6vmHz9NW4OAJgCT7NTD4iSHO3v07OvbVCSiIzxLrzqd6TPpKf7mYp9OOdlt7X8otYF5kXzMDTBcrkp7k+xhSAweWn9b5UY+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130481; c=relaxed/simple;
	bh=GhJZsS7fnKkiEqgaPDE74QMWDdrYtzY0H60r5ALuXw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d1h7DlvHbRYXszeehu6DvVleZB6dN3+iii94v7C9Q1BgYo4hBc5YWDRdIQwYf9wX9ZtUTDxfbYxgZOYzL11jTxDWAONYNSazEsMh+R5nQcE3xB0GZpbWxAJp7UOtNdDrOQUlfMnI1BXFuJr7wDNeeoSMwmz1gy8bvwaaSPznp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMjxDB+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMjxDB+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4051F000E9;
	Wed, 19 Aug 2026 09:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130477;
	bh=lXesPxmkJ5KwRwiAUbLPx/bCQIxwOQtDs8z70u9gbwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMjxDB+uzoLaHXl2P2ZwpkgTFgf+qtCIj5h3N87k4BCDMvScnWs7D65EDFN/4fBWR
	 FaQJq+kxZWwkrW+aEJ7fjZfRnEhwvJW/oex/GiTC0KiqswY3D4taBHZm66Y1KTbaHA
	 aTXPSZy2u0eEh6ke6PuseLVwAUr4Kk4HeRj2ls+hDhDksO0dwrYnV95TLNbFQhz9H0
	 uitw5/6nd/gyaUluitPzptYK4GDHg2kSwxWYUAIxZ+LHBSN9xtJ9cjoKVZEQ9ONeNZ
	 AhPc+331aEmmZjBD+rz/8nKgzNNSuzWwxlS20T+BhUOd1Nl3ohpuEXu4Cujufhzdgf
	 nBef6VeZbOfKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] s390/pci: fix MSI directed-mode teardown IRQ bit
 count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-4-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-4-826ff27b6e97@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:07:56 +0000
Message-Id: <20260819090757.3F4051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double-addition logic error in `zpci_msi_clear_airq()` causes out-=
of-bounds memory writes and leaves dangling pointers.
- [High] Directed MSI teardown leaks uncleared hardware vector bits on CPUs=
 > 0, causing spurious interrupts.
- [Medium] Missing RCU pointer assignment when publishing `zdev->aibv` to `=
zpci_ibv` array.
--

--- Patch [4]: [PATCH 4/7] s390/pci: fix MSI directed-mode teardown IRQ bit=
 count ---
commit 061bcdd7920b9b7d42fc840ba0aa403eaf0255a5
Author: Tobias Schumacher <ts@linux.ibm.com>

s390/pci: fix MSI directed-mode teardown IRQ bit count

This commit updates zpci_msi_teardown_directed() to free the actual number =
of
allocated MSI bits (msi_nr_irqs) instead of the maximum supported by the
platform (max_msi). This prevents freeing bits that were not actually
allocated, which would corrupt the shared IRQ bitmap.

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 5e934ac990ac1..e9eda846cb2d2 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -349,7 +349,7 @@ static struct airq_struct zpci_airq =3D {
> =20
>  static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
>  {
> -	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->max_msi);
> +	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);

[Severity: High]
This is a pre-existing issue, but does this leak hardware vector bits on CP=
Us
other than 0?

It looks like this only clears the vector bits for zpci_ibv[0]. Since CPUs
greater than 0 have zpci_ibv[cpu] created without AIRQ_IV_ALLOC, their avail
mask is NULL, and airq_iv_free() returns immediately without clearing the b=
its
in zpci_ibv[cpu]->vector.

If a pending hardware interrupt bit is left set on a CPU greater than 0 aft=
er
device teardown, could reallocating that bit index to a new device trigger a
spurious interrupt on that CPU?

>  	zdev->msi_first_bit =3D -1U;
>  	zdev->msi_nr_irqs =3D 0;
>  }

[Severity: High]
This is a pre-existing issue, but is there a double-addition logic error in
zpci_msi_clear_airq()?

arch/s390/pci/pci_irq.c:zpci_msi_clear_airq() {
	...
	msi_index =3D zpci_decode_hwirq_msi_index(d->hwirq);
	bit =3D zdev->msi_first_bit + msi_index;

	if (irq_delivery =3D=3D DIRECTED) {
		for_each_possible_cpu(cpu) {
			airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
			airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
...
}

During allocation, irq_domain_set_info() is passed hwirq + i, so d->hwirq
already incorporates the index i. zpci_decode_hwirq_msi_index(d->hwirq)
decodes this to desc->msi_index + i.

Since bit is calculated as zdev->msi_first_bit + msi_index (which already
includes i), clearing bit + i evaluates to base + 2*i.

Does this skip odd-indexed entries and write out of bounds when clearing,
leaving the intended MSI vector entries dangling?


[Severity: Medium]
This is a pre-existing issue, but is an RCU pointer assignment missing when
publishing zdev->aibv to the zpci_ibv array?

arch/s390/pci/pci_irq.c:__alloc_airq() {
	...
		/* Create adapter interrupt vector */
		zdev->aibv =3D airq_iv_create(msi_vecs,
					    AIRQ_IV_PTR | AIRQ_IV_DATA | AIRQ_IV_BITLOCK,
					    NULL);
	...
		/* Wire up shortcut pointer */
		zpci_ibv[*bit] =3D zdev->aibv;
}

The interrupt handler zpci_floating_irq_handler() correctly uses
rcu_dereference() to read zpci_ibv[si]. However, this plain assignment
publishes the pointer to readers without the required RCU compiler barriers.

Could compiler optimizations like LTO reorder the initialization of
zdev->aibv to occur after the pointer is published, allowing a concurrent
interrupt handler to read uninitialized structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-s390_irq_d=
omain_fixes-v1-0-826ff27b6e97@linux.ibm.com?part=3D4
