Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73EF35B639
	for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273365; cv=none; b=EI9+/C7vFVdMVx0DtdGJFaTgxFb5VEFEJzRVtvJkdXc9Ubwvyr3PrpgHUDV/2402BW/4O3ZJoG6oqH2fqqsFMnIfI1A5lMtTcD8ebpvF0YJevADxgGWCPylRvPqeRAJ7qON/dehhKt6m6VMps5hQOIsROEBAKL0e2iBX7/AebbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273365; c=relaxed/simple;
	bh=O1Neb1cMq/5Ua5L4bvOIeXlM5Z9FvKq8FR62IYKwOkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wkgfyk+OC8pFS62utIf32AWc9QKkf/q6ee3VLkFmqHLuuZcvDu7SU4hz6xyYDNuYbIJu2VJ09uQt3h15jEGWcG6PR+/Wklkgdw77AwwxZnQ0x/ffxrGo1AK8GF4H1uDTaz7akb/ets2xPgPd+ZxLvegCWLlkU/yRgcqjXSOh2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M7JxHddX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M7JxHddX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfbd17589so7789811f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777273362; x=1777878162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+yQBCe0d4ZRJ5bPsrJ9MMnmzAXjuvRB9nOtpkyNZnw=;
        b=M7JxHddX8/5F//QExpiNaZplhwQrbE2mIPMx8dfxHrxnn5Da0wIyLM02Eb37ZhQidv
         wg4pcX2r75cxvrl08f82T9Se4kpsFMEPeYJvvOuchWTR4yMx40elgmATLiBNcr++CfPc
         zu6hDSuVBeEX1/xOegxBt00ah0stHaGmIXwE9tBcXBZpSFmlu74khvWtVEQyjOhqm2ir
         P/1KHGMMTdyAVY16+qtH6M0tq8MQUS9uwnKvgMMMJ/0WST8tmB5yHyzDGENVxxNvPji9
         sr6RCTynTwfxcYkiDMmFKSJISlrpvmeOrlfNVsV7Pp2heCeiilTN1c1ewGIyY1ZhQ19Q
         /ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777273362; x=1777878162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+yQBCe0d4ZRJ5bPsrJ9MMnmzAXjuvRB9nOtpkyNZnw=;
        b=LIgkx+gtjc8ZhaI7Zxk0ei7yDow5dePwU1a+nfWKSm2LhXpRmJje3CreznrIIRwm1B
         tI0FS5Iz4x8WoNopj0VFiBCI2UsN3+thFZqmG6dtQt8cgiPfh21yFifWU41Rncgm61iO
         Hm5xt5uwXuWV99iwcKYg5FYmryloGwu5UtPHFlTKnMj/FMKNvMKuDRAJiMTYVzTqvUea
         d+ATNCEpYV389gDIpEJ0LN5bqoCLhFNha1OlNdg386c8OeKDHvD9xqZ7WfjB7pYCsVa/
         NDxxLlPItjuYfSSHAYhoPap2yYERgV+VLh69lDStLTVPZSPM/Ec7YO/1bdA3FTxsQA4x
         VBVA==
X-Forwarded-Encrypted: i=1; AFNElJ/AyklPuILLnFxCqqQKX+SXaw6joqNZLF2gtlZ+Az81h6zFOVA78W8sTh6QTtqeU9pIS9mTTeaI07XO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw514DmjRQhQLGWqxdUX+x82ueRRCtpAqWLR0sL3S0xfBJ2xDpv
	ZTgk+H5XQEHgU5b4sHgPz9LSBjWfPeYOI7M8p2D5+9l6bIzltcjZOZxT78FhOgug2gI=
