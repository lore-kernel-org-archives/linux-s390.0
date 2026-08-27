Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996253624D3;
	Thu, 27 Aug 2026 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810795; cv=none; b=cY4cv+G8fEGGat+QHOVm2qBQvSgRvAh0w7Ipzf2suSz1PG2MpGinyE50YMZo9SMlRYne8cRzjtI7CLs6m8Y3Ix5SDRDEV+lGziAjjUQ4KAjB18t8tExYx7SHwqVWJjqsZui/ddUaSNMGIa0bVRAqrD4MGGMZFvrj6D+ih0bUGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810795; c=relaxed/simple;
	bh=4MEVYAYSJL4cEovvPaUuVnqFB51awZSJxYddF6SWzro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq69hnNIJU8hblxeQF44JDGZK894+0A1Zq6M7EGp5TZlkeO/rUOU5CvHk3nZYVLwgnaXloamI/89YEfmm0aekwfrTJ3vQsRyCTzTrP41zHStOV/G61uFMa55Fca2tjpvKMqwaExkSpqcayHxqBzq1fY3dTpcbrX5FP0o2lyzXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=atxvd2MB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="atxvd2MB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 343D01691;
	Wed, 26 Aug 2026 23:06:29 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46D2D3F85F;
	Wed, 26 Aug 2026 23:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787810793; bh=4MEVYAYSJL4cEovvPaUuVnqFB51awZSJxYddF6SWzro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atxvd2MBYeFEkKGg88c3L5GRhXIVBg8ao3BgsUAsWkYA7ds0RiLYyyyMKGlCqEe4v
	 MOEpEcQqGd8VjOnqn4rLw1NEKggOUfl9biN2Je1oGa1rmznEcLbhjXu1/IkCtDfkV+
	 TlSm0YogFKVAPwPubmvtzGJxMq025DHHeIV/tBH0=
Date: Thu, 27 Aug 2026 11:36:29 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
Message-ID: <xj6w5re27lbtih3lxksk2jxv6kvnpek25urjjcoobwj5pgfqtr@z5loauvsw3jj>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
 <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>

On Mon, Aug 24, 2026 at 10:45:09AM -0500, Samuel Holland wrote:
> On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
> > Move ptrval_to_str() inside a header thus making the helper more generally
> 
> Typo here and in subject: ptrval -> ptval

Fixed.

> 
> > available for new users which are being added later. While here, also move
> > another related string size macro PTVAL_STR_MAX inside the header as well.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  include/linux/mm_types.h | 15 +++++++++++++++
> >  mm/memory.c              | 16 ++--------------
> >  2 files changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index b18c2b2e7d2c..a5b514e55dd7 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -2001,4 +2001,19 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
> >  	return flags & MMF_INIT_LEGACY_MASK;
> >  }
> >  
> > +void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
> > +
> > +#define ptval_to_str(buf, val)								\
> >...
