Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2241A0B0C
	for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734643438; cv=none; b=SyE1ONaNCKkAMnt1UK8FaYjbpUuMKxg4LfnkzDjnRw9foWJ+sspnJ/wZzmT2uoLbbl3xv4mGPpD/4n34vti4+Zi8xW9OTWPOKDMVNvJREj1X7p4qJwV2gFd+JSlEYEP/sAUms+XagX++DIZx8DvqfFaYtuyYdru+3RgTKs+GcK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734643438; c=relaxed/simple;
	bh=keoRl54NWZPtQ84RElGXzpELoz6344MYboTc2v3bu40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLx/OefSZq/dGap1hZytGj2LOpt9oBYin8RM9oe4CTTO76qZXirfqAU/UMPTEkfLz1RHZ2mzzSBgqYeh654bDEw7xL6p899RLES1zIQZxWZqUrp4yIXLPpGcDCYBG2gJoHHnw/nDNMiig0hLbLkHLpitJj95Xy20GqYlMzDQzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m8jG4o7/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m8jG4o7/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8kKonPtP1zr+o198crHshLQzyr24FQfVra5qjFFGmFw=; b=m8jG4o7/21QmvUf4VIt3CeuxkW
	hIYvsPQQW4mILbSkP9ZkglmfeljQtP2l3KUxnxt2i/kZuQSo9w2w/An248HwEn/YV5E0128QjoSt4
	l2eD+je8n3QO1ODCbiRrkO1RV2ukifbyZTTFijTBjMXOh2FlweSQFwwK5x1LwCXZB9ZX+bCzqj1XI
	E9MXaSKfqpSIY/uJHmZr2qKSlgIXTdserHHANMLQzG+GqCpEIPX2pCcp9Pstp2W/mskMCA7iqu3Ra
	QudWz+iv92D9n7gxqFNIDVCRWkHs6LTQ+F+k6DStdIRWB/rXRtWv4NKli5iiNwghubz3+tWKufLjw
	btrQRpdg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tONzu-00000005TnP-2lUU;
	Thu, 19 Dec 2024 21:23:54 +0000
Date: Thu, 19 Dec 2024 21:23:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH 1/2] s390: Convert gmap code to use ptdesc
Message-ID: <Z2SO6p5MJuPBUwRf@casper.infradead.org>
References: <20241219162252.1025317-1-willy@infradead.org>
 <20241219162252.1025317-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219162252.1025317-2-willy@infradead.org>

On Thu, Dec 19, 2024 at 04:22:49PM +0000, Matthew Wilcox (Oracle) wrote:
> There was originally some doubt about whether these page tables
> should be represented by a vanilla struct page or whether they
> should be a ptdesc.  As we continue on our quest to shrink
> struct page, we seem to have crossed the line into believing that
> thse page tables should be a ptdesc.  At least for now.

Looking at this patch some more, I'm not sure that pt_index is really
what we should be calling this.  Would pt_gmap_addr make sense?  If
not, what's the right name?
