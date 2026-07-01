Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA8F2D1303;
	Wed,  1 Jul 2026 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923675; cv=none; b=bXlu1R6Eaf6HycG3i+TRNPdl2VrxjpVp2s/i3EjhYJpNZasDwX8DyVJF09UfQEXPupgDowzn5eyZz3knk2m0EFRNP8FPt9ayCJVDPqvFC2fg77qytG2w+dk2B7T/fvOqVra2flJkiy5YIIzSYzJXjJaM8YDhhCq2o2AP4zUJonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923675; c=relaxed/simple;
	bh=6OR0VXzaHKHsel8gwWPY05AGPVQJ1I33PeXfbGN5Tc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8wvgXqu/oczEY8JX08+XMKc7b5bBJUnWUVdWhRd76RKYtn71+J62HsVAesNSIR15A2KDq0t+uQEcLu8/787OoRP61D5JgBAkAtsm4GFxvX2zJYTzsrODqTP9neVCDYy5Q/zZeKhlng8gxywdAHGCmpzWt/4tA7bt55fGH+NH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAATed9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAATed9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084CE1F000E9;
	Wed,  1 Jul 2026 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782923668;
	bh=BRqenpLcnH+SH1EZEEX1HXHyYR/vz5aIKTkkI+ynyRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TAATed9H8cwK7oUiY/weZZMUSQXnaJkwb/YE88hpWVIhj1McCbWGrWoJ4PUPI26nv
	 +uxaGXuPQUKvSwM4Dg9Z8L0ffu7pTXy0nlu33xAixJQhi2ZKTf38SISQk+8CD5QYlq
	 lDB6FrJHvUI0D/rqDfPlvrxhifxc4aFLK1l/EamdlDVyq9+jnCMeSMIqHBqeM23hXK
	 xt2vJO1+Fg7AF2+yPhXmlAn+Bev2xSzcnMlW4PdQKI4FqDOMz5G67k0U+q4svdakF9
	 nymWQomOCjl2sNlA+VsecH1Rn0sNh560qU+JLsHverJaYXHNXP+wC5NHCLnkpoQhZX
	 h7djtweWiQBTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/11] dma-buf: heaps: Add support for Tegra VPR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, conor+dt@kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, robh@kernel.org, dri-devel@lists.freedesktop.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260701-tegra-vpr-v3-8-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-8-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:34:27 +0000
Message-Id: <20260701163428.084CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 20 potential issue=
(s) to consider:
- [High] The driver hijacks global system suspend primitives to implement a=
 hardware-specific memory resize operation, causing race conditions and dea=
dlocks.
- [High] Allocated pages are freed using an excessively large size calculat=
ed via `get_order(size)`, leading to adjacent active memory being mistakenl=
y cleared.
- [High] The `vpr->lock` mutex is dynamically allocated but never initializ=
ed.
- [High] In the chunk recycle loop, the driver uses the wrong loop variable=
 to clear active and dirty bits, corrupting the chunk bitmap state.
- [High] Unchecked access to `dev->driver->pm->freeze` causes a kernel pani=
c if a device has no PM ops.
- [High] Concurrent modification and traversal of the `vpr->devices` list.
- [High] Using `phys_to_page()` on `no-map` reserved memory yields invalid =
page pointers.
- [High] A race between module initialization and device probing can cause =
a NULL pointer dereference in `tegra_vpr_device_init`.
- [High] `tegra_vpr_resize` returns success (0) even if freezing a device f=
ails and the hardware VPR is never resized, bypassing memory protections.
- [High] Integer truncation in the `num_pages` calculation allows massive D=
MA-BUF sizes to be allocated with 0 backing pages, leading to immediate ker=
nel panics when mapped.
- [High] CMA memory is released before the VPR hardware firewall is removed.
- [Medium] The error recovery path in `tegra_vpr_recycle()` fails to restor=
e the `vpr->active` bitmap.
- [Medium] Device node pointers are saved without taking reference counts, =
leading to UAF and a memory leak of the `/reserved-memory` node.
- [Medium] `tegra_vpr_find_free_region` passes `vpr->num_pages - 1` as the =
`end_page` boundary, preventing allocation of the last page of the VPR.
- [Medium] `kmalloc_array` is used to allocate an excessively large page po=
inter array.
- [Medium] Active VPR chunks are not deactivated if `dma_buf_export` fails.
- [Medium] `tegra_vpr_resize` calls `freeze_processes()` but the driver lac=
ks a `CONFIG_FREEZER` or `CONFIG_PM_SLEEP` dependency.
- [Medium] Lockless iteration of `vpr->buffers` in debugfs exposes a TOCTOU=
 list corruption race.
