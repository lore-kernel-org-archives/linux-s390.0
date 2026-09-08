Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A884A49A7
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867369; cv=none; b=LmNeUd7OB91Th7JJyyetWzXQKmPa60hZvggIhaoB+Dum6LD3SBGc3h4HDjji4s7fETj1pU0dNm7P0ogEENGb78X5BWO02Y+qPjYMFU0MUa0sD1bxOwrJyJE/YesHumyw/2PR8wI8xFBKC0FC81eZXEjGPX02oAsR8eDK6EBh6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867369; c=relaxed/simple;
	bh=mmni438exKznkBgfvzOXz7KYUn3e+o2EoMQaU1zJJ6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i5A1orXtEF2spY3ogOQPhCMO76xZ4v9Dl5AEa6d9CBdnHEqRuMvOq4a6dBeQsihPl9yfyqht2KmsshtWq73Plmsg56jBnoh5DK7OQXJHb6pvtPA+Ir54Z5nPcFYI6Y7S9KW+Tbz8tY7X9JAIY+1gfkYqcDZytIMCF5w9Wr6erA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9579C1F00A3A;
	Tue,  8 Sep 2026 11:36:01 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/rwlock: Add contention tracepoints to rwlock
 slowpath
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jan Polensky" <japo@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908112607.828469-1-japo@linux.ibm.com>
References: <20260908112607.828469-1-japo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 11:36:01 +0000
Message-Id: <20260908113601.9579C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling trace_contention_begin() before decrementing the tentative=
 reader count exacerbates lock contention by blocking writers and risks dea=
dlocks on recursive tracing.
--

commit 9f56bec8e5a4a2cdb518e49ae0095e4ddfeee5e0
Author: Jan Polensky <japo@linux.ibm.com>

s390/rwlock: Add contention tracepoints to rwlock slowpath

This commit instruments arch_read_lock_wait() and arch_write_lock_wait()
with lock contention tracepoints on s390. This aims to support lock
contention analysis tools like perf by identifying contended rwlocks and
measuring wait times.

> diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
> index dbabca35c008c..9094617a5e00b 100644
> --- a/arch/s390/lib/spinlock.c
> +++ b/arch/s390/lib/spinlock.c
> @@ -316,6 +316,7 @@ void arch_read_lock_wait(arch_rwlock_t *rw)
>  		return;
>  	}
> =20
> +	trace_contention_begin(rw, LCB_F_SPIN | LCB_F_READ);
>  	/* Remove this reader again to allow recursive read locking */
>  	__atomic_add_const(-1, &rw->cnts);

[Severity: High]
Does placing trace_contention_begin() before decrementing the tentative
reader count risk a deadlock?

If a reader enters arch_read_lock_wait() while a writer is waiting, the
reader has already incremented the lock's read count. If a trace probe
attached to trace_contention_begin() recursively acquires the same read
lock, it will enter arch_read_lock_wait(), decrement its own count, and
block on arch_spin_lock(&rw->wait).

Simultaneously, the waiting writer holds the rw->wait spinlock and spins
forever waiting for the outer reader's count to drop to zero. The inner
reader spins forever waiting for the writer to release rw->wait, forming
an ABBA deadlock.

Even without recursive tracing, does holding the elevated reader count
during the tracepoint unnecessarily delay waiting writers? The generic
queued_read_lock_slowpath() appears to decrement the count before
executing the tracepoint to avoid this issue.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908112607.8284=
69-1-japo@linux.ibm.com?part=3D1
