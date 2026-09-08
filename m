Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA04B0491
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857899; cv=none; b=CPSwJTziv0vcMDCxoG8yssOSMZhbprypRlh+bYgu31QGYTVN4IXPO+P8kSz4dVp/CJ3fmZS7aSEtPc5xPYbmic0hTu+3VBgoZq4rtWo0hH2NOjDvC1k+OSTN8t95Dq9ReAzMTGkqx2/IHjIraJi4exbKwg3oaVou23cEo66mnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857899; c=relaxed/simple;
	bh=PJJQNvMp8i9KxxLS+rEKdYHyflNnINHi84WAuotPNB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjKdrED2ceu/Lc2IYvBVdJZIVK18AK43zfCnHgkkSnd+JrPOWjjps1EgxEagc9hOZCRX5wYG5+70M0WRN0qSXO0zlKXX2Na47sTe0kryJNObcYxHbFC/xwbC8771pk1OT2nalsjYikyxP18J7k7RueREYOwwFcMMWD/ljH+/TjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZjIIvCI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZjIIvCI"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso41943435e9.3
        for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788857882; x=1789462682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1zFe5CkdviVdWpTUjRsL71ghioltrlS4PEP9q+np+JE=;
        b=RZjIIvCIiWyCEv/WsP9MnybSlBRLNivD48VZibYeUqfC7lI+DfCD+EIoTkewzwl7Tb
         cG7laJWXtfkz04bMnAGoKBHYiVvxKisaewfYDW3y4XXcRwc8C1W5/9vRVMBeUuzM1gQ6
         3E1phxUpQ8kuKtOftF5ftqER+bYmlfjeOqFSNXq/qsamJFkRhasF6ujUWr05oyeROr8M
         +43EDKFVMtlMrxnWytwKu4KoumTDstluwJR1LvQLFhAPUoM7K8+7hRlZInYbovB0Js96
         Z5LmKZas/enzuoxxfwFunc+geQqNKrEW63EF7MNQR2QtjrEc7uNiX6jdwTF6SdCh2zvP
         rVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788857882; x=1789462682;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1zFe5CkdviVdWpTUjRsL71ghioltrlS4PEP9q+np+JE=;
        b=kgZhzfmnjghbQig/HF5lYI3x67ke+lmSBcE4WsNHDYhuiy/Y11H/1LswwPaSACf1/C
         t48fgbaLzCy7ZPxYBPw6KEGpJMLnih+7pg6VriCmGXoyluq3d5oFCVBtKHzJwydRCta3
         c6VDSDkVjRJ/gjuHezE17DwwQQOmqCM11gjGyF/eBmjyXGkx/f2tF3BLi1D2A1r/3onT
         rCZ7jjvBKGWB7qEPmhgtQaf/wIlzL4gqWYgC34pASCz3NHwfcYvFiJt8zNqzC62D9OR5
         Gf6BWTRqK6qRbWmhQVNDAjASm+x+nOF9i01vDlyzYdUCJB0U4QmxfG3ts3K7gkyeSr78
         34Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxhrq8ExPvLbr6HXWRxREo76+5QKSbQmgW7vClRN4SSX2dUIUTsV+TyBxTTRiSORxPU6lE2vfE7SRzz@vger.kernel.org
X-Gm-Message-State: AFuF++maTDFew4wLS2P8cDUqzYjLc0YsqkkzzBi2yWgjY8c2/ehrm9WV
	pQWb16pVjwyEZBEpMC7nf+SkyWPwaCe57BvRdZKm96MlqjI5ogvaITI/XOw9M2Sx4Q==
X-Gm-Gg: AYBFou3xOCbI5eLn6Vj/B5DlZ0Y+z7Bm4B+fz8TRkB+qCSQ/7qASpVvAPYpEKE5Lt7j
	JirmmpcllxXH3u/80/eZsUVzHLfZi95NQ3Dggt2mjVPNsDPMju7rQj7onnxR8/SfDJdhCIKSDRG
	jQk+a/UgcuhPInEjGi4xecaroKWvhBMhNBRDHVKk4GIVDwOooFSKR/u/T7hHhPEAztR8ISwHi43
	kklUwXg6XKr33tQaeXKaVIFiyRmxOHlwDiaE28eoL2VvN7f9FTc13Y8I29oGjkUnrtT7kdZQWRf
	Wo37ehnsnfe+U6wTHN7oKTW1H7WumpPSPzFwPpPb3worrL52fNo5snVkZH12nGc3oyY3W65aO71
	QqIeDhf7+RjXho1UVB/j9XIJ4DlvaLRogH4bHVlrwaDnueQde3ts2hZjeFaulgYNXZCXQiaI+en
	I2x+5U3wrZSttfyCw50l7XbFn3HKWlKq773xTs/wxtoAHMfI5Qo+gxy24d1uANo4WI1sv1Epr/G
	g644JaZHZgQI4POD2Ja468HYIMcZbgoNw==
