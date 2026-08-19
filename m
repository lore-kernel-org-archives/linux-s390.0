Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDEE3BAD92;
	Wed, 19 Aug 2026 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106794; cv=none; b=NOl4Jch5mcUubvkzkFwsWynoLegt6hEr4et/H9OPuOwCRQYqDsgx2WSZBWdO5xMdgtsXH85azcDEBB60bDAe3X5SRmpuRc6PcmKTlfpo1Tt3GZTFx0+ez3qm4iJl9IzvhruL2tvpR+5WQZy0MfMddxgE25RLplQgIcBF45KJaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106794; c=relaxed/simple;
	bh=tqcHSf2oN0C9VELzoK8zEpTBMhjljkGQ4+lieCgzaaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BcBuypa7nSU0vCKSSH+njPstznnUZQ7UXd/0a1F9n7bExFIFAeYPDQhVSWrjqf7MndVhnw2xw44el5ABC0yS+mQIeWMTvooeJOPKN6qd091wygsHbllg8Erek/wYFFytfPnBfJh+QvvYCjqZHmFiNAFQgXOKQ6JLj4zMCwLVcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrTBO5kl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrTBO5kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86881F00A3A;
	Wed, 19 Aug 2026 02:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787106793;
	bh=ToYm3kX7mV862WfNyqpnX/n3/sf10DqcoJLbf0XSX0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CrTBO5kl8HTwa/ml80npVWFHkoCyrGm9cPdeK0U+JVyLXg2ujoCv4/Bmv68968ggY
	 CaEwqVb9JAzZV/dp6b3Bw8u1yKsFj1BlZNYEg8i0JzWn2FonaMLgkS9HI3oMg/kjL6
	 KZ0hdyLM8iMsogTc65zbd/K+TLHbNU1PZlzfZ9V6tIZs3tUDGnrewgG2vwdYyOZdmB
	 1jA4VQsoKeuvX6SNLXhabpdYVaAhGC/5zWNWSVXqoK5ABuRdr1TPBLJneuofMvW8DR
	 DDz5Kn5rmIKx/cB7FiPG9cqxgGLdVg6hCxGVA5qmr/NcOkGkYPL1rM30L0u6G+EWN4
	 MESLPi4EZyciQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 01/13] keys, pidns, fs/verity, riscv/vector:
 reorder '#include <linux/sysctl.h>'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org, mptcp@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260818-sysctl-module-aliases-v2-1-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-1-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:33:12 +0000
Message-Id: <20260819023312.E86881F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D1

