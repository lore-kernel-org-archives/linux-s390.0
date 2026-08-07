Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F524354AE3;
	Fri,  7 Aug 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119159; cv=none; b=Ijim4Snkvn4oq/rXCrjuqIwOPaQ06AzBfbSEXfEchNctPJhDjz1yaD6Tr141OGDb0UYHeUl0NWWq25qSn4/slpOy55oigEkPhCvHlZ6yo1SXcVE4DNx84PtLK6uIDCv8Nwq4zCRehFKtBmwVqj6GCvtV2weHQL7BiYZziz83dSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119159; c=relaxed/simple;
	bh=PIAu/w7czezb2YdoQGRZVByTcp8qsnlnoJkI1gEbWGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BMVKa24Grs9AG/VhN604KdoVQrInTRWmuYV1uZFtHWfpR/Xx8rMLdiDnEO9sPh8jgrER2M3GCgBwdh6Qv3iDRkkNv/a64pNHEa7Z0NCwS0qv6l8EMi6/D4IDcwWQalnTO3yLawJQi1TUfKlYfSlCaKBT9zTTgWKQ15L6Gpmn1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENUM8gng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENUM8gng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA50B1F000E9;
	Fri,  7 Aug 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119157;
	bh=+jNMcyviXOqyIyEem8wHFLHqIG2ElgcHXaIlla/xQKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ENUM8gng0iGZkjG2b+mYbYE9J1ItMtiI+e+hoHjthfD+eQKi2EKisWtvAOdzqlKBy
	 ZNGarW46nB5+J4IDMXNDD224sUnbrDs+M9KOdeA91hJ05nsG9VmjE+Pj99jKbeAYtn
	 KgjXsK24IQf2cxr2tB3doE0d1sQaDc6/On/2GNUISn1BPUwNAZwRfP3P8zxE4rJzOy
	 vRUVlSO+ydqbKg0BOatgN5hye9Ka6Uh7YCW1cNSUyyNYZYzEmrWKKr12q7aBt1s2d1
	 tqMaYy/qgLHH08WmVkAtlAZ7dsRv2TxwAyv1bEoHXE3QeJiD1/PmJLRBN/oyZwlhQP
	 Ncd6PjLCCjZlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] dma-buf: heaps: Add support for Tegra VPR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, media-ci@linuxtv.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:12:35 +0000
Message-Id: <20260807161236.DA50B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [Critical] `tegra_vpr_map_dma_buf()` unconditionally calls `dma_map_sgtab=
le()` on an SG table initialized with a NULL page for static VPRs.
- [High] Ad-hoc invocation of system PM callbacks (`pm_generic_freeze` / `p=
m_generic_thaw`) without `device_lock()` and freezing userspace risks sever=
e data races and hardware state corruption.
- [High] Memory allocated with `kvmalloc_array()` is incorrectly freed usin=
g `kfree()`, which will cause a kernel panic if the allocation fell back to=
 vmalloc.
- [High] `tegra_vpr_setup_chunks()` can calculate a chunk size of 0 for the=
 final chunk, causing initialization to fail.
- [High] Calling `dma_heap_get_drvdata(heap)` before checking if `rmem->pri=
v` is NULL causes a NULL pointer dereference.
- [High] If `tegra_vpr_chunk_activate` fails during the `tegra_vpr_recycle`=
 error recovery path, it causes a CMA memory leak and invalid chunk state.
- [High] Potential NULL pointer dereference in `tegra_vpr_device_init()` if=
 the device has no bound driver.
- [Medium] Unprotected iteration over the `vpr->buffers` list in `tegra_vpr=
_debugfs_show_chunks()` causes data races.
- [Medium] An off-by-one error in `tegra_vpr_find_free_region()` prevents a=
llocations from using the last page of the VPR.
- [Medium] The device node reference acquired via `of_node_get()` is leaked=
 on the error paths of `tegra_vpr_add_heap()`.
- [Low] The `dirty` bitmap is declared using a runtime variable, creating a=
 Variable Length Array (VLA).
--

--- Patch [7]: [PATCH v4 07/10] dma-buf: heaps: Add support for Tegra VPR -=
--
commit c6dee57f094afce846e231b53f10aa5c8c4898a7
Author: Thierry Reding <treding@nvidia.com>

dma-buf: heaps: Add support for Tegra VPR

NVIDIA Tegra SoCs commonly define a Video-Protection-Region, which is a
region of memory dedicated to content-protected video decode and
playback. Expose the VPR as a DMA heap so that applications and drivers
can allocate buffers from this region.

