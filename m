Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5A309DD8
	for <linux-s390@vger.kernel.org>; Fri,  5 Sep 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063349; cv=none; b=ok55M3MBaiKjQIL9itEHksVYf9Nd7gntQglwad95whRh7Hjef4iD+pgXv9lFJ7By4ajRguiEGtz4qXbISG2k7yLtB+WvHe/jxpK6QW4RyHWcF45x4D5zRfxq8R/y8ncAxlQ+rZM44IM29xtlsfX4Vy3vxEqve81EfbehO9BG6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063349; c=relaxed/simple;
	bh=7Lq3qMXShfmBDk3ScmH45ToYpqdeDRbNuuuQpDGUbUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mSCAP7aa0uIJ3ar2eN0TKJWQb3pOJvoQEQaD/3sOxyHDHV3cOkrhgvod/htMO90Siuv1Rsf/gseO3ykhy04A41QgIC2JjPrSwkJQcBBWE5qels6RBe354z4AZP5beJ/OOi0ffjJOekWgZJZZsiOB/kbYp4a9QFJomYselCpsZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ScCTqce1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ScCTqce1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so13645825e9.1
        for <linux-s390@vger.kernel.org>; Fri, 05 Sep 2025 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063346; x=1757668146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J7GrTx5OAH0jMmNOM8g0SLGoBJRngIK/hcbD1dJzJHo=;
        b=ScCTqce14k01HmfYs3wHrMyvUIRgKddUp4NddEcMTycJ7ihrlrNSUlKV9pvRe7/3Ni
         aJQnJzB0gOjABjKfHArDtBcyQUJbFhWgDXjCp1nPiQSNYfNsV2lA1f+wWVKVCrqTy/vj
         wtHcAP4PFaUdl/sw5YVz2I3/o5/SoqbLYF4DRiF44+y4+LAQkVi90skb9nLh5jjCcK6j
         Ma515EWoTO/L0COOAteblpJIssVWIIae9NXnCu2PgTqcnErDlCV/2A7BGXrcM47UVDMM
         xu1bxbcBktKgNotn89dc122usb4VQ5fkQD+Jru4uniuWO6HDoJU0GyXYShuVfiuDsQZY
         f9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063346; x=1757668146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7GrTx5OAH0jMmNOM8g0SLGoBJRngIK/hcbD1dJzJHo=;
        b=gsolnH4FKR0BwQ06YTwyknbGFVA1GSL8lKsKDA//XaO4nXMTVaOJQ1urB+118RnXZn
         1N03lx7dSd7a6qEPF0b0EKR/b61Hv/ztPOAsgc4VCDy/VfCTrWz/Fb37gJK6lUH3RUQc
         IyoI/HVJFbuAeWGy82PthJoHdyCWGRIGb2B2E7Cx1KjjmSTQHDiLpdok9OQ/lqFYr9Cl
         5SHwrSw/jOMV+XNtGr8+w8G8yyhKr/av7RTABgZEqXeTPE/U7IF5kNAc2UzfghJINjF6
         oo4aiaYzUAhUeUdYRbMkAxR6bstrGFKk3+GY7GcuWzM2N2wa4Bb/dKDrrpj9uerzijyT
         Mnkw==
X-Forwarded-Encrypted: i=1; AJvYcCWM58jwm1I9964wZyn5OUbx6VlnR7Sms0piseHe1O4NxRlb7JizE4UFOw7DWDlIgNBgv6zolghEIV6u@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFf7shysWrY/e6U3mV+B2UaNLeS071VJnVhNMeoxQ1mLEQ/69
	wERAc8D/aPkEZHh/5kDjqa+4w7KLfDaGFJNYB+CljnPTvBbhNdMQUmUiQMo7aS6V9aE=
X-Gm-Gg: ASbGncu4z/AfQt1ewnjK8e9Qlcl/Qe4V4u0itqksdLxPmPadQog5OdqLbpwK/Q285PE
	Jh7YGO5lFKgTawCgxvvc56HgYJeW4r0CpVOQ5WbvyLC3oiSwxq3j2R9HQlSizbez1nYLlFSb+YC
	nxs+S5LP7lbL4qCE227JWUqbSbxf73rTtTi5iaVwdPt/HmbdBufPldJeW4DvYh2XdJn7N7FD08k
	7GMo6FHfrxHGfZheEYpcgCcgVyRB8o3SZCNyl0wysIbm+4kTvs/bdTlHHi/Te6CJmLt1eRE8jwR
	I7ym2Tq3Cx6FMPCEYvr1rOrwruC6U188UpfqVF9Q04Ib3+DnmrYmprJBP+dFZDedq0gld3cv7p6
	xwhp8nL4zxPn7vTEBTvqBOcA6UQSme5tOvLa5Ye0t101FLDweMCEV5+fmcA==
X-Google-Smtp-Source: AGHT+IGFAkAMNWLANszf5sfV5IIK/XFKx1LcXShCkOWPlYc7igvx9YUxhH0uGtBFRkNHjHYd+DFmuA==
X-Received: by 2002:a05:600c:4fcc:b0:45d:d19c:32fc with SMTP id 5b1f17b1804b1-45dd59d2f76mr24210995e9.10.1757063345990;
        Fri, 05 Sep 2025 02:09:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda6da5casm12931995e9.7.2025.09.05.02.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:09:05 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 0/2] s390: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:08:55 +0200
Message-ID: <20250905090857.108240-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq.

2) [P 2] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. This is actually enforced warning if both or none of them
        are present at the same time.

        WQ_UNBOUND will be removed in a next release cycle.

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (2):
  drivers/s390: WQ_PERCPU added to alloc_workqueue users
  s390: replace use of system_wq with system_percpu_wq

 arch/s390/kernel/diag/diag324.c  | 4 ++--
 arch/s390/kernel/hiperdispatch.c | 2 +-
 drivers/s390/char/tape_3590.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0

