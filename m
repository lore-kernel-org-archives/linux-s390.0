Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7D48094A
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708466; cv=none; b=f+GaVKhqYd0+mmQfdmH5tfEYyRB6gqm1G3FRWyFAY3MGYPdltY//tgkBYvDEas5I3vNW/mfLp+oIOXNdUhl8mfRPkLCu+53AJ9tIFi64LzSWUStbwoXxX9eo1mfa5q3FfsRRTRuLK75cjFkWKZCiR55E9gwSQbO1UpQccHn2ifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708466; c=relaxed/simple;
	bh=60tCguXfasSLnq2qNjGSqHclzlUluPht/NjMIlRSn4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m8njVo1lA60pNWoXRaJbbYjkUW+oE06nqVSQjcFCkFhXRDSaY7/NYSP5AlYRp7uoRekxuF+8iAAy6FKSxnwvFO44EXZx4Tf1eZxCrmOx+kk0t9Kjyy+fAsA7+ZuWuyxRtsFaj0hRQXAM1QKd6PkjFfbEwlG8LczOvqdWn8pHrz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh/9IYXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh/9IYXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE991F00A3E;
	Wed, 17 Jun 2026 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708460;
	bh=oFkjVM33Vy9NnhfoQ1NeNoAO/5xQa6vpy034gOemXjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bh/9IYXR8eUQ1lD8BPddc3Q2xqTc26Ia3bXOFu1AV4sA/hug6v+jCj2vOoJtQfhCO
	 qWoUeUne42gjv34SbEHCGyec+qWjKlJeAZ7AJSzC34NwKsfwyo9FdiC+IH2cLQkqjY
	 gMNJNm9as7DpVLvi1X2JN6EJblYIW3CeB+JmXECOeklbggCrHWTLRsktBI32QSGD3Z
	 g4sPCuYYobKuBVojdDbWb04dSdiuOjidAto2fP9CzgxVnJ/gLwlFvINFSlULEZO27E
	 6zolxWqOcP1v6M4sX0zLXJoZeecgDEAHGT9Jlx2iFs33/SN3LG/ZQ7VTsJEx00oKEO
	 EkRwBcuLkgeBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next] s390/idle: Add missing EXPORT_SYMBOL()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260617145313.3910957-1-hca@linux.ibm.com>
References: <20260617145313.3910957-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:00:59 +0000
Message-Id: <20260617150100.5EE991F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Export License Discrepancy: arch_kcpustat_field_idle and arch_kcpus=
tat_field_iowait are exported via EXPORT_SYMBOL instead of EXPORT_SYMBOL_GP=
L.
--

commit 53dd63a70164da468386d3191eb1e7e24af1b440
Author: Heiko Carstens <hca@linux.ibm.com>

s390/idle: Add missing EXPORT_SYMBOL()
   =20
This commit fixes a build breakage for the ledtrig-activity module by
exporting the newly introduced arch_kcpustat_field_idle and
arch_kcpustat_field_iowait functions.

Closes: https://lore.kernel.org/r/ajKsG0JP6qTssQBX@monoceros

> diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
> index 7f7851c001e0a..6da8ee22a1d53 100644
> --- a/arch/s390/kernel/idle.c
> +++ b/arch/s390/kernel/idle.c

[ ... ]

> @@ -83,11 +84,13 @@ u64 arch_kcpustat_field_idle(int cpu)
>  {
>  	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !nr_iowait_cpu(cpu));
>  }
> +EXPORT_SYMBOL(arch_kcpustat_field_idle);

[Severity: Low]
Should this use EXPORT_SYMBOL_GPL() instead? The generic implementations of=
=20
kcpustat_field_idle() in kernel/sched/cputime.c are exported as GPL-only.
Using a standard export here circumvents the GPL symbol restriction imposed
by the core scheduler.

> =20
>  u64 arch_kcpustat_field_iowait(int cpu)
>  {
>  	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, nr_iowait_cpu(cpu));
>  }
> +EXPORT_SYMBOL(arch_kcpustat_field_iowait);

[Severity: Low]
Similarly, does this need to be EXPORT_SYMBOL_GPL() to match the generic
kcpustat_field_iowait() counterpart?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617145313.3910=
957-1-hca@linux.ibm.com?part=3D1
