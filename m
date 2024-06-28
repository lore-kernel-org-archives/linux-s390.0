Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBEE224CC;
	Fri, 28 Jun 2024 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553857; cv=none; b=LVJ6BHts80LPxNJSe+bbV9VofaTLSiIpxSlNivfVwyQm2+vHAgLcMAURZNV6wxoOsE6cFGmYXoyXbQLRqDYyWecwCkJfmMXcDYfnDI+F/807iaMygB/3xAGhwU8jvF1Wi0ANRb3o7S1tytkej/lFd0NSphVJev0x+qHBMlC8d00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553857; c=relaxed/simple;
	bh=+2ls3ugjUjVk0S9jGlw9ITT5uQcjiG6uVmAAY04diqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTgxgNFx/Gy2HK+gQl50A04OFoo5/Wap11COJdr3uHGV1i0JSdEi0xJgfQV2aY6nAWQPewxixhOreNss9EN+Ua6MekUyKWvYgBJOSKMU9glSY9kxthSZu/LQV9XSPgzZ1U/Oak4XsKYL8v6479kxI5zaGxFPNFwg0wwoA742TcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rdUwTOa6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rdUwTOa6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VvUsrQOsamYudQc0HKFkKTKBGBKa/qA2+34N2aoqyGE=; b=rdUwTOa67wU9N59zz37rsh/+o1
	GA75HAY+5cNOjzkV4XQ3Nmvbg0g62+p7fNhBELnC/cfw91duH4rRyA6dxORlyijxHNTw5EN3yossl
	mfaW0RpOqtsSjAD73v5xwoXGVafAVER/jrTQxNk0rIGWARX8WpNR+rGygBVWDyK8Rgk48pcs1EH3i
	6yhUPCZFgxnatmhdkCcaAq7mEx5sKfqtfwKO4hwy6SexJAnpJYj1yXU8Lkldvt0ShSViC5g71Pivs
	tGu9GFnI2IQM2sp1JpWKQcSMjIUx7bM4E2/miGTuFOIrlAj5jRPm262Dsz2GPPLmzuyadiMWStMI5
	P6Seta7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN4VW-0000000CfVS-3Aeb;
	Fri, 28 Jun 2024 05:50:50 +0000
Date: Thu, 27 Jun 2024 22:50:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Ma Ke <make24@iscas.ac.cn>, wintera@linux.ibm.com,
	twinkler@linux.ibm.com, Niklas Schnelle <schnelle@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
	Stefan Raspl <raspl@linux.ibm.com>
Subject: Re: [PATCH] s390/ism: Add check for dma_set_max_seg_size in
 ism_probe()
Message-ID: <Zn5POphJ8pckZ3hY@infradead.org>
References: <20240626081215.2824627-1-make24@iscas.ac.cn>
 <4ab328297c12d1c286c56dbc01d611b77ea2da03.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ab328297c12d1c286c56dbc01d611b77ea2da03.camel@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 26, 2024 at 02:48:30PM +0200, Gerd Bayer wrote:
> 
> However, since ISM devices are PCI attached (and will remain PCI
> attached I believe) we can take the existance of dev->dma_parms for
> granted since pci_device_add() (in drivers/pci/probe.c) will make that
> point to the pci_dev's dma_parms for every PCI device.
> 
> So I'm not sure how important this fix is.

It's not just important, it is stupid and I told them to stop sending
these kinds of crap patches.

