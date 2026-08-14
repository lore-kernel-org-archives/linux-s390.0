Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38231E846;
	Fri, 14 Aug 2026 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722236; cv=none; b=md8uHh7OpA9CL/GjCz8dj1LkGBQ3A9OSUq2RG+DXlIbPyII7FAXbQVOzcya9JzNgZbgT8c2wAWLrjxTSA9+bMoqn91OEzaG76jZf18AUxRrbFd9nWrmMXLbZiDOeaBY337/+RMEVcfhGtDrTOc+DwWyN6hCWIo5mfquG25IykKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722236; c=relaxed/simple;
	bh=JNOIt5mcw3q79EPqkBBZpMT2wjxVVuFJR1rJUxDLOUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nY/Hh2gZBjLO82KfCkhYYLMCWIgAfWNZatdGHI/bHP5ctSiY/EPg0AXUtaYgqDb88NCDfw47psL66OmaHdoL+ctydtvKSgrMfxZfLPozBgG/nC+fQ7GAGeWn4t6EaYYFnPAXeDUx8v+8xwiTcferkDTt3STAvYGXIas1neqvgwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxF336yC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxF336yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF481F000E9;
	Fri, 14 Aug 2026 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722234;
	bh=UurglzDByJOdmCfZtx6+eBja/PKZ7UNuNVBtC7mzBhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NxF336yCNe/gvBithdclQ58YNzMvJj62n5X7S5GOHQdzAWJcX+RWWwvY/jiZg6NID
	 UNhFsSnqZfbs10SDQlv1Tx1TrlOK8PBTTWDDnUo42Mcfi3i73ABppu87QteFgzsd+h
	 shEdnM03NE98XVQtKcy7vzqrE27nnPjs6Zno64AN5d9f4BoE6N1anwwstRu5KxdeVc
	 QFrNWn3jCc9xr+3lTispo7Qh6iuzarjUJNPsNevbbfh2gCTixakKK2hF4Sf4LEhRY7
	 pdK4Tz/7Rcb+g0UgeWDgjcVoSfpGlajtIpvjcEuGHUgNxYM4jAKcqrpMgEck0mttcU
	 gpQPLBBYduAqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/10] dma-buf: heaps: Add support for Tegra VPR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: dri-devel@lists.freedesktop.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org, media-ci@linuxtv.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, robh@kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, devicetree@vger.kernel.org
In-Reply-To: <20260814-tegra-vpr-v5-7-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-7-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:43:53 +0000
Message-Id: <20260814154354.3FF481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [High] Calling `dma_map_sgtable()` on a scatterlist with a `NULL` page po=
inter will overwrite the manual DMA address and cause a kernel panic for st=
atic VPRs.
- [High] Memory allocated with `kvmalloc_array()` is incorrectly freed with=
 `kfree()`, which will cause a SLUB BUG or kernel panic if it falls back to=
 `vmalloc()`.
- [High] Signed integer overflow in physical address calculation for VPR si=
zes exceeding ~2 GiB.
- [High] Unconditional CMA initialization on `no-map` reserved memory will =
cause a kernel panic.
- [High] SMCCC calling convention truncates 64-bit physical addresses to 32=
 bits.
- [High] Race condition and framework abuse by calling `pm_generic_freeze()=
` at runtime without acquiring the device lock.
- [High] Dereferencing `dev->driver` when calling `tegra_vpr_device_init()`=
 will cause a boot-time kernel panic.
- [Medium] Missing locking in `tegra_vpr_debugfs_show_chunks` leads to use-=
after-free and list corruption.
- [Medium] Memory and OF node leaks on the error path of `tegra_vpr_add_hea=
p()`.
- [Medium] Off-by-one error prevents allocation of the last VPR page.
- [Low] Missing Kconfig dependencies for `ARM_SMCCC` will cause compilation=
 and link errors on unsupported architectures.
- [Low] The use of `DECLARE_BITMAP(dirty, vpr->num_chunks)` creates a Varia=
ble Length Array (VLA), which is forbidden in the kernel.
--

--- Patch [7]: [PATCH v5 07/10] dma-buf: heaps: Add support for Tegra VPR -=
--
commit 4503ba247ad23e5d232fb07fec29334ba71260ab
Author: Thierry Reding <treding@nvidia.com>
Subject: dma-buf: heaps: Add support for Tegra VPR

This commit introduces a new DMA-BUF heap for the NVIDIA Tegra
Video-Protection-Region (VPR). It exposes VPR memory, which is restricted
from CPU access, to drivers and applications that handle content-protected
video. The heap supports both static and resizable VPR configurations.

> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> index bb729e91545c4..8909330bfaa2a 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -20,3 +20,15 @@ config DMABUF_HEAPS_CMA
> +config DMABUF_HEAPS_TEGRA_VPR
> +	bool "NVIDIA Tegra Video-Protected-Region DMA-BUF Heap"
> +	depends on DMABUF_HEAPS && DMA_CMA

[Severity: Low]
Is it possible for this driver to be compiled on unsupported architectures?

The driver uses arm_smccc_smc(), which relies on __arm_smccc_smc. This is
only implemented on ARM/ARM64.=20

Without an ARM_SMCCC or ARCH_TEGRA dependency, this could lead to unresolved
symbol linker failures on other architectures like x86.

> diff --git a/drivers/dma-buf/heaps/tegra-vpr.c b/drivers/dma-buf/heaps/te=
gra-vpr.c
> new file mode 100644
> index 0000000000000..c8d9f9c66dded
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/tegra-vpr.c
[ ... ]
> @@ -112,6 +112,6 @@ struct tegra_vpr_attachment {
> =20
> +#define ARM_SMCCC_VENDOR_SIP_TE_PROGRAM_VPR_FUNC_ID		\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_32,			\
> +			   ARM_SMCCC_OWNER_SIP,			\
> +			   ARM_SMCCC_TE_FUNC_PROGRAM_VPR)

[Severity: High]
Does the use of ARM_SMCCC_SMC_32 truncate the physical addresses passed to
the secure monitor?=20

When passing 64-bit phys_addr_t arguments for base and size in
tegra_vpr_set(), the SMC32 convention truncates them to 32 bits.

This might cause the secure monitor to program the VPR to an incorrect
memory location.

