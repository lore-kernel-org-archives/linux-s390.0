Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDD3F0AA9;
	Wed,  8 Jul 2026 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546822; cv=none; b=ZNuopx4u6yfIC37WJotDX6CqR0iuRSLKeKpLdcVOOUD3Xv1KJAoiXTOtXr7It/0mu38j0psdB2zb0vio7LiA3vFNh7KRTWTVSEJ7ARqByPlehikTBDcMjzqLd5nk0JWAFBiTn+vvyFL35yQUMFp5GDwoh6xUfwBkZV7NxwGEBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546822; c=relaxed/simple;
	bh=06X0wts/VWiidyiW7nEPWVVzTkue+gIEbtnmzGNDpCM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rDEzU7iXzJPw60qMH7JuBQDc+qS1ktyZa7v0mXeSriYFYGSDMVKeTN1pljCr5bRSQd8eoYzk7l2TD4PDWtIPh/TlKyBMvZ/MyM1yqBWNxk1dtAecO/XRzwzGWAotU0akzcf8ta/uM2PXNdXFY87DrCUKX9S/uzeBExXmQXE5W3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=Vxaj5QTr; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="Vxaj5QTr"
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 362D5C2A88;
	Thu,  9 Jul 2026 00:39:55 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 362D5C2A88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783546818;
	bh=vh8LzxdSEB6LZ5YWToq98HafI55oS8+SMbKFy7UAtCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Vxaj5QTrZmnMb8kgo0DAnYKLpgF1VNrrEnZhf9ONVOiUDzl0XehMr6So/mzP7wSyL
	 f/bqBaPzsa1UU5XOryNPd/7wb5rGQ7IwzXh6waI3HHJA4HLb35t2X+7MMwejCU49/V
	 wyf2N0EPqZ3qOvz85kyJv8Z4VVG4eamp/AsyfiC+iferCPdwrWRhhI2Gihi8EYWMG6
	 w9oTc7WxIT/1nxUO9bTb5BDnYHc4NJdQoeD9M4hXia3YTHnUvNPgR3MY/vwUlZnDJN
	 KsGLwDIHTElRb68oeRo724l+p50zYouaHMInNxEVvF4Rx2YclHGHsHkUSx9MW9gMJA
	 BLbx/jCYTxmsw==
Message-ID: <0f3a6ccaadc1d330215416d9cec13263d71b685e.camel@rendec.net>
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>,  Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen	
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>,  Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas	 <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven	 <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  Helge Deller	 <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, 	linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, 	linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, 	linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta	 <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>,  Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 17:39:50 -0400
In-Reply-To: <20260707190254.181086755@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190254.181086755@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-07 at 21:06 +0200, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0include/linux/entry-common.h |=C2=A0=C2=A0=C2=A0 9 +++++----
> =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
>=20
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -70,9 +70,10 @@ static inline void syscall_enter_audit(s
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static __always_inline long syscall_trace_enter(struct pt_regs *regs, un=
signed long work)
> +static __always_inline long syscall_trace_enter(struct pt_regs *regs, un=
signed long work,
> +						long syscall)
> =C2=A0{
> -	long syscall, ret =3D 0;
> +	long ret =3D 0;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Handle Syscall User Dispatch.=C2=A0 This must comes first, sinc=
e
> @@ -90,7 +91,7 @@ static __always_inline long syscall_trac
> =C2=A0	 * through hrtimer_interrupt().
> =C2=A0	 */
> =C2=A0	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
> -		rseq_syscall_enter_work(syscall_get_nr(current, regs));
> +		rseq_syscall_enter_work(syscall);
> =C2=A0
> =C2=A0	/* Handle ptrace */
> =C2=A0	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)=
) {
> @@ -145,7 +146,7 @@ static __always_inline long syscall_ente
> =C2=A0	unsigned long work =3D READ_ONCE(current_thread_info()->syscall_wo=
rk);
> =C2=A0
> =C2=A0	if (work & SYSCALL_WORK_ENTER)
> -		syscall =3D syscall_trace_enter(regs, work);
> +		syscall =3D syscall_trace_enter(regs, work, syscall);
> =C2=A0
> =C2=A0	return syscall;
> =C2=A0}

Reviewed-by: Radu Rendec <radu@rendec.net>
