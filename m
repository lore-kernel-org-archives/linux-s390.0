Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19651A6839
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987342; cv=none; b=AXjM1LP1FHAHhkjb0v/rWYF7AMb5kaKUghUOcCubD/yfB0aB+cvuRRKUPuilku1gWrQ9huD4uQsh9inmf0UrWn0gWH17MZBREWCz/lm4+25V8ymhz+Ig4AbbGtVIjUW/bPCukUE/n4QyU59xYvGmbUsyxnhzgpvVfQ8G0wVzEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987342; c=relaxed/simple;
	bh=TsDzbeMIAoB15auULJGz0zaAQwkoG+YfRfs7YSfJtPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8B3vjKbxbvaKvbyN6hwEqv5V4Fkur3r+uOqLdDeEdle7Sj+5Pis8QjnFdqbv/c/22MEVmK4wDLIgiErSpvE/OD/7Iqv+yNd9rCfwjenfy3qsVe7KAj3GpdCfTheWsI/tver3KfDjH/NIoyXNcpnI19wcThcsCDByjce2dfcRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rT3iikZD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rT3iikZD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so46008395e9.0
        for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786987338; x=1787592138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c63lTPw0sJ/0kiyWxvGmU6Nz+vfC7FNZqHlcFwaoBHw=;
        b=rT3iikZD/YYIJoqR5MfpwvdJQrQVjCs9vXXmvNmzLsCCyrNoyku0JRW/9YpPrIEG9C
         +yzLoM5UDpd+tncwANyA55sMO7PGY0/9qi+OUumYrfXbFpEhGl5KzUU38nCx2AzT/I9Q
         nAalEHdBnOoA4AD152DUqZZ/sCuvPbTtzmfLOes5kYueXge7+A2xjnK8F5n3V5Fn+tVP
         7jTM7HDD+Qcz4L5TgBDMO/qYrhdJCw9Athq3BfGH2VTAKfaDxGdYUBniSws7tO/qkP2Z
         b4wfC3ghkKo6lTqo8k9wmPhu9VDca/p93FB7g69O7KnOYn8N0MAqA0eZWTk3D3g9Uy3e
         9vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987338; x=1787592138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c63lTPw0sJ/0kiyWxvGmU6Nz+vfC7FNZqHlcFwaoBHw=;
        b=FxZ+hqSJ7xSHjkiM5bz8hFm0BqgVgpWhKAMfLj/V9XSHCLRV/e/k13d4+heTOTJvgK
         PFQ7+CnWqHAzkV7RoOIO3VoUbiqqHqA+OoWwzpUq8QmZUQabY7D+TA6Rnc3eE+28uu4e
         3fea1o/rmTV5DSoMaFNi4zp/7fT53lg4hf1A2uFVpBVjliK0XjpjRnWGoAYsOBe3JucC
         uFuppgZxwNPV/A4O366P9L5YIw/MYzDNcrQF6svumFBkZUbNfa2ENRPDbZxWobhsJB/u
         jVb1vR3gReF86RXYEQmLNYolxxm1a3k5WC2BY3BiuMwS+n4/pDk6tB1+S4qHTOSo1eGZ
         iClA==
X-Forwarded-Encrypted: i=1; AHgh+RoRfM+ejh7MU5u20mktqFcjGT7QK1iZe73mftkqNCqda2gkq5xtKg8WIHRqHzZ1PA5r9dDGoldn6l8V@vger.kernel.org
X-Gm-Message-State: AOJu0YyC/TV/24Y8Fbwc/Hw1kwgYB6VEOlla3baqJBqqQaIDLgvG++tv
	zq8oc9VWBOjLwdPVV/5yvL6uOl20z7hUAysRqGoKF6Mlmd7k1i7gAMvJZFrgfeUtew==
X-Gm-Gg: AR+sD12ZCunuAb4gRPSHo1AHQshkxZQuKQmczZw8rQldF0YiWXxBpR9sn6fBZBtR7+g
	aLdWSC8rJjKxX2uTJ9jFK5kHMnPRudWTc0OimFqAw2prJBTDyaWPtrccw/EMNKhfSrpaVlGxhh4
	++qbnoyxD/b5CAjEpJFdV6qhqMln1r80QSdlbqt4y7KUMMr0Twqv8Jmwzk2fgvw3ugREfExGnJE
	q2FemYlHZ/o9ZPkZxgeRK7i6bd0kT0eX1oFoeeRSUzBt5bn8XY+VSwY/u2W3PlWkZH+GzUVuk0n
	FH7eEz6w4AP3OtZPuJyGbZMVQtfMgvd9P4fM7m5lRpcLIzKkh6xwFV6ATclA0bZKqTsx4kl79hC
	8fsiJa0BdeJhV91DTbJkF08lbLw+/QSMViArClWGwOy9Nwq5rWwVpXaJ+soYMnH2rYGSfH8aBLR
	5tUfXU1qkv8PWnTwv0ZJXVJxSGECe7AB/amlYrieKhHmSRBzyl6cE0HGIWjs6qp2Sn1TTKFjGpq
	fAh94fo9UAD75ml9FN4sq86bezcI+Ow
