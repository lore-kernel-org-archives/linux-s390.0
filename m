Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9912838B
	for <linux-s390@vger.kernel.org>; Thu,  4 Apr 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237940; cv=none; b=T53e7rBQU4raIOQQNhSCm137uyiZKXhElKj/1RCBVu78Tr7yx58Fll04ipF+XhK4S8l8Iovc0eVDRvzho2ai3PCAy5vLMN57JM806QUF4ul2bSDtIZtjWOB5d9Lh8IUooLhs6/JvaiiuEhg58rCjN0dq47p7GJihRftkIE+kGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237940; c=relaxed/simple;
	bh=qvIuju30lSzTaWY8nspTGRD5fF319mjxZ/Lh07O+/kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWMSpgkfLurXM0j5p9x5OixJ02HtoaO3XHgwvs2AcD6fuQVR/1jaj47HVtX2L8HkOlQQJT2pVd0TwrfhaFQfVY3Ws5tzaPIPbBelrRyDRsVCyUw7c6zViIMGHdK9r2INmZdbuLlkuamjizIqkrPgmH3tKcZN8xmVIDidfNCasIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UJXr7tSu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UJXr7tSu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2CX4kH6t+849g0fbe9UGvbBRNafJesyPSUWW4Z89U9I=; b=UJXr7tSu2EmzNhLAKNqXqWtwBB
	ldlqhb/jnf8J+RTTuXI8D6PQ6pgDAPaojDe8EhqOuPOKTd596vckDcVrvG4rCZUbQmpi3aotpg2WM
	1IFlxut1szhxpflI0dE514hH7RPDKVnr/K9XIaIW1uLV+jzAg1P4XTtIgCwMctgA3nYd8iHP0GXJ5
	aXDO0xTCcTDcg3s9HrM7hJUlGCUnV7pID40glXOzVGXhcpowUHH9VAEk41FcflEUBHbjNH0dPROU2
	LSbw1xpQr1GCkDcX8cEKKuH/j2uD/f9hVb5dPa5TdvXvlhHQxFw//m4ecuN8Nk3B8O/ajTdEHOnfG
	bJsVEnhg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsNIt-000000088nT-353T;
	Thu, 04 Apr 2024 13:38:55 +0000
Date: Thu, 4 Apr 2024 14:38:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] Convert some gmap functions to use folios
Message-ID: <Zg6tb7DMYGF57o2i@casper.infradead.org>
References: <20240322161149.2327518-1-willy@infradead.org>
 <20240326074127.6078-B-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326074127.6078-B-hca@linux.ibm.com>

On Tue, Mar 26, 2024 at 08:41:27AM +0100, Heiko Carstens wrote:
> On Fri, Mar 22, 2024 at 04:11:45PM +0000, Matthew Wilcox (Oracle) wrote:
> > struct page is going to lose its refcount (someday) and as part of
> > that page_ref_freeze() will go away.  s390's ultravisor is one of
> > the few remaining places that uses it, so convert it over to folios.
> > From previous interactions, I understand that ultravisor doesn't support
> > large folios, so this simply declines to make large folios secure.
> > I think you'd be better off splitting the folio if it is large, but
> > that's something I'd rather leave to someone who can test it.
> 
> Christian, Janosch, or Claudio, could you have a look at this please;
> and provide an ACK if this is ok with you?

Ping?