X-Received: by 2002:a05:600c:4713:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49cfa20cd4dmr257500325e9.23.1788857881099;
        Tue, 08 Sep 2026 01:58:01 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm476174585e9.4.2026.09.08.01.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:58:00 -0700 (PDT)
Date: Tue, 8 Sep 2026 09:57:57 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Chun Ng <chunn@nvidia.com>, Mark Rutland <mark.rutland@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
	linux-trace-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v6 00/12] dma-buf: heaps: Add support for Tegra VPR
Message-ID: <ap_OFQepcu26g88u@google.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <apquUWgrD9C2jWQ0@willie-the-truck>
 <ap_HzwVp-6aOKEbJ@orome>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_HzwVp-6aOKEbJ@orome>

On Tue, Sep 08, 2026 at 10:39:17AM +0200, Thierry Reding wrote:
> On Fri, Sep 04, 2026 at 12:41:05PM +0100, Will Deacon wrote:
> > Hi Thierry,
> > 
> > On Fri, Sep 04, 2026 at 12:44:51PM +0200, Thierry Reding wrote:
> > > This series adds support for the video protection region (VPR) used on
> > > Tegra SoC devices. It's a special region of memory that is protected
> > > from accesses by the CPU and used to store DRM protected content (both
> > > decrypted stream data as well as decoded video frames).
> > > 
> > > Patches 1 through 3 add DT binding documentation for the VPR and add the
> > > VPR to the list of memory-region items for display, host1x and NVDEC.
> > > 
> > > The set_direct_map_*_noflush() functions that will be used later in this
> > > series are exported in patch 4 so that the drivers that use them can be
> > > built as a module.
> > > 
> > > Patch 5 adds bitmap_allocate(), which is like bitmap_allocate_region()
> > > but works on sizes that are not a power of two.
> > > 
> > > The of_node_to_nid() function is exported in patch 6 because it is used
> > > in a later patch adding a driver that can be built as a module.
> > > 
> > > Patch 7 introduces new APIs needed by the Tegra VPR implementation that
> > > allow memory to be allocated at a fixed offset within a CMA area. Tegra
> > > VPR needs this in order to implement its own allocator on top of CMA to
> > > meet the strict hardware requirements. This replaces the dynamic CMA
> > > area creation patch from earlier versions.
> > 
> > Did you get a chance to see how this could work with Vincent's series:
> > 
> > https://lore.kernel.org/r/20260902104712.2399797-1-vdonnefort@google.com
> > 
> > ? I think that should remove your reliance on can_set_direct_map() and
> > mean that you can retain block mappings for most of the linear mapping.
> 
> I'm not sure if it would help all that much. Yes, if we mark the VPR
> region as LLMAP (or PTE_MAP, whichever it ends up being), it should make
> the checks for can_set_direct_map() redundant. However, from what I can
> tell, Vincent's series still forces page-granularity on these regions,
> so it won't retain block mappings at all for them.
> 
> The block mappings can be retained for the non-VPR memory, so that's
> nice. It also reduces the amount of external prerequisites, but I had
> kind of hoped that we could go one step further and keep block mappings
> even for the VPR memory if the region happened to be a multiple of the
> block size.
> 
> The recent addition of page count to the set_direct_map_*() functions
> helps reduce the amount of checks that need to be run, so maybe there's
> not too much to be gained from removing whole block mappings at once
> from the linear map.
> 
> Thierry

I should be able to add PMD_SIZE mapping support to the series. That was
actually my original idea as we can easily force the CMA allocation granule to
be PMD_SIZE too.

I didn't implement it as I thought there were not much interest in the end (and
also as contiguous.c is always using PAGE_SIZE granularity).

But now as I have implemented a specific pool (and do not use contiguous.c as
originally planned), if you believe it is important for the VPR driver, let me
see if I can extend the support in a V2.

-- 
Vincent
