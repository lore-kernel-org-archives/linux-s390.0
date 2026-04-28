Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF393644A4
	for <linux-s390@vger.kernel.org>; Tue, 28 Apr 2026 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359690; cv=none; b=cyEbpb3nzrAXx4GNXGS7o4W1t6didswIaszGP0Lurz1oJrzofHyH1qSWN3iHbideZjhRjIpea1aulZeE24cOi8Ane88gmWKGjgtUV8SH7qm1PjWBkYHrwPUopRe3f1pqzYFM8Eo6DkiirL2D1+tYGy0dbc2qjdk7mvEVPGj0IkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359690; c=relaxed/simple;
	bh=aZ+ilQU0CRxBQSHpZWuTx9r/mPqNwDbhSjkzsbTm3VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOGJB2XTVD6VnZU1gzfUAHe5TbVncLCxw6CvKCqGLC8bUCQRIEIkhUDWQo1+igxyRgkWeyiy9SCSTHzd6/jYnTWc1MAbRg3le8wqgjJ2IJRV8lhcrceHOKnwe9RyoEJPFdHswgYNhCVxP7nuac1YhM6NznM6ZlYi3rcBuVhw1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F45mE+OW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F45mE+OW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so58593645e9.1
        for <linux-s390@vger.kernel.org>; Tue, 28 Apr 2026 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777359687; x=1777964487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTLVQg4AUPoFhh0/dMQ7jJusBiykhYrOEzhYSb0BkVI=;
        b=F45mE+OWLktbpVLe0cDGcgsJmUCrZ5H+70M018F4+WlQe6XASgCnEOSbpiox5+TCuU
         cieWVy8oDDRnfStxKlPKFRvym8qo//gxH4ahqeiKonP0aB+CC9jfhX8ndRFf/H+faVL+
         Amv3xHptDH8rr/CNSzuIpD197uRLT+5owc5rYhU5wXFwa85oohP74lJaR1SQtaQ9U9Th
         5FKkl1UP3k7uZmZHSELm+58yEg6rRXWVhERh7YmJvsA5DrR7ApqAEWok8BVuzXRDrloF
         4XLzd8X/njWFbpX1Tj00/bGtwJ8jpVQATPXTIUzMKTNBx2Gd6PiK3/Zaah4i238A3Jlc
         rpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777359687; x=1777964487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTLVQg4AUPoFhh0/dMQ7jJusBiykhYrOEzhYSb0BkVI=;
        b=Et7lAKxPb9vqMYRz2TcCvWClCVsr7RCHXhSuBuIgvWjzZ7Q1/O3WQss7UMs86wGBKV
         I9tRhiZusB5296DX8B1K5yyn1sxG2/mnYg25IQHSUc2TlrCdvUv6XCLvGbAAo/Oogzne
         XKuKWrxE4YWyHz1hgX1ioQg/kEDsZk2A2TM8qej5UPxEsPlt/4uZFa/Z6C4Er1fYTZsv
         jheRXLtoHY4Y+yx1Uh3YIIUkFg7yzNmFVvSMUELq3PIKparUujCUUF44Vqd942IzB/fc
         OQ31SKFaaeUXlViODxW1mRfovk5WQsWWb03BJ+X3Tg6c5QF9ms09ptc+jTjqlgPm1BfG
         kRfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SulwGQVrdQoDKEXXDu8exIm604bNHXawyRchWtitH3YW2xee7jfzQ5HY/zT2SAE5AGiBowMMi+ijR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5J+NDHlAUiEdLojUFy8lElfhW2Px8Ii4hXXaHP9WVQ9oBR69
	RH9TZKaXksXv4DvqTwruxvAZl7xLNxrcIE1JFyyxHpPTK4wq/a9/RXeWBleIeFMP8FU=
X-Gm-Gg: AeBDievRi5v22ZMdsZX03I5FYIaOevgD6U3Fnpx7c2njcrz7YGsrGyGmFhduo/6A9en
	ElR3eXqoxGyGtSG6MXB77+alCkO3Pz3+QUVQk4waL1ZjNjMFqakQ9jsykd6yJT/TA+GE9WpJQ+q
	YPU8co/xC2liSriaebI1rOLnOUtC05tOgr9kHbB5Cho1s7c3pxbUs6rNYzPy4rLEYdVNrR+FVB6
	Bq0/uyV4eWzdmdBJbVN5bJ9Y/EfRlehUnlHf+i9Jp0iWLtFsekVlycI/q3GdbtI2RZWrPvwfQ3p
	SiE+gLEuQpmLfLQoAc+GVN9xwbrtudAnRQl1jDPqGrSAyXAoGr72drQvNx0Nb5hbbGEZJJCrFLy
	VVFZas7+QyY7ZXGcFLMkwR1z7PpB2bf5x21JKbi8ZM4JctxmYml/m9Z9c3Un4l/KjPeB0i9mXTG
	zmROOqBy00XN1XkVVRTD9ioQZRkB7gaizhQ2qwbORlEKOauKcC2cOKttQ/6g==
