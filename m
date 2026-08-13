Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E9400DE8;
	Thu, 13 Aug 2026 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599894; cv=none; b=ltGhZwXZpS78/rC/dHbOOToEb21l7Whm1mmeCdfoE3k6pbMtNegXKCl3+BokvkuK4VJkKJoJYjCyKvxutkBhE605rXwALpVFwEAmL/ccxxrNzVNDFAJ7lrms54f86LMP0d4dO4zqntRikgCQGlkoMW2+eMe1qAf7+tF2hPQdJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599894; c=relaxed/simple;
	bh=CoIN6guADWC+zDyPfhFO/S+t2cXcLfG3khdmtOUCkug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVdesQZ/TzBZ1q3Mlo4LY84aFvc977g5/4WSGEDFSsn2DKgD8kmAmdQX7rKH+Flbs6oQ9TBBzxNnQv9nnjhpCgXuGlMpj3ypLdW1VXupMcEn34Zg7O57fhrGlLLUVmW6ujXKLtTisFN4S/jOGy+H4Os5owtys4KoK8sWfqo5WYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=anxqrjk0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="anxqrjk0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 708381516;
	Wed, 12 Aug 2026 22:44:47 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A22393F673;
	Wed, 12 Aug 2026 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786599891; bh=CoIN6guADWC+zDyPfhFO/S+t2cXcLfG3khdmtOUCkug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anxqrjk0iLjQHV3BgBtB7FofiyVfbzxU/TOQyrqfHVrE3KY34mv1wfvSAdfZk8k+b
	 NqfdwWG4Em+MP9I5C6wmSIbC3ZhVt828UvY5voXcU42QX/ayulcSospBc/5SlZ/BEt
	 dTzsVhGl1W0qDqm43doqgOf533QinHxqjz/j8G+o=
Date: Thu, 13 Aug 2026 11:14:48 +0530
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
Subject: Re: [RFC V2 4/6] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Message-ID: <3bruvrvxg5blgzuhqg2f27yvfjvvsycx6lmt3jcianvpuqcs5n@zdgzfhmmhvom>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-5-anshuman.khandual@arm.com>
 <94b52871-9cfc-42d6-b30f-545b722e71a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b52871-9cfc-42d6-b30f-545b722e71a0@kernel.org>

On Wed, Aug 12, 2026 at 01:21:28PM +0200, David Hildenbrand (Arm) wrote:
> On 8/11/26 06:21, Anshuman Khandual wrote:
> > Stop using [p4d|pud|pmd]_ERROR() in __get_pte_phys() as the pgtable entries
> > are known to be NULL and hence could not really be accessed.
> > 
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Cc: linux-sh@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  arch/sh/mm/init.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> > index b3c7fd84ceb4..0bb8555568a4 100644
> > --- a/arch/sh/mm/init.c
> > +++ b/arch/sh/mm/init.c
> > @@ -58,22 +58,16 @@ static pte_t *__get_pte_phys(unsigned long addr)
> >  	}
> >  
> >  	p4d = p4d_alloc(NULL, pgd, addr);
> > -	if (unlikely(!p4d)) {
> > -		p4d_ERROR(*p4d);
> > +	if (unlikely(!p4d))
> >  		return NULL;
> > -	}
> >  
> >  	pud = pud_alloc(NULL, p4d, addr);
> > -	if (unlikely(!pud)) {
> > -		pud_ERROR(*pud);
> > +	if (unlikely(!pud))
> >  		return NULL;
> > -	}
> >  
> >  	pmd = pmd_alloc(NULL, pud, addr);
> > -	if (unlikely(!pmd)) {
> > -		pmd_ERROR(*pmd);
> > +	if (unlikely(!pmd))
> >  		return NULL;
> > -	}
> >  
> >  	return pte_offset_kernel(pmd, addr);
> >  }
> 
> Do we want to print an error like "allocating p4d table failed"?

Sure, will add error prints like the following.

--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -56,16 +56,22 @@ static pte_t *__get_pte_phys(unsigned long addr)
                return NULL;

        p4d = p4d_alloc(NULL, pgd, addr);
-       if (unlikely(!p4d))
+       if (unlikely(!p4d)) {
+               pr_err("allocating p4d table failed\n");
                return NULL;
+       }

        pud = pud_alloc(NULL, p4d, addr);
-       if (unlikely(!pud))
+       if (unlikely(!pud)) {
+               pr_err("allocating pud table failed\n");
                return NULL;
+       }

        pmd = pmd_alloc(NULL, pud, addr);
-       if (unlikely(!pmd))
+       if (unlikely(!pmd)) {
+               pr_err("allocating pmd table failed\n");
                return NULL;
+       }

        return pte_offset_kernel(pmd, addr);
 }

> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> -- 
> Cheers,
> 
> David
