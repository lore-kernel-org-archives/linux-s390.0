Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBBC3DE452;
	Fri,  1 May 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651896; cv=none; b=pOktJj1F8bvc0Y+0Hk/OZwbWrRzKMRVxjt7SJzkcDtm2eFl7fKtC63txIv3fxGXROMWFiXhxUC3s4pRgKv7WMzvqYzxDzQLud9m6TVBcKTzm87KQ4GTyubjIyApUkj0ih6bszHy/NK4OxgQSNYiv6SZXig3+8h1htgENx1XOyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651896; c=relaxed/simple;
	bh=EDgfBtzDuvaLC34/xxrAYgibgHUUw6ST2MQ2XgEQwis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPPgPVWnu3jv68J3ko/IFegiva01lQxmj1u8eIjSZoUcyxWkMUz1JrTbVdU90JzTDbW1J5GztleBWyn6Y9SLon3DtrFjDKhc6d6qnY2IQnJzk615c7OdTXV5teQyvuRrkdpjilBNXfn4DZJBZe/RtqknfTWbnKWhi2mDQKieNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S+PrOaTu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S+PrOaTu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+CybRlbN4CxbIfeNSZrydRrLn1TjflMMzYAXjMcpWY4=; b=S+PrOaTuYpMS9yVFL/SRQq4G+T
	EDyv1/76Ou/0SIA3LL0ouPq9EWPMO5l4Z+1N0ptLnqAYO0BqCC4Xm3PO+wTeHKuBAB3IahTX8uA6n
	a7trLSaMY2QWSwvrG+FRQkKWQ18oVU4G7Xnue+id4br5moG5PbXCSji7QEubPHOv5XAVHxDx6zgXt
	wJ7FY6JrVfHfYKvW2+QN3fwPrQPGIgx3RMlpFCjGDCQcXCHPoN+y5K0Lw5lnU6sBd7VbJb/qhMWfh
	UTsBtEsZO5IdNigyrAUUvt2/YmNpV3JbBPOkDvUuz1JBSyohrXzO8wluq9Nh5ga/qGIKeRzyOIxxx
	5YZRXdig==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIqSF-000000091b3-3rae;
	Fri, 01 May 2026 16:11:03 +0000
Date: Fri, 1 May 2026 17:11:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz,
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn,
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com,
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com,
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: Don't retry page fault if folio is uptodate
 during swap-in
Message-ID: <afTQl12XcXVnku9J@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <20260430040427.4672-5-baohua@kernel.org>
 <afNMkqwxC00OT134@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afNMkqwxC00OT134@casper.infradead.org>

On Thu, Apr 30, 2026 at 01:35:30PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 30, 2026 at 12:04:26PM +0800, Barry Song (Xiaomi) wrote:
> > If we are waiting for long I/O to complete, it makes sense to
> > avoid holding locks for too long. However, if the folio is
> > uptodate, we are likely only waiting for a concurrent PTE
> > update to finish. Retrying the entire page fault seems
> > excessive.
> 
> I think the idea is good, but the implementation is misplaced.
> The check for folio_uptodate() should be inside folio_lock_or_retry()
> rather than tampering with FAULT_FLAG_ALLOW_RETRY in its caller.

Actually it needs to be a little more complex than this.  We
sometimes wait for writeback while holding the folio lock, and
that's a similar latency to reads (or with cheap NAND, maybe longer!)

So I think the test needs to be:

	if (folio_test_uptodate(folio) && !folio_test_writeback(folio))

