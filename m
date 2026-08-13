Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC84345729;
	Thu, 13 Aug 2026 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601010; cv=none; b=sFi4as8gDs9Dwbpk5z35S1jTs1KjDqpb2yanIsR2rqigbPNniTELKYSwByiZTaQhHs/XQgxNEuA+brdg/OfhakttnLyNuW+SEFq6VdW8LlcxTAZf41AuBvu5g47ig2u27YIp6G84tEvauidZNFbMogxFSLCFAWL/UjBUqUYN/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601010; c=relaxed/simple;
	bh=urvzQP14xjouAFJaMxm1KkmF2FK+YkPxtlg+0tmM3dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=josgcMyVJCiFQo2Vi0TZCwPnaMEE1TiaaVxLcBEZVhjjBL3W7+XwuP26hbNx9hpD4r+tzEfUMwH6dLn/Zn5MbVYEr5sbJ1mH4TZNlnZVIu9T32BwLP6Bhu3VaxxCIuILh4VnqHwgLjcO57eNGKZJQ1es+jWMKD7V8CbBhH9QiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FCmrH71a; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FCmrH71a"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27767153B;
	Wed, 12 Aug 2026 23:03:23 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B05F3F632;
	Wed, 12 Aug 2026 23:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786601007; bh=urvzQP14xjouAFJaMxm1KkmF2FK+YkPxtlg+0tmM3dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCmrH71a8GibDaT/4TzLpR5i+19TJkV8Y7yUEveP9J/tnpZ41lNWsq0jvpmBepdWh
	 3M9emmtusN3STsiD2oIUPfk8jrriw7cyAgWrBFzUsYOHmzUnSzzBNBDES9ShVkwlc0
	 +Kv5zwJCzOVfLHIcWwsl8hCWFk4UC3OStKBDaUuE=
Date: Thu, 13 Aug 2026 11:33:23 +0530
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
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
Message-ID: <2ys7apbnfuj3ugfoqgbptgej3jjcyfpmdgbv6qbxupmwg6mefc@h5p33ua2nzlu>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-7-anshuman.khandual@arm.com>
 <1fb9ed88-67d0-4ac1-878d-0dc8e1135d19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb9ed88-67d0-4ac1-878d-0dc8e1135d19@kernel.org>

On Wed, Aug 12, 2026 at 01:33:14PM +0200, David Hildenbrand (Arm) wrote:
> On 8/11/26 06:21, Anshuman Khandual wrote:
> > pxd_ERROR() has been used in generic mm just to print the page table entry
> > in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> > pxd_ERROR() macros have been provided by all platforms which basically did
> > the same thing.
> > 
> > Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> > page table entries thus completely dropping dependency on platform provided
> > pxd_ERROR() macros which can then be dropped off. First move all required
> > helpers in core MM into a header file which could then be used else where.
> > 
> 
> It might make sense to split this patch further up to ease review:
> 
> Patch 1) provide ptval_to_str() a header.
> 
> Patch 2) Stop using pxd_ERROR() and friends in common code, converting to
> pteval_to_str()
> 
> Patch 3) Remove now unused pxd_ERROR() and friends from arch code.

Sure but the intiial platform changes which now use ptval_to_str() as well
will probably come after the Patch (2) but before the Patch (3).

> 
> ...
> > +static inline void
> > +ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
> > +{
> > +	if (WARN_ON_ONCE(buf_size < entry_size * 2 + 1)) {
> > +		snprintf(buf, buf_size, "overflow");
> > +		return;
> > +	}
> > +
> > +	switch (entry_size) {
> > +	case sizeof(u32):
> > +		snprintf(buf, buf_size, "%08x", *(const u32 *)entry);
> > +		break;
> > +	case sizeof(u64):
> > +		snprintf(buf, buf_size, "%016llx", *(const u64 *)entry);
> > +		break;
> > +#if defined(__SIZEOF_INT128__)
> > +	case sizeof(u128):
> > +		snprintf(buf, buf_size, "%016llx%016llx",
> > +			 (unsigned long long)(*(const u128 *)entry >> 64),
> > +			 (unsigned long long)*(const u128 *)entry);
> > +		break;
> > +#endif
> > +	default:
> > +		snprintf(buf, buf_size, "unsupported");
> > +		break;
> > +	}
> > +}
> 
> Why not leave ptval_bytes_to_hex_str() in the C file for less churn for now?

Agreed - will change.

> 
> -- 
> Cheers,
> 
> David

Thanks for the review.
