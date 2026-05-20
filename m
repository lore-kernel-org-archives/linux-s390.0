Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0873793C6;
	Wed, 20 May 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311117; cv=none; b=F5BT+vvuG+6G3/dkr9t/wVxPWRsovGwinAMc1Y7hhOI1sNUF0vSuA1Svzpt/X7mUHE0DpmC10qFhYqCAgQI3UbbQmYwfrp0hCiNNqlyjH7yj8BDa46wCiC1+N+/2KuLH4ednIRiwiVeFzH7EQcGGhLBEN8VrOSdEkPn0bV0O+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311117; c=relaxed/simple;
	bh=j78Cl6y21myQYpLfkKEHj6Jpm3i0D9QvC6anF9Zsa4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzew1BbyeRWIBqwk8Lobq5ze6xJ1IdUxW4LvIO7VzEBVQHfLxFXR2IhbT7uRSsVw5x4Fwe/7mhXkbEgDdfsCs6OViqtB1BxGXkRfNWS5mEKVr/0FwiVe4BJri88zISHj9DbJUZ9NpOHxvK6uAh7NyNeViMdyRpdsBMeYg0oY1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bR9HCAGS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bR9HCAGS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NoQFWNK7oWAD/wrjDNQs2N+Z55W1ZBNqkdyVcG17n+A=; b=bR9HCAGSj3BuTqMtUE+DLlE2/V
	hbqFNHpAblQKp5tyrESGJToQyAt4gGSYt43sRu6JEbVNZTj0qvFZxTyoBxJ1wp0kQ5ZcRxN1nm3Rb
	gh32K03vbE/E7J0yrggnNOynCTcgltl9vPaiaVZXlPQBWE/JQgInR1dXcExZ8Iz6LVbgTlq8x52mX
	WL8vfh2Lyfw2a/Tpq2i/SXxctbJ1CzS4YgLicbHSvLU347BFYhk2464cXsmbdNSDNV+5du23ojl3E
	wPSEPslSUR5LG+Oc0B2L/jDVGsi3Or0fTJoXFl2vl9TX0JbwU5Szrew428V10FYaIsgWdHpxL5RaA
	8tHIsB1A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPo5z-00000007aEX-3LBW;
	Wed, 20 May 2026 21:04:51 +0000
Date: Wed, 20 May 2026 22:04:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, david@kernel.org, vbabka@kernel.org,
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de,
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com,
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ag4h87CBd-gph9zX@casper.infradead.org>
References: <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>

On Wed, May 20, 2026 at 06:01:56AM +0800, Barry Song wrote:
> > implied is that the per-vma locking may stall mmap_lock writes for
> > longer than if the mmap_lock was taken in read mode?  Barry, is that
> > correct?
> 
> Not the case — the actual situation is (if we modify the
> current kernel to perform I/O without releasing VMA read locks):
> 
> thread 1 PF: lock vma1 read ----  IO ----- ;
> thread 2 PF: lock vma2 read ----- IO ----- ;
> thread 3 PF:  lock vma3 read ---- IO ----- ;
> thread 4 fork:  mmap_lock_write ---- lock vma1, vma2, vma3 write ;
> thread 5 :  take mmap_lock for any read/write reason
> 
> Now you can see that thread 4 has to wait for the I/O of
> VMA1, VMA2, and VMA3 to complete, and thread 5 then has to
> wait for thread 4 to release mmap_lock. Both thread 4 and
> thread 5 can become extremely slow, because I/O may be stuck
> anywhere in the bio/request queue or filesystem GC.
> 
> So now we have two choices:
> 
> 1. Change fork() to avoid taking the vma write lock for vma1/2/3 where possible;
> 2. Keep the current kernel behavior and drop the VMA lock before I/O:

Option 3: Say that this is a very silly thing to optimise for.  I have a
hard time believing that any application will care about the latency of
fork(), or the latency of page faults while it's in the middle of fork().
Multithreaded applications just don't fork that often!