X-Gm-Gg: AeBDiesPYTBXnKORRq7x2WHgjkIrbbDWpvHcJbBl1TNQexdGwp55gdFz3lw9G7EBTh3
	qWXeXrBLnw3sMnRCgQGnbk+ClAG+Yzv5RjtlGLxqrZL/n0zQVESwIh9NK3qxV/pF/+Ott+31HwM
	11Q/NhpyIriQamJ95796ldZ+n6vRoHbVNkE4ZpdbrwqND4NslEM2WeC2l1+kdVOledU6Nrb6utl
	aatNV12ZlWv/tzWmKboIsA3cKvFHopNSXjHOBlypTHMnEjBbPCdEv2aG07Wx+a7nDIO5jR1EdmQ
	CGchijjdGYkUFbAJvYkSwDRR4yrZwiATyOFtHl+1W076bWoqboYLUSPRgN7bhGoG1R9/pcQnAeO
	37ZZqDuA17cGc0RLkSxtjb8coM2f/WeLc1vIfe5ugd4DNimKGAjCHDp+nH3H2VZyl9wDMkJWPtA
	WxuoKtZdP4iSfHzgFiLkuzLcL1B8r3fytoYUb4OfR2HdTJFh8=
X-Received: by 2002:a5d:64e7:0:b0:43d:5ec9:246 with SMTP id ffacd0b85a97d-43fe3db2d0fmr64773276f8f.12.1777273362099;
        Mon, 27 Apr 2026 00:02:42 -0700 (PDT)
Received: from localhost (109-81-17-171.rct.o2.cz. [109.81.17.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm79101146f8f.13.2026.04.27.00.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 00:02:41 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:02:39 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <ae8KD_Tq0t7RvUy1@tiehlicka>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-4-minchan@kernel.org>
 <aesiYAumkLCyedf0@tiehlicka>
 <aevzbx_Pk5Cu5exa@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aevzbx_Pk5Cu5exa@google.com>

On Fri 24-04-26 15:49:19, Minchan Kim wrote:
> On Fri, Apr 24, 2026 at 09:57:20AM +0200, Michal Hocko wrote:
> > On Tue 21-04-26 16:02:39, Minchan Kim wrote:
> > > Currently, process_mrelease() requires userspace to send a SIGKILL signal
> > > prior to the call. This separation introduces a scheduling race window
> > > where the victim task may receive the signal and enter the exit path
> > > before the reaper can invoke process_mrelease().
> > > 
> > > When the victim enters the exit path (do_exit -> exit_mm), it clears its
> > > task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> > > leaving the actual address space teardown (exit_mmap) to be deferred until
> > > the mm's reference count drops to zero. In Android, arbitrary reference counts
> > > (e.g., async I/O, reading /proc/<pid>/cmdline, or various other remote
> > > VM accesses) frequently delay this teardown indefinitely, defeating the
> > > purpose of expedited reclamation.
> > > 
> > > This delay keeps memory pressure high, forcing the system to unnecessarily
> > > kill additional innocent background apps before the memory from the first
> > > victim is recovered.
> > 
> > Thanks, this makes the motivation much more clear and usecase very
> > sound.
> > 
> > > This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> > > an integrated auto-kill mode. When specified, process_mrelease() directly
> > > injects a SIGKILL into the target task.
> > > 
> > > To solve the race condition deterministically, we grab the mm reference
> > > via mmget() and set the MMF_UNSTABLE flag *before* sending the SIGKILL.
> > > Using mmget() instead of mmgrab() keeps mm_users > 0, preventing the
> > > victim from calling exit_mmap() in its own exit path.
> > 
> > Why is this needed? Address space tear down is an operation that can run
> > from several execution contexts.
> 
> Agreed.
> 
> > 
> > > This ensures that
> > > the memory is reclaimed synchronously and deterministically by the reaper
> > > in the context of process_mrelease(), avoiding delays caused by
> > > non-deterministic scheduling of the victim task.
> > 
> > The memory is still reclaimed synchronously from the mrelease context.
> > This is really confusing.
> > 
> > Please also explain why do you need to do all that ugly
> > task_will_free_mem hoops. Why cannot you simply kill the task if
> > task_will_free_mem fails (if PROCESS_MRELEASE_REAP_KILL is used).
> 
> I wanted to handle shared address spaces.
> Even though we are okay with the target task not being in a SIGKILL
> state yet (since we are about to kill it), we must ensure that all
> *other* processes sharing the same mm are also dying.

Then just bail out when the mm is shared accross thread groups, rather
than kill just one of them. Or kill all of them. There is no reason to
play around that on the task_will_free_mem level.
-- 
Michal Hocko
SUSE Labs