- [Medium] Negative bit shift when `vpr->size` is small, and chunk setup ca=
n create 0-sized chunks.
- [Low] Typo in `attach->dev` initialization results in self-assignment of =
a zero-initialized field.
--

commit 4c286d7ffd5b9cd569447863a311213170bdfb04
Author: Thierry Reding <treding@nvidia.com>
Subject: dma-buf: heaps: Add support for Tegra VPR

This commit exposes the Tegra Video-Protection-Region (VPR) as a DMA heap.
The memory region is dynamically resized by freezing userspace processes and
allocating/freeing chunks via CMA.

> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> index bb729e91545c4..dd6035598d028 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
[ ... ]
> @@ -20,3 +20,10 @@ config DMABUF_HEAPS_CMA
>  	  Choose this option to enable dma-buf CMA heap. This heap is backed
>  	  by the Contiguous Memory Allocator (CMA). If your system has these
>  	  regions, you should say Y here.
> +
> +config DMABUF_HEAPS_TEGRA_VPR
> +	bool "NVIDIA Tegra Video-Protected-Region DMA-BUF Heap"
> +	depends on DMABUF_HEAPS && DMA_CMA

[Severity: Medium]
Should DMABUF_HEAPS_TEGRA_VPR depend on CONFIG_FREEZER or CONFIG_PM_SLEEP?

Since vpr->use_freezer is true, if CONFIG_FREEZER is disabled,
freeze_processes() evaluates to a static inline function returning -ENOSYS.
This will cause the VPR resize operations to unconditionally fail.

