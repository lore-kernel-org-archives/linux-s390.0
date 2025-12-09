Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF50219A7A;
	Tue,  9 Dec 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765284993; cv=none; b=qNhAoUEADbI0Yt1gdMtb8EZ0tFvDlMK2lSA14osb+GprkGmHWwQ4ePLXXwp4qDO82dB3NB3NX7agwCKAaVKr5LNGvHrQFK/IRkfR95HsxGk9VMkvxabw0tk6hCIdcP2BR4dncZ2zEfIHZvsnYgjoN7cMiWo1tp96uMPkMeks2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765284993; c=relaxed/simple;
	bh=RR3bt6P8iXOXnJ8uTIIhtA9Alxmrv+rTSCnJlYb4rp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K210KoF0pyX1kM8xD3c3FQwNeFIVOJN7gWuF4F71e8yFoKW+a/+PLd6Mf4xGjyNjFYqPC3kJqOvXs5bY4caOu8k1GuUBGVPCj5miexdQmvGB1srvEimtI0GwEjg2yD1TS9KpMzermeHoqNsIuBOh60JONYn7JfoDLfTwFzs32S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oSZzWTUJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oSZzWTUJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=La44+vrPSRf6tLBZN9WnRWCtbw7U44CROD2xiC1F494=; b=oSZzWTUJ+ILbvWzS/amPsC+PUi
	qro4YvhqKu7S7QecGqIAkvmfdQMKgxQ0wxRoQd0RUbR8ipG8/i0bPqh/Dx0DxLAV3xBo+9kmPzUqq
	a69382req6TxIZvVcI9ZMaXscgQwQwRVDlnzfd/HwzR01ahaduath5YPXYF47IQn2jNiJqslmn69c
	PlxOqgGgd9WFRC/WP1ZmXlariUjltbYGFWw5W8JS8DYJZUgKnvcjKVr/hz5h6Ltl31/z21boDYgiH
	jTy3vPBWCKclM8hcQOuxdzUTMgIy4OUqK0lDhFbOLgybzHBINqtpN0XNQix9OZ7SOxxZ63sH/exO9
	v1KTtU2w==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSwOz-0000000Bm12-3ria;
	Tue, 09 Dec 2025 12:01:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B81130045C; Tue, 09 Dec 2025 13:56:27 +0100 (CET)
Date: Tue, 9 Dec 2025 13:56:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jens Remus <jremus@linux.ibm.com>,
	Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/9] s390: Exception based WARN() / WARN_ONCE()
Message-ID: <20251209125627.GG3707837@noisy.programming.kicks-ass.net>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209121701.1856271-1-hca@linux.ibm.com>

On Tue, Dec 09, 2025 at 01:16:52PM +0100, Heiko Carstens wrote:
> Use the generic infrastructure introduced by Peter Zijlstra [1] to implement
> an exception based WARN() and WARN_ONCE() similar to x86.
> 
> Due to some compiler oddities on s390 this requires to raise the minimum gcc
> version to 9. Maybe there are ways to avoid this, but I failed to find a
> working solution. Details are in the patch descriptions.
> 
> Just posting this now to also get some compile bot testing, since I'm afraid
> there might be some compiler version / config option around where even this
> new approach breaks.
> 
> Peter, since you were wondering: your generic infrastructure pieces work very
> nice. Looking at the x86 and s390 implementation: it might be possible to make
> things even more generic since both __WARN_printf(), and WARN_ONCE() are
> identical; it looks like only __WARN_print_arg() needs to be provided.

Nice! and yeah, perhaps we can unify that later.
