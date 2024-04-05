Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9E1370;
	Fri,  5 Apr 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299765; cv=none; b=NmBNs3z5Qk0NjHX+Djtd2ycMDWDtocOph2SgbYdoR0NhU/hRlcp2NRhf2J8pgoJ3HUrqoiY9Hemjf3esCMVOpZYH2WZUwlHg9HXms9lS2oKOCJgR5nagAo/ZD/HYPMIDjNzVAewXNH84WLzQIBkjr0D8A12yfVyX8nDuyNeA6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299765; c=relaxed/simple;
	bh=2qIDQhf8Ezg35/KZesFxdWVwgujKl2P4Z5XtWDsQdmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3ZGLmlR5uCwMKsWa3J2aA4AsoliKAeTinvOMbFmBKqquuQumZ77fBBn33ZcLSU2DHZSTwroUTDfSmbtAucgyJxMfy4G9b/9xcvSYP4oGArqRDKPoAs4LCwMm5M5TVtC2J3MsLvYfknEf/gZ52LMcybL3Xpmec+VMhpLy2EEcZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9358268D07; Fri,  5 Apr 2024 08:49:19 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:49:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Heiko Carstens <hca@linux.ibm.com>, pasic@linux.ibm.com,
	schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH net 1/1] s390/ism: fix receive message buffer allocation
Message-ID: <20240405064919.GA3788@lst.de>
References: <20240328154144.272275-1-gbayer@linux.ibm.com> <20240328154144.272275-2-gbayer@linux.ibm.com> <68ce59955f13751b3ced82cd557b069ed397085a.camel@redhat.com> <cb7b036b4d3db02ab70d17ee83e6bc4f2df03171.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb7b036b4d3db02ab70d17ee83e6bc4f2df03171.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 04, 2024 at 01:10:20PM +0200, Gerd Bayer wrote:
> > Why can't you use get_free_pages() (or similar) here? (possibly
> > rounding up to the relevant page_aligned size). 
> 
> Thanks Paolo for your suggestion. However, I wanted to stay as close to
> the implementation pre [1] - that used to use __GFP_COMP, too. I'd
> rather avoid to change interfaces from "cpu_addr" to "struct page*" at
> this point. In the long run, I'd like to drop the requirement for

The right interface actually is to simply use folio_alloc, which adds
__GFP_COMP and is a fully supported and understood interface. You can
just convert the folio to a kernel virtual address using folio_address()
right after allocating it.

(get_free_pages also retunrs a kernel virtual address, just awkwardly as
an unsigned long. In doubt don't use this interface for new code..)

> compound pages entirely, since that *appears* to exist primarily for a
> simplified handling of the interface to splice_to_pipe() in
> net/smc/smc_rx.c. And of course there might be performance
> implications...

While compounds pages might sound awkward, they are the new normal in
form of folios.  So just use folios.
