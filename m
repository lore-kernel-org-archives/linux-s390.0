Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C548349CEF;
	Fri,  9 Oct 2026 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512662; cv=none; b=QWavyFjZPI5VF509Ww6CT6zD++Dtg7EZ3vI5laLN3UL6adH1cTKUuhStpflV/MO50aXbCMXNdCY7EeDmziH7c+LgcUPXotlnqTvQR0H+52dJD6lnFYm+oBfeLTRwJkuowiVpcgEnXW77Z0eF7U0YKvEzRcS7Y0rJMfGTP+QPzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512662; c=relaxed/simple;
	bh=2QLRKUYyFp8S6i+UXZO3Wxnz517D73K9DyPKeDJE9KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJrrqlOhMHeiMUd8Y7okO2NFy/IbCeHxNi7yQDdj0axq9khJ2nKZi60JhB6K890Z5Il5OtsjwuEYO1I3mln1khDC/RGvpLG50JU4hA3nCkLmbt1XxrpKEKKmPGSNE0ucNjsl5+Lut1BM3M2S2V6xNM6uo59WrguUOr/k53nDRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cdimGt4B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cdimGt4B"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0010F1692;
	Thu,  8 Oct 2026 19:24:14 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99E593F66F;
	Thu,  8 Oct 2026 19:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791512658; bh=2QLRKUYyFp8S6i+UXZO3Wxnz517D73K9DyPKeDJE9KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdimGt4BwBkbC2kvqJXbpnU8+qL/O0F0HZ2Z0H4CpSxUOxCh+EcoJtLXctAWoTzrV
	 OtcAfxF5iREGuxkwM6scrG4vYN4mDhOT5dXuCp6y3UYQNkA+QiuO7WX1/GccVSzj2V
	 OoaC3kiLUtydOmdP9bIBEODXTrrr6BODQU57YXnw=
Date: Fri, 9 Oct 2026 07:54:15 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-mm@kvack.org, samuel.holland@sifive.com, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 8/8] mm: Drop pxd_ERROR()
Message-ID: <y4zwpwqqxnjtwzm2j5xrdnnmdle5eiih7tsn7quywur7w2beh4@z3lk5ztxdz35>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-9-anshuman.khandual@arm.com>
 <c24fc419-7bee-4fe4-be12-9aa378d49af1@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c24fc419-7bee-4fe4-be12-9aa378d49af1@gaisler.com>

On Thu, Oct 08, 2026 at 11:20:14AM +0200, Andreas Larsson wrote:
> On 2026-08-31 07:43, Anshuman Khandual wrote:
> > There are no more users left for any pxd_ERROR() either in generic MM or in
> > the platform MM. Hence all these platform macros along with their generic
> > fallback could be dropped across the tree.
> > 
> > Cc: linux-alpha@vger.kernel.org
> > Cc: linux-snps-arc@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-csky@vger.kernel.org
> > Cc: linux-hexagon@vger.kernel.org
> > Cc: loongarch@lists.linux.dev
> > Cc: linux-m68k@lists.linux-m68k.org
> > Cc: linux-mips@vger.kernel.org
> > Cc: linux-openrisc@vger.kernel.org
> > Cc: linux-parisc@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-riscv@lists.infradead.org
> > Cc: linux-s390@vger.kernel.org
> > Cc: linux-sh@vger.kernel.org
> > Cc: sparclinux@vger.kernel.org
> > Cc: linux-um@lists.infradead.org
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ...>  /*
> >   * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
> >   * are !pte_none() && !pte_present().
> > diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
> > index f89b1250661d..5a5f54a090f5 100644
> > --- a/arch/sparc/include/asm/pgtable_32.h
> > +++ b/arch/sparc/include/asm/pgtable_32.h
> > @@ -40,9 +40,6 @@ void load_mmu(void);
> >  unsigned long calc_highpages(void);
> >  unsigned long __init bootmem_init(unsigned long *pages_avail);
> >  
> > -#define pte_ERROR(e)   __builtin_trap()
> > -#define pmd_ERROR(e)   __builtin_trap()
> > -#define pgd_ERROR(e)   __builtin_trap()
> >  
> >  #define PTRS_PER_PTE    	64
> >  #define PTRS_PER_PMD    	64
> > diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> > index 0837ebbc5dce..44d1333065a6 100644
> > --- a/arch/sparc/include/asm/pgtable_64.h
> > +++ b/arch/sparc/include/asm/pgtable_64.h
> > @@ -96,16 +96,6 @@ bool kern_addr_valid(unsigned long addr);
> >  #define PTRS_PER_PUD	(1UL << PUD_BITS)
> >  #define PTRS_PER_PGD	(1UL << PGDIR_BITS)
> >  
> > -#define pmd_ERROR(e)							\
> > -	pr_err("%s:%d: bad pmd %p(%016lx) seen at (%pS)\n",		\
> > -	       __FILE__, __LINE__, &(e), pmd_val(e), __builtin_return_address(0))
> > -#define pud_ERROR(e)							\
> > -	pr_err("%s:%d: bad pud %p(%016lx) seen at (%pS)\n",		\
> > -	       __FILE__, __LINE__, &(e), pud_val(e), __builtin_return_address(0))
> > -#define pgd_ERROR(e)							\
> > -	pr_err("%s:%d: bad pgd %p(%016lx) seen at (%pS)\n",		\
> > -	       __FILE__, __LINE__, &(e), pgd_val(e), __builtin_return_address(0))
> > -
> >  #endif /* !(__ASSEMBLER__) */
> 
> Perhaps a bit of a pity to lose the printing of the address of the pxd
> that a number of architectures did before this series, but i have no
> strong opinion.
> 
> Acked-by: Andreas Larsson <andreas@gaisler.com> # sparc

Thanks Andreas.
