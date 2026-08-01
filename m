Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8173B776A
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608104; cv=none; b=rDdIWpKhMA8JdTPY5imR8h2nk30dmx/hBxINmirqSbactw/Mg+I8nnSvhIQPpzue/xBzjtUPbxLwfOeP/pYiemf8rHh47Q7KD1nxt9NAt7BqgjRyA77IigmeJXAAf+AriNUhdDpsuD4aceXHbTdY0JJ+azVLGexXqJ1BuSWEMcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608104; c=relaxed/simple;
	bh=W3KOmkeYvrOk2eYGBccTXF9nt9VLsmDaU1sH09HQONY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1cc1Zg7ffjbvF53MUI2R01UZwNXXftrHLxpSXl2ZXiZenl+z0bdClnbSDVF2AfaZCqd6h30lySeW9y5NiLQ1pHWcxx6wOfLncE3PGPbrqkLmUsB1h/IYAYSiNEs41l/ST9Zv14H1bq6ny9PBCC9BFmjFp1DWH2zZMXYNjAVi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INHsi6MN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INHsi6MN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958061F00AC4;
	Sat,  1 Aug 2026 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608102;
	bh=9mDwMJ8AbKKO7SPKcLw1QUNYlwWARJoc4RPDyYNOoTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=INHsi6MNGt3c5ovop1M5B0a176oXX3omm2D5Cb2NdbZbcib2dBE4qB5k7U6/65M+A
	 Mxp/2o23kGIqJ6IsZajJElv/pTEBxrM5615/4YFZif+JywPrwPpZWlBK0lUC3JcTUl
	 3n8aSUaGQRIf9px2mwrnBuKfTXpC8C2KvNmR6+s7PI2mMtVuawQt/vgaDf8fjX5WeJ
	 uOEeVg1s5kQz4MJacLGRptzilK3JxSKUl974uSI97mxlSaIhUcw02bl6BsRCaRRI2k
	 747GOp5T42vk5TOBsFZrtM0k3eWQRB+BD/n3Flzjpv96qvsfen06PI3PW5cZADjqrx
	 xGKR3itFjVVIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/19] s390/dasd: Use GFP_KERNEL in
 dasd_alloc_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-7-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-7-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:15:02 +0000
Message-Id: <20260801181502.958061F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free on `cqr` during spinlock release in `dasd_flush_blo=
ck_queue()`.
--

--- Patch [6]: [PATCH v7 06/19] s390/dasd: Use GFP_KERNEL in dasd_alloc_dev=
ice() ---
commit a4cb04e072a32106527d386076e01c8c126cd561
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Use GFP_KERNEL in dasd_alloc_device()

dasd_alloc_device() runs in process context (device set_online), so its
pool allocations do not need GFP_ATOMIC. Use GFP_KERNEL instead, which is
more reliable, especially for the larger DMA allocations that later ESE
full-track work adds here.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index f5585c549e09e..d0f72d3d0f541 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c

[ ... ]

drivers/s390/block/dasd.c:dasd_flush_block_queue() {
...
		spin_lock_irqsave(&cqr->dq->lock, flags);
		cqr->endclk =3D get_tod_clock();
		list_del_init(&cqr->blocklist);
		__dasd_cleanup_cqr(cqr);
		spin_unlock_irqrestore(&cqr->dq->lock, flags);
...
}

[Severity: High]
This is a pre-existing issue, but does this code cause a use-after-free on
cqr?

__dasd_cleanup_cqr() calls free_cp(), which frees the cqr request block back
to its memory pool.

When spin_unlock_irqrestore(&cqr->dq->lock, flags) executes immediately aft=
er,
the already freed cqr structure must be dereferenced to read the dq pointer.
Could this result in using a poisoned or invalid lock address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D6
