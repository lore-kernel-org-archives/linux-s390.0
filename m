Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB7474271;
	Fri,  4 Sep 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521884; cv=none; b=PhE3Y7DDGZK10DrHZa1lOKkJNpeGAnGNBE7SGPCSGaEviTuUruU38Bv6cSZpJrpWGbeEoJalI/hfyaNg3SEI6Bdb1pF2yoH/Iafy/ur3HFVLe4b3yjNNFW0tFwqq0fbA2dSdp9KPd7BNo2gacqNGTBBBCw1mUAK4j9ZSBq6MjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521884; c=relaxed/simple;
	bh=0IZxIPiPo0OJnv4Wyk0nu84tFvUiJjwF1tNmqVNCBzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QrZurW9v+sWm894Hi9xySzqIfggJ1HXTavundNrYkKs2IssI2d02yJINuJ0OMmuY61JOc49swbzb+gpzcP4T+tY4lXrLjKyuRQmOXxsklz9fW5zgGbeJ50i0nm2s/zRnxYBVXQGwZdlV53LKp1RYAuQJAzt+2Zcsp4bojitT1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/tilQNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/tilQNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10BA1F00A3D;
	Fri,  4 Sep 2026 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788521882;
	bh=3hJVkmHa88Bx8Rttvds9TNaNTHDpmkdFA4o7Ba6H37w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a/tilQNKf36M2t0S1Q73nv2l0l3j98vRxZ2oFFeS8ZAfDJ6oLwNVbhRs3LzsLaccb
	 j6AlVkXCD8gMN0/PCrC6rQEE+1aPLBHoiN+bt4uc36qRR7cpr9BWK5fmXlev9nGqtX
	 nDeNGGPNG1D0gHUIg0syw+z4hhzu5dE6bAxFqMlvp7WMjXehInf1br1VgYFKYyoOmR
	 sUzDhxxUN4GQBvG5qbj39HXa2OguVGhws2ru4xS0nrj9Qfdlp/V9A8UHgOS14CRg7O
	 fVrat2BPLKTIpJ/NnCYDfCF6xPRMtvsgWrfU4eovbOBeCiNx/HLw/JsJAxQmKeZDaD
	 6Q6uLGzrptxaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/12] dma-buf: heaps: Add support for Tegra VPR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: media-ci@linuxtv.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, robh@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-s390@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904-tegra-vpr-v6-9-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-9-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:38:01 +0000
Message-Id: <20260904113801.B10BA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 15 potential issue=
(s) to consider:
- [High] Calling `cma_init_reserved_mem` on a `no-map` region causes a boot=
-time kernel panic.
- [High] Memory allocated with `kvmalloc_array()` is incorrectly freed with=
 `kfree()`.
- [High] Calling `dma_map_sgtable()` with an SG list containing a NULL page=
 maps garbage physical addresses.
- [High] Direct invocation of system PM callbacks (`pm_generic_freeze`/`tha=
w`) bypasses the PM core.
- [High] 0-sized chunks generate an integer underflow that permanently brea=
ks VPR buffer allocation.
- [High] Pointer arithmetic on `struct page` arrays across MAX_ORDER / memo=
ry sections causes panics on SPARSEMEM.
- [High] Direct map corruption when returning partially invalidated pages t=
o the CMA allocator.
- [High] Integer overflow in allocation size allows a zero-sized allocation=
 that permanently bricks the heap.
- [High] Shrinking VPR restores linear mapping before the hardware protecti=
on is removed, risking speculative SErrors.
- [Medium] Memory and reference leaks on the error path of `tegra_vpr_add_h=
eap()`.
- [Medium] Missing lock acquisition when traversing `vpr->buffers` list in =
`tegra_vpr_debugfs_show_chunks`.
- [Medium] Dereferencing `dev->driver->pm` without checking if `dev->driver=
` is valid.
- [Low] Off-by-one error in VPR end_page calculation permanently wastes the=
 last page.
- [Low] Use of dynamically sized Variable Length Arrays (VLAs) via `DECLARE=
_BITMAP`.
- [Low] The commit message claims userspace processes are frozen during res=
ize, but the code does not implement this.
--

commit 08e43ed119b9e546aa530f96844c1805cc1597a2
Author: Thierry Reding <treding@nvidia.com>
Subject: dma-buf: heaps: Add support for Tegra VPR

