Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326CF4DD3C1;
	Fri, 18 Sep 2026 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730660; cv=none; b=RHx/mAhvTDS6Or/uz+cuAfB+r2lFn8cuRFZeIEa2/ixKosqcxgE9oYuuHMnNnORwhAeSKvlqvB6U7ZOAcmTmqvZGL8dh4Qu61yqFHvgxH4QLv3ZlI35AmyW1+HLLIGKdLz/TjUTOWZscUP+04XmJ4qQHAO41p5V9lU5mvONtprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730660; c=relaxed/simple;
	bh=rOEzUmmMKHol1VJA1wIsjHCI8/mOyC4B8RvzvvSZTMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmiuJ5xDumpBHONvIfxsxyJFaRuvbisNqcvueoIP8Ed3pCm6+9jYdqMRuNSdmUV7fAOMrxuVNagrjZeo7gAo0j5OXZqD3/yxjKR8lIUy6TX1MRzbO3IoeVaeWRNgktxcbtKzg9DgICsk/7rukQAZI4bUpXG1bfL15PFhPA/Ybmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cjvK9slF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cjvK9slF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0C0B1596;
	Fri, 18 Sep 2026 04:24:12 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86B623F882;
	Fri, 18 Sep 2026 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789730656; bh=rOEzUmmMKHol1VJA1wIsjHCI8/mOyC4B8RvzvvSZTMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjvK9slF6U8HqVTYGdLKV4K9zcHkSmzpcpCfbwT2AmrypC8c6uLHRJRMRuTjtMiC2
	 5fo/M5fCtuJxI03I6naY70DXaDDVpJ/a0lVhXM6s6nBwkzB4+yESitKh8/ii/KkpZB
	 8dFvVbwa3fxIlBSZGEFJyHM4GB9eV84fYaNRE+dA=
Date: Fri, 18 Sep 2026 12:24:11 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 00/12] s390: More this_cpu_*() changes
Message-ID: <aq0fW9r0vV9K7vqb@J2N7QTR9R3>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <aq0S_fKqcZ5WoLUU@J2N7QTR9R3>
 <20260918105922.20386E38-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918105922.20386E38-hca@linux.ibm.com>

On Fri, Sep 18, 2026 at 12:59:22PM +0200, Heiko Carstens wrote:
> On Fri, Sep 18, 2026 at 11:31:25AM +0100, Mark Rutland wrote:
> > > v2:
> > > - Yet another brown paper bug: Re-add CPU migration check to last
> > >   patch. Unconditionally recalculating and updating the percpu variable
> > >   address and percpu offset register can corrupt previous context
> > >   register state in several cases (not only the single case reported by
> > >   Sashiko).
> > 
> > Do all of those case boil down to:
> > 
> > * During exception entry from context A to context B, a nested exception
> >   is taken from context B to context C before percpu_entry() is called,
> >   and the nested exception handler updates B's live regs using A's
> >   percpu register indices.
> > 
> > * During exception return from context B to context A, a nested
> >   exception is taken from context B to context C after percpu_entry() is
>                                                          ^^^^^^^^^^^^
> That should have been percpu_exit(), I guess.

Whoops; yes!

> >   called, and the nested exception handler updates B's live regs using
> >   A's percpu register indices.
> > 
> > ... or was there another case that you spotted (e.g. some case where
> > percpu_{entry,exit}() aren't called)?
> 
> Yes, all scenarios boil down to exactly the above.
> 
> > On arm64, I think we avoid those two cases by virtue of not taking
> > nested (architectural) exceptions during those windows, and by not
> > applying fixups for SDEI events (SW NMIs that can be taken during those
> > windows).
> > 
> > If there's another case to consider, it'd be handy to know.
> 
> I'm not aware of more cases.

Perfect, thanks for confirming!

Mark.
