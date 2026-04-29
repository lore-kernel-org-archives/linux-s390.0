Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B03A382D
	for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451153; cv=none; b=Z0hgtTxAZnKMnaVvIZFYAMYdocAmWSWAjjM8kjBRtFfV7aA997MeRDtmuHMYhKa7pyg5T/gu+hWb70SpE7KU651SsLUy/m6R4txH1rFSmTJ/HM6XEOXc0bTgkSd8bjyW0QyRH3l/EaMKdfX9TYFSVS9ssNWBV0EWxa1d/lpFFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451153; c=relaxed/simple;
	bh=+tpUQisjen8Gwmt1CYAmzHpIbM0Er/xztnTt3NR51sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0mZ19SmYYj52R5BDD81xKuXgppKu1AgSp9UKkoQSV85YdTRR7ZP9o5iF0focguZuqv6+Oq1tjsoG7xqytaOB9bjxhwUrhMfTmaz9xydtJMt91EGhGnjj8wcdexENP0/Nw9doTCBJKpjpnmetJyfNz/UFcAfKb24m54d6oOVnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W+hLOkel; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W+hLOkel"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so9992471f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 01:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777451150; x=1778055950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xevsexu3UbZ8Pxbz/hjTHebmPREf3aJf4+wnjlsTUo8=;
        b=W+hLOkelS2fk8nkXfkTjUlJSvlmpTnh+k4TUold91FnUgHpNEY7oDYkAnG5RRMz+yC
         aAFn8GzXpU42aaxZmh3s1cwMTIZJ2rGdRyqA7lMNViTNDuOWxLSVRd2B15tONmFY+o1u
         9KyG2Gj6dhOcg34sjBc13phUPEs3Yd6/PUzC02XpGGJkw1IUC53+mL1ui9kd4kx1/1Mp
         u6s7KmWKRrIT/ttXyBUxqEko0En9QrxoMLJvcXadKWrmgXZiYG7yn1W80VDnG0XWmKH1
         8GXT0BdncWqp0sibgjQummbGw+pV6EKL6ZiKKUr6eBxQWedGP4qiVAE3xcpGWZ56PbFV
         WRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777451150; x=1778055950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xevsexu3UbZ8Pxbz/hjTHebmPREf3aJf4+wnjlsTUo8=;
        b=BroKGj7lyUthB4T7I528o/X1p5bbjEXJQuh2DsMOjqLOWmorOzZdB3wACbbSgO6wcY
         HiZrdka4XPfDhaVH53Rqv9x/4EcCUCB0RopDr3xdmFg1hyGtwNSuQLgRFz1ONmSAySsz
         GHIwtjZr8HnJaDfbE/Jqvq0wali7a7o42Ns4ZHSGM+fXYGbuP7rXPmnGJukGCInf+1W8
         5/U/JmIzR2lr02yuj8WQYTJw6DQhEoif4pD/ou4PHr5h+CqZBLT7jdnbqEOjQ8YzmT6V
         71PjjGc/jNnbCuXhKrmX3QkICRFGBXCi2ral6ePjcX5BLzPNTye7DMy8uE+4oWM35hmb
         FtXg==
X-Forwarded-Encrypted: i=1; AFNElJ/4OQXx8rlo5Mcm15GPqJvRsdGEh4FO+dweRxq4ASi2xHKV7sRsmmO376uHQEXxtm201Q1YEU7fBjgP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dXYmQ22sgyv3SNr7UMBorh6XUEzlxvZuGhUYPAwY3kiq5A5U
	R7npi4zShhZtoYMAY3vGWjLgnrUzF82PFWtzlmMwEDQnMUauiseL0dkvkxjr6JTMCos=
