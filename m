Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453B23775;
	Fri, 28 Jun 2024 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553825; cv=none; b=o0mT3eviUo7VCsJLxk0IzFNJw2qLW8yWxF/byWFiPfl96RoNd3nP2aDMRfKppp4wJCa25x/mVcmsecxGqwMDErItmjHUB7JNNQCU78YHIUVs0o5CDGXjhX3clfZhBNOosxnOgppUaRsSEaKbZQU942Wr6JFWIb4T2wtJJNRaJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553825; c=relaxed/simple;
	bh=YJl9lRTDu7izkpBQMcqWpSMHwlAl/P9ARwCewei2ULQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgbjZpSKL7I5oCT1nlgwFwvBK9CgxPD9QAgh884ElSMCYlgNadT2/MPqPU+Vi8M+8QV5AhqQjxRoRf4CsoGPc5VDHIl7YvaNo37+9AVWmBvUGsop+r9hfWrvyiCDc6dGgOHxNcaPDnzGabZl92XPYc63V8/bS4HMvayC/yWxqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xAj5Zzv2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xAj5Zzv2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YJl9lRTDu7izkpBQMcqWpSMHwlAl/P9ARwCewei2ULQ=; b=xAj5Zzv2NR3tx888OFk+ZJv24Q
	ugxTLpoCfmfZUvIIHeuEYj8FDlot59zhICq1Qik+BvtWIqL9n2y//lfeRSQMh+RI/4f6iByjmnr/V
	HP0TilfLQfFfC9TMA32T4lIXGucwPp84y8bHwDzdSKcMlsb7OkqPx/2aaWS2PrnEy22vdW/668VxL
	x4cqieHOpq4olAOTEhw/6zW4CmCyWnQZVcJ8YrI5D5aM9qUKH94ies9wmuQji79/acl62k/tL2Ifx
	Dtq8pLjluIiCkVI3fxFVloT2yMhsWgncKub/LU4IESJkQWE4aWxx4Iq4HbyiSF4Sk9JPgFIYUyrjB
	breKAyNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN4V0-0000000CfP2-0gqE;
	Fri, 28 Jun 2024 05:50:18 +0000
Date: Thu, 27 Jun 2024 22:50:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
	ubraun@linux.ibm.com, sebott@linux.ibm.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/ism: Add check for dma_set_max_seg_size in
 ism_probe()
Message-ID: <Zn5PGjhkzFumxDjv@infradead.org>
References: <20240626081215.2824627-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626081215.2824627-1-make24@iscas.ac.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 26, 2024 at 04:12:15PM +0800, Ma Ke wrote:
> As the possible failure of the dma_set_max_seg_size(), we should better
> check the return value of the dma_set_max_seg_size().

As I told you last time these checks are stupid, and I asked you to
instead send a patch to remove the return value.

Each and every of those patches just makes that removal harder.
Please stop this now and I'll prepare the removal for the next
merge window.
