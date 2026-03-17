Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB338F22A;
	Tue, 17 Mar 2026 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781734; cv=none; b=Gxhxm/QRFurB+1doofa4MWjK5G/ftliYM9EdZSh3RckHeZY2i4UpvEZlcMHeHf/K7Ji7KdTyNlHXiLYvqnH9RoOQzS+t0WimHjJXgPWNvXBNzFwL107D2D8JB+/WKH/sBtIWIFlPngjNI2v9LWsj67hxhJOickKH4Ek9qJceoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781734; c=relaxed/simple;
	bh=tW0oc93n/qGfupqTT69D3UHctXUg8TyZ+GrafEf8Waw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8jAhzf4ub0QJLKWv1WdiTbKBOszqKqeOum5srgxFKSqXt/xG7Gg7QP0b37sdMI8KMM3JGRR8T/gAGOW8UBHHblgeU0aZLdin3qc4T0KF+bV+/NHArJJ2wk41qdVh8/0HXMDVVWSCU9ZERhQeN+vZqHfFtQqD4Lids2Fa2Z/2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nJBooYQz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nJBooYQz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EMtUMedDQ3iRE+hxnQIAGFf8j6u8uxreYXmHnHH2skQ=; b=nJBooYQz6cmftWqCBbERwacLmz
	XenrhemSWHI+sYnDoVP88TqO/y5KYHEKqdtuRNvujCGPyeN+VfDwRvBeDsqqmwU0ClO/AzeKqweys
	8AbuL85Dcb90yS+Hh0dZZ4ibu6oPiA+32hiDhh6fqJ0Yge+jRpFBI/zt34rn4OjnnlmtJ8fJ3AmYB
	mC6bM3NynGxA0NulQ/CpK8pzNquwIFn3RiQuuqKqVn1tGMQKgUVu/QyL5Hf+/I0Gvk9nZ0od1hIew
	P3hu/SaUHD2n5QvDSugScOU/S2lPRycBsphKbKaC5+9XhOrZQdJ7YDSiVM6HlxlLYxFnd+Xfm+kZJ
	Rk09wYqw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2bed-00000003K0r-0Xgp;
	Tue, 17 Mar 2026 21:08:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F301B301BD5; Tue, 17 Mar 2026 22:08:41 +0100 (CET)
Date: Tue, 17 Mar 2026 22:08:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/9] s390: Improve this_cpu operations
Message-ID: <20260317210841.GK2872@noisy.programming.kicks-ass.net>
References: <20260317195436.2276810-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317195436.2276810-1-hca@linux.ibm.com>

On Tue, Mar 17, 2026 at 08:54:27PM +0100, Heiko Carstens wrote:

> The idea is that this_cpu operations based on atomic instructions are
> guarded with mvyi instructions:
> 
> - The first mvyi instruction writes the register number, which contains
>   the percpu address variable to lowcore. This also indicates that a
>   percpu code section is executed.
> 
> - The first instruction following the mvyi instruction must be the ag
>   instruction which adds the percpu offset to the percpu address register.
> 
> - Afterwards the atomic percpu operation follows.
> 
> - Then a second mvyi instruction writes a zero to lowcore, which indicates
>   the end of the percpu code section.
> 
> - In case of an interrupt/exception/nmi the register number which was
>   written to lowcore is copied to the exception frame (pt_regs), and a zero
>   is written to lowcore.
> 
> - On return to the previous context it is checked if a percpu code section
>   was executed (saved register number not zero), and if the process was
>   migrated to a different cpu. If the percpu offset was already added to
>   the percpu address register (instruction address does _not_ point to the
>   ag instruction) the content of the percpu address register is adjusted so
>   it points to percpu variable of the new cpu.
> 
> All of this seems to work, but of course it could still be broken since I
> missed some detail.

Right, so this relies on them being single atomic RmW instructions. If
the interrupt/exception happens before the RmW the address is adjusted
and the atomic instruction is executed on the correct CPU. If the
interrupt/exception hits after the atomic but before the second "mvyi"
the address is still adjusted but then goes unused.

I don't immediately see a hole in that scheme. It is neat for not having
retries.
