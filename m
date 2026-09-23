Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F333CCA02;
	Wed, 23 Sep 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165527; cv=none; b=o3XTn7Q9bk2WMwmIGrIr32x6wcI7H1pKMIG6w6MDo/mY0gZT/Hl+r7Xzr1XIAoH6ICLMtV7RDsIjt20UVlw6LufHX1B3MPgrqZVuBveUGq+8ETh1MckJ1aIkYPbERL4HkQ1iXZprV4IXrNC5f4Y04mvPI3+/UD4C0sQrTPnC0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165527; c=relaxed/simple;
	bh=xi8NIofPhpB3H7iilBZyGWD0DeG69Ptc46KK7MjGIYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4EV8hxZYEIiTWNwinXRCO3/KenwFN5aQWA1PU3M++Xq2Hl4iuGA050Ry2Tg0TpIODlWQnnVVgg4b8IErUTuTxqVMGrL0be7ukJ+F7IiT2Q11RDiT1FtF3grnqXixjBw6yHYeSM6V+2dKKAl30objMct/OAyETw/y9NLnZEK1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WfbrlIJc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WfbrlIJc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 782041570;
	Wed, 23 Sep 2026 05:12:00 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44B4E3F86C;
	Wed, 23 Sep 2026 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790165524; bh=xi8NIofPhpB3H7iilBZyGWD0DeG69Ptc46KK7MjGIYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfbrlIJc6PIRO3QJdGN02l6yILN8LZNb5gXKSL0optlm3pfpEn+tM3q/hDkuH2wlp
	 b7m0xt9GrefxYQL48XX0paq0rO+hkAkx9VGwwoGQs06sTvHhKkn6+2nLuuHUhWCUuO
	 poloeD0oI3YcPeBHHqLRi6Bgs2yqbLb4hXKdEUic=
Date: Wed, 23 Sep 2026 17:42:00 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Helge Deller <deller@gmx.de>, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] s390/mm: Drop all pxdp_get()
Message-ID: <echvqvjj435meeh6gcrqewysdqbtkrsgayvsyfcr3q6h3bh7fn@hsa7xh22l4rj>
References: <20260923043226.331880-1-anshuman.khandual@arm.com>
 <20260923043226.331880-2-anshuman.khandual@arm.com>
 <20260923091629.9636A36-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923091629.9636A36-hca@linux.ibm.com>

On Wed, Sep 23, 2026 at 11:16:29AM +0200, Heiko Carstens wrote:
> On Wed, Sep 23, 2026 at 10:02:20AM +0530, Anshuman Khandual wrote:
> > Current platform specific pxdp_get() helpers are exact same as the default
> > ones defined in the generic MM header (include/linux/pgtable.h) thus making
> > them redundant. Just add required forward declarations.
> > 
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  arch/s390/include/asm/pgtable.h | 35 +++++----------------------------
> >  1 file changed, 5 insertions(+), 30 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> > index e882663a58e77..0a0b0ec42b624 100644
> > --- a/arch/s390/include/asm/pgtable.h
> > +++ b/arch/s390/include/asm/pgtable.h
> > @@ -25,6 +25,11 @@
> >  #include <asm/page.h>
> >  #include <asm/uv.h>
> >  
> > +static inline pte_t ptep_get(const pte_t *ptep);
> > +static inline pud_t pudp_get(const pud_t *pudp);
> > +static inline p4d_t p4dp_get(const p4d_t *p4dp);
> > +static inline pgd_t pgdp_get(const pgd_t *pgdp);
> > +
> >  extern pgd_t swapper_pg_dir[];
> >  extern pgd_t invalid_pg_dir[];
> >  extern void paging_init(void);
> > @@ -985,36 +990,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
> >  	WRITE_ONCE(*ptep, pte);
> >  }
> >  
> > -#define ptep_get ptep_get
> > -static inline pte_t ptep_get(pte_t *ptep)
> > -{
> > -	return READ_ONCE(*ptep);
> > -}
> 
> As reported by Sashiko, this results in a compile error due to conflicting
> types; but I don't see too much value with this patch if a forward declaration
> of the common code implementation needs to be added instead. Looks like s390
> would be the only architecture which would have that.

We could move pxdp_get() caller functions from this header inside C files
like other platform changes proposed here. Would that be better instead ?

> 
> Besides that the s390 implementation of ptep_get() will be filled with
> more content "soon", when Alexander's lazy mmu work will be merged.

Hmm, okay. I don't have strong opinion either way.