X-Received: by 2002:a05:600c:c171:b0:499:7f38:d77 with SMTP id 5b1f17b1804b1-4999fb2e1dbmr33554105e9.6.1786987337398;
        Mon, 17 Aug 2026 10:22:17 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b51asm5583583f8f.11.2026.08.17.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:22:16 -0700 (PDT)
Date: Mon, 17 Aug 2026 18:22:13 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Chun Ng <chunn@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
	linux-trace-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH v4 07/10] dma-buf: heaps: Add support for Tegra VPR
Message-ID: <aoNDRTKCUkzd2n5G@google.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com>
 <an4MEI7lkc2p3nKI@google.com>
 <an8K2gb1pIqbDj6-@orome>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an8K2gb1pIqbDj6-@orome>

On Fri, Aug 14, 2026 at 02:56:05PM +0200, Thierry Reding wrote:
> On Thu, Aug 13, 2026 at 07:25:20PM +0100, Vincent Donnefort wrote:
> > On Fri, Aug 07, 2026 at 05:54:27PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > NVIDIA Tegra SoCs commonly define a Video-Protection-Region, which is a
> > > region of memory dedicated to content-protected video decode and
> > > playback. This memory cannot be accessed by the CPU and only certain
> > > hardware devices have access to it.
> > > 
> > > Expose the VPR as a DMA heap so that applications and drivers can
> > > allocate buffers from this region for use-cases that require this kind
> > > of protected memory.
> > > 
> > > VPR has a few very critical peculiarities. First, it must be a single
> > > contiguous region of memory (there is a single pair of registers that
> > > set the base address and size of the region), which is configured by
> > > calling back into the secure monitor. The memory region also needs to
> > > quite large for some use-cases because it needs to fit multiple video
> > > frames (8K video should be supported), so VPR sizes of ~2 GiB are
> > > expected. However, some devices cannot afford to reserve this amount
> > > of memory for a particular use-case, and therefore the VPR must be
> > > resizable.
> > > 
> > > Unfortunately, resizing the VPR is slightly tricky because the GPU found
> > > on Tegra SoCs must be in reset during the VPR resize operation. This is
> > > currently implemented by freezing all userspace processes and calling
> > > invoking the GPU's freeze() implementation, resizing and the thawing the
> > > GPU and userspace processes. This is quite heavy-handed, so eventually
> > > it might be better to implement thawing/freezing in the GPU driver in
> > > such a way that they block accesses to the GPU so that the VPR resize
> > > operation can happen without suspending all userspace.
> > > 
> > > In order to balance the memory usage versus the amount of resizing that
> > > needs to happen, the VPR is divided into multiple chunks. Each chunk is
> > > implemented as a CMA area that is completely allocated on first use to
> > > guarantee the contiguity of the VPR. Once all buffers from a chunk have
> > > been freed, the CMA area is deallocated and the memory returned to the
> > > system.
> > 
> > Hi,
> > 
> > I believe we (the Android team) are trying to solve similar issue to yours: Arm
> > CPUs can still speculatively read memory after it has been transitioned to the
> > Secure state, as long as they retain a cacheable mapping to it.
> > 
> > As modifying the direct mapping is difficult, the workaround ended up in the
> > hypervisor which unmaps the pages from the host stage-2 on intercepted FF-A Lend
> > invocations.
> > 
> > If convenient, this is nonetheless the wrong place to do it. Scattering the host
> > stage-2 is really terrible for performance and we would like to move it where it
> > should be, directly into the kernel...
> > 
> > This is what I thought was the attempt in v3, but I am now a bit confused
> > because I see you are using set_direct_map_invalid_noflush()
> > set_direct_map_default_noflush(), but I am not sure that works if rodata=full is
> > not set? So does the memory for the NVIDIA IP still need to be unmapped?
> 
> Yeah, this currently relies on the circumstances being such that
> can_set_direct_map() returns true, and in the case where we want to use
> the resizable VPR functionality, we're going to have page-granular
> mappings anyway.
> 
> > If so, how about having an option where the CMA allocation is backed by a direct
> > map with the same page granularity, or at least a smaller and aligned granule?
> > 
> > With that, we know that for whatever CMA allocation we do, we can safely unmap
> > from the direct map without risking splitting blocks. On CMA free, we can safely
> > remap into the direct map as I do not believe we coalesce yet.
> 
> This sounds intriguing. For VPR we could possibly make the size a
> multiple of the memblock size (or whatever might be appropriate). If we
> can create a page-granular linear mapping specifically for that region,
> that'd be ideal. I don't know if the linear mapping can be subdivided in
> this fashion, though.

