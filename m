Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF637F01B;
	Tue, 14 Jul 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042615; cv=none; b=ax7j+Klp9fIbMgLaxmzvqkfbtU5gfbDIe6v5HZIvXBQY0ed3nrx/JEIZqS3fLtEHMvC3G5P0RLwRLTgnichv5pu8WjkRU/Vw4bpDu1bCyoszxe+8y33EiP777h9wbN25D4qe50axHdKhVCZ4vGIoROzxHXqTyB+u2tsl+7P55fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042615; c=relaxed/simple;
	bh=Ir7gOd1UlRJzm1DeOhfIp4x+PlGL6grjZeWO05G8H/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmZOeAvSxA2DL932D18+5Ur44qXOZ/odjmj8pbhTY8AlnUCH3Htmq34tJ1KPiPnBcWgozV0rLIsG4L1Fu1lHgcskrO5try5Ats4o/grAtHxbDlyCgDDivp2Iz+sqFJAweDjcKDpVBsu+5GKuacOlMUFHplG/qhvAyNIQR7ZJTvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=NV0vXk8z; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="NV0vXk8z"
Received: from bat.kanata.rendec.net (unknown [24.114.105.230])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 58080C2C75;
	Tue, 14 Jul 2026 18:23:15 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 58080C2C75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1784042604;
	bh=WOpcFbjQEhRjPrDCcWIUFFBWvc4u//IvEcN3XAtJ46I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NV0vXk8zgJRLB4TtiCBgyeC9r0tDdcneBcb9wPunGxkt0IKYL3V3oFKcGY5VDzgyB
	 Qh/m8oD8LhVi1YOubpwGJCzzpJkvbVs+/C7SpT0eBLs6j2D9LC01WQoJevg+YaxeP7
	 Ch7a6ki6Pr+ZxagiEAWxYNM91lMjUP7v7VU8+VBfhBVCnIyf2AfpbY8o00oq1ARHfx
	 ufS87s6adDnBw8zOd3lwsGeZmOenN4AaIMQm9evAXHQOA28DvO+bDbE0lfPGsOErPt
	 xi2vbdX0VrCsKrlSVW9ZFCkHw3ALvgdXIVgUO0XIk014YkUnKwqRZzed8VzIRlFPzw
	 hWwXWveUqEvoA==
Message-ID: <2a8d25c1645cbc570d9da8dfc3043bc9d2f39cd5.camel@rendec.net>
Subject: Re: [patch 1/4] entry: Rework syscall_audit_enter()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Michael Ellerman
	 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt	
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle	
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland	 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm	 <linmag7@gmail.com>, "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>,  Jonathan Corbet	 <corbet@lwn.net>
Date: Tue, 14 Jul 2026 11:23:09 -0400
In-Reply-To: <20260712141346.576865340@kernel.org>
References: <20260712134433.549076055@kernel.org>
	 <20260712141346.576865340@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-07-12 at 23:25 +0200, Thomas Gleixner wrote:
> Move it out of line and let it reread the syscall number on it's own. Tha=
t
> makes the low level entry code denser and allows to move the reread to th=
e
> call site of syscall_trace_enter() once the tracer is fixed up.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0include/linux/entry-common.h=C2=A0 |=C2=A0=C2=A0 14 +++-----------
> =C2=A0kernel/entry/syscall-common.c |=C2=A0=C2=A0 10 ++++++++++
> =C2=A02 files changed, 13 insertions(+), 11 deletions(-)
>=20
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -60,16 +60,7 @@ static __always_inline bool arch_ptrace_
> =C2=A0
> =C2=A0long trace_syscall_enter(struct pt_regs *regs, long syscall);
> =C2=A0void trace_syscall_exit(struct pt_regs *regs, long ret);
> -
> -static inline void syscall_enter_audit(struct pt_regs *regs, long syscal=
l)
> -{
> -	if (unlikely(audit_context())) {
> -		unsigned long args[6];
> -
> -		syscall_get_arguments(current, regs, args);
> -		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> -	}
> -}
> +void syscall_enter_audit(struct pt_regs *regs);
> =C2=A0
> =C2=A0static __always_inline long syscall_trace_enter(struct pt_regs *reg=
s, unsigned long work,
> =C2=A0						long syscall)
> @@ -111,7 +102,8 @@ static __always_inline long syscall_trac
> =C2=A0	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> =C2=A0		syscall =3D trace_syscall_enter(regs, syscall);
> =C2=A0
> -	syscall_enter_audit(regs, syscall);
> +	if (unlikely(audit_context()))
> +		syscall_enter_audit(regs);
> =C2=A0
> =C2=A0	return syscall;
> =C2=A0}
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -1,5 +1,6 @@
> =C2=A0// SPDX-License-Identifier: GPL-2.0
> =C2=A0
> +#include <linux/audit.h>
> =C2=A0#include <linux/entry-common.h>
> =C2=A0
> =C2=A0#define CREATE_TRACE_POINTS
> @@ -21,3 +22,12 @@ void trace_syscall_exit(struct pt_regs *
> =C2=A0{
> =C2=A0	trace_sys_exit(regs, ret);
> =C2=A0}
> +
> +void syscall_enter_audit(struct pt_regs *regs)
> +{
> +	long syscall =3D syscall_get_nr(current, regs);
> +	unsigned long args[6];
> +
> +	syscall_get_arguments(current, regs, args);
> +	__audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> +}

Reviewed-by: Radu Rendec <radu@rendec.net>
