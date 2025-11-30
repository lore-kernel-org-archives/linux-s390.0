Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D9213254
	for <linux-s390@vger.kernel.org>; Sun, 30 Nov 2025 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764481121; cv=none; b=OHuPWEqFjJfwJgcBnOZhjJwOq3ngEAXX1mgPLdbYv2UuaFRUmylLEX7e+/asXgayXk0wwpYNa3rcnv2dCGjiIaJBfjOL0xUNPzI1Pk8104YeRymdlOy+1KnjRASwpy2m62zKZhVDD39WvjyyEC72ESkkBQ4P8dUpPHjoqOEZurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764481121; c=relaxed/simple;
	bh=J61Wc7dRscv8TM9M6NxxjfJMs8Mw1xoWRuRANocH18E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2cylOxp9tVeQYXZ5SJXqJc2oWCnoPEFUGKTTHRqMNMax3mIpHaorw3FAJ1CLfSYm7Mxpkc6J+nMSC38FjpxCDWfPZ4lGlUHS5KUmWEYebB6U++bp+F1YWKqiM7juZqrt3itmO7LTokycZy0wclHaNXblpVGA6OcZpWxgA+u71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mzyQTml2; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mzyQTml2"
Date: Sat, 29 Nov 2025 21:38:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764481106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMFM3mZm3tfpZm9opFnIUzFCaL9Wf3MxVqcMizCNUwo=;
	b=mzyQTml2HeLVP/7KkNdTn5q52aTUXfw24UVLKCemUVyERxGGs6BfXps44VPj/aI0p2bjyv
	KMjhAOW0HBu+NVi0mdYKElpoDb/9sqzgpso500188A+9PEXABE1B4WxKsO43Lp+jFHQO1d
	m7bA8X9LFJTjAWdANdBQuTczyx3HC7g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying
 page faults after I/O
Message-ID: <6xwf5rtl6ccmeera55oz6xsubsljibxb7gfv63ul4locgfiipd@dhjxr6gqrfvh>
References: <20251127011438.6918-1-21cnbao@gmail.com>
 <aSfO7fA-04SBtTug@casper.infradead.org>
 <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com>
 <aSip2mWX13sqPW_l@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSip2mWX13sqPW_l@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 27, 2025 at 07:43:22PM +0000, Matthew Wilcox wrote:
> [dropping individuals, leaving only mailing lists.  please don't send
> this kind of thing to so many people in future]
> 
> On Thu, Nov 27, 2025 at 12:22:16PM +0800, Barry Song wrote:
> > On Thu, Nov 27, 2025 at 12:09 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Nov 27, 2025 at 09:14:36AM +0800, Barry Song wrote:
> > > > There is no need to always fall back to mmap_lock if the per-VMA
> > > > lock was released only to wait for pagecache or swapcache to
> > > > become ready.
> > >
> > > Something I've been wondering about is removing all the "drop the MM
> > > locks while we wait for I/O" gunk.  It's a nice amount of code removed:
> > 
> > I think the point is that page fault handlers should avoid holding the VMA
> > lock or mmap_lock for too long while waiting for I/O. Otherwise, those
> > writers and readers will be stuck for a while.
> 
> There's a usecase some of us have been discussing off-list for a few
> weeks that our current strategy pessimises.  It's a process with
> thousands (maybe tens of thousands) of threads.  It has much more mapped
> files than it has memory that cgroups will allow it to use.  So on a
> page fault, we drop the vma lock, allocate a page of ram, kick off the
> read, sleep waiting for the folio to come uptodate, once it is return,
> expecting the page to still be there when we reenter filemap_fault.
> But it's under so much memory pressure that it's already been reclaimed
> by the time we get back to it.  So all the threads just batter the
> storage re-reading data.

I would caution against changing kernel for such usecase. Actually I
would call it a misconfigured system instead of a usecase. If a
workload is under that much memory pressure that its refaulted pages
are getting reclaimed then it means its workingset is larger than the
available memory and is thrashing. The only option here is to either
increase the memory limits or kill the workload and reschedule on the
system with enough memory available.

