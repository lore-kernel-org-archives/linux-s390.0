Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A544065D;
	Wed, 19 Aug 2026 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163621; cv=none; b=OT9W/3t+BYTyxmwLMtXoY8FjdCJSyKluLOKeH8K3//s/ZQvFbdacxjGZHHBSUCulU9TY/0E+6P0OuyE76584zNEScSm0B4kvIa5ifbgmH1N52Uk86Lm4cpB8jBzKilQB2Hi9UojLKuzSa9f3PxXQYia1RAroEmFpc9hvAhii08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163621; c=relaxed/simple;
	bh=H/GbFGYpLq0r/0n0ofJsMHkOgIk7JKewpvqzS39uvQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HKRJJDBVuBB52kHOqbG1dg5yQTVb6fsrKNPYPWPNccyu+jqiIEDjp03YO8OgAaIR0sJmx+zXUO0fS9wUFDKH7sbS5TskakTWLyn6ArxqwJRah6w+6xEv6kwItnoQ3EQo2tSF1tNdvZr+as4m2Zbyt+49u841bZP3WkXwbYtR3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAoM3Y6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAoM3Y6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8F91F000E9;
	Wed, 19 Aug 2026 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787163620;
	bh=tsxbI1iZ3qeG/iMfzs7o9fPcUpUsh/75jsYI3/2dt8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CAoM3Y6cNXEnQFnNjdJgc8//h/0hCxENtIiRBoiEI0ARlX3DjJ38ywiQfDpYv6epX
	 HhDlRbMoP2KoKNPL8jSY3ajTWz1U1SZp7abzbJWa5Q41+s1+ZKTb1XQy2nYYsgPQhk
	 ahnzG2Bnk4TONo3UNFN9hbo/lqj86TcWidsB/hGv5vJNeIMCHOwSw53lg2i2rUurw5
	 KuP1sUazP0mIJR463w2KTcJRn9Q4uB1wuMzwaRd4EIqUkFylVQevobEo0Xgim1CN3/
	 aUI95mLX5WUkxJFXpcNg2Jc/YCAgZzT3REIJciNU3NHeR+/dZXyyIIrCGwiFAQS5Bc
	 XuNjORms7HFwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 01/13] keys, pidns, fs/verity, riscv/vector:
 reorder '#include <linux/sysctl.h>'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org, mptcp@lists.linux.dev, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260819-sysctl-module-aliases-v3-1-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-1-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:20:18 +0000
Message-Id: <20260819182019.7D8F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Fix an include loop error in preparation for sysctl.h to include module.h:
>=20
>     CC [M]  arch/x86/events/amd/uncore.o
>   In file included from .../include/linux/fs.h:44,         <<<
>                    from .../include/linux/compat.h:17,
>                    from .../arch/x86/include/asm/ia32.h:7,
>                    from .../arch/x86/include/asm/elf.h:10,
>                    from .../include/linux/elf.h:6,
>                    from .../include/linux/module.h:20,     <<<
>                    from .../include/linux/sysctl.h:245,    <<<
>                    from .../include/linux/key.h:17,        <<<
>                    from .../include/linux/cred.h:13,       <<<
>                    from .../include/linux/sched/signal.h:10,
>                    from .../include/linux/ptrace.h:7,
>                    from .../include/uapi/asm-generic/bpf_perf_event.h:4,
> [ ... ]
>=20
> Address this by removing sysctl.h from key.h, which does not need it,
> and adding it to files that actually need it.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D1

