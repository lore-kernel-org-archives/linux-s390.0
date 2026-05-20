Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F135DA75;
	Wed, 20 May 2026 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311780; cv=none; b=rNkQ7MJmYLFl6f3Xtp4msBGZSnxte6r8V4coTJdHLVkVdwWrr3bDnMKWPysffb/d1yS6qOoEKG81nUs26hZnxo7oPuNF2ROMv/VeyfYKejyrwClHHQ2/47SNt1GyEuUOZrZgJcAZulPoZdRznLFVexmPlNO4TRIaEAi2pTlmLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311780; c=relaxed/simple;
	bh=fU02cunUf5qx+CTJ998toCQden5I5L9eTw1htlE14B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZM9gh/aJF5/H3Lh8npVRKqVAyEbT9PDmfocfThEnzxeYG+K0pi3knI7VuC5qkirBRFs0vsSGC8v4CcesqoP2tE+G/LZui58j4dTZHAKeSSfR2h4MV7+nmGRDTLtVmxvR+K5SvMC+6gFb4FFo1Uawv4Csbqe5l/pb15bS7sBYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ahb0j2Ei; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ahb0j2Ei"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fU02cunUf5qx+CTJ998toCQden5I5L9eTw1htlE14B4=; b=Ahb0j2Ei6nx5qSArSbx3QXwe7j
	nN0qnERaYLGpASZAP09LlU+EPQowKBvJPWhRsI00juo+im78mkgYHs+sP5ZWwXXBd7zRVmKWFHh91
	ozzCsrVpwBFURX4JqqoPT0iEmX8E9NvxsJFClE4jAwVlL4pGe782qw3PvR74tDYThCZ3q+fwmuY2k
	TzdU054pRFbgWK4qDrlWLvQekRsHk+y4KM+0uWUFsCECk4H+2CGnBJFwpoiJbHR/MvjI7M4kc/Ssx
	zg1lHxgjWogJBSyWKXMDALCFwuerNCe/Tci5nkDTpyDfHMo2R9PAJoJdp1sxjZy6+MelEhK4vLDAA
	A5g2JMmA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPoGl-00000007air-0tv9;
	Wed, 20 May 2026 21:15:59 +0000
Date: Wed, 20 May 2026 22:15:59 +0100
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
Message-ID: <ag4kj84EcKqamdB-@casper.infradead.org>
References: <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org>
 <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>

On Thu, May 21, 2026 at 05:14:20AM +0800, Barry Song wrote:
> My understanding is that we should not blame applications here. This is 2026:
> there are basically only two kinds of applications — single-threaded and
> multi-threaded — and single-threaded applications are nearly extinct.

all of the applications i run are either single threaded or don't fork.
what multithreaded applications call fork?