Actually I don't think modifying the memblock is necessary at all!

Here's what I have so far:

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d4de88770ecf..a9f81413b70d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/of_fdt.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/kfence.h>
@@ -1138,6 +1139,27 @@ static inline void arm64_kfence_map_pool(void) { }
 
 #endif /* CONFIG_KFENCE */
 
+#define MAX_FORCE_PTE_REGIONS 64 /* Greater or equal to MAX_RESERVED_REGIONS */
+
+static struct {
+       phys_addr_t start;
+       phys_addr_t end;
+} force_pte_regions[MAX_FORCE_PTE_REGIONS] __initdata;
+
+void __init early_init_dt_force_pte_arch(phys_addr_t start, phys_addr_t end)
+{
+       static int count;
+
+       if (force_pte_mapping())
+               return;
+
+       if (count >= MAX_FORCE_PTE_REGIONS)
+               return;
+
+       force_pte_regions[count].start = start;
+       force_pte_regions[count++].end = end;
+}
+
 static void __init map_mem(void)
 {
        static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
@@ -1186,6 +1208,15 @@ static void __init map_mem(void)
        __map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
                       flags);
 
+       for (i = 0; i < ARRAY_SIZE(force_pte_regions); i++) {
+               if (!force_pte_regions[i].end)
+                       break;
+
+               __map_memblock(force_pte_regions[i].start, force_pte_regions[i].end,
+                              pgprot_tagged(PAGE_KERNEL),
+                              flags | NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+       }
+
        /* map all the memory banks */
        for_each_mem_range(i, &start, &end) {
                /*
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 42e3e2d8a2b8..445f204f01e4 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -136,6 +136,8 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
        return memblock_reserve(base, size);
 }
 
+void __weak early_init_dt_force_pte_arch(phys_addr_t start, phys_addr_t end) { }
+
 /*
  * __reserved_mem_reserve_reg() - reserve memory described in the
  * first entry in 'reg' property
@@ -168,6 +170,9 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
        size = s;
 
        if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
+               if (of_get_flat_dt_prop(node, "force-pte", NULL))
+                       early_init_dt_force_pte_arch(base, base + size);
+
                fdt_fixup_reserved_mem_node(node, base, size);
                pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
                         uname, &base, (unsigned long)(size / SZ_1M));
@@ -517,6 +522,9 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
                return -ENOMEM;
        }
 
+       if (of_get_flat_dt_prop(node, "force-pte", NULL))
+               early_init_dt_force_pte_arch(base, base + size);
+
        fdt_fixup_reserved_mem_node(node, base, size);
        fdt_init_reserved_mem_node(node, uname, base, size);
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 51dadbaa3d63..6c73c76dee1b 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -74,6 +74,7 @@ extern void early_init_dt_check_for_usable_mem_range(void);
 extern int early_init_dt_scan_chosen_stdout(void);
 extern void early_init_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
+extern void early_init_dt_force_pte_arch(phys_addr_t start, phys_addr_t end);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
 extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
 
> 
> > (This alignment is not necessary for upcoming systems with BBML3)
> > 
> > However, to implement this, we'd need to split memblocks and I believe the only
> > way at the moment is temporarily mark it as "nomap" which didn't seem very
> > popular in the comments on v3.
> 
> Could this be simplified if this type of allocation is always memblock
> aligned?
> 
> Looking at map_mem(), it seems like we could add some sort of special-
> casing in the for_each_mem_range() block to check if the memory is VPR
> (or generic, page-granular carveout, or whatever we want to call it) and
> set NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS in that case.
> 
> If that works, set_direct_map_*() could be enhanced to detect such cases
> and always work. Or perhaps a more specific API could be introduced.
> 
> Thierry

for set_direct_map() I think we could extend it to check if it is mapped at the
PTE-level and if it is we can proceed?

I am currently looking at extending CMA with an option "unmap-on-alloc;" that
would only be available if CONFIG_ARCH_HAS_SET_DIRECT_MAP, or
cma_set_unmap_on_alloc, or if "force-pte;" is set. 

Hopefully I can share something this week.

-- 
Vincent
