Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1D441166E;
	Tue, 11 Aug 2026 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437277; cv=none; b=u0T8KGVhyRjlENCxY7QJyDVJCiWXmi/uQglOoLhY0u3NV9ARx6PPLsifNxkMuOSCqtdBJ/REBmiGmryaJTwG+jzs5SBQUTGj6HAvxRodvudLZhSj3rMD3txU4sOjfFA9Q2D91fdA0ZSLAuT/Ah07x14pjHiiIpkU3bLNSTNUs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437277; c=relaxed/simple;
	bh=ZT08f1GiOgKpD31g66zZnUhmuNu7zNORWfMHkMNA+MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwwb2tPc+fbOTZuclvcVlBkR0mpNeQhYxiHNbs74MRtylRQ86RNcz3xcBTiYyl4mGZuFWlXuTjBzCeXq7xfVBarWabECoVSMlZ3qvcpNMHVucpFyszGPypuTShYIeCjflaa+LTxUtcInS4/7/hKmc5QkhVHdYYpxqS/LthLo5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ILvmNn+1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ILvmNn+1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B295E1516;
	Tue, 11 Aug 2026 01:34:31 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA58F3F673;
	Tue, 11 Aug 2026 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786437275; bh=ZT08f1GiOgKpD31g66zZnUhmuNu7zNORWfMHkMNA+MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILvmNn+1uP0GCjTeWxHAARq3POjelk/zkkggHRqr669N5vBlnXQv9Yg8uShAHAWPV
	 r+uFJpIr4Ahch5mMzxC2ouczYWRZPMGrkwVkFNIVMPn+HCacIXd33isOumG+cExtcS
	 egAiyy/T4cf+1AQQkz3B427/hIS4SjOBaBYGwt8M=
Date: Tue, 11 Aug 2026 14:04:32 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
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
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
Message-ID: <ijjadks7zjpwqlw4nbcawr3tva2r4y6gn3weuc73vbec46petn@ovlf52m2kugw>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-7-anshuman.khandual@arm.com>
 <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>

On Tue, Aug 11, 2026 at 08:49:43AM +0200, Geert Uytterhoeven wrote:
> Hi Anshuman,
> 
> Thanks for your patch!
> 
> On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> > pxd_ERROR() has been used in generic mm just to print the page table entry
> > in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> > pxd_ERROR() macros have been provided by all platforms which basically did
> > the same thing.
> >
> > Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> > page table entries thus completely dropping dependency on platform provided
> > pxd_ERROR() macros which can then be dropped off. First move all required
> > helpers in core MM into a header file which could then be used else where.
> 
> Oh, the "x" in "pxd" is a wildcard?
> Except that is not, as it does not match "pte" ;-)

Unfortunately that's the odd one but "pxd" was the closest possible :)

> 
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> >  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
> >  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
> >  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Thanks !

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
