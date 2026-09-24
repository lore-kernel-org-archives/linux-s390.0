Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8373BADA9;
	Thu, 24 Sep 2026 02:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217445; cv=none; b=PpDVGxOSvjyTKaQZq35NwCPt1GufkkoK1Xpe4xe3t7hF/2CzvO854ol/R26wRE6DQHct8HzgLYQhmtG9+3oVJD6+Ng8syMAhzzDGQjPvmxCXYMajdsViUCY1lBf4xp65Q1en10GBZ+le1O7Bakm30T99fx6WhuYfYAK1X5kKeKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217445; c=relaxed/simple;
	bh=GiKDHzPpFLpGJ+NyI2Fn3PGxG+LBOmciezdoBuMh62s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv8TajReBCa0RSThuuLp9XKxqA06J8hD1ofcw9/AyJhMloHT3mOID6KD1FtJW9OKeUvKNvWG1Iab+3PRAwoPnTXTRlmYhaFqKC0ILVlyLkH7L39ljRqjMxP7cYNc4OpZaqhH72R5LRuu/BLm2IXmnRep2O5Hp3J1nTZyzgn0gk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JdwQyTYy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JdwQyTYy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BFC8152B;
	Wed, 23 Sep 2026 19:37:16 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5029B3F632;
	Wed, 23 Sep 2026 19:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790217440; bh=GiKDHzPpFLpGJ+NyI2Fn3PGxG+LBOmciezdoBuMh62s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdwQyTYyCLq2dAuQ3V7VCWTu7ZEUpTZ5e32h5cPG3Zz1eFNKdLIfN2dBRnFOvwzm5
	 rVWcH6DnePga5DgN3Bo9/TWjlLCe275AZ9dIPbh6NN7n6gwtT2c5DnIbABUnJVjQQD
	 OCsyLaai6eUN0qCz9hghvtEi1pBzfk6yIuiOFGYk=
Date: Thu, 24 Sep 2026 08:07:16 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Helge Deller <deller@gmx.de>, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] s390/mm: Drop all pxdp_get()
Message-ID: <scg5ftqczjhpoa4k3htrm7bzdf6rbxrk3dtwvgdfzg537is5dk@hykspk4yq2en>
References: <20260923043226.331880-1-anshuman.khandual@arm.com>
 <20260923043226.331880-2-anshuman.khandual@arm.com>
 <20260923091629.9636A36-hca@linux.ibm.com>
 <echvqvjj435meeh6gcrqewysdqbtkrsgayvsyfcr3q6h3bh7fn@hsa7xh22l4rj>
 <20260923143247.9636Cf1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923143247.9636Cf1-hca@linux.ibm.com>

On Wed, Sep 23, 2026 at 04:32:47PM +0200, Heiko Carstens wrote:
> On Wed, Sep 23, 2026 at 05:42:00PM +0530, Anshuman Khandual wrote:
> > On Wed, Sep 23, 2026 at 11:16:29AM +0200, Heiko Carstens wrote:
> > > On Wed, Sep 23, 2026 at 10:02:20AM +0530, Anshuman Khandual wrote:
> > > > +static inline pte_t ptep_get(const pte_t *ptep);
> > > > +static inline pud_t pudp_get(const pud_t *pudp);
> > > > +static inline p4d_t p4dp_get(const p4d_t *p4dp);
> > > > +static inline pgd_t pgdp_get(const pgd_t *pgdp);
> ...
> > > > -#define ptep_get ptep_get
> > > > -static inline pte_t ptep_get(pte_t *ptep)
> > > > -{
> > > > -	return READ_ONCE(*ptep);
> > > > -}
> > > 
> > > As reported by Sashiko, this results in a compile error due to conflicting
> > > types; but I don't see too much value with this patch if a forward declaration
> > > of the common code implementation needs to be added instead. Looks like s390
> > > would be the only architecture which would have that.
> > 
> > We could move pxdp_get() caller functions from this header inside C files
> > like other platform changes proposed here. Would that be better instead ?
> 
> That would make pud_clear() & friends real functions calls instead of being
> inlined. Function calls are more expensive, so I would like to avoid that.
> 
> I would prefer to drop this patch.

Alright, thanks for your review.
