Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE648BD4A;
	Tue, 14 Jul 2026 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043703; cv=none; b=Ec9UDIeuxEQ/faxWlCMRK0sX0UGd49ZHI+vMYizgF9Xl57WMu+ut80JxHSxDN/CAANFv/ZfgGSOdzQLGFUlt6RWUa2gg2Zn2Ps5AXSoGujUMjdBfHFft5tE/7aerQ7kMT1ArB95aOmiAEe5zTWrY6KNcR1f/YSzDcIGNr8BE1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043703; c=relaxed/simple;
	bh=u0x5lbDonOcd/zZRrlPN3V+m//i3MRhDi3VADgJWwPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwif81uINFoLOEUkOHi3LkkX1NyqMR1kjzIeJSOgZ8P4Rlcmkb3zdQji9NV7HiVJAkJAv4X2WjVGzy5QI8a5V4E3hsyVuHHQORwNlewPJNzP6IBXCSWvtNy+Otow0f/knUsDvM19Gt0/bccps6IwFhurGcvnKJcNsgJ2xbOYBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=rAqaJqFF; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="rAqaJqFF"
Received: from bat.kanata.rendec.net (unknown [24.114.105.230])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 5F076C2C75;
	Tue, 14 Jul 2026 18:41:28 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 5F076C2C75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1784043698;
	bh=hKhKnBtVoVUk/sXTgCEmjbmfk+iGn8mR/E/A1x3cNyk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rAqaJqFFLrO6y6tNVaFvU6vIVcy3LmKR3vuzw4P0LZXbAJVJVm0ALDzL8TymM6hBv
	 CET/mK/kqUWiSZemfVMilwSqWFX7NQXXVpNQ/Te8bp3aMO1QuzmgMSY/iDK1H3oLI+
	 b54jOKhx6ngl0C+7U/vHITetf6JHV6RPlMzsTCj07sqnDOQYY9HRrwARS76jc64IHh
	 JgxemAMZU4ZbJH9EgYX9u416U/McWH+76dZ34vUPOoUw4O7hFqTWBFLZhpRbtKSpsT
	 lqzJ3VpJ/iGQMdziAOF0ZQPwuFo3eBNqkoCEX46BG6CZbIkZNRCTXHdambhKsn3JM6
	 YjYhQXSomeepg==
Message-ID: <0b9b0da3dd27df230038bc87efa8ed43bb02e740.camel@rendec.net>
Subject: Re: [patch 3/4] entry: Make return type of syscall_trace_enter()
 bool
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
Date: Tue, 14 Jul 2026 11:41:24 -0400
In-Reply-To: <20260712141346.699072205@kernel.org>
References: <20260712134433.549076055@kernel.org>
	 <20260712141346.699072205@kernel.org>
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
> From: Thomas Gleixner <tglx@kernel.org>
>=20
> This prepares for changing the return types of
> syscall_enter_from_user_mode[_work]() to bool, which in turn separates th=
e
> decision of invoking the syscall from the syscall number, which might hav=
e
> been changed in the call by ptrace, seccomp, tracing.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0include/linux/entry-common.h |=C2=A0=C2=A0 18 +++++++++++-------
> =C2=A01 file changed, 11 insertions(+), 7 deletions(-)
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -72,7 +72,7 @@ static __always_inline long syscall_trac
> =C2=A0	 */
> =C2=A0	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
> =C2=A0		if (syscall_user_dispatch(regs))
> -			return -1L;
> +			return false;
> =C2=A0	}
> =C2=A0
> =C2=A0	/*
> @@ -87,13 +87,13 @@ static __always_inline long syscall_trac
> =C2=A0	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)=
) {
> =C2=A0		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 (work & SYSCALL_WORK_SYSCALL_EMU))
> -			return -1L;
> +			return false;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Do seccomp after ptrace, to catch any tracer changes. */
> =C2=A0	if (work & SYSCALL_WORK_SECCOMP) {
> =C2=A0		if (!__seccomp_permit_syscall())
> -			return -1L;
> +			return false;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> @@ -102,8 +102,7 @@ static __always_inline long syscall_trac
> =C2=A0	if (unlikely(audit_context()))
> =C2=A0		syscall_enter_audit(regs);
> =C2=A0
> -	/* Either of the above might have changed the syscall number */
> -	return syscall_get_nr(current, regs);
> +	return true;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -133,8 +132,13 @@ static __always_inline long syscall_ente
> =C2=A0{
> =C2=A0	unsigned long work =3D READ_ONCE(current_thread_info()->syscall_wo=
rk);
> =C2=A0
> -	if (work & SYSCALL_WORK_ENTER)
> -		syscall =3D syscall_trace_enter(regs, work, syscall);
> +	if (work & SYSCALL_WORK_ENTER) {
> +		if (!syscall_trace_enter(regs, work, syscall))
> +			return -1L;
> +
> +		/* Reread the syscall number as it might have been modified */

nit: I would add "in the call above by ptrace, seccomp, tracing" - which
is actually in your commit message, but would make it immediately obvious
when reading the code.

> +		syscall =3D syscall_get_nr(current, regs);
> +	}
> =C2=A0
> =C2=A0	return syscall;
> =C2=A0}

Reviewed-by: Radu Rendec <radu@rendec.net>
