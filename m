Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CA3C0630
	for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362292; cv=none; b=aUi9loSdu7lUGP9KJO+AE6IzdO7kYGQ2ZtJzYiTTPj3A5553xtdZxUQcgiELxeh8Ok5lU6yGoFszOUaYFrXUSB8F7XEcR5VdO+13Tf1B7jGglCxRukxhRn0+o/pfV3r0VVvc0+Kk2pf2HVZ4oSNZjTGOk9lLWoKFD3lpGfXZC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362292; c=relaxed/simple;
	bh=UpjDohN913S0PV813vB2BjTKa8bT9HSq6oYNW/M+mWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pMUjrpGnbVuzpKuVBX8eIPP7LFya6KSSdhLHnZUHy70f65H6v9LoFyEWuAhP3iGrwt9xeXQt5NfiU0k+iB6RZX6yeWh6qhgx/k3vr8RAiUJawNnjEXFtff3wV3cIczOiojRTkuxPX4/slCdD8N2xvlQZJvK3dcbRdKyRMWEXPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL/Os/Sj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL/Os/Sj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4900A1F000E9;
	Mon, 10 Aug 2026 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786362291;
	bh=yHL2CVa/J5kmAMOhNbNyJ+TVrpB93he2cBXp35x3/PE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NL/Os/SjC1IlL1I6YlIbicqynvuNi3LfaDsCBukKBsmJHoGr+GA4FxjuDvhhZUjNq
	 oJ+zw6IIuEaTjlxwz8qqmYjS3mZatGt8zup9dyjqWTp1/cDVQlBXlLaIT1GZO1CJQS
	 rHWq6Un/YRqyau28dEhvaJGkodw1GeDV6WsXdvK77kFRM7LJFKRWBp4dGNbYdk+eGe
	 NA2aclc6uJsMNlT5ACOZ+N+UlhPP1UeXsViZXOQNpHTsEVu2qH8ySJTHxyn/4CBP/n
	 /JlP0TW2Xiu6fFAPFd0GMh2LqoWdJ5EFOQSw0tjyYunin3f7PMOAvp8Xx/V9pcnTjK
	 A+lPDUfkwM/XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] s390: Implement arch_do_panic()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260810-arch_do_panic-v5-2-e86ae992c253@linux.ibm.com>
References: <20260810-arch_do_panic-v5-0-e86ae992c253@linux.ibm.com>
 <20260810-arch_do_panic-v5-2-e86ae992c253@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 11:44:50 +0000
Message-Id: <20260810114451.4900A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced `arch_do_panic()` hook is placed before the=
 final console flushes, which causes the 'end Kernel panic' marker to remai=
n unflushed in deferred printk contexts on s390.
--

--- Patch [2]: [PATCH v5 2/3] s390: Implement arch_do_panic() ---
commit b9b01d12abb499c817ce8c2a246d404e0331bf81
Author: Mete Durlu <meted@linux.ibm.com>

s390: Implement arch_do_panic()

This commit introduces a s390-specific arch_do_panic() implementation, remo=
ving
an ifdef section from vpanic(). It moves the disabled_wait() call so it occ=
urs
after the "end Kernel panic" marker is printed.

> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index 564403496a7ce..309d3d3e95fd9 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
[ ... ]
> @@ -275,6 +277,11 @@ static void monitor_event_exception(struct pt_regs *=
regs)
>  	}
>  }
> =20
> +void arch_do_panic(void)
> +{
> +	disabled_wait();
> +}
> +

[Severity: Medium]
Will this prevent the final console flushes from executing on s390?

Looking at vpanic() in kernel/panic.c, arch_do_panic() is called before the
final console flushes:

	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);

	arch_do_panic();
	/* Do not scroll important messages printed above */
	suppress_printk =3D 1;

	/*
	 * The final messages may not have been printed if in a context that
	 * defers printing (such as NMI) and irq_work is not available.
	 * Explicitly flush the kernel log buffer one last time.
	 */
	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
	nbcon_atomic_flush_unsafe();

Since disabled_wait() puts the CPU into an infinite wait state, it never
returns to vpanic(). If the panic occurs in a context that defers printk
(such as an NMI), does this mean the "end Kernel panic" marker will remain
unflushed and not visible on the console?

>  void kernel_stack_invalid(struct pt_regs *regs)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-arch_do_pa=
nic-v5-0-e86ae992c253@linux.ibm.com?part=3D2
