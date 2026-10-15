Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B797499F0E;
	Thu, 15 Oct 2026 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049885; cv=none; b=Lpzyd1j5OUH7vNGPJKQQXATmCH1J/rI700e6qtrQSCuL6GFW/0c9SFwhzfa+fXwXIbdu0/OG877uwNPuoZSTJ/RrletmAFYgBxSWqXxdXoLtp6SBorE3Vo2WWE56P5uGwn05OIo2Mq0vR2+U2uhFWasw4pya0DsIw2Ht9nS91BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049885; c=relaxed/simple;
	bh=/WBISo+oZz4wuqFDWBP8+OVw0WLhbmv1EqAVjjnSkHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2jsy1PmUXlu+t7arG2Xe9ZZ2pZq0/XXp2h1luXUhL12cwTTqM/bQS03tJ71ti5gdd6MZUo6M3pya+1WBBwUhcF2WJWjExYy9AzQRJGtPHB7isVewp7tSwTQlinSK9KlmvN/twQcUIS7Kxp3GHPHl59+BDHf/1RaUJaU3/YxCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f9CGffsm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f9CGffsm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+iNt1ZN1awP3QtLz+KT7PKyGu52nrjki8HDScJnxeYs=; b=f9CGffsmpBZgk184/KYxaw+Bbe
	93Su0EHGd3mnDSKXruRYCRlYd8WS9b4xGrdMoy31P+t/z7uQl9Gm408NZ6iiHglhurjCv9Ct4hLaJ
	7wQz1ZgJeI/Syj34a08aRcXvqBy5yu7kgLe9vd6Ps0JSTugSF49FreuQJ/HcU8E6RfwpqB3Ejy/IZ
	/DOq1Ksc+krUahyGwbxJN+8k4k7y7SsWF7D3Uj6XL2k3baREjW+3+q5aRTMv1DSGTSszuHM8XwlXt
	PnCP4tAjuQXHOlKhYfuh5GhXV/QcLdURpBpn4HWMRXX3YJCA6Wbqr4a69ZBw0NkL65dBLIb+tiKQo
	mZE6PQnw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHG2B-0000000BlKh-3lc4;
	Thu, 15 Oct 2026 07:37:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 00B403006DD; Thu, 15 Oct 2026 09:37:50 +0200 (CEST)
Date: Thu, 15 Oct 2026 09:37:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, cocci@inria.fr
Subject: Re: [PATCH] sched: Replace nr_iowait_cpu() with a bool accessor
Message-ID: <20261015073750.GI4121339@noisy.programming.kicks-ass.net>
References: <20261014134745.3032405-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014134745.3032405-1-christian.loehle@arm.com>

On Wed, Oct 14, 2026 at 02:47:45PM +0100, Christian Loehle wrote:
> The menu governor was the last consumer of the per-CPU I/O-wait count
> that needed its magnitude, apart from nr_iowait() summing it globally.
> Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
> that use. All remaining per-CPU consumers only test for zero/nonzero.
> 
> Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
> and s390 idle accounting callers. Have nr_iowait() read the counters
> directly so that the global total and existing accounting are preserved.
> Replace the stale menu comment with a description of the predicate.
> 
> Include the Coccinelle recipe for the code conversion, verified against
> the original files. The helper's comment is updated manually. Reproduce
> the conversion with:
> 
>   make coccicheck COCCI=scripts/coccinelle/api/cpu_has_iowait.cocci MODE=patch
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  arch/s390/kernel/idle.c                     |  4 +-
>  include/linux/sched/stat.h                  |  2 +-
>  kernel/sched/core.c                         | 13 ++---
>  kernel/sched/cputime.c                      | 10 ++--
>  scripts/coccinelle/api/cpu_has_iowait.cocci | 56 +++++++++++++++++++++
>  5 files changed, 69 insertions(+), 16 deletions(-)
>  create mode 100644 scripts/coccinelle/api/cpu_has_iowait.cocci

So I like this; but I'm confused about including the cocci script. Why
is this?
