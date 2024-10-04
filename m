Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34C146A72;
	Fri,  4 Oct 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036525; cv=none; b=Pjc7PvgS/XRP6czD1+2V/hX8oWXJCo3oaKypN0olG+tCw4hFv+wJ0ON724aCiO3WlbhVFeU4lm5NDtGvxCKb8HtObZGDnsd4FMv0ir1qPAnaMoZrHgBmxcT9k8eUyhITs/jYpa+DdICPkHXy2cLCLn4qDXJ6Z2WvN48M9AfiuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036525; c=relaxed/simple;
	bh=GMIxrpyZ7lWGEEHcirtrn9Tag+b3HbRGsmWpQIAcR8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP7NByUFl68yhb6fwdEbZSyXjIrBEVgMnexDgGTrGxUqrC8LvS7hMZMZSJSqqK9LvkoyKMwnSM/bgQB3PdWQDL0dCD8eeVw43spd8UibTbUi8Wd8sbwhuf68SqRc8Al04NemtTx5NUfMKX9zN2usQePTW9NU1haJ9A270HvGSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NdHNdaFc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NdHNdaFc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xaIy+tdNmAOIqcYnnJ2OzNqLnsHQb5n/Nh5bV5Dh8k8=; b=NdHNdaFcsueRNxvgLKJtfa0YDt
	nuJhx0CS9W4YnLjcOqKeTTCLN+wIlSKYr21+6l3iQV1KnccgEwwyBtsJgBqv3PyqtYfcF40fhQoMo
	fB9+GLPYxxKmQOWUQUkEFNHmdRXutxI/jZDxTPtYqhEaLfbSlvk9/uTiGVszM7ulpTmlXaBtQRKj7
	4S2jLAG3Rx3dgOUsjP3v3H1JtClOE9GdC6CPrJDy8tBtLVjN2VrqM8142/DMEBAuYCWeXpq96uvWg
	cokpvIxZ1m+XQUcQcZjVxNeBTW9wkMcokLH3Pko0GWUGNcJvYKFt/matGeUd6RQFOYwPO0KwbW4uk
	ummA1yMQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swfEi-0000000A91d-3iFx;
	Fri, 04 Oct 2024 10:08:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 87FBB30083E; Fri,  4 Oct 2024 12:08:36 +0200 (CEST)
Date: Fri, 4 Oct 2024 12:08:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 resend2] locking/spinlocks: Make __raw_* lock ops
 static
Message-ID: <20241004100836.GP18071@noisy.programming.kicks-ass.net>
References: <7201d7fb408375c6c4df541270d787b1b4a32354.1727879348.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7201d7fb408375c6c4df541270d787b1b4a32354.1727879348.git.geert+renesas@glider.be>

On Wed, Oct 02, 2024 at 05:03:55PM +0200, Geert Uytterhoeven wrote:
> If CONFIG_GENERIC_LOCKBREAK=y and CONFIG_DEBUG_LOCK_ALLOC=n
> (e.g. sh/sdk7786_defconfig):
> 
>     kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_spin_lock' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_spin_lock_irqsave' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_spin_lock_irq' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_spin_lock_bh' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_read_lock' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_read_lock_irqsave' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_read_lock_irq' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_read_lock_bh' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_write_lock' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_write_lock_irqsave' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_write_lock_irq' [-Wmissing-prototypes]
>     kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_write_lock_bh' [-Wmissing-prototypes]
> 
> All __raw_* lock ops are internal functions without external callers.
> Hence fix this by making them static.
> 
> Note that if CONFIG_GENERIC_LOCKBREAK=y, no lock ops are inlined, as all
> of CONFIG_INLINE_*_LOCK* depend on !GENERIC_LOCKBREAK.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Waiman Long <longman@redhat.com>

Thanks!
