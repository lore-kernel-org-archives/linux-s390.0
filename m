Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4852BE7D1
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621772; cv=pass; b=IBQT6spY7ROVeqv//pqgRlWW4pS+lsFGNAW9igLkXKRBqAslhllJDSrqH0YGNksCZ7aA35vu01CoJcZ+TiXTJJleva2qXDbq/diFkREUuLZF9s8JIW1C7TLIyS7pW1Xhr2HvTrPioQ3qbkKvjQnk0v7WSlJ1D2GkEx0IOPZEieA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621772; c=relaxed/simple;
	bh=tNVFIzJVs0+iZMuJrmxC7LemBx7xzRbpwl1nigl6Caw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzO8+VXpOqgN/lW7XRPsYibP9zJK9ai+bD+CHJ+EmqcNWlqMUBAwx2H3QWNW0z824srVf3BVD6nyF8Gl+dJ2xRo4hCcB1dsq561vZ0ph+rT+lWiRXe8pfsLR16rEmVCA9bQAw2LJ24JBXigpk/HaaITJY/LeglTTBWz7qt8eeaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oIAAl11l; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIAAl11l"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c88e5f4aeso3569410c88.0
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 14:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778621770; cv=none;
        d=google.com; s=arc-20240605;
        b=IofDm3ZxlP8s3HVKoeo1nRFSo1uBikgzODOiAdeC5hEawwG7Y/AFXV33YP9Q63r4d6
         xRjWusDu6uRMWVBA2YqvnwpNh16QpqlVCSWpE2YdKz4tpHz2KSHnnOUGffB9Q2sRh7Iw
         QpVmKjvMk1Oje5uSmX7D3A/eVWYUYY9BQiHw64i+N3Nc2LzFUb9vj2wwRoU8RmX7SEbO
         Qx+yWGzBoDPhUoZuIlTssk90SUi9cPOr8josbWHQVhWESnWqiFVoaPth/ozC3xwGL/Ox
         /PWZYSvMGV6pFxVj7F3vo94XuO9WwRYzvC0c0kY9idWnIzJXdJsYTuSyGU4029CHLqKB
         tQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nSfrdVT23xuwz4hEJjcmKT2AG7iJ7xwKeb8ijCFAitg=;
        fh=R2n7dgwXSj2SVC9+gLf08R/VwCZFu2kxj067cG0eCVs=;
        b=FLJEQXVc/9HhuEYYKnQZoBGjgQY9ctMOh7YxXFkgXa27gighvGCDG3/gw+O4VaqOKo
         Cgbj1wqBpGDzxgLbxcT6sFyfhOsA6gUK0EFKD+lj8nBcix4IdcFIHN1PLyjZfSXPvfRy
         fMEgDWKH0MdErNS1vNC62zWVxag5WnQ+kQDs0GkPmXL9F3qy343Z3ajBSekRCqM4xHn4
         jBTRKkK+WbiZuYv38fZZmpz+5VgFzApPGikDiLbwTlgJK/GvMppFnjqjt1p9teUvb5Z5
         w3vl19znnlOTWptjRwXegjET2ldjj5aPXJ8AVXYWlm5zzdfPD9TvrL6goWc4xOx1mwp/
         HT8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778621770; x=1779226570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSfrdVT23xuwz4hEJjcmKT2AG7iJ7xwKeb8ijCFAitg=;
        b=oIAAl11lIikzrQnnaZR9DpV+8+huZvRT5KfEaOcDiMT10kDlMaxgZmr08p5AnUfIkD
         jM5B017vrbfzwMsB5YJEU1bSDks6N550QMJqFNp/KreEioif2FsbQ6+mT2+yiQqtybIt
         rjymbIAkPew90+mrqLu4CCVEnqjOSzZK4zYLRo5VimoxMaVw/sMv0tNSAoihsqAO91kd
         5nk9TtZaS27uQ+pJvjDr5reVMIZFxeKXDJcgDhcI8s3WGWd/DUuCFjx7iTpmbF2E5rRQ
         VxQOFgb/w7llJpvg6+VLES9owv5FwLnTtddK5ugvMU+E2zsruG0EGCVGESncjPp36ewe
         XDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621770; x=1779226570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nSfrdVT23xuwz4hEJjcmKT2AG7iJ7xwKeb8ijCFAitg=;
        b=LgxJOD1bksDmDVyZ64Attifv50wZ5vMxjFt0jG/k/k1q6E2AaAkJ8BZVUrgp+6Ci4d
         mk/6U3L2dH5J9UX5m+lA2G6Sre1jZQL0YgURFYzeRx40w5R8Trms/aXXz+5V9vo11z5L
         XUAoffVt4zK83qQm/QEUEnguIM2W5TetiMuj6tq7+WDLEcMDvCXQX7iJB0NYlFsxodVz
         j2XiveDJemk2pQyb4GYG+vGAGq5Y0SfvEaIhwtXqxfOi5Ufim80zAD+cnaUv1p5ZXrZ/
         S6pMDPpzo11qtz5Re+vD2Tq9v4FYWnQ8WJe+vJ7LaKYNlfnJXt05c+4EpliQY+jALxSI
         P/0g==
