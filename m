Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35DD28315D;
	Wed,  3 Sep 2025 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887139; cv=none; b=Is2vM+7XbO0t+E+NBRXlfb5KfOxQ4xGzbtyb5MGo0dlBregAruF2cx3pkosMuQWuounT/jlUfBkJt3NWCnrQJPs4/TKL8rpbzUSFwF4G5CfETi08Evmz4NEASc93EWWYUVS+vFeyhbawE9w+Z0DGXnL2ct6uvYVJ+c7pHBzLpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887139; c=relaxed/simple;
	bh=1bDVjTqTrvTyx3jCOVewrN5vmmyZijgy/U9beuzNqik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlTJYBG/2GLIuGqOOuN9qRv1NWDaSsi2urIlymGpkABLOU1n5wv5/7lOMkUF9WkbUFN/U0AAbJ8Cx8/lBrUtLDh6t0Qv9+jFLp+W+i5nlzUBh69DRExobZw251jJbh4y7G+lLqZdX/vBax70kfX7pLgQ6Razab2p6dGfZbDIKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kN0YLQfF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kN0YLQfF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=82BXPuTIAmYs8Jgya751jyIs2p821MLp1j4bro46M3c=; b=kN0YLQfF0Kqedc8S5A6h+o6O/6
	butaHyUaf77lZbt8jbYVbyt3s2C7e+qUhoqykljabExiBdGoaeI1J0p3SCEC1aCR6E56sJgN+pgQR
	QUOhf9QucUxcNcdhYzJcVBrfkd9dLgvQaHJGV8jQteh/UFL7CmAfC/WvbQGwHYhWc2bMg0rskvWVk
	oNFOpUpdUQpCz1Adz7gxkuRNghc5tFUKFPaVhnsufHhh031+WZHOevobOSQe0OUyM//WbE4cD0788
	n/MbRMh6kBP6Qfc9TsAn6kyG4V+UvE+5Fj81BqacNPhF/NeljZndxMSmQekBmgDNOUwuLR7WxGTLO
	3gr8V27g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utibC-0000000HVse-42d2;
	Wed, 03 Sep 2025 08:12:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30D4130039F; Wed, 03 Sep 2025 10:12:11 +0200 (CEST)
Date: Wed, 3 Sep 2025 10:12:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
	Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: [PATCH] perf: Fix the POLL_HUP delivery breakage
Message-ID: <20250903081211.GO3245006@noisy.programming.kicks-ass.net>
References: <20250811182644.1305952-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811182644.1305952-1-kan.liang@linux.intel.com>

On Mon, Aug 11, 2025 at 11:26:44AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The event_limit can be set by the PERF_EVENT_IOC_REFRESH to limit the
> number of events. When the event_limit reaches 0, the POLL_HUP signal
> should be sent. But it's missed.
> 
> The corresponding counter should be stopped when the event_limit reaches
> 0. It was implemented in the ARCH-specific code. However, since the
> commit 9734e25fbf5a ("perf: Fix the throttle logic for a group"), all
> the ARCH-specific code has been moved to the generic code. The code to
> handle the event_limit was lost.
> 
> Add the event->pmu->stop(event, 0); back.
> 
> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> Closes: https://lore.kernel.org/lkml/aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com/
> Reported-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  kernel/events/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index dd8cf3c7fb7a..ec19c456b66d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10378,6 +10378,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  		ret = 1;
>  		event->pending_kill = POLL_HUP;
>  		perf_event_disable_inatomic(event);
> +		event->pmu->stop(event, 0);
>  	}
>  
>  	if (event->attr.sigtrap) {

Right. I've queued the patch, but should we take a hard look at anybody
still consuming the return value of perf_event_overflow?
