Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D1347FCC;
	Tue,  3 Mar 2026 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772576314; cv=none; b=L5comH6G6qY6iudaS6VIAwxXWYjDsV0BwNpO8n8XUtHLFrM74yxH0PbGeZotp9NZShB1s8ocxxli8gh1Q1iIArzIRDmQcpCtQZfdZQ4WPaRbFunx8zZNxQ5BTDsmfDdWcmQi25IjqEeyyWea2Esp7Yk4EGDippCd4bwmgLlWFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772576314; c=relaxed/simple;
	bh=8aDiVZDKYlzG0TV6P91JV/73yV1ngm9SmriUCQKegN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjVpDVSd/NTsCHOYHnngKEWQB79K+ENyGyjoDarG60SmAlNPg8LjvdzSD/ouHXohz7ufdsNyiVAQ8tWiE5HjZpnTjl4wn1x2vXWUioVtFa9/ChJVRhybDBQj8eW4dK79oi4Lz6SYPx8GdH2ONTAx+0qasqEwjJIoUNpQap92XiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TDgirRMe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TDgirRMe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BP2R36w3xYUknyVVM5sNFE0Pq2fJT7cuN70tvl8P0F8=; b=TDgirRMe9e/+WYFoYTAQq7tOTs
	n3lhPxA0uC4xXUHSKUoGdyS0FUEYdY1lsPT5yDeY3Jl04CutcDvjaJ6+Q3Vu/fL9sBAb+wTfurQgf
	t0li1gR28N452WXjgi643PV+t5nUfSdHHLUCcr3US0LAE29SxoPZgIT3T8W3ga9RKqK18QBz4wp7R
	LnCMIGqtRLRdW0teAYWqC/dxqac2YaDztPOn03I+oybc/z62V2MBEnsBSiG2HCMj9yv9s2/SIP6Mh
	lL5pqNxRI3v1TIuIBG7viDAXylqbpfoKmluG3AcOeO3K2fvSOBBIkl7YyUDTo+enLV1giDl9ay39o
	o2wr4APw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxY46-0000000CJPp-2JLA;
	Tue, 03 Mar 2026 22:18:06 +0000
Date: Tue, 3 Mar 2026 22:18:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org,
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz,
	jannh@google.com, rppt@kernel.org, mhocko@suse.com,
	pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com,
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
	borntraeger@linux.ibm.com, frankja@linux.ibm.com,
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, svens@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 2/3] mm: replace vma_start_write() with
 vma_start_write_killable()
Message-ID: <aadeHiMqhHF0EQkt@casper.infradead.org>
References: <20260226070609.3072570-1-surenb@google.com>
 <20260226070609.3072570-3-surenb@google.com>
 <74bffc7a-2b8c-40ae-ab02-cd0ced082e18@lucifer.local>
 <CAJuCfpHBfhKFeWAtQo4r-ofVtO=5MvG+OToEgc2DEY+cuZDSGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHBfhKFeWAtQo4r-ofVtO=5MvG+OToEgc2DEY+cuZDSGw@mail.gmail.com>

On Tue, Mar 03, 2026 at 02:11:31PM -0800, Suren Baghdasaryan wrote:
> On Mon, Mar 2, 2026 at 6:53 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Overall I'm a little concerned about whether callers can handle -EINTR in all
> > cases, have you checked? Might we cause some weirdness in userspace if a syscall
> > suddenly returns -EINTR when before it didn't?
> 
> I did check the kernel users and put the patchset through AI reviews.
> I haven't checked if any of the affected syscalls do not advertise
> -EINTR as a possible error. Adding that to my todo list for the next
> respin.

This only allows interruption by *fatal* signals.  ie there's no way
that userspace will see -EINTR because it's dead before the syscall
returns to userspace.  That was the whole point of killable instead of
interruptible.
