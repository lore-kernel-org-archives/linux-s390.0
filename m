Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA416F27B;
	Fri,  5 Apr 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327809; cv=none; b=dqejVYMeL3tQKUf2evP+T5uGXQT7FN+m0tvl+KCSKUlGMSyUgiz5apx24fq9jjIrmPItaEDRFXEWp1tlojjWAOZeQnzigbVRfAYpO14lAG8SUa427ZJ6OPwEHnTh10+9Vk9TA/o2lw3qqlAkA0crZN8H2HdHnNBlGfF7qkPzsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327809; c=relaxed/simple;
	bh=2rwvwbJ8j5CiwfXuk4eU0se94mbY1GCuzA3tIi4iW78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm7HwQBB9gVAfgkOovjF3y5iQ08DHV7Nyl4kt0MHcidRFJgxrRznoAADuYwO5kBtWFsflU4cCFO76IXFEgZWvL9K9fWQtl17ER0s0dYXGszO393Jow+muGZlAGN/0p6ZyaWRtn0QSf1GKwQSEIDDzzqf970ibcgY7A5sp8E37Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD29B68D07; Fri,  5 Apr 2024 16:36:41 +0200 (CEST)
Date: Fri, 5 Apr 2024 16:36:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Heiko Carstens <hca@linux.ibm.com>, pasic@linux.ibm.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH net 1/1] s390/ism: fix receive message buffer allocation
Message-ID: <20240405143641.GA5865@lst.de>
References: <20240328154144.272275-1-gbayer@linux.ibm.com> <20240328154144.272275-2-gbayer@linux.ibm.com> <68ce59955f13751b3ced82cd557b069ed397085a.camel@redhat.com> <cb7b036b4d3db02ab70d17ee83e6bc4f2df03171.camel@linux.ibm.com> <20240405064919.GA3788@lst.de> <50b6811dbb53b19385260f6b0dffa1534f8e341e.camel@linux.ibm.com> <1e31497c3d655c237c106c97e8eaf6a72bcb562f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e31497c3d655c237c106c97e8eaf6a72bcb562f.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 05, 2024 at 01:29:55PM +0200, Niklas Schnelle wrote:
> Personally I'd go with a temporary variable here if only to make the
> lines a bit shorter and easier to read. I also think above is not
> correct for allocation failure since folio_address() accesses folio-
> >page without first checking for NULL. So I'm guessing the NULL check
> needs to move and be done on the temporary struct folio*.

Yes, it needs a local variable to NULL check the folio_alloc return.

