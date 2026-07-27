Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F583F9A11
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149349; cv=none; b=G7ol50jACkSW4gFWD45wjZdUSGnsLp4VBqNnACsKXCmkDD5aU0nI1aYw0M4suJaWgmwdIgnXZEO0QOyNlHP0UeYWnEVut+5EQ39m91CK4mhVWqk2PNktI6BGPgKyNrSKapGsKTwJY7qg3lwXJBMv9VdF1cYXtAvoVxX+DjKGvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149349; c=relaxed/simple;
	bh=gUcvHRHBCpRSuvrRPAgRr8FCgpnkKLjEYNDy6ERahyg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O+O1cFGI6wHw3VbjDk7mxbImG/1wf+Hs3WzbB9d8saOMxVCwU1zPH5CMg0mA6QHy27WX4EQQhdGXbJ/DrwA2bY+BDmadFCETEXUoif3kyK3d+tcnSTTcRaT4onq6zS6REG6B0J/zs/5wctnevqDLHefKe2A0gyTiHjIydaT1prI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKCetVSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKCetVSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B03C1F00A3D;
	Mon, 27 Jul 2026 10:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785149347;
	bh=SmBJci1kV309YaUDz6XdxXpB+s/CM8fQuU0efXE90zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKCetVSFll0SCi+uHAzp9zGkIHs7dD6rzsM6cUDUAM/HIFtoxiBvsameivoSPKYLC
	 vyiTm6H0ZIeeW5x2kWuQkZEhxlRiYGqRZX75BIluwzu1Kp6tSjf9AxjcGRZx7HBKX6
	 sa8E8W4r3aKoJHs4JZZVsN94vNvN4Dnc5fwF7jNp7J3Q/4Pu3jusiSp8m/8zGPF1P/
	 0BRuY6kti/K3OOaE7IfyABWCDwexZuFrpYb93z1YTCOShYY7riHdDjBtTKh0oHrBd5
	 0ZBONV+MikD/EhoFq0TsoYE/NXRBYtX5XqXYuCiStiR31ICXzBwyGBp16O5YTzJFYB
	 52iq2zPQREpYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] sparc: Implement arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727-arch_do_panic-v2-3-4e25ceb05075@linux.ibm.com>
References: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
 <20260727-arch_do_panic-v2-3-4e25ceb05075@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:49:06 +0000
Message-Id: <20260727104907.3B03C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The function `arch_do_panic` is defined without a visible prototype=
, triggering a `-Wmissing-prototypes` compiler warning.
- [Low] Redundant local `extern` declaration of `stop_a_enabled`.
--

--- Patch [3]: [PATCH v2 3/3] sparc: Implement arch_do_panic ---
commit ab46dd14f9e80619721232e0fc090eea0709afa1
Author: Mete Durlu <meted@linux.ibm.com>

sparc: Implement arch_do_panic

Implement sparc specific arch_do_panic() instead of using sparc specific
ifdef sections in vpanic() code.

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

[Severity: Low]
Does this trigger a -Wmissing-prototypes compiler warning? The patch
declares arch_do_panic() in arch/sparc/include/asm/bug.h, but fails to
include that header (or linux/bug.h) here where the function is actually
implemented.=20

While it might appear that asm/setup.h indirectly includes linux/bug.h
via linux/interrupt.h -> linux/jump_label.h, the jump_label.h header
only includes linux/bug.h if CONFIG_JUMP_LABEL is disabled. If enabled,
the indirect inclusion path is broken. Could we add a direct include of
linux/bug.h or asm/bug.h to ensure safety across all configurations?

> +{
> +	extern int stop_a_enabled;

[Severity: Low]
Is this local extern declaration still needed? Because
arch/sparc/kernel/setup.c directly includes asm/setup.h at the top of the
file, stop_a_enabled is already globally declared for all configurations.

Could we remove this redundant block-scope declaration that was leftover
from when the code resided in kernel/panic.c?

> +	/* Make sure the user can actually press Stop-A (L1-A) */
> +	stop_a_enabled =3D 1;
> +	pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
> +		 "twice on console to return to the boot prom\n");
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-arch_do_pa=
nic-v2-0-4e25ceb05075@linux.ibm.com?part=3D3
