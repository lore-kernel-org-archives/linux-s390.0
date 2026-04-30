Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450683D8108;
	Thu, 30 Apr 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552653; cv=none; b=ZPbpriqZ0RhRE0NeicKJHtvXog1AIBsL+x/IoGrFg5YmOxH5A8yrlDuBIPvMZzS5Eal+A+1uV4GAL1/rAdQRcONcDPxG3RPdR22aFi7NBLv4MevTxuvh3/G2cDpl6FUy+Bn2zFzcRZPHirhYuyfKilbUKV5YdjNhfcx9wDNAn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552653; c=relaxed/simple;
	bh=ex2ksKZW5h10ORBAxez0flk5kcPXnUIayevTSSwbL+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L99u4FouBmGoufthxTbf1Hqr06Ou15KRfCjYDnfIvCcofMTgL7FfRz1s78wxxqFDW+BU61oUSN6gs8EOx4AnXs5/nT1EKOebPdKccgxnN22dboVDJPs97iR+nHKcBYd/XKgXiZxd1KBOPmx8Ke9QPweXatFA2PIH8FZ9Czn9760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OVEuy04Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OVEuy04Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z/YmOm364MLgKTekAQcMcyvI8WeWgw/tah25yx/smkI=; b=OVEuy04ZJAcBaKwk8cxrvq7Tt5
	XT82G1jqIw0PkdnsdUVlw+7QCza/twzfpnsx2kAqSxg7PTBm0kBexRmE2xwQdNMnRyEnteCqgWzIn
	pGkT+4EL2ASd9E3W3zW7yYDg3jwhiv9VQjK8KHyhy+eeJpz4dqkaLDP6PuXP1J2eRrmKWTk8F9tKW
	CawTIBqH87INZkKlSIMhv2zjWwFJnSYo+4xe4HesOWqi4rik/G82R6PqrkV5YTcbPWHu29MwOaGgj
	jzKa0vAXrEAUkOYciTPNLGggQqRFBNNvsXY3E40Q+hwIcMj9vZmSiwG6RsfdSJ+eO9OpzQbCzsngB
	wKLRaGvg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIQdn-00000007Dwg-0sn0;
	Thu, 30 Apr 2026 12:37:15 +0000
Date: Thu, 30 Apr 2026 13:37:14 +0100
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
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afNM-gIqxpyJ6ro7@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430040427.4672-1-baohua@kernel.org>

On Thu, Apr 30, 2026 at 12:04:22PM +0800, Barry Song (Xiaomi) wrote:
> (1) If we need to wait for I/O completion, we still drop the per-VMA lock, as
> current page fault handling already does. Holding it for too long may introduce
> various priority inversion issues on mobile devices. After I/O completes, we
> retry the page fault with the per-VMA lock, rather than falling back to
> mmap_lock.

You're going to have to do better than that.  You know I hate the
additional complexity you're adding.  You need to explain why my idea of
ripping out all the complexity now that we have per-VMA locks doesn't
work.
