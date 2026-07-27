Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494713E9C03
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143497; cv=none; b=ATuyRNUAQtDrzMfI+4kBhgNeQk2o+9/A4WPqfT0H1prZqd91hT69hcsCYD+q2ncEFa2toMccIyYMIMcka8UpboRjd6YcecgWSIVFqD5wKaQH1V5wgVNlR06RfAA19R6foyfCNBSRplXv+yBgY/I3togyTLXWG91w1ZSlRmSIpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143497; c=relaxed/simple;
	bh=QqCsKvk0sXiUU1OIaT/rC98phh3/yiCptodpOsoF8gg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EW3h3So0nujEFJ9oiqgr0Lq3io5Alfblb/6BipOQUtqz9E2vOw0FwsEELqhr0tOOCCHSyu1UHx84ro9hiQT0alnnaXqY+bZOYpef7tRmH3qbecJ2ZMvRF3U+xxOtt5t306H5qZQEXcg6zVOSjKuZbUSuccFkwXpBvq5FcftPm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVvDRWiz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVvDRWiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742931F000E9;
	Mon, 27 Jul 2026 09:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785143495;
	bh=oEaGw8SHmsQ2nRk590CJyvN5Rvy/TrOhbbNESE7PCt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IVvDRWizJmjfu2Z4L+PQaBtXnlARLlHhxjZrNxJeQZELysdzim/48Jm7El/KZ7q4I
	 w7ygydS1rOjWwZk2FSCoRbMjEvk7CQcp7I1nAUhhQomhnbQb+FqZTtK+3R3d3KDNuT
	 25lvWhqjSzUBwwuFpNBM6AsFkD0t+b/t/W+hiNEWoF2zKCKQNJYTgzaSmVPpYL8Ehm
	 DOeMB6UhX1tLGJaGyjRkDASxKdhgXoK8ggvuC00ripLH+ZObef7sAoh6WYWvk/Nomj
	 LX56zY8iphx0NCSQOLtR50TA52+1F/pvSoLcLm0tpQaguiBiR1dHUvOYpHTeCcRF3n
	 xSLcXNzoFvN0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] sparc: Implement arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727-arch_do_panic-v1-3-ca1777547c38@linux.ibm.com>
References: <20260727-arch_do_panic-v1-0-ca1777547c38@linux.ibm.com>
 <20260727-arch_do_panic-v1-3-ca1777547c38@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 09:11:34 +0000
Message-Id: <20260727091135.742931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The newly introduced SPARC implementation of `arch_do_panic()` is =
never called because the overriding macro is not visible in `kernel/panic.c=
`, resulting in the empty fallback stub being used and the SPARC implementa=
tion becoming dead code.
- [Low] Redundant local `extern` declaration of `stop_a_enabled`.
--

--- Patch [3]: [PATCH 3/3] sparc: Implement arch_do_panic ---
commit 0468bb7524180e5a2aa478f794a79dc389197120
Author: Mete Durlu <meted@linux.ibm.com>

sparc: Implement arch_do_panic

This patch implements a sparc-specific arch_do_panic function to handle
the Stop-A hardware sequence. It removes the architecture-specific ifdef
blocks from the generic panic code.

> diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setu=
p.h
> index 21bed55140288..557e8277a6407 100644
> --- a/arch/sparc/include/asm/setup.h
> +++ b/arch/sparc/include/asm/setup.h

[ ... ]

> @@ -67,4 +66,7 @@ void sun_do_break(void);
>  extern int stop_a_enabled;
>  extern int scons_pwroff;
> =20
> +void arch_do_panic(void);
> +#define arch_do_panic arch_do_panic
> +
>  #endif /* _SPARC_SETUP_H */

> diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
> index 4975867d9001b..87d3569c520f8 100644
> --- a/arch/sparc/kernel/setup.c
> +++ b/arch/sparc/kernel/setup.c

[ ... ]

> @@ -36,6 +36,14 @@ static const struct ctl_table sparc_sysctl_table[] =3D=
 {
>  #endif
>  };
> =20
> +void arch_do_panic(void)
> +{
> +	extern int stop_a_enabled;

[Severity: Low]
This isn't a bug, but is this local extern declaration necessary?
Since asm/setup.h is included at the top of this file, the global
declaration of stop_a_enabled should already be visible.

> +	/* Make sure the user can actually press Stop-A (L1-A) */
> +	stop_a_enabled =3D 1;
> +	pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
> +		 "twice on console to return to the boot prom\n");
> +}

> diff --git a/kernel/panic.c b/kernel/panic.c
> index de0bda946cabb..593aa2c24d93f 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c

[ ... ]

> @@ -747,15 +747,6 @@ void vpanic(const char *fmt, va_list args)
>  			reboot_mode =3D panic_reboot_mode;
>  		emergency_restart();
>  	}
> -#ifdef __sparc__
> -	{
> -		extern int stop_a_enabled;
> -		/* Make sure the user can actually press Stop-A (L1-A) */
> -		stop_a_enabled =3D 1;
> -		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
> -			 "twice on console to return to the boot prom\n");
> -	}
> -#endif
>  	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> =20
>  	arch_do_panic();

[Severity: High]
Will this actually call the sparc-specific implementation?

Looking at kernel/panic.c, it does not appear to include asm/setup.h where
the override macro for arch_do_panic is defined. Because the override macro
isn't visible in this translation unit, won't vpanic end up executing
the default empty inline fallback instead of the newly added sparc
implementation, effectively dropping the sparc panic behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-arch_do_pa=
nic-v1-0-ca1777547c38@linux.ibm.com?part=3D3
