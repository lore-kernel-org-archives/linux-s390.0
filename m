Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3BE233948;
	Wed,  8 Jul 2026 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548495; cv=none; b=eBsSIMiQn6jlICTEnSsynF3plPxjuv7N+NzUnOSxWGs8uM8jujSvTKGdWNmbKrcnoG0uIr3aCXAD1m9fDL/RtVK4+eu414cDh4rjGRQo5BDyN0RozecJtRhx10Q8mfwo/VgKLyskMhNSrr1g3aTaD9T9ijnuh73ajRRP3lMhMcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548495; c=relaxed/simple;
	bh=lmylIDM0+kOtyB+bardoVJ9BhbjECLz4hguHAE4YuQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bwShpW7wf4crXDsB0UTAyPAlE/A31Flo4pzByDszfD4fDiDpZbii65vXr6GjFopbYHNZohnOmcUF2vlCR7TxaVyjGBFVlznlTcDzoaxM/ahQiYTc/ocGzTBpoBAj+Xh2rPlN3H5PD6eWzxiGsV15jfbQ4fDdA8sQiTjp22l2Gzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHRxCIVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHRxCIVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A72C1F000E9;
	Wed,  8 Jul 2026 22:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783548494;
	bh=6Cz8BOTHw08E9NcS2yyN9pfUWQWxwh/AbZG3/5oSlNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FHRxCIVTukQAG3miFmDwBEU6I209sFjCARp6kEzFqtKLvTVeoIbUSsC2eSN9qIdnR
	 VQXn9bZShPRC0JvYyhaNRqG/HqxM+0wwkl21YMKvZbZEbwDcCKokdsns9i9ZzyHYbj
	 JPwH4nZrvGyAqtNPEHE5kgl0uyruw7Hao0EDZtv1yI13czTm2pC4iPHCUKvnl9ttoA
	 FQw80n5mm74fyWAHSi+eqhPD70ioINDjajTGwworQYlA/8+7sT+AhOFmASXWzYgLLf
	 IhREvhCoeEVhqiVsSYxwG/avxpiZWCQ9oe9o7pb6I/zkL58DG4nCbi8UNCb/vvui/f
	 nhrMJDrJBHLcg==
From: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <radu@rendec.net>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 09/18] entry: Remove syscall_enter_from_user_mode()
In-Reply-To: <28fb0a8fd840bbf5223c60fea156584cb0f0f208.camel@rendec.net>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.132654198@kernel.org>
 <28fb0a8fd840bbf5223c60fea156584cb0f0f208.camel@rendec.net>
Date: Thu, 09 Jul 2026 00:08:11 +0200
Message-ID: <87mrw1qgms.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08 2026 at 17:21, Radu Rendec wrote:

> On Tue, 2026-07-07 at 21:06 +0200, Thomas Gleixner wrote:
>> All architecture use either:
>>=20
>> =C2=A0=C2=A0=C2=A0 nr =3D enter_from_user_mode_randomize_stack(regs, nr);
>
> You probably mean syscall_enter_from_user_mode_randomize_stack.

Duh. I obviously got that wrong in a hurry. Thanks for pointing it out!
>> =C2=A0static __always_inline bool report_single_step(unsigned long work)
>> =C2=A0{
>> --- a/include/linux/irq-entry-common.h
>> +++ b/include/linux/irq-entry-common.h
>> @@ -49,9 +49,9 @@
>> =C2=A0 * Defaults to an empty implementation. Can be replaced by archite=
cture
>> =C2=A0 * specific code.
>> =C2=A0 *
>> - * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
>> - * section. Use __always_inline so the compiler cannot push it out of l=
ine
>> - * and make it instrumentable.
>> + * Invoked from enter_from_user_mode_syscall_and_randomize_stack() in t=
he
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Probably syscall_enter_from_user_mode_randomize_stack()? But the
> reality is it's only ever invoked from enter_from_user_mode(), which is
> below in the same file (include/linux/irq-entry-common.h).

Yes. Indeed.