[ ... ]
> @@ -166,5 +166,5 @@ static int tegra_vpr_resize(struct tegra_vpr *vpr)
> =20
> +	list_for_each_entry(node, &vpr->devices, node) {
> +		err =3D pm_generic_freeze(node->dev);

[Severity: High]
Is it safe to call pm_generic_freeze() here without acquiring the device
lock?=20

Calling it directly without holding device_lock() can race with concurrent
runtime PM transitions, device removal, or unbind operations.=20

Could this lead to crashes if dev->driver is cleared concurrently?

[ ... ]
> @@ -365,3 +365,3 @@ static int tegra_vpr_activate_chunks(struct tegra_vpr=
 *vpr,
> +{
> +	DECLARE_BITMAP(dirty, vpr->num_chunks);

[Severity: Low]
Does this declaration create a Variable Length Array (VLA)?=20

Because vpr->num_chunks is a struct member evaluated at runtime, this
creates a VLA on the stack. Since the kernel is compiled with -Werror=3Dvla,
this will result in a build failure.

[ ... ]
> @@ -498,4 +498,4 @@ static int tegra_vpr_find_free_region(struct tegra_vp=
r *vpr,
> +{
> +	return tegra_vpr_find_free_region_in_range(vpr, 0, vpr->num_pages - 1,
> +						   num_pages, align);

[Severity: Medium]
Will passing vpr->num_pages - 1 prevent the allocation of the last VPR page?

Looking at tegra_vpr_find_free_region_in_range(), the loop condition is
pos + num_pages <=3D end_page.=20

If end_page is decremented by 1, it seems it will incorrectly exclude the
final page from ever being allocated.

[ ... ]
> @@ -642,3 +642,3 @@ tegra_vpr_buffer_allocate(struct tegra_vpr *vpr, size=
_t size)
> +	INIT_LIST_HEAD(&buffer->list);
> +	mutex_init(&buffer->lock);
> +	buffer->start =3D vpr->base + (pageno << PAGE_SHIFT);

[Severity: High]
Can this calculation overflow for VPR sizes exceeding 2 GiB?=20

Because pageno is a signed 32-bit int, pageno << PAGE_SHIFT can overflow
and become a negative value before being promoted and added to the 64-bit
phys_addr_t vpr->base.=20

This could yield a completely incorrect DMA address.

[ ... ]
> @@ -654,4 +654,4 @@ tegra_vpr_buffer_allocate(struct tegra_vpr *vpr, size=
_t size)
> +		buffer->pages =3D kvmalloc_array(buffer->num_pages,
> +					       sizeof(*buffer->pages),
> +					       GFP_KERNEL);
> +		if (!buffer->pages) {
[ ... ]
> @@ -672,3 +672,3 @@ free:
> +	kfree(buffer->pages);
> +release:

[Severity: High]
Should this be kvfree() instead of kfree()?=20

Memory allocated with kvmalloc_array() might fall back to vmalloc().=20
If that happens, calling kfree() on a vmalloc address will cause a SLUB BUG
or kernel panic during virt_to_page() translation.

[ ... ]
> @@ -728,4 +728,4 @@ static void tegra_vpr_buffer_release(struct tegra_vpr=
_buffer *buffer)
> +	bitmap_clear(vpr->bitmap, buffer->pageno, buffer->num_pages);
> +	list_del(&buffer->list);
> +	kfree(buffer->pages);

[Severity: High]
Similarly, should this teardown path also use kvfree() to release
buffer->pages since it was allocated using kvmalloc_array()?

[ ... ]
> @@ -785,4 +785,4 @@ tegra_vpr_map_dma_buf(struct dma_buf_attachment *atta=
chment,
> +
> +	err =3D dma_map_sgtable(attachment->dev, sgt, direction,
> +			      DMA_ATTR_SKIP_CPU_SYNC);

[Severity: High]
Can this crash for static VPR configurations?=20

In the static VPR case, the scatterlist is populated with a NULL page
pointer.=20

Unconditionally calling dma_map_sgtable() here will cause the DMA framework
to iterate over the scatterlist and dereference the NULL page pointer. This
could corrupt the DMA address or cause a kernel panic.

[ ... ]
> @@ -796,4 +796,4 @@ static void tegra_vpr_unmap_dma_buf(struct dma_buf_at=
tachment *attachment,
> +{
> +	dma_unmap_sgtable(attachment->dev, sgt, direction,
> +			  DMA_ATTR_SKIP_CPU_SYNC);

[Severity: High]
This appears to have the same issue as the mapping path. Calling
dma_unmap_sgtable() unconditionally attempts to unmap a NULL-paged
scatterlist, which could lead to a panic.

[ ... ]
> @@ -800,3 +800,3 @@ static void tegra_vpr_recycle(struct tegra_vpr *vpr)
> +{
> +	DECLARE_BITMAP(dirty, vpr->num_chunks);

[Severity: Low]
Does this declaration also create a Variable Length Array (VLA) on the
stack? This will similarly cause a build failure under -Werror=3Dvla.

[ ... ]
> @@ -1048,4 +1048,4 @@ static void tegra_vpr_debugfs_show_chunks(struct te=
gra_vpr *vpr,
> +
> +	list_for_each_entry(buffer, &vpr->buffers, list) {
> +		string_get_size(buffer->size, 1, STRING_UNITS_2, buf,

[Severity: Medium]
Should this list iteration be protected by vpr->lock?=20

Iterating over vpr->buffers without the lock can race with concurrent
dma-buf allocations or frees, potentially leading to a use-after-free or a
panic from list corruption.

[ ... ]
> @@ -1199,6 +1199,6 @@ static int tegra_vpr_add_heap(struct reserved_mem *=
rmem,
> +
> +cleanup:
> +	if (vpr->resizable)
> +		tegra_vpr_free_chunks(vpr);
> +free:
> +	bitmap_free(vpr->bitmap);
> +	kfree(vpr);
> +	return err;

[Severity: Medium]
Are there a couple of resource leaks on this error path?=20

If dma_heap_add() fails, tegra_vpr_free_chunks() is called, but it looks
like the vpr->active bitmap is never freed.=20

Additionally, it seems the device node reference acquired via of_node_get()
is not released with of_node_put(vpr->dev_node).

[ ... ]
> @@ -1305,4 +1305,4 @@ static int __init tegra_vpr_node_init(unsigned long=
 offset,
> +
> +	err =3D cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name,
> +				    &cma);

[Severity: High]
Will this cause a panic for static VPRs?=20

Static VPRs use the "no-map" property, which removes the memory from the
linear map and prevents struct page creation.=20

However, this calls cma_init_reserved_mem() unconditionally, and CMA
expects struct page to be present when initializing pageblocks.

[ ... ]
> @@ -1359,3 +1359,3 @@ static int tegra_vpr_device_init(struct reserved_me=
m *rmem, struct device *dev)
> +{
> +	const struct dev_pm_ops *pm =3D dev->driver->pm;

[Severity: High]
Can this unconditionally dereference a NULL pointer?=20

This function acts as the device_init callback for reserved memory
operations. When devices are instantiated and memory regions are attached
via of_dma_configure_id(), this callback is invoked before a driver is
matched or bound to the device.

This means dev->driver would be NULL here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D7
