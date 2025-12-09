Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0CD1D9346;
	Tue,  9 Dec 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765284426; cv=none; b=ij0fwv0O40/f1pCvFIt8XpiobQaMRiWFoxdXe0Xy5Bf2bOUhXQdBPasfvHl/yH2DDz+yZcvEFT2YX5oaxJYLzq6gLj3jmX8h4yqLBdgh9xodZYFVXnilZeyhSIUhFE8DToz8tWm/cmv6hOWUjBeMESEMsKCN5zWtY7bgEYdGj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765284426; c=relaxed/simple;
	bh=X6d4rQIBQPMfMStmP8QquufNVAGNIou6VE/E9COHbv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDZQVrIfRiOmsOJ50qj7AKj7HXfQUyZu0wjRQwo8PTqjkw1n364NSOaL5j2i2LauNeM0Sjp4KyXsUyoMyn2WuEdcWOhGXl3P6WOw27i0hNl0QzfK1IRsZhaZEGQZyDxhvpcjPlU7SxzmptL5nnukJFCmcQ2IZmy2kTfyhUxL93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qH/yzYQD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qH/yzYQD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FAAPy53oQtLqXmP8QvbSkIOmvco7sxZS8ek26/A6eso=; b=qH/yzYQDMBSnCXFJcX1XuR2dq+
	hmVFfCDokRCoGb9Zp3DJLE/bieacL+5+Mxo5UWUuSdtJmefF4WF3U14hrAJDDf8OxcVrt7LsIYC1O
	XW3Qs54l2lUlOcqa1UwuekHulC3IKzj/wSyxmFkJ8q3/w46GvsgcWIUGzIoKXZLTZwqNDqGZ3s3Yq
	WsyI5Wd69IaiKw0GUJ6/SsTc2dyBKFYfFD4U1St+OFhcKiaHgf1ggYbZqmTFloTtadlzc7ligcd0I
	Arcw7VsZ8d9ZT6FyyHYVP/xPpG9jFUnS9uX+MpNv+QKsJhnYvHUg8LEqf11o8MVEHglyPNvQfv/KT
	Kl9Jh1iw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSwFr-0000000BlNV-2X03;
	Tue, 09 Dec 2025 11:51:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0989A30045C; Tue, 09 Dec 2025 13:47:01 +0100 (CET)
Date: Tue, 9 Dec 2025 13:47:00 +0100
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
Subject: Re: [PATCH 9/9] s390/bug: Prevent tail-call optimization
Message-ID: <20251209124700.GF3707837@noisy.programming.kicks-ass.net>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
 <20251209121701.1856271-10-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209121701.1856271-10-hca@linux.ibm.com>

On Tue, Dec 09, 2025 at 01:17:01PM +0100, Heiko Carstens wrote:
> For the exception based __WARN_trap() implementation it is technically not
> necessary to prevent tail-call optimization, however it may be confusing to
> see warning messages like:
> 
> WARNING: arch/s390/kernel/setup.c:1017 at foobar+0x2c/0x50, CPU#0: swapper/0/0
> 
> together with a disassembly of a different function caused by tail-call
> optimaziation for the __WARN_trap() call. Prevent that by adding an empty
> asm statement. This generates slightly worse code, but should hopefully
> avoid confusion.

Aah, because:

	bar()
	  foo()
	    __WARN_trap()


when foo() does a tail-call, your link reg points to bar() and not the
expected foo().

And at this point you don't have enough clues to conditionally do that
psw/r14 fixup either.

Oh well.

> With this the output looks like:
> 
> WARNING: arch/s390/kernel/setup.c:1017 at foobar+0x2c/0x50, CPU#0: swapper/0/0
> ...
> Krnl PSW : 0704c00180000000 000003ffe0119788 (foobar+0x38/0x50)
> ...
> Krnl Code: 000003ffe0119776: e3e0f0980024        stg     %r14,152(%r15)
>            000003ffe011977c: c02000b8992a        larl    %r2,000003ffe182c9d0
>           *000003ffe0119782: c0e5007270b7        brasl   %r14,000003ffe0f678f0
>           >000003ffe0119788: ebeff0a00004        lmg     %r14,%r15,160(%r15)
>            000003ffe011978e: 07fe                bcr     15,%r14
>            000003ffe0119790: 47000700            bc      0,1792
>            000003ffe0119794: 0707                bcr     0,%r7
>            000003ffe0119796: 0707                bcr     0,%r7
> Call Trace:
>  [<000003ffe0119788>] foobar+0x38/0x50
>  [<000003ffe185bc2e>] arch_cpu_finalize_init+0x26/0x60
>  [<000003ffe185654c>] start_kernel+0x53c/0x5d8
>  [<000003ffe010002e>] startup_continue+0x2e/0x40
> 
> A better solution would be to replace or patch the branch instruction to
> __WARN_trap() with the monitor call instruction, similar to what is done
> for x86 [1]. However s390 does not support static_cond_calls(). Therefore
> use the simple approach for the time being.

Right, and no objtool for you either :/ Because all you need is
something to find all the __WARN_trap() callsites and stick them in a
section.

> [1] commit 860238af7a33 ("x86_64/bug: Inline the UD1")
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/bug.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
> index e6e8b492c0e7..89187ec6f6b0 100644
> --- a/arch/s390/include/asm/bug.h
> +++ b/arch/s390/include/asm/bug.h
> @@ -99,6 +99,8 @@ do {									\
>  	int __flags = (flags) | BUGFLAG_WARNING | BUGFLAG_ARGS;		\
>  									\
>  	__WARN_trap(__WARN_bug_entry(__flags, format), ## arg);		\
> +	/* prevent tail-call optimization */				\
> +	asm("");							\
>  } while (0)
>  
>  #define __WARN_printf(taint, fmt, arg...) \
> -- 
> 2.51.0
> 