This commit introduces DMA-BUF heap support for the NVIDIA Tegra Video
Protection Region (VPR). It adds initialization for CMA memory during boot
and a heap driver for dynamically allocating and resizing chunks of this
protected memory.

>     Unfortunately, resizing the VPR is slightly tricky because the GPU fo=
und
>     on Tegra SoCs must be in reset during the VPR resize operation. This =
is
>     currently implemented by freezing all userspace processes and calling
>     invoking the GPU's freeze() implementation, resizing and the thawing =
the
>     GPU and userspace processes. This is quite heavy-handed, so eventually

[Severity: Low]
The commit message states that userspace processes are frozen during resize=
,=20
but this doesn't seem to be implemented in the code (perhaps removed in v4?=
).=20
Could the commit message be updated to reflect the current behavior?

> diff --git a/drivers/dma-buf/heaps/tegra-vpr-init.c b/drivers/dma-buf/hea=
ps/tegra-vpr-init.c
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/tegra-vpr-init.c
> @@ -0,0 +1,133 @@

[ ... ]

> +static int __init tegra_vpr_node_init(unsigned long offset,
> +				      struct reserved_mem *rmem)
> +{
> +	struct cma *cma;
> +	int err;
> +
> +	if (!IS_ALIGNED(rmem->base, SZ_1M)) {
> +		pr_err("%s: base is not aligned to 1 MiB\n", rmem->name);
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(rmem->size, SZ_1M)) {
> +		pr_err("%s: size is not aligned to 1 MiB\n", rmem->name);
> +		return -EINVAL;
> +	}
> +
> +	err =3D cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name,
> +				    &cma);

[Severity: High]
Can this cause a panic during early boot if the firmware configures a fixed=
=20
VPR using the no-map property? A no-map region is removed from the linear=20
memory map (no struct page allocation), but cma_init_reserved_mem() is call=
ed=20
unconditionally. When CMA later tries to return pages to the buddy allocato=
r=20
via pfn_to_page(), won't it access invalid pointers?

[ ... ]