> +	help
> +	  Choose this option to enable Video-Protected-Region (VPR) support on
> +	  a range of NVIDIA Tegra devices.
> diff --git a/drivers/dma-buf/heaps/tegra-vpr.c b/drivers/dma-buf/heaps/te=
gra-vpr.c
> new file mode 100644
> index 0000000000000..918cf66ec222c
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/tegra-vpr.c
[ ... ]
> +static int tegra_vpr_resize(struct tegra_vpr *vpr)
> +{
> +	struct tegra_vpr_device *node;
> +	phys_addr_t base, size;
> +	int err, status =3D 0;
> +
> +	err =3D tegra_vpr_get_extents(vpr, &base, &size);
> +	if (err < 0) {
> +		pr_err("%s(): failed to get VPR extents: %d\n", __func__, err);
> +		return err;
> +	}
> +
> +	if (vpr->use_freezer) {
> +		err =3D freeze_processes();

[Severity: High]
Is it safe to invoke the global task freezer from within a device driver's
allocation path?

In tegra_vpr_allocate(), mutex_lock(&vpr->lock) is held, which places the
current task in TASK_UNINTERRUPTIBLE. tegra_vpr_resize() then conditionally
calls freeze_processes(). If another userspace task is concurrently waiting
for vpr->lock, it cannot be frozen because it is in an uninterruptible sleep
state, and the freeze operation will time out and fail.

> +		if (err < 0) {
> +			pr_err("%s(): failed to freeze processes: %d\n",
> +			       __func__, err);
> +			return err;
> +		}
> +	}
> +
> +	list_for_each_entry(node, &vpr->devices, node) {

[Severity: High]
Are the vpr->devices list modifications protected against concurrent
traversal?

tegra_vpr_device_init() and tegra_vpr_device_release() modify the list
without holding vpr->lock, while this traversal relies on the lock. If a
device binds or unbinds while a VPR resize is active, the list pointers
could become corrupted during the traversal.

> +		err =3D pm_generic_freeze(node->dev);
> +		if (err < 0) {
> +			pr_err("failed to runtime suspend %s: %d\n",
> +			       dev_name(node->dev), err);
> +			goto thaw;

[Severity: High]
Does this error path inadvertently return success?

The status variable is initialized to 0, and if pm_generic_freeze() fails,
the code jumps to the thaw label without updating status. The function then
returns 0, falsely indicating that the hardware VPR was successfully resize=
d,
potentially compromising memory protections.

> +		}
> +	}
[ ... ]
> +static int tegra_vpr_find_free_region_in_range(struct tegra_vpr *vpr,
> +					       unsigned int start_page,
> +					       unsigned int end_page,
> +					       unsigned int num_pages,
> +					       unsigned int align)
> +{
> +	unsigned int pos, next =3D ALIGN(start_page, align);
> +
> +	/* Scan through aligned positions, trying to allocate at each one */
> +	for (pos =3D next; pos + num_pages <=3D end_page; pos =3D next) {

[Severity: Medium]
Could this prevent the allocation of the final page of the VPR?

tegra_vpr_find_free_region() passes vpr->num_pages - 1 as the end_page
parameter. This loop condition treats end_page as an exclusive boundary.
If attempting to allocate a buffer right at the end of the VPR, this
boundary check will evaluate to false and fail the allocation.

> +		next =3D find_next_bit(vpr->bitmap, pos + num_pages, pos);
[ ... ]
> +static struct tegra_vpr_buffer *
> +tegra_vpr_buffer_allocate(struct tegra_vpr *vpr, size_t size)
> +{
> +	unsigned int num_pages =3D size >> PAGE_SHIFT;

[Severity: High]
Can the 64-bit size parameter overflow the 32-bit unsigned int num_pages?

Shifting a massive size by PAGE_SHIFT could result in a value that truncates
to 0 in num_pages. This would cause kmalloc_array(0) to return ZERO_SIZE_PT=
R,
which could lead to an immediate kernel panic when the buffer is later mapp=
ed.

> +	unsigned int order =3D get_order(size);
> +	struct tegra_vpr_buffer *buffer;
> +	unsigned long first, last;
> +	int pageno, err;
> +	pgoff_t i;
[ ... ]
> +	buffer->pages =3D kmalloc_array(buffer->num_pages,
> +				      sizeof(*buffer->pages),
> +				      GFP_KERNEL);

[Severity: Medium]
Will this order-10 contiguous allocation reliably succeed on a heavily
utilized system?

If the VPR is sized for multi-gigabyte video frames (e.g., a 2 GiB allocati=
on
requires 524,288 pages), kmalloc_array() will require multiple megabytes of
contiguous physical memory. This is highly likely to fail due to fragmentat=
ion.
Would kvmalloc_array() be more appropriate here?

> +	if (!buffer->pages) {
> +		err =3D -ENOMEM;
> +		goto free;
> +	}
[ ... ]
> +static void tegra_vpr_buffer_release(struct tegra_vpr_buffer *buffer)
> +{
> +	struct tegra_vpr *vpr =3D buffer->vpr;
> +	struct tegra_vpr_buffer *entry;
> +	unsigned long first, last;
> +	unsigned int i;
[ ... ]
> +	bitmap_release_region(vpr->bitmap, buffer->pageno, buffer->order);

[Severity: High]
Does this logic mistakenly clear adjacent active memory?

In tegra_vpr_buffer_allocate(), the allocation sets exactly num_pages bits
in vpr->bitmap. However, here it clears bits using buffer->order which is
calculated as get_order(size). Since get_order() rounds up to the next power
of two, non-power-of-two sizes will cause too many bits to be released
(e.g., a 5-page allocation sets 5 bits but order 3 clears 8 bits). This cou=
ld
mark adjacent pages belonging to other active allocations as free, leading
to reallocation and data corruption.

> +	list_del(&buffer->list);
> +	kfree(buffer->pages);
> +	kfree(buffer);
[ ... ]
> +static int tegra_vpr_attach(struct dma_buf *buf,
> +			    struct dma_buf_attachment *attachment)
> +{
> +	struct tegra_vpr_buffer *buffer =3D buf->priv;
> +	struct tegra_vpr_attachment *attach;
> +	int err;
> +
> +	attach =3D kzalloc_obj(*attach, GFP_KERNEL);
> +	if (!attach)
> +		return -ENOMEM;
> +
> +	err =3D sg_alloc_table_from_pages(&attach->sgt, buffer->pages,
> +					buffer->num_pages, 0, buffer->size,
> +					GFP_KERNEL);
> +	if (err < 0)
> +		goto free;
> +
> +	attach->dev =3D attach->dev;

[Severity: Low]
Is this field meant to be initialized from attachment->dev?

As written, it assigns the zero-allocated field back to itself, leaving
attach->dev uninitialized.

> +	INIT_LIST_HEAD(&attach->list);
> +	attachment->priv =3D attach;
[ ... ]
> +static void tegra_vpr_recycle(struct tegra_vpr *vpr)
> +{
> +	DECLARE_BITMAP(dirty, vpr->num_chunks);
> +	unsigned int i;
> +	int err;
> +
> +	bitmap_zero(dirty, vpr->num_chunks);
> +
> +	/*
> +	 * Deactivate any unused chunks from the bottom...
> +	 */
> +	for (i =3D 0; i < vpr->num_chunks; i++) {
> +		struct tegra_vpr_chunk *chunk =3D &vpr->chunks[i];
> +
> +		if (!chunk->active)
> +			continue;
> +
> +		if (chunk->num_buffers > 0)
> +			break;
> +
> +		err =3D tegra_vpr_chunk_deactivate(chunk);

[Severity: High]
Is the CMA memory released back to the general pool before the VPR hardware
firewall is removed?

tegra_vpr_chunk_deactivate() immediately calls cma_release(), making the
memory available to other subsystems. The firewall isn't removed until
tegra_vpr_resize() is called afterward. Any CPU access to the newly
re-allocated memory before the firewall is disabled could cause a hardware
bus error or CPU crash.

> +		if (err < 0)
> +			pr_err("failed to deactivate chunk #%u\n", i);
> +		else {
> +			clear_bit(i, vpr->active);
> +			set_bit(i, dirty);
> +		}
> +	}
> +
> +	/*
> +	 * ... and the top.
> +	 */
> +	for (i =3D 0; i < vpr->num_chunks; i++) {
> +		unsigned int index =3D vpr->num_chunks - i - 1;
> +		struct tegra_vpr_chunk *chunk =3D &vpr->chunks[index];
> +
> +		if (!chunk->active)
> +			continue;
> +
> +		if (chunk->num_buffers > 0)
> +			break;
> +
> +		err =3D tegra_vpr_chunk_deactivate(chunk);
> +		if (err < 0)
> +			pr_err("failed to deactivate chunk #%u\n", index);
> +		else {
> +			clear_bit(i, vpr->active);

[Severity: High]
Could this loop corrupt the chunk bitmap state?

The top chunk loop iterates over the chunks from the top down using the
calculated index (vpr->num_chunks - i - 1), but when modifying the bitmap,
it clears bit i instead of the calculated index. This could deactivate the
top chunk in hardware but mark the bottom chunk as inactive in the software
bitmap.

> +			set_bit(i, dirty);
> +		}
> +	}
[ ... ]
> +activate:
> +	for_each_set_bit(i, dirty, vpr->num_chunks) {
> +		err =3D tegra_vpr_chunk_activate(&vpr->chunks[i]);

[Severity: Medium]
Should this error recovery path also restore the bit in vpr->active?

If tegra_vpr_resize() fails, the code jumps here and successfully calls
tegra_vpr_chunk_activate(), but it doesn't set the bit in vpr->active.
Since the bit was cleared in the deactivation loop, the software state
will indicate the chunk is free, breaking internal tracking.

> +		if (WARN_ON(err < 0))
> +			pr_err("failed to activate chunk #%u: %d\n", i, err);
> +	}
> +}
[ ... ]
> +static struct dma_buf *tegra_vpr_allocate(struct dma_heap *heap,
> +					  unsigned long len, u32 fd_flags,
> +					  u64 heap_flags)
> +{
> +	struct tegra_vpr *vpr =3D dma_heap_get_drvdata(heap);
> +	struct tegra_vpr_buffer *buffer, *entry;
> +	size_t size =3D ALIGN(len, vpr->align);
> +	DEFINE_DMA_BUF_EXPORT_INFO(export);
> +	struct dma_buf *buf;
> +
> +	mutex_lock(&vpr->lock);

[Severity: High]
Could the uninitialized vpr->lock cause a system crash?

The tegra_vpr structure is allocated using kzalloc_obj(), which
zero-initializes the memory, but mutex_init(&vpr->lock) is never called.
When this function attempts to acquire the lock, it interacts with an
uninitialized mutex, which can trigger warnings or a kernel panic.

> +
> +	buffer =3D tegra_vpr_buffer_allocate(vpr, size);
[ ... ]
> +	buf =3D dma_buf_export(&export);
> +	if (IS_ERR(buf))
> +		tegra_vpr_buffer_release(buffer);

[Severity: Medium]
Should the active VPR chunks be deactivated if dma_buf_export() fails?

tegra_vpr_buffer_release() decrements the chunk use counts but does not
deactivate the chunks. A missing call to tegra_vpr_recycle() could mean
chunks successfully activated during this allocation attempt remain pinned
in CMA indefinitely.

> +
> +	mutex_unlock(&vpr->lock);
> +	return buf;
> +}
> +
> +static void tegra_vpr_debugfs_show_buffers(struct tegra_vpr *vpr,
> +					   struct seq_file *s)
> +{
> +	struct tegra_vpr_buffer *buffer;
> +	char buf[16];
> +
> +	list_for_each_entry(buffer, &vpr->buffers, list) {

[Severity: Medium]
Is it safe to traverse the shared vpr->buffers list without holding vpr->lo=
ck?

Concurrent buffer allocations or releases could modify the list pointers
mid-traversal, potentially causing a kernel panic when reading the debugfs
node.

> +		string_get_size(buffer->size, 1, STRING_UNITS_2, buf,
> +				sizeof(buf));
> +		seq_printf(s, "  %pap-%pap (%s)\n", &buffer->start,
> +			   &buffer->limit, buf);
> +
> +	}
> +}
[ ... ]
> +static int tegra_vpr_setup_chunks(struct tegra_vpr *vpr, const char *nam=
e)
> +{
> +	phys_addr_t start, limit;
> +	unsigned int order, i;
> +	size_t max_size;
> +	int err;
> +
> +	/* This seems a reasonable value, so hard-code this for now. */
> +	vpr->num_chunks =3D 4;
> +
> +	vpr->chunks =3D kcalloc(vpr->num_chunks, sizeof(*vpr->chunks),
> +			      GFP_KERNEL);
> +	if (!vpr->chunks)
> +		return -ENOMEM;
> +
> +	max_size =3D PAGE_SIZE << (get_order(vpr->size) - ilog2(vpr->num_chunks=
));

[Severity: Medium]
Could this bit shift result in a negative shift amount?

If the device tree specifies a small VPR size, get_order(vpr->size) might
be 0, and subtracting ilog2(vpr->num_chunks) (e.g., 2) would result in -2.
Shifting PAGE_SIZE by a negative amount causes undefined behavior.

> +	order =3D get_order(vpr->align);
[ ... ]
> +static int __init tegra_vpr_add_heap(struct reserved_mem *rmem,
> +				     struct device_node *np)
> +{
> +	struct dma_heap_export_info info =3D {};
> +	unsigned long first, last;
> +	struct dma_heap *heap;
> +	struct tegra_vpr *vpr;
> +	int err;
> +
> +	vpr =3D kzalloc_obj(*vpr, GFP_KERNEL);
> +	if (!vpr)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&vpr->buffers);
> +	INIT_LIST_HEAD(&vpr->devices);
> +	vpr->resizable =3D !of_property_read_bool(np, "no-map");
> +	vpr->use_freezer =3D true;
> +	vpr->dev_node =3D np;

[Severity: Medium]
Does this code leak the device node reference?

When storing the child node pointer in vpr->dev_node, should it be acquiring
a reference with of_node_get()? The scoped loop in tegra_vpr_init() will dr=
op
its reference when it finishes, which could leave a dangling pointer here.

> +	vpr->align =3D PAGE_SIZE;
> +	vpr->base =3D rmem->base;
> +	vpr->size =3D rmem->size;
> +
> +	/* common setup */
> +	vpr->start_page =3D phys_to_page(vpr->base);

[Severity: High]
Can phys_to_page() safely be used if the VPR device tree node specifies no-=
map?

If the memory is removed from the direct mapping, there is no valid struct
page array associated with it. Calling phys_to_page() here and later
dereferencing these page pointers in tegra_vpr_attach() via
sg_alloc_table_from_pages() could cause a system crash.

> +	vpr->num_pages =3D vpr->size >> PAGE_SHIFT;
[ ... ]
> +static int __init tegra_vpr_init(void)
> +{
> +	const char *compatible =3D "nvidia,tegra-video-protection-region";
> +	struct device_node *parent;
> +	struct reserved_mem *rmem;
> +	int err;
> +
> +	parent =3D of_find_node_by_path("/reserved-memory");

[Severity: Medium]
Does this code leak the device node reference?

of_find_node_by_path() increments the reference count for the
/reserved-memory node, but there doesn't seem to be a matching of_node_put()
call.

> +	if (!parent)
> +		return 0;
[ ... ]
> +static int tegra_vpr_device_init(struct reserved_mem *rmem, struct devic=
e *dev)
> +{
> +	struct dma_heap *heap =3D rmem->priv;
> +	struct tegra_vpr *vpr =3D dma_heap_get_drvdata(heap);

[Severity: High]
Could a hardware device probing before the module initialization runs cause
a NULL pointer dereference?

tegra_vpr_rmem_ops is registered early via RESERVEDMEM_OF_DECLARE. If a
device probes before tegra_vpr_init() executes, tegra_vpr_device_init() will
be called while rmem->priv is still NULL, causing dma_heap_get_drvdata() to
dereference a NULL pointer.

> +	struct tegra_vpr_device *node;
> +
> +	if (!dev->driver->pm->freeze || !dev->driver->pm->thaw)

[Severity: High]
Can this unconditionally dereference a NULL pointer?

If the device's driver does not provide PM operations (dev->driver->pm is
NULL), this check will cause a kernel panic during device probe.

> +		return -EINVAL;
> +
> +	node =3D kzalloc_obj(*node, GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&node->node);
> +	node->dev =3D dev;
> +
> +	list_add_tail(&node->node, &vpr->devices);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D8
