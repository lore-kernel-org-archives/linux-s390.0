Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675D3F12EF
	for <linux-s390@vger.kernel.org>; Sat,  5 Sep 2026 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601521; cv=none; b=M66zGyPVG5cT9+YOqU4lgh8Z3PWBhkLAX3n14JZMbLBcCu7egwPTzHcllGOV/G2yVtxzpcGyH5+Ol3fv3ud5fuSUbl2V5g3vDTfBMWGTiRZkQ/Gc3cddaIh03GZJIQMKlrj5F0f7Gu0LXiSSZhKnOJBrPXRvBhk7T4wkIMUoyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601521; c=relaxed/simple;
	bh=jBhqe9iACA+qkw6TOOA4jqnL6Qu1omomiXcheujB57g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UCsdRUSTY7aRUlAeoKekmOkTMR+lsIirg2YyiaMFMeWCE1NlbXBVaxY9HAWiD0IzC6EncqPMq56dQS/BukaUxJl8DVBAkhee8hOvp47+FkwWZl1P2Ic3TwAowIIWV3XO5PVgL5sGVMm29uQkHdDMa02nteRR9oYMXuK0Fsc2BPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2F5WSdS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2F5WSdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65911F00A3D;
	Sat,  5 Sep 2026 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788601516;
	bh=eLps9hN7rTnTkxOHLlSpk2+ReSv63CXDxVJlqRk/GJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2F5WSdSAmoI9SjTwbuZVokbgXLtLGbLAlwYhaRcINDctiFdntM945Et4nhTon+Uk
	 dKsbfRKAYDEzd5lr/WvQtHw586FiDCj1PC5Y1NZah4q2/9oTGoWGKTihRtmTucX0Zr
	 qelhBmyKJrXk607KbKeYdbhPsVrcH0OUplYJLTJQ2uUVbjZPla1R/GUPjtKe52HdIP
	 60WWsPmafnNi58T0nE/3HyPAFwwRDZYj3Mvos4Sme5xnksh85iaR+ihh2NXCXlsnuE
	 FpddcBZS4cLXnSOzkYzDhfon+skXbJ8AGhS69HWEyXmBTiDpP5ZtvGDSI+hfwfc3QU
	 JWUZ4wo5fEtjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] dibs: Avoid inconsistent lockstate warning in
 dibs_lo_move_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandra Winter" <wintera@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260904094446.1342654-1-wintera@linux.ibm.com>
References: <20260904094446.1342654-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 09:45:15 +0000
Message-Id: <20260905094515.D65911F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe error path calling kfree() on memory allocated via folio_al=
loc().
--

commit 71f881ca9b5f87a2235598ada197106f8482dccb
Author: Alexandra Winter <wintera@linux.ibm.com>

    dibs: Avoid inconsistent lockstate warning in dibs_lo_move_data()
   =20
    dibs->lock is acquired in process context and interrupt context
    (ism_handle_irq()). So always use spin_lock_irqsave() in process contex=
t.
   =20
    Note that this is not a real deadlock, as dibs_lo devices don't have
    any interrupt context.

[ ... ]

> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
> index 649e4e375be33..44a2e74c2efcb 100644
> --- a/drivers/dibs/dibs_loopback.c
> +++ b/drivers/dibs/dibs_loopback.c

[ ... ]

While reviewing this commit, I noticed a pre-existing issue in the related
ism_alloc_dmb() function:

drivers/s390/net/ism_drv.c:ism_alloc_dmb() {
[ ... ]
	folio =3D folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
			    __GFP_NORETRY, get_order(dmb->dmb_len));

	if (!folio) {
		rc =3D -ENOMEM;
		goto out_bit;
	}

	dmb->cpu_addr =3D folio_address(folio);
	dmb->dma_addr =3D dma_map_page(&ism->pdev->dev,
				     virt_to_page(dmb->cpu_addr), 0,
				     dmb->dmb_len, DMA_FROM_DEVICE);
	if (dma_mapping_error(&ism->pdev->dev, dmb->dma_addr)) {
		rc =3D -ENOMEM;
		goto out_free;
	}

	return 0;

out_free:
	kfree(dmb->cpu_addr);
[ ... ]
}

[Severity: High]
This is a pre-existing issue, but does calling kfree() on memory directly
allocated by folio_alloc() cause a kernel panic due to invalid slab metadat=
a?

When dma_map_page() fails, the execution jumps to the out_free label, which
incorrectly calls kfree(dmb->cpu_addr) instead of using folio_put() as seen
in ism_free_dmb().

If a user exhausts DMA mapping space (e.g., filling up the IOMMU or exhaust=
ing
bounce buffers), could this error path be triggered resulting in a denial of
service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904094446.1342=
654-1-wintera@linux.ibm.com?part=3D1