X-Forwarded-Encrypted: i=1; AFNElJ8d6KNOLaZq71Tz9Lkq8ngzM/9UYDtllrPovSpLdKlnF2XTzMBeNDc6DOTYy8Lgqio9sqjHYqUfjSow@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5FXMF+eEZkLOnBeIpIRMc7F8MOBLc64H5JvpAMCDc6O98vR/
	0mtWEIAXyL1ALKTs36blTLEB1BS04BO65qLbEPiDKC/rWR0gUKfaxDWwpZ0zTw0VXKOl7mm0BCq
	vW/IkOhhykx3xAg2XQzipSoZnS30dgCRSN09d0cI=
X-Gm-Gg: Acq92OGbT3Y5AmTACnwlaZVBfzrB/Sgqx4Wr/lkti2V7VCosWZGo+uclSOb8AXd0yZW
	oK8sNOUpJKVK5xWvVMjAVw7fWXhJ902LWg0JVPws4v0zrORCd17MSxkqrvfX/rfRYreoNqym8u/
	L7t53Wp09tOgmTm5mI7e3BagMBFzvZc7CMYqAznuF2Lmvm5up1L2MyUaWs3ykudhk/EaT4o1df4
	NKf2u82LO3oFKxjFoy2yr8zFa2ZWKJ8uG9p2Y79bLIQhNxsKD7uVVsJsN2C3OltLAttf4ekJCD+
	HRVcxgUZAhigWrMcNsAcmrYl5MNbyKyi6z5RQn6/s/nr/pi2I0HT3OoetfTRcwbf0d8Ze+CX7Xe
	f+R7/pzgS+3CkXHwyd/2jnbDbfViFZBWOb7xddW5mPKv2ZX99hZIBd0SW
X-Received: by 2002:a05:7022:4a3:b0:12c:81b:c74b with SMTP id
 a92af1059eb24-1333af7fc9emr3319324c88.1.1778621769297; Tue, 12 May 2026
 14:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c00-02.v2.ttenwd4@ub.hpns> <p01-02.v2.g318c298267e3.ttenwd4@ub.hpns>
In-Reply-To: <p01-02.v2.g318c298267e3.ttenwd4@ub.hpns>
From: John Stultz <jstultz@google.com>
Date: Tue, 12 May 2026 14:35:56 -0700
X-Gm-Features: AVHnY4Lea-1Mo6XfoYgaXQAM1WvAL6V2xb41TrcKYtBn0cUfeE49P69xWlqM7sU
Message-ID: <CANDhNCobpxgBJ8ZRxNfXuD_TSmv+DW_3wYCAjJ7yjRa-syL+Yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/core: Don't steal a proxy-exec donor
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vineeth Pillai <vineethrp@google.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 3:42=E2=80=AFAM Vasily Gorbik <gor@linux.ibm.com> wr=
ote:
>
> try_steal_cookie() avoids stealing src->core_pick and src->curr before
> moving a task with the same cookie via move_queued_task_locked().
>
> With proxy-exec, src->donor is the current scheduling context and may
> differ from src->curr. Stealing it migrates a task that the source rq
> still treats as current, leaving src's scheduler state for that task
> stale. For CFS this means cfs_rq->curr points at the stolen entity,
> and the next pick on the source rq hits the WARN_ON_ONCE in
> put_prev_entity().
>
> Commit 7de9d4f94638 ("sched: Start blocked_on chain processing in
> find_proxy_task()") tweaked the fair class logic so that the donor task
> isn't migrated away while we're running the proxy. Do it similarly for
> try_steal_cookie() and skip src->donor as well.
>
> Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_pr=
oxy_task()")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b905805bbcbe..8aed55592ca9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6366,7 +6366,7 @@ static bool try_steal_cookie(int this, int that)
>                 return false;
>
>         do {
> -               if (p =3D=3D src->core_pick || p =3D=3D src->curr)
> +               if (p =3D=3D src->core_pick || p =3D=3D src->curr || p =
=3D=3D src->donor)
>                         goto next;
>

This makes sense to me, we don't want to be migrating rq donors.
 Acked-by: John Stultz <jstultz@google.com>

I'm still getting my head around the finer details of the core
scheduler, but I suspect we also should add a task_is_blocked() check
in here as well, since migrating blocked_on tasks isn't useful either.

thanks
-john
