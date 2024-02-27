Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5C7A72E;
	Tue, 27 Feb 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047230; cv=none; b=LsmIqBQ0hmqprES4obodP/FkYH2LWV3JDCn2H8v/JxvLkEjsbj54qzPiRR2XM70DtMdgQN5o7C3Tm4F5vdVUEFDSICcaEVlxWXDLDbO9kqFOMfyHrge5Q9UerhJ+3uVe8q4iTmHiEpAX9uPqeNm5hmMoki3TiYM+haKFrtIjB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047230; c=relaxed/simple;
	bh=e26wjytBL/rhm9zF8JZKc5qzNCIgc58GlODAcP9wFQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lit0gdMnOJ2C61ZhHdBtdt4qX9iM5S5F2hZ9r5k4sbfm525dTRTgFLVp9D3mFG0SI5bmF/5I2SRvT37asfc6ogr2qflV+2Mbz7FPP6q2WqvkQ97RnDi1h5Ocs+aRteeBg7NpDscx92EWwXMuexvubXaMuDwNZiwp39J4ZeoQl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE2C068D05; Tue, 27 Feb 2024 16:20:25 +0100 (CET)
Date: Tue, 27 Feb 2024 16:20:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/3] dasd: move queue setup to common code
Message-ID: <20240227152025.GB14628@lst.de>
References: <20240221125438.3609762-1-hch@lst.de> <20240221125438.3609762-3-hch@lst.de> <14bad51d-734e-4d4e-b47a-3f6af6794a40@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14bad51d-734e-4d4e-b47a-3f6af6794a40@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 26, 2024 at 05:49:30PM +0100, Stefan Haberland wrote:
> Could we call this dasd_*_max_sectors() or something like this?

Sure.

>> -	blk_queue_max_segment_size(q, PAGE_SIZE);
>> -	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
>> -	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
>> +	return DIAG_MAX_BLOCKS;
>
> You are dropping the shift here (and in the other discipline cases). This 
> might lead to smaller request sizes and decreased performance.
> Should be:
>
> return DIAG_MAX_BLOCKS << block->s2b_shift;

I actually wanted to move the shift to the caller, but forgot to add
it there.  But with the max_sectors naming it's probably better to
keep it in the disciplines.