X-Received: by 2002:a05:600c:a403:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48a78a391b9mr13790805e9.10.1777359686867;
        Tue, 28 Apr 2026 00:01:26 -0700 (PDT)
Received: from localhost (109-81-17-171.rct.o2.cz. [109.81.17.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773efe04sm37690385e9.12.2026.04.28.00.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:01:26 -0700 (PDT)
Date: Tue, 28 Apr 2026 09:01:25 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afBbRUaGnE8WZIkY@tiehlicka>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-4-minchan@kernel.org>
 <aesiYAumkLCyedf0@tiehlicka>
 <aevzbx_Pk5Cu5exa@google.com>
 <ae8KD_Tq0t7RvUy1@tiehlicka>
 <ae_dRZ95dCDTTxaQ@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae_dRZ95dCDTTxaQ@google.com>

On Mon 27-04-26 15:03:49, Minchan Kim wrote:
> On Mon, Apr 27, 2026 at 09:02:39AM +0200, Michal Hocko wrote:
> > On Fri 24-04-26 15:49:19, Minchan Kim wrote:
> > > On Fri, Apr 24, 2026 at 09:57:20AM +0200, Michal Hocko wrote:
> > > > On Tue 21-04-26 16:02:39, Minchan Kim wrote:
> > > > > Currently, process_mrelease() requires userspace to send a SIGKILL signal
> > > > > prior to the call. This separation introduces a scheduling race window
> > > > > where the victim task may receive the signal and enter the exit path
> > > > > before the reaper can invoke process_mrelease().
> > > > > 
> > > > > When the victim enters the exit path (do_exit -> exit_mm), it clears its
> > > > > task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> > > > > leaving the actual address space teardown (exit_mmap) to be deferred until
> > > > > the mm's reference count drops to zero. In Android, arbitrary reference counts
> > > > > (e.g., async I/O, reading /proc/<pid>/cmdline, or various other remote
> > > > > VM accesses) frequently delay this teardown indefinitely, defeating the
> > > > > purpose of expedited reclamation.
> > > > > 
> > > > > This delay keeps memory pressure high, forcing the system to unnecessarily
> > > > > kill additional innocent background apps before the memory from the first
> > > > > victim is recovered.
> > > > 
> > > > Thanks, this makes the motivation much more clear and usecase very
> > > > sound.
> > > > 
> > > > > This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> > > > > an integrated auto-kill mode. When specified, process_mrelease() directly
> > > > > injects a SIGKILL into the target task.
> > > > > 
> > > > > To solve the race condition deterministically, we grab the mm reference
> > > > > via mmget() and set the MMF_UNSTABLE flag *before* sending the SIGKILL.
> > > > > Using mmget() instead of mmgrab() keeps mm_users > 0, preventing the
> > > > > victim from calling exit_mmap() in its own exit path.
> > > > 
> > > > Why is this needed? Address space tear down is an operation that can run
> > > > from several execution contexts.
> > > 
> > > Agreed.
> > > 
> > > > 
> > > > > This ensures that
> > > > > the memory is reclaimed synchronously and deterministically by the reaper
> > > > > in the context of process_mrelease(), avoiding delays caused by
> > > > > non-deterministic scheduling of the victim task.
> > > > 
> > > > The memory is still reclaimed synchronously from the mrelease context.
> > > > This is really confusing.
> > > > 
> > > > Please also explain why do you need to do all that ugly
> > > > task_will_free_mem hoops. Why cannot you simply kill the task if
> > > > task_will_free_mem fails (if PROCESS_MRELEASE_REAP_KILL is used).
> > > 
> > > I wanted to handle shared address spaces.
> > > Even though we are okay with the target task not being in a SIGKILL
> > > state yet (since we are about to kill it), we must ensure that all
> > > *other* processes sharing the same mm are also dying.
> > 
> > Then just bail out when the mm is shared accross thread groups, rather
> > than kill just one of them. Or kill all of them. There is no reason to
> > play around that on the task_will_free_mem level.
> 
> Kiling unrelated processes just because they share an mm is too radicical.

Well, that depends on what you try to achieve. The global OOM killer
does kill all tasks sharing the mm.

> Thinking about quick check whether mm is shared.
> 
> An idea:
> 
> `atomic_read(&mm->mm_users) > task->signal->nr_threads` to detect sharing
> across thread groups without looping like task_will_free_mem.

We have MMF_MULTIPROCESS. Can you use that?

-- 
Michal Hocko
SUSE Labs
