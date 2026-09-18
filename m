Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E344498906;
	Fri, 18 Sep 2026 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715222; cv=none; b=bhxkxG5AOXqDwh/qyHrhnUptgL+isLB4izAFvzMn0u54HiCcmtcOViWFgmKC+kpDCKsHDt0XMbGb1ExmkRLS3Y6eWI/Yucts6Zm3rKAH7aLb1mDgH5KkZ2pFMLfCRco3gLK3f03AvCdV+BIqDrMCnXVFA1dE6/rRunITJpt8Prk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715222; c=relaxed/simple;
	bh=gjbyf3Gcbv4XlVEKdrgPMZz66DVdSELa98i5Z2lm5Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtT1FMswPxP9i+SdhXjrJAizMiuEM4UqzPBdEuSBtS6OSZO8zvgbVNMY5EY9YZIQ8RfojO6h7eV2TqwHdw+nEJD8WTcCL9/o/tUujfbmRLpPCbzFcQWcD8/NzA3Hl0Mfoft3TKUD2O+K3A4JvYAClfQS1QrjuzduK3AF7xUHEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPezEhSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPezEhSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5821F000FF;
	Fri, 18 Sep 2026 07:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789715217;
	bh=CYTKS6LtEqOXedQDCZMgSMsK8BAtRN8tnXK08Vs7mUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QPezEhSFz1oJEKdWrJysPdVqTui36u9odN7Ok89a/CQ+JbBtuDOXa15EERg8ZHwM6
	 ZTt4ZDn1nuVULyCuBvwHgV2346nH5Q31xiBVxqTWKRcU7H6+vPVnG+MBoStEXxZlH1
	 Xap4i3X/5T8j7QsiIHsnc7bbLDJvtAEI0m4rAYlMU5rHISYDO7bukISllG5+xtwJNz
	 kM7l/Kjb5SAW/Fihbkforg6oxz5cfiOZ4ZYWcuKqsxjhJpAKsTlv7VRjoreQWFvDxr
	 TGrZ/lQF71IY8+LNwMLWkMQDSnXz5F5cqxBokgTzQ5HZlmjxvRF1P5+OBsVW9rmiXP
	 MqnIc0HIdvADA==
Date: Fri, 18 Sep 2026 10:06:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Len Brown <lenb@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v3 1/6] set_memory: add number of pages parameter to
 set_direct_map APIs
Message-ID: <aqzjBA_101LcKRCD@kernel.org>
References: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
 <20260903-execmem-set-vm-perms-v0-2-v3-1-949b64a9f755@kernel.org>
 <d299f7c5-6c71-499a-b8cd-aa69c4c81dd1@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d299f7c5-6c71-499a-b8cd-aa69c4c81dd1@arm.com>

On Thu, Sep 17, 2026 at 08:11:22PM +0200, Kevin Brodsky wrote:
> On 03/09/2026 11:28, Mike Rapoport (Microsoft) wrote:
> > When set_direct_map APIs were introduced by the commit d253ca0c3865
> > ("x86/mm/cpa: Add set_direct_map_*() functions") the single page
> > parameter made sense because the initial callers (vmalloc and
> > hibernation) had sets of unsorted struct pages that required changes of
> > their mappings in the direct map.
> >
> > Since there is an increasing demand for direct map manipulation and it
> > is also desirable to be able to update larger physically contiguous
> > mappings, for example an entire large folio, extend set_direct_map APIs
> > to receive number of pages parameter.
> >
> > As there is still only a handful of callers, change the existing
> > functions directly and update all the call sites rather than adding
> > wrappers for single page case.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/arm64/include/asm/set_memory.h     | 4 ++--
> >  arch/arm64/mm/pageattr.c                | 8 ++++----
> >  arch/loongarch/include/asm/set_memory.h | 4 ++--
> >  arch/loongarch/mm/pageattr.c            | 8 ++++----
> >  arch/riscv/include/asm/set_memory.h     | 4 ++--
> >  arch/riscv/mm/pageattr.c                | 8 ++++----
> >  arch/s390/include/asm/set_memory.h      | 4 ++--
> >  arch/s390/mm/pageattr.c                 | 8 ++++----
> >  arch/x86/include/asm/set_memory.h       | 4 ++--
> >  arch/x86/mm/pat/set_memory.c            | 8 ++++----
> >  include/linux/set_memory.h              | 6 ++++--
> >  kernel/power/snapshot.c                 | 4 ++--
> >  mm/secretmem.c                          | 6 +++---
> >  mm/vmalloc.c                            | 5 +++--
> >  14 files changed, 42 insertions(+), 39 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
> > index 90f61b17275e1..b07fd4e026eac 100644
> > --- a/arch/arm64/include/asm/set_memory.h
> > +++ b/arch/arm64/include/asm/set_memory.h
> > @@ -11,8 +11,8 @@ bool can_set_direct_map(void);
> >  
> >  int set_memory_valid(unsigned long addr, int numpages, int enable);
> >  
> > -int set_direct_map_invalid_noflush(struct page *page);
> > -int set_direct_map_default_noflush(struct page *page);
> > +int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
> > +int set_direct_map_default_noflush(struct page *page, unsigned int numpages);
> 
> I don't have a strong opinion on whether to call the argument nr or
> numpages, but we might as well be consistent across archs :)

Well, it's either consistent across archs or consistent within each arch :)
Or add a churny patch that renames it everywhere to nr_pages :)
 
> Aside from that:
> 
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

Thanks!

-- 
Sincerely yours,
Mike.
