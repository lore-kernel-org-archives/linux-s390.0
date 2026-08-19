Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2C3D4128;
	Wed, 19 Aug 2026 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122360; cv=none; b=ldGrxMFgTawmSVUBI7TvGIlE2OxBZnX3clb+olGRN5yLMBnF23zUwhIVfgn/geK/NC7APR2hOWWgExZEfuShPDA6FaX5upT5zcpDHd+4ukLkCR0sk348qCWanowhScKZSlVrre1KSJILgvarGn/JA3tkEuNsSb3Iqbdkus5Nia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122360; c=relaxed/simple;
	bh=ONtBQ2kZ+7dkxiGpao17uLBP4vsrPT+zPy1RD7Ksg5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRqTlfS6Wb0pY9+W5XFeQhPNRizMyfNPDE6sE5tIAczR44ypTEBLF/3dlhBFodUv4LD8AkG4+dpx98RBPDBa2LAVajJQk2de5MeyzjGfS1kUJsccFdE8I8cPzwQqCfVd4CnBUBbnyfJkYvNxksKRDcXQ1SaKuiuFPisn/clH0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkLTMf+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkLTMf+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7811F000E9;
	Wed, 19 Aug 2026 06:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787122357;
	bh=7d351kwETeBhwKUAevfFIdhiS/3pPYk4RDmKm2u9Xu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WkLTMf+qpN/io805Y+2gkeOkMbkpIKzf/6QzY2J/6Bl2FWOx3hYwxZqHUNh5M4dgw
	 NmuyAHXcBRvh2GxscHJW61nXGUBR8lNKbUmLxqWPpQcQgLHWUAVlSWz6LVoosdqCUL
	 ZEmosEMGQfwSgXLsUlMUGHaMqKfk3Jvw8lbWY34WrNbJ3DRB7qmc/YZZa7OShj2kZU
	 9F9gzCeo4nBVxNMDWaMYPftvg52ti3BnqeVARRjJq5cVbN2pVAHAoYGhFw0l1dFtDu
	 nWSAaMBzSD2S1DqUVmDAMWvEN7eDywpx8rVr2/eMxUkxs3qh6vnl3GoJDWDRt0ReB8
	 kGYH6E45e0M5Q==
Date: Wed, 19 Aug 2026 09:52:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH 1/6] set_memory: add number of pages parameter to
 set_direct_map APIs
Message-ID: <aoVSpnf-b-btyHR9@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-1-90944a3ad43f@kernel.org>
 <DKR7IK0VAERF.3ALVHRNQMSXZU@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKR7IK0VAERF.3ALVHRNQMSXZU@linux.dev>

On Mon, Aug 17, 2026 at 02:10:39PM +0200, Brendan Jackman wrote:
> On Sun Aug 16, 2026 at 12:59 PM CEST, Mike Rapoport (Microsoft) wrote:
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
> 
> I think if we add this arg we also need to specify how the
> implementations are supposed to behave when they fail midway?

This is the same as set_memory, I don't think it deserves a special care
right now.

> IIUC the incumbent answer for stuff like this is:
> 
> - The implementation might leave partial modifications behind when it
>   fails. The caller needs to deal with that.
> 
> - ... But, that's gonna be due to allocation failure. So the caller can
>   just do the inverse operation in the failure path as a cleanup, and
>   assume that inverse operation succeeds since the pagetables are
>   already allocated up to the failure point.
> 
> I guess it's worth making that a sort of explicit contract since it
> makes certain implementation details load-bearing, e.g. I think...
> 
> - It forces the pagetable update algorithm to work in a fixed order.
> 
> - it forbids us to e.g. merge PTEs into a PMD if the region might be
>   pending such a cleanup, since it would force that cleanup to
>   reallocate a PTE table.

I'd leave the load-bearing parts for now ;-)

I'm going to resend the patches that generalise CPA and I'll add some docs
to that set.

[1] https://lore.kernel.org/linux-mm/20260721-generic-set-memory-v0-1-v1-0-2c1fc62306b3@kernel.org/

-- 
Sincerely yours,
Mike.