X-Gm-Gg: AeBDieuwPFpYwdXfU2y9sXG70CpV8Ngy8UP/kKV5rL8RcEiO+p+W+R/A70XcC4l9Y0r
	OfLfOqaStsUHXXOjU/3mmZMZPwuhyvnoT0OVBir71dQn8cBNIIedPu8nmqYgXUxyK5lSsS2QzJX
	a6SmirBxYYBN3RpvykANTtymsFC1GdM98JZuqKWwVZGQdASfvk7E9oQ4he1c9AmszL95o7M0Xzj
	cLuVU6EkOUPe6M1Ngw8udASENmSw0xLDQPBJzoCL0vXV651xjDe+UyE/ClUqypJ2tgo3DCwytn2
	NtOXMV/qfJzRgWmHhW6HUJyu6QDNEGCDoA9PPJ/dyAfuR/CzpdIZtxrlrJgSKDM4xe9nMLBVOAX
	BhzOU97Y9rdSqMR2TYBO/orEGmkynOKK88w0sSGng7YT4zvqNTkcciCewnxZA9XYM1e8aAizItQ
	6c+ueDeiyHeNrVzjNmTrKdpVmeTBZzd06JLn+rnGHVxUeWeMfSgz7Jn3t3/A==
X-Received: by 2002:a5d:5d0f:0:b0:43c:fc5c:aa0b with SMTP id ffacd0b85a97d-44790d12a8fmr4412927f8f.42.1777451149563;
        Wed, 29 Apr 2026 01:25:49 -0700 (PDT)
Received: from localhost (109-81-86-177.rct.o2.cz. [109.81.86.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7217a57sm3805010f8f.24.2026.04.29.01.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 01:25:49 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:25:47 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afHAi0E11D5sg_9y@tiehlicka>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-4-minchan@kernel.org>
 <aesiYAumkLCyedf0@tiehlicka>
 <aevzbx_Pk5Cu5exa@google.com>
 <ae8KD_Tq0t7RvUy1@tiehlicka>
 <ae_dRZ95dCDTTxaQ@google.com>
 <afBbRUaGnE8WZIkY@tiehlicka>
 <afE2xchFRh2xARBn@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afE2xchFRh2xARBn@google.com>

On Tue 28-04-26 15:37:57, Minchan Kim wrote:
[...]
> >From be4bd22a100ed6be2d1d2599ddb9da04043143eb Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Fri, 24 Apr 2026 14:27:08 -0700
> Subject: [PATCH] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
>  flag
> 
> Currently, process_mrelease() requires userspace to send a SIGKILL signal
> prior to invocation. This separation introduces a scheduling race window
> where the victim task may receive the signal and enter the exit path
> before the reaper can invoke process_mrelease().
> 
> When the victim enters the exit path (do_exit -> exit_mm), it clears its
> task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> leaving the actual address space teardown (exit_mmap) to be deferred until
> the mm's reference count drops to zero. In the field (e.g., Android),
> arbitrary reference counts (reading /proc/<pid>/cmdline, or various other
> remote VM accesses) frequently delay this teardown indefinitely,
> defeating the purpose of expedited reclamation.
> 
> In Android's LMKD scenarios, this delay keeps memory pressure high, forcing
> the system to unnecessarily kill additional innocent background apps before
> the memory from the first victim is recovered.
> 
> This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> an integrated auto-kill mode. When specified, process_mrelease() directly
> injects a SIGKILL into the target task after finding its mm.
> 
> To solve the race condition, we grab the mm reference via mmgrab() before
> sending the SIGKILL. If the user passed PROCESS_MRELEASE_REAP_KILL, we assume
> it will free its memory and proceed with reaping, making the logic as simple
> as reap = reap_kill || task_will_free_mem(p).
> 
> To handle shared address spaces safely in the auto-kill mode, we bail out
> immediately if the mm is marked with MMF_MULTIPROCESS when
> PROCESS_MRELEASE_REAP_KILL is specified. This protects existing users of
> process_mrelease() from behavior changes while preventing unsafe reaping of
> shared memory.

Please explain why this is a different behavior from the global oom
killer and how do you intend to deal with those mm shared process
groups. I am not saying this is a wrong behavior but it will be hard to
change once in place.

> Fundamentally, this allows process_mrelease() to trigger targeted memory
> reclaim (via oom_reaper infrastructure) quickly, even if the victim is
> not yet in the exit path, while reusing existing race handling between
> reaper and exit_mmap.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Other than the above looks ok to me.

-- 
Michal Hocko
SUSE Labs
