Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99191345749;
	Thu, 13 Aug 2026 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786595662; cv=none; b=GzT0Vamh6EB4IYNMm3L97CwgWT1EkfdRW13GZpBMDv5XKcp21zk3i1uWgS6SG9jCql4XHG5i0YpXlKVBS+RGBpDVRliDN9dlH8J1bLyWltVEuhX/CYHBOFWFvI/M7OoPetrxUc+z232XFg/F/l9J+0PWIRcsr1MbnTuF4B7VrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786595662; c=relaxed/simple;
	bh=mO6mrRKNqP+ykHI/mGROppdDnXxIwgWT7LgXJj+JezI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSPFvuKsku569kd4Nk6gztsu27KRVylGr0S956nCg8L9fJetIHsu+xJFQEMxgxrAT1HDx2jmEvAejcsBY45T0xyeVjXC3KAXA4k+KUYzW9Q1nLwCb+TfDJzmakdvBaxbsUyJixpNi/AZs+dDshY/nMyWKSUbI7Tl7R64c92VeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ucFab0TP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ucFab0TP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8A551596;
	Wed, 12 Aug 2026 21:34:14 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E593D3F632;
	Wed, 12 Aug 2026 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786595658; bh=mO6mrRKNqP+ykHI/mGROppdDnXxIwgWT7LgXJj+JezI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ucFab0TPnxvbqz3KEVyBy+XPNcRzGlpGCroO3Eciy3LZ0+X/OxqSrfgUvooo+EVnM
	 CkkbCWk5eaKn4RSc34lEp7tZQ4pnzvhzXI1BWphp8/e5uuWc6hv5uSnA/KhXLfZVFZ
	 sIXAXG2CvPJZ7I27QA35Hy/JfVFzGZIK3afmsQfQ=
Date: Thu, 13 Aug 2026 10:04:15 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 1/6] loongarch/mm: Stop using pte_ERROR()
Message-ID: <qymuy4grl654s6jwwyhlwwo6kfr3ongxpfnxifojkvism2ddwg@5lyq7iooel6b>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-2-anshuman.khandual@arm.com>
 <e0ada89f-26b2-4e82-8273-8ea7b391c147@kernel.org>
 <9a66d741-536e-44ac-b02f-395b5fc8ab6d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a66d741-536e-44ac-b02f-395b5fc8ab6d@kernel.org>

On Wed, Aug 12, 2026 at 01:27:54PM +0200, David Hildenbrand (Arm) wrote:
> On 8/12/26 13:19, David Hildenbrand (Arm) wrote:
> > On 8/11/26 06:21, Anshuman Khandual wrote:
> >> Directly use pr_err() in __set_fixmap() and drop pte_ERROR() which helps in
> >> eventually dropping pte_ERROR() macro across the tree. In this new printing
> >> __FILE__ and __LINE__ has been dropped because they are always the same and
> >> don't really add any value.
> >>
> >> Cc: Huacai Chen <chenhuacai@kernel.org>
> >> Cc: WANG Xuerui <kernel@xen0n.name>
> >> Cc: loongarch@lists.linux.dev
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  arch/loongarch/include/asm/pgtable.h | 2 --
> >>  arch/loongarch/mm/init.c             | 2 +-
> >>  2 files changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> >> index 223528c04d73..a32a8fff70c1 100644
> >> --- a/arch/loongarch/include/asm/pgtable.h
> >> +++ b/arch/loongarch/include/asm/pgtable.h
> >> @@ -128,8 +128,6 @@ struct vm_area_struct;
> >>  #define ptep_get(ptep) READ_ONCE(*(ptep))
> >>  #define pmdp_get(pmdp) READ_ONCE(*(pmdp))
> >>  
> >> -#define pte_ERROR(e) \
> >> -	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
> >>  #ifndef __PAGETABLE_PMD_FOLDED
> >>  #define pmd_ERROR(e) \
> >>  	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
> >> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> >> index 3407030f3e7a..be9b127daef2 100644
> >> --- a/arch/loongarch/mm/init.c
> >> +++ b/arch/loongarch/mm/init.c
> >> @@ -203,7 +203,7 @@ void __init __set_fixmap(enum fixed_addresses idx,
> >>  
> >>  	ptep = populate_kernel_pte(addr);
> >>  	if (!pte_none(ptep_get(ptep))) {
> >> -		pte_ERROR(*ptep);
> >> +		pr_err("bad pte %016lx\n", pte_val(*ptep));
> >>  		return;
> >>  	}
> >>  
> > 
> > Ah, I missed that we want to print actual values, I somehow thought that we
> > would be printing pte_none() ...
> > 
> > Maybe we should just be more verbose while at it?

Initially thought that these new prints should be right close to the
original via pxd_ERROR() but I guess making them verbose while doing
the replacements should be indeed acceptable.

> > 
> > pr_err("unexpected set PTE at %ul in __set_fixmap: %016lx\n",
> >        addr, pte_val(*ptep));
> > 
> 
> On second thought, why not simply use ptval_to_str() here as well?

Sure will do the required changes - the following builds successfully.

--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -197,13 +197,15 @@ void __init __set_fixmap(enum fixed_addresses idx,
                               phys_addr_t phys, pgprot_t flags)
 {
        unsigned long addr = __fix_to_virt(idx);
+       char str[PTVAL_STR_MAX];
        pte_t *ptep;

        BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);

        ptep = populate_kernel_pte(addr);
        if (!pte_none(ptep_get(ptep))) {
-               pr_err("bad pte %016lx\n", pte_val(*ptep));
+               ptval_to_str(str, pte_val(*ptep));
+               pr_err("unexpected set PTE at %lx in __set_fixmap: %s\n", addr, str);
                return;
        }

> 
> -- 
> Cheers,
> 
> David
