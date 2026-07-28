Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2A3AB5AC;
	Tue, 28 Jul 2026 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235395; cv=none; b=E+QigAK5xPduYlSKzL2nyowCvlakgMnclaBo+9Owri1U3DuH1IGTV6QV+nS+aF8I6bgsdKDmaQOc8jBBSe/0GBHTfvyhV7y3O8oRkSOLeMyEHJ4fLiBCLn3JzgeRPBYqxLZzNU6dSpZyvOyJUFwf06xek9pY1+Asl8VGT3H3SIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235395; c=relaxed/simple;
	bh=EutFiyZSKQKa7LaCNJADiscjAb1o9anbThDCOnvSuUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdwghgCybV522OXz4rSyi0xPuRSUjIEatg7gXkSIPT7Vgw+dQHcuy4u75nnO/IqHmNw+ghhSMEQUYmSYLS4TonAgbMotFGpNkyXylQ31FckzHRm3LCbKn2PubGmhFTRYi8epFmLFZWUqzyUy1Sfwj5r3V2ZGBo0eKfFb48Unf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AYMaZIFC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AYMaZIFC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ori7tVw4BszhGpGM/PUOqEi2xQpfS+gNcPV903UBqqg=; b=AYMaZIFCttQhdcvUYjuKZaeDfg
	DyG/DevW6DTnoNIvTm+sWNNldjEy0S+vEH6TczWws4o+FHjL12R2qKMH2MW39Dlh9/Fs3/xpnNUVJ
	BSjB70SUZ/rJP1kNzPfI8dsmY19bjI7S9NG9fxuKWDg72QHB3zDLr4HUOm33Yvkz7WCHNNazRaZ2L
	qmd8dECUFxr8zbvjnOQNFI9ssuQfdq+cBNG12D+DeA5oKY+3cghAyuY/kk93e/icDPshRfILskYv8
	EvMpEZ4DAmyILB08K0UhKWFcTSs0faHX1v+RHvAGQsNC40jQ/pcQngQ5P0y+dGdLXBrqYx3m37h8n
	qxaLFvaQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wofH9-0000000CynX-2U2D;
	Tue, 28 Jul 2026 10:43:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 527E930093A; Tue, 28 Jul 2026 12:43:06 +0200 (CEST)
Date: Tue, 28 Jul 2026 12:43:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] s390/crypto: Replace cond_resched() with schedule()
Message-ID: <20260728104306.GG49951@noisy.programming.kicks-ass.net>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-2-hca@linux.ibm.com>
 <f88846b24b1250f89b503b6ddfda318c@linux.ibm.com>
 <20260728082948.13361Ab7-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728082948.13361Ab7-hca@linux.ibm.com>

On Tue, Jul 28, 2026 at 10:29:48AM +0200, Heiko Carstens wrote:
> On Tue, Jul 28, 2026 at 09:05:16AM +0200, Harald Freudenberger wrote:
> > On 2026-07-27 18:24, Heiko Carstens wrote:
> > > The comment for all cond_resched() calls in crypto code says that the
> > > process should be scheduled away to avoid instant re-invocation of a
> > > callback. This is not what cond_resched() would do or did.
> > > 
> > > Replace cond_resched() with a call to schedule() which comes closer, but
> > > it looks more like this code wants an msleep() call.
> > > 
> > > Note that with [1] cond_resched() is always compiled away and becomes a
> > > no-op.
> > > 
> > > [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
> > > 
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > > ---
> > >  arch/s390/crypto/paes_s390.c  | 8 ++++----
> > >  arch/s390/crypto/phmac_s390.c | 4 ++--
> > >  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> ...
> 
> > > -			cond_resched();
> > > +			schedule();
> > >  			return -ENOSPC;
> > >  		}
> > >  		break;
> > 
> > Ok for me but we agreed to have all this code going via Herbert Xu.
> > So please address this patch to Herbert and the crypto mailing list.
> > And then I'll add my Reviewed-by.
> 
> Well, the main question still remains: why did the code use cond_resched()?
> 
> This doesn't make sense to me, at least when reading the comment. So to me
> even the schedule() approach I proposed is questionable. Why didn't the code
> use msleep() instead? Or can we just remove cond_resched() entirely without
> any replacement?

Right, so suppose the task is a real-time FIFO-99 task (and there are no
deadline tasks), then the task will be the highest priority task in the
system and calling either cond_resched() or schedule() is a no-op, since
it will instantly re-select this same task for execution.