> diff --git a/drivers/dma-buf/heaps/tegra-vpr.c b/drivers/dma-buf/heaps/te=
gra-vpr.c
> new file mode 100644
> index 0000000000000..b56dfa5c7a0a0
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/tegra-vpr.c
[ ... ]
> @@ -171,6 +171,11 @@ static int tegra_vpr_resize(struct tegra_vpr *vpr)
>  	}
> =20
>  	list_for_each_entry(node, &vpr->devices, node) {
>  		err =3D pm_generic_freeze(node->dev);

[Severity: High]
Does this code introduce a data race or risk hardware corruption by invoking
pm_generic_freeze() directly from an ioctl context? These callbacks are
normally executed during system-wide suspend and expect device_lock() to be
held and userspace to be frozen.

>  		if (err < 0) {
>  			pr_err("failed to freeze %s: %d\n",
>  			       dev_name(node->dev), err);
[ ... ]
> @@ -368,6 +368,7 @@ static int tegra_vpr_activate_chunks(struct tegra_vpr=
 *vpr,
>  				     struct tegra_vpr_buffer *buffer)
>  {
>  	DECLARE_BITMAP(dirty, vpr->num_chunks);

[Severity: Low]
Does this introduce a variable length array (VLA)? vpr->num_chunks is not a
compile-time constant, so this expands to a dynamic allocation on the stack,
which might trigger build errors with -Wvla.

>  	unsigned int i, bottom, top;
>  	int err =3D 0, ret;
[ ... ]
> @@ -503,8 +503,8 @@ static int tegra_vpr_find_free_region(struct tegra_vp=
r *vpr,
>  				      unsigned int num_pages,
>  				      unsigned long align)
>  {
>  	return tegra_vpr_find_free_region_in_range(vpr, 0, vpr->num_pages - 1,
>  						   num_pages, align);

[Severity: Medium]
Does this code leak the last page of the VPR due to an off-by-one boundary
check? tegra_vpr_find_free_region_in_range() loops while
pos + num_pages <=3D end_page, meaning passing vpr->num_pages - 1 as end_pa=
ge
prevents allocations from using the final page.

>  }
[ ... ]
> @@ -668,9 +668,9 @@ tegra_vpr_buffer_allocate(struct tegra_vpr *vpr, size=
_t size)
>  		/*
>  		 * Memory is backed by struct page, so track which ones we
>  		 * use.
>  		 */
>  		buffer->pages =3D kvmalloc_array(buffer->num_pages,
>  					       sizeof(*buffer->pages),
>  					       GFP_KERNEL);

[Severity: High]
Does this memory leak or cause a panic if the allocation falls back to
vmalloc? buffer->pages is later freed using kfree(), which will fail for
vmalloc addresses.

>  		if (!buffer->pages) {
>  			err =3D -ENOMEM;
[ ... ]
> @@ -746,8 +746,8 @@ static void tegra_vpr_buffer_release(struct tegra_vpr=
_buffer *buffer)
> =20
>  	bitmap_clear(vpr->bitmap, buffer->pageno, buffer->num_pages);
>  	list_del(&buffer->list);
>  	kfree(buffer->pages);

[Severity: High]
Is it possible for this code to panic by calling kfree() on a vmalloc
pointer? buffer->pages was allocated using kvmalloc_array().

>  	kfree(buffer);
[ ... ]
> @@ -776,9 +776,9 @@ static int tegra_vpr_attach(struct dma_buf *buf,
>  		if (sg_alloc_table(&attach->sgt, 1, GFP_KERNEL)) {
>  			err =3D -ENOMEM;
>  			goto free;
>  		}
> =20
>  		sg_set_page(attach->sgt.sgl, NULL, buffer->size, 0);

[Severity: Critical]
Can this code cause a panic when an importer maps the buffer? For static
VPRs, the SG table is initialized with a NULL page here, but later passed to
dma_map_sgtable() which attempts to dereference it.

>  		sg_dma_address(attach->sgt.sgl) =3D buffer->start;
>  		sg_dma_len(attach->sgt.sgl) =3D buffer->size;
>  	}
[ ... ]
> @@ -806,8 +806,8 @@ tegra_vpr_map_dma_buf(struct dma_buf_attachment *atta=
chment,
>  	struct tegra_vpr_attachment *attach =3D attachment->priv;
>  	struct sg_table *sgt =3D &attach->sgt;
>  	int err;
> =20
>  	err =3D dma_map_sgtable(attachment->dev, sgt, direction,
>  			      DMA_ATTR_SKIP_CPU_SYNC);

[Severity: Critical]
Does this code trigger a panic for static VPR buffers? The sgt can be
populated with a NULL page by tegra_vpr_attach(), causing dma_map_sgtable()
to dereference it.

>  	if (err < 0)
>  		return ERR_PTR(err);
[ ... ]
> @@ -826,6 +826,7 @@ static void tegra_vpr_unmap_dma_buf(struct dma_buf_at=
tachment *attachment,
>  static void tegra_vpr_recycle(struct tegra_vpr *vpr)
>  {
>  	DECLARE_BITMAP(dirty, vpr->num_chunks);

[Severity: Low]
Does this introduce a variable length array (VLA)? vpr->num_chunks is not a
compile-time constant, so this expands to a dynamic stack allocation which
might trigger build errors with -Wvla.

>  	unsigned int i;
>  	int err;
[ ... ]
> @@ -890,7 +890,7 @@ static void tegra_vpr_recycle(struct tegra_vpr *vpr)
>  		/*
>  		 * This may not be fully activated at this point, but we need
>  		 * to keep track of it anyway to make sure the CMA region can
>  		 * eventually be released. The WARN_ON above tells us when it
>  		 * happens: here be dragons.
>  		 */
>  		set_bit(i, vpr->active);

[Severity: High]
Does this code create an inconsistent chunk state and leak CMA memory? If
tegra_vpr_chunk_activate() fails on the error path above, the chunk's active
flag remains false, but this blindly sets it as active in the VPR bitmap.
Subsequent allocations may see the chunk as inactive, allocating new memory
and leaking the old CMA allocation.

>  	}
>  }
[ ... ]
> @@ -1023,8 +1023,8 @@ static void tegra_vpr_debugfs_show_chunks(struct te=
gra_vpr *vpr,
>  			   chunk->active ? "active" : "inactive",
>  			   chunk->num_buffers);
>  	}
> =20
>  	list_for_each_entry(buffer, &vpr->buffers, list) {

[Severity: Medium]
Does this unprotected traversal of vpr->buffers cause data races? This loop
iterates over the list without holding mutex_lock(&vpr->lock), which can ra=
ce
against concurrent buffer allocation or release operations.

>  		string_get_size(buffer->size, 1, STRING_UNITS_2, buf,
>  				sizeof(buf));
[ ... ]
> @@ -1079,9 +1079,9 @@ static int tegra_vpr_setup_chunks(struct tegra_vpr =
*vpr, const char *name)
>  	for (i =3D 0; i < vpr->num_chunks; i++) {
>  		size_t size =3D limit - start;
>  		phys_addr_t end;
> =20
>  		size =3D min_t(size_t, size, max_size);
>  		end =3D start + size - 1;
> =20
>  		err =3D tegra_vpr_chunk_init(vpr, &vpr->chunks[i], start, size,
>  					   order, name);

[Severity: High]
Can this code fail during initialization if the calculated size is 0? If
vpr->size is not a power of 2, earlier chunks could consume all available
space. For the final chunk, size would evaluate to 0, which gets passed to
tegra_vpr_chunk_init() and cma_create(), failing the allocation.

>  		if (err < 0) {
>  			pr_err("failed to create VPR chunk: %d\n", err);
[ ... ]
> @@ -1134,6 +1134,7 @@ static int tegra_vpr_add_heap(struct reserved_mem *=
rmem,
>  	INIT_LIST_HEAD(&vpr->devices);
>  	mutex_init(&vpr->lock);
> =20
>  	vpr->resizable =3D !of_property_read_bool(np, "no-map");
>  	vpr->dev_node =3D of_node_get(np);

[Severity: Medium]
Does this code leak the device node reference on error paths? If subsequent
operations like bitmap_zalloc() or dma_heap_add() fail, the function jumps =
to
the free label but does not call of_node_put(vpr->dev_node).

>  	vpr->align =3D PAGE_SIZE;
>  	vpr->base =3D rmem->base;
[ ... ]
> @@ -1215,9 +1215,9 @@ static int tegra_vpr_node_init(unsigned long offset=
, struct reserved_mem *rmem)
> =20
>  static int tegra_vpr_device_init(struct reserved_mem *rmem, struct devic=
e *dev)
>  {
>  	struct dma_heap *heap =3D rmem->priv;
>  	struct tegra_vpr *vpr =3D dma_heap_get_drvdata(heap);
>  	const struct dev_pm_ops *pm =3D dev->driver->pm;

[Severity: High]
Can these lines cause a kernel panic due to NULL pointer dereferences?
dma_heap_get_drvdata() dereferences the heap pointer before checking if
rmem->priv (the heap) is NULL. Furthermore, dev->driver is dereferenced
without checking if a driver is actually bound to the device.

>  	struct tegra_vpr_device *node;
> =20
>  	if (!rmem->priv)
>  		return -EPROBE_DEFER;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D7
