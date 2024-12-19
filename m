Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B351482F2
	for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627128; cv=none; b=PNUZDheZz2EbKETk8E/HZdJy0p+8OAHGAWBXfNQMOgbSQSvAmIme5clFZDpBZhL3cK6Uutt8pBR7JF6OSOKaSRLM/GV5/jTNzBRqbSS5JMcA7O8p+OW+X8QiF3Yabaj07OYmXJp2VSD4XTpsuq84BFJ6DepZpIemsnhWK1auBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627128; c=relaxed/simple;
	bh=WyTgacPIQOdlvZYSa5vcrA+ZzX4kXxw4Gnm1kNwaOe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGOfbKrFkeLtnQAEgqO9eeRtM04S6YSy590ja0USOHQ20HcmyewrFQQ+5DOxLKr0PtSYhsHqH51KVOabqWFimDKSK4+vYGfF7x5dA7GcuFtg+98qHVDQpKCwy2n1/dUzBNz4kf6j7PYfRFVfPNo3VOjruJwRT2XZrIb7JYZZC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tJ+ZI58m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tJ+ZI58m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g9BcSRrxUykMMVWj5F8KcTDiGGo2F5oqCWeRlheeGGg=; b=tJ+ZI58mvRmrTmN7x4Gn8NCaZU
	aZkT5poG1xFZfz25ezJSCIsiuAiAL1Oiy5jDhYklV1RpcN+ZjDnwrfyLyFEToD3QJps+kRl22GH8V
	Om4v5+zoa+kIeq04ExYu4O8dv86iRjTc2k+KD/5jD3ix2upX5pKe+LPEBMi9lDLSD+qqfIwnpv60U
	dTZJYUgyLEfIJbV8PbQyydSSmXg/Mo06GFQ9qzUgtNezXlxRvPrAHQ0ZIViqXLBv7LBbMZXaTVQzS
	93X+rHw0bsnFOgWT240xbgJSnXd43Ns1Xvv9aFl2wVPNvuQvFLbzafJfZGlXYiZsvbOZAgau7NOU/
	7q50qrpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJkq-00000004PtZ-2XWa;
	Thu, 19 Dec 2024 16:52:04 +0000
Date: Thu, 19 Dec 2024 16:52:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] s390: Remove uses of page->index
Message-ID: <Z2RPNBDbWvZ9Vu9D@casper.infradead.org>
References: <20241219162252.1025317-1-willy@infradead.org>
 <9d4efc2e-56d9-4786-9ccb-ecd15f34f3e7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4efc2e-56d9-4786-9ccb-ecd15f34f3e7@redhat.com>

On Thu, Dec 19, 2024 at 05:33:32PM +0100, David Hildenbrand wrote:
> On 19.12.24 17:22, Matthew Wilcox (Oracle) wrote:
> > These two patches compile ... I can promise nothing more than that.
> > 
> > David suggested to me that the gmap code really should be using ptdesc,
> > and I think I agree with him.  The vsie code looks quite different
> > and probably shouldn't be using a ptdesc, but we can use page->private
> > instead of page->index.  It's not yet clear to me if we'll ever manage
> > to get rid of page->private.
> 
> Just curious, does that mean that memdesc would always contain these
> additional 8 bytes?

Eventually we'll have a choice to make.

1. Shrink struct page to 8 bytes, but we'll need to allocate a 32 byte
   memdesc for all the current users of page->private
2. Shrink struct page to 16 bytes

I genuinely don't know which will be better for the whole system.

If you're asking because we can defer some of the mapcount
work by using the 8 bytes of page->private to store mapcount, then
yes, let's do that.
