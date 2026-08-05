Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE126B0A9
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924035; cv=none; b=pb3SxsPnFnxfwzdR3E7SHm01J66MiTPrkqxOw2Tba3fPkeAZircqbKU3PwaWSvbGKKCqh5linzsP9j+eJRG5sGv2HlzFGE4qAH3/klbdMJ7l5aLmPFXdbwjR0sAoB49W4/jWhvQtv8o5w2T3q66//46E3J7plt7Mfj1873PhoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924035; c=relaxed/simple;
	bh=RrmmPpN7nrwdwS9MR1Hh20Dw1yIDFZSIaIZcH5VUYyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AXDOd+i2Lo8XstLXy/kBcufF5RXzr0TzSVBP6TzEf1/vZIduBHMaset7A4Mnxpfqybuo4OlNvjkshoo6H7KSLlHlgj6+MFGsVLBDdanhrMnqt7/HQEiKKuvt3fnzMaubKWZLax9nswet8BxuFBU35+yu3J2R8aJE/vYvu9TDqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fenJ6a0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fenJ6a0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1709E1F00A3A;
	Wed,  5 Aug 2026 10:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785924034;
	bh=oMTx2L+wnmyhLaFc/O1VGcBm7VYt8vIlc0ZL1zjVRb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fenJ6a0nWYocY6hYfcXWAg/+txHYdeIbbugYj9M4ZxVrkL3HOingY5PDrgnuukDu0
	 xEqFk9ZbH0WtmzSFh6FLVDhFRvvHscpGcwzEwC9tBZyI6GcjvErAHvItORrlbTaEug
	 aotfQmC88GwE7CbeOIaa6RL8DIfGHsAk+g+fGO/fV8mpLiBhfbjHpOAlWj+4dOd/2L
	 Krf/YHNzJXPi+S+8vQm63uEG2K83Cn5aJOS21NNcPH42hLQysZ4w8VTdpCCzoTFufm
	 gK7BaGzZeZrmcvKIBKeG/M9p8zNFRrqnUW0uD/WSgBEWtF9hFYTHk4yokQUjSZuPRf
	 xBbNdTg64YXbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] panic: Introduce arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805-arch_do_panic-v4-1-af4a36f99414@linux.ibm.com>
References: <20260805-arch_do_panic-v4-0-af4a36f99414@linux.ibm.com>
 <20260805-arch_do_panic-v4-1-af4a36f99414@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 10:00:32 +0000
Message-Id: <20260805100033.1709E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced `arch_do_panic()` hook is placed before the=
 explicit console flushes. On architectures that halt indefinitely within t=
his hook (e.g., s390), the final 'end Kernel panic' message and any deferre=
d NMI logs will be lost because the required explicit flush is never execut=
ed.
--

--- Patch [1]: [PATCH v4 1/3] panic: Introduce arch_do_panic ---
commit 6fe8c46d4a07969ba51a615fab55e7ba7120f254
Author: Mete Durlu <meted@linux.ibm.com>

panic: Introduce arch_do_panic

This patch introduces a weak hook for architectures to provide their
specific panic handlers. This aims to help clean up architecture specific
ifdef checks in the panic path.

> diff --git a/kernel/panic.c b/kernel/panic.c
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
[ ... ]
> @@ -756,6 +758,7 @@ void vpanic(const char *fmt, va_list args)
>  #endif
>  	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> =20
> +	arch_do_panic();

[Severity: Medium]
If an architecture implements this hook and halts indefinitely, will this
bypass the final explicit console flushes?

The final explicit flush happens shortly after this addition:

vpanic() {
    ...
    pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
    arch_do_panic();
    suppress_printk =3D 1;

    console_flush_on_panic(CONSOLE_FLUSH_PENDING);
    nbcon_atomic_flush_unsafe();
    ...
}

Could this cause deferred log messages, such as NMI backtraces or the final
panic banner, to be lost because the required explicit flush is never execu=
ted?

>  	/* Do not scroll important messages printed above */
>  	suppress_printk =3D 1;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-arch_do_pa=
nic-v4-0-af4a36f99414@linux.ibm.com?part=3D1
