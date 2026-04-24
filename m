Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD682F25F0
	for <linux-s390@vger.kernel.org>; Fri, 24 Apr 2026 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017448; cv=none; b=NvXZtNss7nlMptlUHqg2/ncNQGHzc6ClQyFBa+vmK4a9GrEXCo349bh5AT7bmZZtd6mCBmmyvTeBC87HmNsnNjKwlH4MFKoyb8+mLeNS0vy3b1/tZOM6sfRsr7iFzIXhlQ46+xF27ltETTfGjYJkkmxxDtWM7SFyMYGRMPVBT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017448; c=relaxed/simple;
	bh=PIeHOAwGv7BR2+lUgKRtaZEi63/Z6vyq4F9Xa9F8Rio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPEF1yuJRFUwK6W2l7JS9DUIKj6tK2sUnzVYRVv48IHw2J5X0LLCfze3PLuk/tUM3zTyrus4bHxEQvB9fL7wWA7NxW9LPS7sIbebDuJxnxosZZiC3YczNWnZRUoknMks1RVVgvKyziTrzHpOC7V0eLzdKigRkq4lksAHFqv5S7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c21f8Acl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c21f8Acl"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4411e1eba51so4066136f8f.3
        for <linux-s390@vger.kernel.org>; Fri, 24 Apr 2026 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777017442; x=1777622242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQWnF9NzCxgEjMbfmZKZ7IVW4SmCDS5kYe81JwXOOKY=;
        b=c21f8Aclt6aiqnDVWqWomBX9AbFYWVgPJs9lJOWJLIjBJhP/5Pove9nLakDpOJ2d/9
         IMcUzmePKPz7EYoNbcVjYas9dWVNPdrhqqW0YZ45+XVkX12pE2eunK8Xy1GFxQd0yi+g
         7L3IPno53KfUY8MacNHAIe70ER4s1evFGUawKdIeoqJRkcJcj6azUPUL6svNfHelnzjz
         x/kBJt9VNSeK8HyYtDl2P8A1Il2rBO6Sj5PhKwpEzuW5/efFSAjBg5gDVcnj9cTciPjm
         jDF4PVhO8+QvDLSbxcL69GYIoEBsJUF8iaOjPocM8bL23mtCRhWlGis5I7wr0xoTD5Fs
         PVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777017442; x=1777622242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQWnF9NzCxgEjMbfmZKZ7IVW4SmCDS5kYe81JwXOOKY=;
        b=OFSYb05QykBz0nx8hcA+LVF6FpkyZ/vlBWdos8PDxMGEYehVXIdS4RMugwUBKj/OD4
         6kqSSeaKeDvD43ncHbQhFdpRCCMKjyMX05YbrTxi4Lh2Bjt7xNKFrzOYtD2MoTeOyY1z
         WZNrl1TKlJzkTVQrvwZEbDMMuODkNU3X4gXOhKgbmlFYYople0O6NBUmfRbw+rPCBUt9
         nK2RUPQLG/MHDFZc5tX1WrmrdDSoZeRPnkpH4yYsyQEojvEnJ3OO/SLTHPwZuFXOkk7C
         OHrhSFf1932IRb61mEDI1dDUNpE3liL+16w3Mxi4QkvsZDdwu0kioVw2xaVeVIPhYmYE
         PEdA==
X-Forwarded-Encrypted: i=1; AFNElJ8L1G/DUOzFzUY/0ibpBhgtaZC5ecnqrIPa9N/wWH8wfj9pGHB213BGzg9zJMGV1ODaV+JyUoyF6gGs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9aPMauJ9GlmbT3k2rlIo+C2+rgSubPd0i1kNDRqreKQ5g6rtP
	aNOcjRa5iMt4aY+wWgzccBgkelgCwKwb/2gvvWQiM5qisE76wQdF/IHwkrd8PxJwRf8=
X-Gm-Gg: AeBDies7MGzi8MtEWLRRNSuQwqLLXNE2pXBLsEk0Rg6zrbB7br8eD7tBdG+jf+MoQ+l
	qE16IZo3yrnkwLlNc/94ypPHiGeD4bGZaCkhiPV/YAS0f2gw7HQ0aGbSuz4jrqZ2tes72JwGenR
	1ehgMn0nPr2pGmpEw6s11D88wkEleNxWTr8N+SXr+h4EQQAGmCRtpCI/uaNPzn5ewsy6MFjP+zS
	OwX0sS96xZbXy9pYvq0lZ3ax0O0+NngONpZoQ67ZfJ+RRcTJnG0jgnQcNudopDZRu/5uS849Grw
	GVWXYw9aDPeQYXDZ/MdCZabqgZq0WgQhgUAksxnisBG1DHI2sl5KPae3Sa76BpWLlqQAx4XVoN+
	wzbz3VqcAHAlVLMoO3DAAe0bwhSOSLQ4XcnOiiSpcieMgIXPCnCPGulmZm58XEyN5x6RIZm8KJ7
	UUuiZ5hA2JoQukQeC9o2gu9aE0G6xMkrnvnIQQopXfKwC2xPY=
X-Received: by 2002:a05:6000:4283:b0:43d:73ff:fd59 with SMTP id ffacd0b85a97d-43fe3db9bc9mr46929495f8f.10.1777017441623;
        Fri, 24 Apr 2026 00:57:21 -0700 (PDT)
Received: from localhost (109-81-17-171.rct.o2.cz. [109.81.17.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0d51sm59342251f8f.10.2026.04.24.00.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 00:57:20 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:57:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com, Minchan Kim <minchan@google.com>
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <aesiYAumkLCyedf0@tiehlicka>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-4-minchan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421230239.172582-4-minchan@kernel.org>

On Tue 21-04-26 16:02:39, Minchan Kim wrote:
> Currently, process_mrelease() requires userspace to send a SIGKILL signal
> prior to the call. This separation introduces a scheduling race window
> where the victim task may receive the signal and enter the exit path
> before the reaper can invoke process_mrelease().
> 
> When the victim enters the exit path (do_exit -> exit_mm), it clears its
> task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> leaving the actual address space teardown (exit_mmap) to be deferred until
> the mm's reference count drops to zero. In Android, arbitrary reference counts
> (e.g., async I/O, reading /proc/<pid>/cmdline, or various other remote
> VM accesses) frequently delay this teardown indefinitely, defeating the
> purpose of expedited reclamation.
> 
> This delay keeps memory pressure high, forcing the system to unnecessarily
> kill additional innocent background apps before the memory from the first
> victim is recovered.

Thanks, this makes the motivation much more clear and usecase very
sound.

> This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> an integrated auto-kill mode. When specified, process_mrelease() directly
> injects a SIGKILL into the target task.
> 
> To solve the race condition deterministically, we grab the mm reference
> via mmget() and set the MMF_UNSTABLE flag *before* sending the SIGKILL.
> Using mmget() instead of mmgrab() keeps mm_users > 0, preventing the
> victim from calling exit_mmap() in its own exit path.

Why is this needed? Address space tear down is an operation that can run
from several execution contexts.

> This ensures that
> the memory is reclaimed synchronously and deterministically by the reaper
> in the context of process_mrelease(), avoiding delays caused by
> non-deterministic scheduling of the victim task.

The memory is still reclaimed synchronously from the mrelease context.
This is really confusing.

Please also explain why do you need to do all that ugly
task_will_free_mem hoops. Why cannot you simply kill the task if
task_will_free_mem fails (if PROCESS_MRELEASE_REAP_KILL is used).
-- 
Michal Hocko
SUSE Labs
