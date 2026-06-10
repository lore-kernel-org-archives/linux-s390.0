Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07A732B9A1
	for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102026; cv=none; b=f4b0x6XM5JC1WbI7kdFMkvJedgmXrwgGI31+LsnWUG98K4FkZgBZ4H26AiIhLn2keghUR8cQ1fn6DARioD7z/5nByb3Ay1TCJcLGkx/R3uumTx+B/IvyNlUH0RXA9mTpmWAEsKGUAaMWQGcl4cVdMB1fSEzra91CI2EPrkLuml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102026; c=relaxed/simple;
	bh=Yvn8AhY/Y76aTlSXknTuKpVzy+wldXOy6vbPcn1IBXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ju+tAvcbaKkWoEfgjbgWfl1iMNNPQn1Mthrzh9Boe3WX1hJM0n8aWJXhLL/CK5B/qXxAumckooxdtPKMFTacOrHPzKzXX910FDMQ5Ex7tCGzL/7XmfvaVWgmhcvVX0kFkniZ0HJP4TnlrCpD9dKymv9rcdpruZc4l+AJ/3p7A1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOTecDwY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOTecDwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E371D1F00893;
	Wed, 10 Jun 2026 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102025;
	bh=Nc4WWGysk4BX4jXdA7yrMnTVb1/myijYZec3dC5qscE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MOTecDwYbCzd7OL0TnmzLqSOFlpDCffMVA3xzE8KS/UcWY21SZ/2ofWWhGuB1M9TI
	 54v4JOXWtCCeJ+iU57PvVsR2AQGjzdcnBUFFxUG2BfOsO6Q3n9bQ25RwfE2FrfuxK5
	 jOStm3hximRI3bD7AzRjj1uzoS33wTvvgyi/R4xaZNqIRr2o1OKBg1SLPJwy87KlA/
	 NrSwuk9ENYL/3RWhK8J5ukHN3rhRUKLV5j7GRgP/hAUhNma4YBQbnrvgiJyWBtQ8Rq
	 KGgus+9j/nlzCLyEZ/3W54vx+2NSryNhJhecny9Q1HqjrgIJHk/IGUJbkCX/NkCHmI
	 I8MbUpNh0KkyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate
 Kconfig
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sumit Semwal" <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260610142329.3836808-1-sumit.semwal@linaro.org>
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:33:44 +0000
Message-Id: <20260610143344.E371D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional page re-encryption in error path causes potential me=
mory leak and invalid hypercalls
--

commit 611c6660a2bb2f9f324ce349cfce6b2530846d28
Author: Arnd Bergmann <arnd@arndb.de>

dma-buf: move system_cc_shared heap under separate Kconfig

This commit moves the system_cc_shared heap into its own Kconfig symbol,
DMABUF_HEAPS_CC_SYSTEM. This resolves a build failure on architectures like
powerpc and s390 when the system heap is built as a loadable module, since
the set_memory_encrypted and set_memory_decrypted functions are not
exported to modules.

> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> index c92bdec356fcc..71d9028cc3dfc 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
[ ... ]
> @@ -485,7 +488,7 @@ static struct dma_buf *system_heap_allocate(struct dm=
a_heap *heap,
>  		 * Intentionally leak pages that cannot be re-encrypted
>  		 * to prevent shared memory from being reused.
>  		 */
> -		if (buffer->cc_shared &&
> +		if (cc_shared_buffer(buffer) &&
>  		    system_heap_set_page_encrypted(p))
>  			continue;
>  		__free_pages(p, compound_order(p));

[Severity: High]
This isn't a bug introduced by this patch, but does this error path
unintentionally re-encrypt pages that were never decrypted?

If system_heap_set_page_decrypted() fails during the earlier loop in
system_heap_allocate(), it jumps to the free_pages label. However, the
cleanup loop here uses for_each_sgtable_sg(table, sg, i), which iterates
over the entire scatterlist starting from index 0.

This means pages after the failure point, which were never decrypted, will
still be passed to system_heap_set_page_encrypted(). If the underlying
set_memory_encrypted() call fails on already-encrypted pages (e.g., due to
hypervisor state enforcement), the code skips __free_pages() and leaks the
memory.

Could this loop be modified to only re-encrypt the pages that were
successfully decrypted before the failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610142329.3836=
808-1-sumit.semwal@linaro.org?part=3D1
