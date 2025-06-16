Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034A1B87EB;
	Mon, 16 Jun 2025 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750043652; cv=none; b=Tu6ceqrcPlPl8CHzWsko1W6McovaDde3i/GjJSGvLFPmiz8ypSICF9bXsUFA3Laa5rUMEC2+RwcycD4xjlFQphpOwf6Q+ZV0E5gHrsZ37zgWhnEN85VqWTSp7eV/JNB5FbmP0U2i/DxngH6OQbyH7BXxAlAntRWBplNRQDVUCwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750043652; c=relaxed/simple;
	bh=c0gwZpvRrZjf8E2MnG1KTyVnYNJEeLeorWvXPnso7jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlZBXbEhDhm1EPYMaEesZINI/Frug3WcKnMmYpYuhLLtudJSyA0PhLeKgse9RCCHrf7htiRBisPkFMlnzE5LHH7yQi9k2B7Q6dgyyf5OgO9aU9nk88lUjP92z4odiXE2e2HZMKO3sZEJj9PmCxCz0B1aadQKO9GWgJxUHlTLIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BsNKNSEx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BsNKNSEx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=saNW8zdmippLZ+j7mPmKokLCsY7iQ+AF9tZzNqrD19s=; b=BsNKNSExvA9ezQrc46m9qXkSN7
	4cQGezjhvnz2LgDhnu8UNRpY71q7WcxFVbxKkvwFooieoP1RAqi2gMen9NdtjmJKJr1tk7Yg3jryv
	U4NeEqkudnRmDnynRoYxCleb7l1+TdsVDXNF7EKSNZ3WXMK5iT0ifuHtAt9hbX2Fmh9cu5R4xwmZB
	i0+2vHFe0uzJv6c7dEuDfdTPc80CHfdFFi4B/I3Ku3PnISB7mTNlYswQ4QzkPM1ioF8ritKYHhRmu
	U6CNQZQViGDPU1oaUA+CLOkr88XQfqLNszq7vrJZ5uoI19RtJMc4jMdT+DSCAijzCsZ5obtSa8gQP
	IugRgPbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR0IF-0000000FUtX-15Dq;
	Mon, 16 Jun 2025 03:13:55 +0000
Date: Mon, 16 Jun 2025 04:13:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH v3 1/2] mm: Optimize the ARCH_NEEDS_WEAK_PER_CPU logic
 for s390/alpha architectures
Message-ID: <aE-L81GzxzWBTfPb@casper.infradead.org>
References: <cover.1750040317.git.gehao@kylinos.cn>
 <57e110be6d8387e403b4ef1f3b10714c36afbb51.1750040317.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e110be6d8387e403b4ef1f3b10714c36afbb51.1750040317.git.gehao@kylinos.cn>

On Mon, Jun 16, 2025 at 10:29:17AM +0800, Hao Ge wrote:
> +++ b/mm/Kconfig
> @@ -929,6 +929,10 @@ config ARCH_SUPPORTS_PUD_PFNMAP
>  	def_bool y
>  	depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>  
> +# s390 and alpha should be enabled,see comments for DECLARE_PER_CPU_SECTION

This comment is inappropriate and should be removed.

> +config ARCH_NEEDS_WEAK_PER_CPU
> +       bool
> +
>  #
>  # UP and nommu archs use km based percpu allocator
>  #
> -- 
> 2.25.1
> 
> 
