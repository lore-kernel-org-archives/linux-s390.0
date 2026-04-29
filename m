Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5D274B3B;
	Wed, 29 Apr 2026 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497366; cv=none; b=uP70zQwob0nc/t0b1vxxMj4zGayvF8Fmie+vVhsPKUUt90EQxIyvSwC089f6v+TpFpYRbgj1xxBaszHYDIOF7mz5pQiGnhGY/GOjCqo91QStrD6AOHpBKZ9/O0BMtu1WOSCm9uHC/xliKM3uwqc+PtxtAsuyf6Hiy39jH0v4/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497366; c=relaxed/simple;
	bh=eDEEz0vt3dv+Jo2Hz2ZFuyN1GgIyXSje5S5MFDCH8r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQCuLAgJ6O/C6dPjCe87XpLHTptIqGxv2PCIFUt5vAPi0temV9/jxihoORFS/Ptt/KEmbOb5dN0nL0wgoAbKxN0Mmjc6jvP/lAn44Yv/fKEUxUSRJ4X00cnsRv/VhDi5LTlsm81405PZDvkren48jrq+HOrZIBRC9UR7O/Y3SYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGVwTUEG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGVwTUEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D927FC19425;
	Wed, 29 Apr 2026 21:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497366;
	bh=eDEEz0vt3dv+Jo2Hz2ZFuyN1GgIyXSje5S5MFDCH8r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGVwTUEGS1sYLq/4czDmqkj7k+tgCjVAOKKbjuysUNo5fr1n85oUG07mPNLKw/mG6
	 1DUZMDZ6x6T5HHSnxIifcX8XasCJbPsVJBN+TNNI2IDzsqzaWA6Wix4tv0oMl/6+AH
	 c7fiNT3CcHXGrADyBJ2j8K1yBABpkReCNOKhjz3tcKbNYqJj3lIfBd3vdrkZ7QQ7x/
	 t3yhEccUW4Fc8H4McnljTY+srxbMB/yRSeefjcoZqHN3SYnh0IwTXBgKkN3zMooGP7
	 5Kbnld/l2izOgwcTMpAZ416pulhwHz4d9XWvkNA5+WNFf524v94bmF+RtemLvVfNfp
	 MzPN4srUOOLhQ==
Date: Wed, 29 Apr 2026 14:16:04 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afJ1FPuFy_rQgSOY@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-4-minchan@kernel.org>
 <aesiYAumkLCyedf0@tiehlicka>
 <aevzbx_Pk5Cu5exa@google.com>
 <ae8KD_Tq0t7RvUy1@tiehlicka>
 <ae_dRZ95dCDTTxaQ@google.com>
 <afBbRUaGnE8WZIkY@tiehlicka>
 <afE2xchFRh2xARBn@google.com>
 <afHAi0E11D5sg_9y@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afHAi0E11D5sg_9y@tiehlicka>

On Wed, Apr 29, 2026 at 10:25:47AM +0200, Michal Hocko wrote:
> On Tue 28-04-26 15:37:57, Minchan Kim wrote:
> [...]
> > >From be4bd22a100ed6be2d1d2599ddb9da04043143eb Mon Sep 17 00:00:00 2001
> > From: Minchan Kim <minchan@kernel.org>
> > Date: Fri, 24 Apr 2026 14:27:08 -0700
> > Subject: [PATCH] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
> >  flag
> > 
> > Currently, process_mrelease() requires userspace to send a SIGKILL signal
> > prior to invocation. This separation introduces a scheduling race window
> > where the victim task may receive the signal and enter the exit path
> > before the reaper can invoke process_mrelease().
> > 
> > When the victim enters the exit path (do_exit -> exit_mm), it clears its
> > task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> > leaving the actual address space teardown (exit_mmap) to be deferred until
> > the mm's reference count drops to zero. In the field (e.g., Android),
> > arbitrary reference counts (reading /proc/<pid>/cmdline, or various other
> > remote VM accesses) frequently delay this teardown indefinitely,
> > defeating the purpose of expedited reclamation.
> > 
> > In Android's LMKD scenarios, this delay keeps memory pressure high, forcing
> > the system to unnecessarily kill additional innocent background apps before
> > the memory from the first victim is recovered.
> > 
> > This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> > an integrated auto-kill mode. When specified, process_mrelease() directly
> > injects a SIGKILL into the target task after finding its mm.
> > 
> > To solve the race condition, we grab the mm reference via mmgrab() before
> > sending the SIGKILL. If the user passed PROCESS_MRELEASE_REAP_KILL, we assume
> > it will free its memory and proceed with reaping, making the logic as simple
> > as reap = reap_kill || task_will_free_mem(p).
> > 
> > To handle shared address spaces safely in the auto-kill mode, we bail out
> > immediately if the mm is marked with MMF_MULTIPROCESS when
> > PROCESS_MRELEASE_REAP_KILL is specified. This protects existing users of
> > process_mrelease() from behavior changes while preventing unsafe reaping of
> > shared memory.
> 
> Please explain why this is a different behavior from the global oom
> killer and how do you intend to deal with those mm shared process
> groups. I am not saying this is a wrong behavior but it will be hard to
> change once in place.

Sure.

> 
> > Fundamentally, this allows process_mrelease() to trigger targeted memory
> > reclaim (via oom_reaper infrastructure) quickly, even if the victim is
> > not yet in the exit path, while reusing existing race handling between
> > reaper and exit_mmap.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> Other than the above looks ok to me.

Thanks for the suggestion and reviews, Michal.
