Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596178F2F
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997794; cv=none; b=UFQ4hPE9viy3RqQdp5ZRbbZSo/w94mZuKcWSthF9m6xPP3wnRcQACheenmw6EBlai9u1eJAYeRvgdJ4KYggUmR2pHPca4qdu9dzKpXkZEUkPRXJEK25jlXEthBykHDgLQYAhW9fQO9spZNOFgdLqwvc0iKiek3T7EvKN/e3ctNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997794; c=relaxed/simple;
	bh=xaB64Rla0B5nMr3IETngU+D62VpJ+1MvhEVZA7Z1gUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BnTow0T0XQX/xP8SI5KQIwhjdGdzIJStu9oP+NfIGQz8YF0izImKQt2sDawwkbap/wXC5vnhQFkORoav7Z4EbyinbIf2UVT/L1E0841hVm+HYb6jCsABCmprPt+L/Op1bf+ELDj9QBgxpwSKggWSEQWVpjt9BkMGWVUKOuTOqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jak9tYQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jak9tYQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417D61F000E9;
	Thu,  6 Aug 2026 06:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785997793;
	bh=QFOQYO3eChpCNsUny0uOrLzBDFQTYaQCNrjYrYgI3eU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jak9tYQVxOvzmqiXGc2m5kVsXczVLPb93FZKyxJD7PwGF0G4liFQTKc4omImLiGOh
	 /3yhCKqcpC7egEB76gtMv5smP29LMvQxt6PsGTHjHkqWn/4RJC70HfyJLhzZpL/79X
	 PP8JcxVAFmhYbYkc+LUb8PeLTk9mCFh4Hm1B9hatuRRxN0FlBRPrfkbDn048BNPNfj
	 gnj0bDcTmONImoBRnen7IZMttesYos+64fumIPyYRn5h5f/PqGBhGoMBYpthnL2lYC
	 aAwHPQMxJoWZRFdnQQ3tfrDiLv0rDk8+vj2/XDBAYCzs4G24pNw76f5M2tokes5whi
	 f7VH6u2PMreXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] init/Kconfig: make config INIT_ENV_ARG_LIMIT
 user-configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wilson Felipe Pereira" <wfelipe@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260806061429.474992-4-wfelipe@google.com>
References: <20260806061429.474992-1-wfelipe@google.com>
 <20260806061429.474992-4-wfelipe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 06:29:52 +0000
Message-Id: <20260806062953.417D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] init_setup() and rdinit_setup() fail to clear argv_init[MAX_INIT_A=
RGS], leading to a ghost argument or spurious kernel panic.
--

--- Patch [3]: [PATCH 3/3] init/Kconfig: make config INIT_ENV_ARG_LIMIT use=
r-configurable ---
commit 40d27a1b9f7dbca831686327245c33052b28fb18
Author: Wilson Felipe Pereira <wfelipe@google.com>

init/Kconfig: make config INIT_ENV_ARG_LIMIT user-configurable

This commit makes the INIT_ENV_ARG_LIMIT Kconfig symbol user-configurable
by adding a prompt string and a valid range. This allows users to increase
the maximum number of kernel command-line arguments passed to init beyond
the default.

> diff --git a/init/Kconfig b/init/Kconfig
> index c581817966ee2..a77a2c33c319c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -228,9 +228,10 @@ config BROKEN_ON_SMP
>  	default y
> =20
>  config INIT_ENV_ARG_LIMIT
> -	int
> +	int "Maximum number of kernel command line arguments"
>  	default 32 if !UML
>  	default 128 if UML
> +	range 32 4096

[Severity: High]
This is a pre-existing issue, but could making this limit configurable=20
expose a bug in init_setup() and rdinit_setup() where they fail to clear=20
the last element of argv_init?

Looking at init_setup() in init/main.c:

init/main.c:init_setup() {
    ...
	for (i =3D 1; i < MAX_INIT_ARGS; i++)
		argv_init[i] =3D NULL;
    ...
}

And similarly in rdinit_setup():

init/main.c:rdinit_setup() {
    ...
	for (i =3D 1; i < MAX_INIT_ARGS; i++)
		argv_init[i] =3D NULL;
    ...
}

Since argv_init is sized MAX_INIT_ARGS + 2, if the boot command line includ=
es=20
exactly MAX_INIT_ARGS unknown arguments before 'init=3D', they populate=20
argv_init[1] through argv_init[MAX_INIT_ARGS]. The loop in init_setup() sto=
ps=20
at MAX_INIT_ARGS - 1, leaving argv_init[MAX_INIT_ARGS] populated with a sta=
le=20
argument.

If the boot command line then provides MAX_INIT_ARGS - 1 arguments after=20
'init=3D', they fill indices 1 to MAX_INIT_ARGS - 1. This makes the unclear=
ed=20
argv_init[MAX_INIT_ARGS] contiguous, which could cause kernel_execve to=20
pass it to init as a ghost argument.=20

Alternatively, if exactly MAX_INIT_ARGS arguments are provided after 'init=
=3D',
could the argument checking loop evaluate argv_init[MAX_INIT_ARGS] as true,
set panic_later, and cause a spurious boot panic?

>  	help
>  	  Maximum of each of the number of arguments and environment
>  	  variables passed to init from the kernel command line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806061429.4749=
92-1-wfelipe@google.com?part=3D3
