Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4035540BA
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876479; cv=none; b=idVXdKLFITvuS/fZon2s7y9kz8ii5H+jGDkg20y43qQMsAAxhFdKfECcKgvaH3ToykOFv4p2eZm7KoPQtCR46avyAj3naZ4Q2LzoQEH3vgY8qt4wAZ5ayHq7c5g47KOVreEE2c2Ey2S8zc5ZhnoSKJ4ieY3/eKxzuvAksqkzCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876479; c=relaxed/simple;
	bh=gKqT0ESoT+CNIh+v9+ildB+pEzzNzFqMlicON90kIMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DrMykYoasHLgqpvntO7WQRdh3hm8xuGHwci5G0l2SHIyrWvHOYp/ZhaDyf7GFBPFqHdXwS03WetqoOyQrMMs8u2LhADmCg1Xz2aoZU9Zf6fACu0giqZOuMEaCAdcJmpeI/z2GXwio7qj+AsNnK6d6rafudjUZhS8nBUlfSdBc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1382B1F00A3A;
	Tue,  8 Sep 2026 14:07:48 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/rwlock: Add contention tracepoints to rwlock
 slowpath
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jan Polensky" <japo@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908135843.1384367-1-japo@linux.ibm.com>
References: <20260908135843.1384367-1-japo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:07:37 +0000
Message-Id: <20260908140748.1382B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Instrument arch_read_lock_wait() and arch_write_lock_wait() with
> trace_contention_begin() and trace_contention_end().
>=20
> These tracepoints are used by lock contention analysis tools such as
> perf lock contention to identify contended rwlocks and measure wait
> times. The generic implementation in kernel/locking/qrwlock.c already
> emits the same events from its read and write slowpaths.
>=20
> For arch_read_lock_wait(), the in_interrupt() fast-path is intentionally
> left outside the tracepoint scope. That path spins without entering the
> wait queue, so it does not represent queue-based contention and its
> duration is not comparable to the normal slowpath. This matches the
> behaviour of queued_read_lock_slowpath() in qrwlock.c.
>=20
> The include for <trace/events/lock.h> is already present from
> commit ffa796cc1f45 ("s390/spinlock: Add contention tracepoints to
> lock slowpath").
>=20
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908135843.1384=
367-1-japo@linux.ibm.com?part=3D1

