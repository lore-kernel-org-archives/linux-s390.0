Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0073FCB22;
	Mon, 18 May 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121085; cv=none; b=YuLEmAjD2PCUtFyAQz6wkehCmTA3KxMAgf/Jlhn00cWgcXhx3T4SXfQRFDa0lREKLHYpqqANGD8w1kgKg2c5pq786mRtoh38DjjWCZ7FOU+kTTY/Ys1Bk9Pl1Tv62FlV39zvgnpCr+cZMxxPvXitdAvbB3Ytb7g4z016Wpaq/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121085; c=relaxed/simple;
	bh=o1rptViwTTP1to40Twvuxj4BvWWDX0i69HpeZZvzhrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnwUvLITNLq4NNc4IPgWFB2bLxh8DZXj3SofZAFBYhFuM/muEp2WkmTw2aP5SjjJbroI2IAlq7iNUvkwvBvQKA7chLjXQiOJom/zT2f8gxXH+VFqBvUSS82MVcX03NjWURMPE7ZqLYHfOQi4ThZkD32f72+6xIVh+0/46pMlzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fU3+SCOF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fU3+SCOF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GQ3AyNwcHkDwyotJKfmaIM16qng3evSu5qPs3Xeesp0=; b=fU3+SCOFfUUlkOUmyIuTsbnywe
	89kqfFg93eDsIn1f4q6CEtRQBpKAuBqXFwczvVeUyK1MqiAmO/Is7GNS6SQajMkq/Ou4EEPXO5gjd
	QG3X5RgIMMIHaZt2k6X7tQJKlMJUiidUWjRLLsCK96ufITmHS/etRFdCcKGXPu9m3Y/9455P1VY+7
	yI95TKqa8/ath+SxD9IFOJNLaKt8Sstckq3piVjXElv/WkNhCMR7wKydSnX4sVdCnnWMjLyWBjQ2b
	4vkZR2poj4v3QZS8BJi9xbkgnOoh2L9CaUbogqrM9GJMbxKImRWLaIAgDeo+jPw7Sed1HBtUwdBx+
	aOLN/sjA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP0em-00000004wNm-3PR8;
	Mon, 18 May 2026 16:17:28 +0000
Date: Mon, 18 May 2026 17:17:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	mhocko@suse.com, jack@suse.cz, pfalcato@suse.de,
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
Message-ID: <ags7mPK7Ong0ZsBf@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>

On Mon, May 18, 2026 at 07:25:54PM +0800, Barry Song wrote:
> We have clearly observed that the `fork()` operations of many
> popular Android apps, such as iQiyi, Baidu Tieba, and 10086,
> end up waiting on page-fault (PF) I/O when the VMA lock is
> held during I/O operations. This has already become a
> practical issue. I also believe this can lead to chained
> waiting, since the global `mmap_lock` blocks all threads that
> need to acquire it.

It's always been a terrible idea to call fork() from a multithreaded
application.  For example, this question:

https://stackoverflow.com/questions/53601200/calling-fork-on-a-multithreaded-process

or this lwn thread: https://lwn.net/Articles/674660/

Do we have any insight into why these applications are doing this
horrible thing?
