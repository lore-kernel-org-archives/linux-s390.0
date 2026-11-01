Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571349;
	b=ZyYH4MARGNQLS+U/IbWY11/l++A8Fgh2Av7C4fn0dKsOGLMOKgsLtXjEnhZtHVQQVjGq
	 DB7Y8OD72gkHGPBLVL02mTBgbapfFBXD4OjQt8LpY5ckpO0KWxl56ntwjib6T5YiZPSao
	 m2X3f9kBnfxK9m2vwi45esq8hBjiK/iovV+fls8pnTG6xibNaNRWaw977OLaWb4nyPgl2
	 6sxn6njwmPXdt9ijL8c45ksvE1kgPg1IseAKNLISf3kBrAdLsh5fP3zrkwwWHbVHvd11T
	 p9Xy64iphEWE6kS/Ckkp7ttEA6GBSdsi1A47iu08e5NcFcVqK/o0RqY2d9Qj6ofcxeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571349;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=zWjchA1R3k2PWinfdPa1bmSSkYcmsFonhHSsoHtMyf0=;
	b=RYfm5yroD962OEJ1i2RDYgUGoCWDrHVp/iL8lyOvwkxg0KraAWDWipNLolN7zSI+N1Yy
	 J/BggXTYJDLJojgzMAbPcniQN2zv65/q99UGxogU3v+ZpeXcXvxjyveVDw4IGDqXXuSOJ
	 tZtiPhCzakTqNaSWYBmcZPEciw/jCXdwU5o5ka7VO4F4uyBJBPgPlU/Z2iRrJFJa/3G/k
	 rlJw2tl5ypn2CXbBaMmJ80AbzKTjujdepQ526fu0IloFRsb7tA2LQemkyrHexIkf5o/e/
	 IbdAZUsBWArhyM0qvZb9SFlB63qSIAPT5RFKP61nHMwSmAiqHgjP0Ewx1kk32kwtMFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLtzwK85;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E45606A32E;
	Sun,  1 Nov 2026 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLtzwK85
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8672C1F000C1;
	Sun,  1 Nov 2026 22:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571348;
	bh=zWjchA1R3k2PWinfdPa1bmSSkYcmsFonhHSsoHtMyf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YLtzwK85l4hGxLyA70UvP4j1W3M7aK0AnO65y/AzsiFBwFu+o+am4lM03VbtHtJ5K
	 SS29sY8vrSYrA6jdvWzfwe5K90LxJtzoHxZZu0mTSUAvpZkN1PYLCGRsEs6UgYx0aB
	 97oKuIhcSNLzzTU7IsY2JDbPwHgALU8UUMTUIacoZU37AQpC6KtulGbzQ30fh/1Pj7
	 439Gr0UJypJlNRfMtvA0ZTTdkqVe4hPq7HarsqK8Usmvu9Wk0QYv2Bnam4S5juFWnH
	 d/jArMh+zoyROvtkvZe5ytr6PBXG3TqNVsxhJFaqiJVBj+Botefdp40TKRHbDajTSy
	 ztyxsj6TJTA0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D5C738003B8;
	Sun,  1 Nov 2026 22:15:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/15] vdso: Clean up the vsyscall.h headers
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357134704.2624073.7289302544673229273.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:15:47 +0000
References: 
 <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
In-Reply-To: 
 <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, luto@kernel.org, tglx@kernel.org,
 vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Thomas Gleixner <tglx@kernel.org>:

On Wed, 09 Sep 2026 10:51:13 +0200 you wrote:
> The vsyscall.h headers are a mess. Some of that was necessary back when
> some architectures where not using the generic vDSO infrastructure.
> Now that this is not necessary anymore, the headers can be cleaned up
> and many of the can be deleted altogether.
> 
> The recipient list is trimmed to only the vDSO maintainers and the
> architecture lists.
> 
> [...]

Here is the summary with links:
  - [01/15] vdso: Move the kernel-side time update helpers to a new header
    https://git.kernel.org/riscv/c/35f0a96848a7
  - [02/15] vdso/gettimeofday: Define fallback __arch_get_vdso_u_time_data() in gettimeofday.c
    https://git.kernel.org/riscv/c/4fba7bb3e73a
  - [03/15] vdso/getrandom: Define fallback __arch_get_vdso_u_rng_data() in getrandom.c
    https://git.kernel.org/riscv/c/ca0da001d3cf
  - [04/15] vdso/vsyscall: Define fallback time synchronization functions in vsyscall.c
    https://git.kernel.org/riscv/c/e4eeeaa14d8d
  - [05/15] vdso: Delete asm-generic/vdso/vsyscall.h
    https://git.kernel.org/riscv/c/8579b901d150
  - [06/15] x86/vdso: Move vDSO page definitions to asm/vdso.h
    https://git.kernel.org/riscv/c/8051a0f482e6
  - [07/15] sparc/vdso: Move __VDSO_PAGES to asm/vdso.h
    https://git.kernel.org/riscv/c/782478555fc6
  - [08/15] s390/vdso: Delete asm/vdso/vsyscall.h inclusions
    https://git.kernel.org/riscv/c/d5b1dadd2ef0
  - [09/15] sparc/vdso: Delete asm/vdso/vsyscall.h inclusion
    https://git.kernel.org/riscv/c/cc729f844815
  - [10/15] x86/vdso: Delete asm/vdso/vsyscall.h inclusions
    https://git.kernel.org/riscv/c/3086b69ee00f
  - [11/15] arm64/vdso: Delete asm/vdso/vsyscall.h inclusions
    https://git.kernel.org/riscv/c/128b1c7d3ac8
  - [12/15] riscv/hwprobe: Include vdso/datapage.h
    https://git.kernel.org/riscv/c/0d10af5db481
  - [13/15] vdso: Remove unnecessary vdso/vsyscall.h includes
    https://git.kernel.org/riscv/c/d6df494a0135
  - [14/15] vdso: Add asm-generic/vdso/vsyscall.h
    https://git.kernel.org/riscv/c/996b01393e93
  - [15/15] vdso: Remove __ASSEMBLER__ guards from vsyscall.h
    https://git.kernel.org/riscv/c/9e61cabcce2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