> +static int tegra_vpr_device_init(struct reserved_mem *rmem, struct devic=
e *dev)
> +{
> +	const struct dev_pm_ops *pm =3D dev->driver->pm;

[Severity: Medium]
Is it safe to blindly dereference dev->driver here? If this is called on a=
=20
device node without a bound driver, dev->driver would be NULL, causing a pa=
nic.=20
Should we verify dev->driver is valid first?

> diff --git a/drivers/dma-buf/heaps/tegra-vpr.c b/drivers/dma-buf/heaps/te=
gra-vpr.c
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/tegra-vpr.c
> @@ -0,0 +1,1210 @@

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
> +	list_for_each_entry(node, &vpr->devices, node) {
> +		err =3D pm_generic_freeze(node->dev);

[ ... ]

> +	list_for_each_entry_continue_reverse(node, &vpr->devices, node) {
> +		err =3D pm_generic_thaw(node->dev);

[Severity: High]
Does calling pm_generic_freeze() and pm_generic_thaw() directly bypass the=
=20
PM core's synchronization? Normally these are coordinated under device_lock=
.=20
If a device's driver is concurrently unbinding, dev->driver might become NU=
LL=20
during the callback, which could lead to a kernel panic. Should this be=20
coordinated with the PM core instead?

[ ... ]

> +static bool tegra_vpr_chunk_overlaps(struct tegra_vpr_chunk *chunk,
> +				     unsigned int start, unsigned int limit)
> +{
> +	unsigned int first =3D chunk->offset;
> +	unsigned int last =3D chunk->offset + chunk->num_pages - 1;

[Severity: High]
Could chunk->num_pages be 0 for trailing chunks if the total VPR size doesn=
't=20
evenly divide into num_chunks?=20

Looking at tegra_vpr_setup_chunks():
    size =3D min_t(size_t, size, max_size);
    end =3D start + size - 1;

If the remaining size is 0, this would cause chunk->num_pages to be 0, maki=
ng=20
the calculation underflow to UINT_MAX. This would cause the 0-sized chunk t=
o=20
falsely overlap all future allocations and break the VPR heap.

[ ... ]

> +static int tegra_vpr_activate_chunks(struct tegra_vpr *vpr,
> +				     struct tegra_vpr_buffer *buffer)
> +{
> +	DECLARE_BITMAP(dirty, vpr->num_chunks);

[Severity: Low]
Since vpr->num_chunks is evaluated at runtime, doesn't DECLARE_BITMAP creat=
e=20
a Variable Length Array (VLA) on the stack? The kernel globally forbids VLA=
s=20
and this will likely cause a build failure with -Werror=3Dvla.

> +	unsigned int i, bottom, top;
> +	int err =3D 0, ret;
> +
> +	bitmap_zero(dirty, vpr->num_chunks);
> +
> +	/* activate any inactive chunks that overlap this buffer */
> +	for_each_set_bit(i, buffer->chunks, vpr->num_chunks) {
> +		struct tegra_vpr_chunk *chunk =3D &vpr->chunks[i];
> +
> +		if (chunk->active)
> +			continue;
> +
> +		err =3D tegra_vpr_chunk_alloc(chunk);
> +		if (err < 0)
> +			goto deactivate;
> +
> +		err =3D tegra_vpr_chunk_activate(chunk);
> +		if (err < 0) {
> +			tegra_vpr_chunk_release(chunk);
> +			goto deactivate;
> +		}

[Severity: High]
If set_direct_map_invalid_noflush() fails partially, tegra_vpr_chunk_activa=
te()=20
returns an error, and the caller immediately invokes tegra_vpr_chunk_releas=
e().=20
Will this return partially invalidated pages back to the CMA allocator with=
out=20
restoring the linear mapping? Subsequent allocations of these pages could=20
trigger direct map faults.

[ ... ]

> +static int tegra_vpr_find_free_region(struct tegra_vpr *vpr,
> +				      unsigned int num_pages,
> +				      unsigned long align)
> +{
> +	return tegra_vpr_find_free_region_in_range(vpr, 0, vpr->num_pages - 1,
> +						   num_pages, align);
> +}

[Severity: Low]
Is there an off-by-one error here? tegra_vpr_find_free_region_in_range()=20
expects end_page as an exclusive upper bound, but passing vpr->num_pages - =
1=20
means an allocation perfectly reaching the end of the region will be=20
incorrectly rejected.

[ ... ]

> +static struct tegra_vpr_buffer *
> +tegra_vpr_buffer_allocate(struct tegra_vpr *vpr, size_t size)
> +{
[ ... ]
> +		buffer->pages =3D kvmalloc_array(buffer->num_pages,
> +					       sizeof(*buffer->pages),
> +					       GFP_KERNEL);
> +		if (!buffer->pages) {
> +			err =3D -ENOMEM;
> +			goto free;
> +		}
> +
> +		for (i =3D 0; i < buffer->num_pages; i++)
> +			buffer->pages[i] =3D &vpr->start_page[pageno + i];

[Severity: High]
Is it safe to perform direct pointer arithmetic on struct page arrays acros=
s=20
potentially massive VPR regions? On platforms using the SPARSEMEM memory mo=
del=20
without VMEMMAP, struct page objects are only contiguous within a single me=
mory=20
section. A 2 GiB VPR region crosses many section boundaries, so this arithm=
etic=20
could point into unmapped memory and crash the kernel when accessed.

[ ... ]

> +static void tegra_vpr_buffer_release(struct tegra_vpr_buffer *buffer)
> +{
[ ... ]
> +	kfree(buffer->pages);
> +	kfree(buffer);
> +}

[Severity: High]
buffer->pages is allocated using kvmalloc_array(), which may fall back to=20
vmalloc space. Shouldn't this be freed with kvfree()? Calling kfree() on a=
=20
vmalloc'd pointer will cause a SLUB panic or memory corruption.

[ ... ]

> +static int tegra_vpr_attach(struct dma_buf *buf,
> +			    struct dma_buf_attachment *attachment)
> +{
[ ... ]
> +	} else {
> +		if (sg_alloc_table(&attach->sgt, 1, GFP_KERNEL)) {
> +			err =3D -ENOMEM;
> +			goto free;
> +		}
> +
> +		sg_set_page(attach->sgt.sgl, NULL, buffer->size, 0);
> +		sg_dma_address(attach->sgt.sgl) =3D buffer->start;
> +		sg_dma_len(attach->sgt.sgl) =3D buffer->size;
> +	}

[Severity: High]
For static VPR setups, the SG list is populated with a NULL page. When=20
tegra_vpr_map_dma_buf() later calls dma_map_sgtable(), the IOMMU DMA mappin=
g=20
code relies on sg_phys(), which calculates page_to_phys(NULL) + offset. Thi=
s=20
usually results in physical address 0. The IOMMU will be programmed to map=
=20
address 0 instead of the actual VPR hardware address, breaking DMA.

[ ... ]

> +static void tegra_vpr_recycle(struct tegra_vpr *vpr)
> +{
> +	DECLARE_BITMAP(dirty, vpr->num_chunks);
> +	unsigned int i;
> +	int err;

[Severity: Low]
Here is another DECLARE_BITMAP using vpr->num_chunks that creates a VLA.

[ ... ]

> +		err =3D tegra_vpr_chunk_deactivate(chunk);

[ ... ]

> +	if (!bitmap_empty(dirty, vpr->num_chunks)) {
> +		err =3D tegra_vpr_resize(vpr);

[Severity: High]
tegra_vpr_chunk_deactivate() is called before tegra_vpr_resize(). This rest=
ores=20
the CPU's linear mapping to the memory while the hardware firewall is still=
=20
active. Does this inverted ordering create a race window where speculative =
CPU=20
accesses to the direct map could trigger a fatal bus fault / SError before=
=20
the hardware firewall is shrunk?

[ ... ]

> +static struct dma_buf *tegra_vpr_allocate(struct dma_heap *heap,
> +					  unsigned long len, u32 fd_flags,
> +					  u64 heap_flags)
> +{
> +	struct tegra_vpr *vpr =3D dma_heap_get_drvdata(heap);
> +	struct tegra_vpr_buffer *buffer, *entry;
> +	size_t size =3D ALIGN(len, vpr->align);

[Severity: High]
Could ALIGN(len, vpr->align) overflow to 0 if an unprivileged user requests=
 a=20
massive len? A 0-sized allocation might succeed and eventually underflow=20
vpr->last when it computes vpr->last =3D limit - 1 with limit =3D 0. This w=
ould=20
permanently corrupt the heap tracking bounds and break future clustered=20
allocations.

[ ... ]

> +static void tegra_vpr_debugfs_show_chunks(struct tegra_vpr *vpr,
> +					  struct seq_file *s)
> +{
> +	struct tegra_vpr_buffer *buffer;
> +	unsigned int i;
> +	char buf[16];
> +
> +	for (i =3D 0; i < vpr->num_chunks; i++) {
> +		const struct tegra_vpr_chunk *chunk =3D &vpr->chunks[i];
> +
> +		string_get_size(chunk->size, 1, STRING_UNITS_2, buf,
> +				sizeof(buf));
> +		seq_printf(s, "  %pap-%pap (%s) (%s, %u buffers)\n",
> +			   &chunk->start, &chunk->limit, buf,
> +			   chunk->active ? "active" : "inactive",
> +			   chunk->num_buffers);
> +	}
> +
> +	list_for_each_entry(buffer, &vpr->buffers, list) {

[Severity: Medium]
This iterates over the vpr->buffers linked list without holding vpr->lock.=
=20
If a user reads this debugfs file concurrently with heap allocations or fre=
es,=20
could this race with list mutations and cause use-after-free or list=20
corruption panics?

[ ... ]

> +static int tegra_vpr_add_heap(struct reserved_mem *rmem,
> +			      struct device_node *np)
> +{
[ ... ]
> +	vpr->dev_node =3D of_node_get(np);
[ ... ]
> +	if (vpr->resizable)
> +		err =3D tegra_vpr_setup_chunks(vpr, rmem->name);
> +	else
> +		err =3D tegra_vpr_setup_static(vpr);
> +
> +	if (err < 0)
> +		goto free;
[ ... ]
> +free:
> +	bitmap_free(vpr->bitmap);
> +	kfree(vpr);
> +	return err;
> +}

[Severity: Medium]
There appear to be multiple leaks in the error paths here. If=20
tegra_vpr_setup_chunks() fails, it jumps to free without calling=20
of_node_put(vpr->dev_node). Additionally, if dma_heap_add() fails, the clea=
nup=20
path calls tegra_vpr_free_chunks(), which correctly frees the chunks array =
but=20
forgets to free the vpr->active bitmap allocated during setup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D9
