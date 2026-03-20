Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA238BF8B;
	Fri, 20 Mar 2026 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007069; cv=none; b=WjuJulBIr+pY25cLM3X96b5eHsNoMLGXSurdsjZY0b1rN8h3Z3tstQqeCiPFNRhrzepFTr5VqtVuJ9A64c5yUlGL5tKecAuDCzSjDavSeHMIa7Zv1TuBLr/rIQZ6A1onQrd6ImXoGOdC0akr+a/jrWRjx/0Qch+yNzqP2APq1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007069; c=relaxed/simple;
	bh=hArs6kuS6KydQwdlUptQjuqRWQ1FvnPZM7ZYZf/TLrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBzR1URDlyAVZl/Bsky4l2FH8cIWE5OM6ncaYMNVJXKv7uPyR6Lpy6n8Yjm8uh4GdgmgTiJJ4XaXKq1kCtVwF7kCjBU3TR7iACxYUx7j57R/PBXjoIXsQHRd2pyOh9745S3bJ8vYzD/0yUM+/1OYXvarpEwyfsqmrw5E/0Gt/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YqxYl0Jr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YqxYl0Jr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=05LtVHDNFjk2gcHE0LjqHjkm1UfXVzvSZfD5gJyPASA=; b=YqxYl0JrNguL8FYvIt586nPwqi
	hufFUS0Orf+rBIunwY3lw6HbNbS6x8hyohUPMGaWTL4XRrOW7OBaAxVcrzLQspcibzH9XSH+26rsv
	ebjN8atQ/5jVoJCM/aOKK1cl+zKFMkXWY6Cnbpm4XrkA2LpsKJc5uOImVQvwVFZR4bkSpJJQkEkd+
	0WP/2o2NdyUu3Bj6ejK270tmWr8Q5Ft0k4PTNfgGQJKXO6GqtFAHD3wVSbazwOU4/CWhAlkr+w7cm
	PeB47eRWpDclVcWccYOeeJv3ZVb38g5kF9QkLAMSh8D5gM1P9vK5OstWHm76GxSAMHFigSDwfyJrq
	8DCL2ToQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3YHB-0000000FT4q-0NAV;
	Fri, 20 Mar 2026 11:44:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C5616300578; Fri, 20 Mar 2026 12:44:23 +0100 (CET)
Date: Fri, 20 Mar 2026 12:44:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/9] s390: Improve this_cpu operations
Message-ID: <20260320114423.GC3558198@noisy.programming.kicks-ass.net>
References: <20260319120503.4046659-1-hca@linux.ibm.com>
 <20260319135612.GI3738786@noisy.programming.kicks-ass.net>
 <20260320113909.9681Aad-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320113909.9681Aad-hca@linux.ibm.com>

On Fri, Mar 20, 2026 at 12:39:09PM +0100, Heiko Carstens wrote:
> On Thu, Mar 19, 2026 at 02:56:12PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 19, 2026 at 01:04:54PM +0100, Heiko Carstens wrote:
> > > v2:
> > > 
> > > - Add proper PERCPU_PTR cast to most patches to avoid tons of sparse
> > >   warnings
> > > 
> > > - Add missing __packed attribute to insn structure [Sashiko [2]]
> > > 
> > > - Fix inverted if condition [Sashiko [2]]
> > > 
> > > - Add missing user_mode() check [Sashiko [2]]
> > > 
> > > - Move percpu_entry() call in front of irqentry_enter() call in all
> > >   entry paths to avoid that potential this_cpu() operations overwrite
> > >   the not-yet saved percpu code section indicator  [Sashiko [2]]
> > 
> > Would it make sense to add arch hooks to irqentry_{enter,exit}() ?
> 
> I guess it would make sense to have some architecture hook which
> allows to run code on all entry/exit paths instead of duplicating the
> code n times.
> 
> But apparently my code seems to have more bugs (e.g. I didn't consider
> kprobes which would make the instruction comparison not work). So this
> has to wait until I'm back after vacation.

My vote is to reject kprobes in these regions :-) Anyway, enjoy the time
off!
