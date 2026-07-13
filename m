Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B3368D7B
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926387; cv=none; b=I+4GnA9LcIRSVapgTuQJjGOnUlVR5WAxax957vg+W3dIX5+Ylmlo8YSpzSA3h9T5zY6qwKUdHkslCnMs/bnB/T2C3FD9fPfUZfvJ55ZF5FItdC+uapNgxh5dtOO5S3IswQqaos81uYjqy8hixL6G8YjJNMK1D9LaRCK+Y1awtgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926387; c=relaxed/simple;
	bh=hCeMAFawqUQZK5TTzZSun5coCAr0fqMieti9jZqRw7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ0pmwADOTKOYNHIwfdx3Vr2cpo0EjLslb3QjLyhJJxE5hh7GIQ0a0Pdf61qC8WzaJCxtMEjQVRsO9QwPThmUlBjlm83gAzJZ4b/MLSNtkTeq4R4nltRouco/sb7xQIowf6p4AD5C1Sw+s/rfTN/ZWoLEHJdIZNmoI4P8ZRD1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbglOxZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbglOxZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5B61F01564
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 07:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783926384;
	bh=MaoMLNzrQSdilHBAPxvn7cFGYo6KCQRZiQrYmmdeSDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TbglOxZrZc+8ho1Z2BcK0IhS3egNUSq0c5Yekd6nxDBKZQhVPPnrHghm6ItjXrvW8
	 myYXJ6x6lFh7QX5ecmuh/vq7Qwc4aN3eTk8kvvmFs1d8wRQY7vrvAGfQK8ML7sZ4Yj
	 k2WeLrzUteazWoeRwgjCCUDZJ2+PWRLzL1ozd2prV95l5uW3ki91C/T/KpUndY2saf
	 +I1D4H0CLwMJu74DptZISJOOYDmUct5uhnCyLsAUx2HSrcK3fC5VZsBannIxQYZ7Rq
	 GNjV6d1+IgN8jsegZ7lli5dbQ5dULez5iyH6dt+oUZzipNLSJVSN9n9AB3HDQyztKw
	 NLk2nciGwWqEA==
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so21544335e9.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 00:06:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpE0ZkOXacari2j9CkySlOoj3cl8SiaSI9VwRHS6l/HRBb70SIhLXyAqCHYYqM9+8dSetj9oiROuVhj@vger.kernel.org
X-Gm-Message-State: AOJu0YySXJuFMdqSFvcH4BI7+FWcDKHseMaDzSykf07zQ84vLXIEvET5
	JYafSrTE9vDLMAdrdGSTYQXEzda4mesmVV+r9Adizc0d9uuNYmBc+rjo61NoIhEjkOnSsr8Q9ty
	zwpKQLRom4ZPjS9G/driMsCBG9zUVdKI=
X-Received: by 2002:a05:6000:186c:b0:476:d13f:bb74 with SMTP id
 ffacd0b85a97d-47f2dc9bac8mr8770361f8f.15.1783926382749; Mon, 13 Jul 2026
 00:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <20260707190253.974626922@kernel.org>
In-Reply-To: <20260707190253.974626922@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 13 Jul 2026 15:06:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjW0RfZsJmHVAqrRsHpK4cJ+01G_Kkytt=0Wpm4sZpkg@mail.gmail.com>
X-Gm-Features: AUfX_mzuKA4JwmuMUWB774bzpkP7q4a7PrJvxtp8N1GWwrENQwGP0BULxiqlyqc
Message-ID: <CAJF2gTTjW0RfZsJmHVAqrRsHpK4cJ+01G_Kkytt=0Wpm4sZpkg@mail.gmail.com>
Subject: Re: [patch 06/18] riscv/syscall: Use syscall_enter_from_user_mode_randomize_stack()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, 
	Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 3:06=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
>
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var=
()
> as that code is invoked with interrupts disabled.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/kernel/traps.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -7,7 +7,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/irqflags.h>
> -#include <linux/randomize_kstack.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/signal.h>
> @@ -333,9 +332,7 @@ void do_trap_ecall_u(struct pt_regs *reg
>
>                 riscv_v_vstate_discard(regs);
>
> -               syscall =3D syscall_enter_from_user_mode(regs, syscall);
> -
> -               add_random_kstack_offset();
> +               syscall =3D syscall_enter_from_user_mode_randomize_stack(=
regs, syscall);

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
