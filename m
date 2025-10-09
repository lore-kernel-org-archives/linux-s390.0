Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B53148832;
	Thu,  9 Oct 2025 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972038; cv=none; b=L+yRHP3RT2+QsJPUrup2AL41r1Dgky4wyoQYixKxADvRdIBt5uv4AS6GWBR6XNpV+Qm2BsdvAPvmlkUi2VtcJF+2EdBHak9Q9UEQorU6Wke3hlqikSKfxajmAU4Me25FdUEBlJ+OIEkWPxk/hWMidYAxZxciux1CFCWw0c6caos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972038; c=relaxed/simple;
	bh=0pQ9vc0S7+W0X1K4N+Om/UUij1yWdKMoXEP+Dp45E6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qFWxkuiV6sJO37/A9K0TMVdo6YGfVSubcg0HDhCpnRsrzBAJdICizZD/V5Ouy44/W1rMD4JcPxbs4X1lzAExGkzRHEbM/bFZAtr+wA0MElIcC5Lmge1VHWE03dxsYLGOE83gkIIZKlJwnd/U3B3s39dchlGSmOp/TTaXUwLq3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgLCEG1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgLCEG1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1021AC4CEE7;
	Thu,  9 Oct 2025 01:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759972038;
	bh=0pQ9vc0S7+W0X1K4N+Om/UUij1yWdKMoXEP+Dp45E6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mgLCEG1psTMeWNX86G6Tj93NFOr9A6HPWBooqhDsK/peZJiDr0z/lTt34SW/uV2wG
	 K2KA79ATbUyDb+QTtCiIb37Rmvl0ZB6h8EYOw6lZaU8PA4YEraSK96r4wnFJg5DgK6
	 px0wfbyKDtcXRuIuG3T18Ewh+okDNXN4RBEutXF8zlOxKiOztQ3FRVjOkE20nlpwGX
	 YhuXK6buub3FK7cN2EWSYIN6r/pZvCaQavyztMciWzkDa46lDOV/dfEDrzjJFL6sad
	 0NMFuRS+cJkrvvNwdswXaYRikNalB+yZpqvN9LdbCi0fl6LsirGqURxRennMUrvEHk
	 ipzxebesp0GnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF8C3A41017;
	Thu,  9 Oct 2025 01:07:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/2] kasan: unify kasan_enabled() and remove
 arch-specific
 implementations
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175997202628.3661959.104646439887808862.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 01:07:06 +0000
References: <20250810125746.1105476-1-snovitoll@gmail.com>
In-Reply-To: <20250810125746.1105476-1-snovitoll@gmail.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: linux-riscv@lists.infradead.org, ryabinin.a.a@gmail.com,
 christophe.leroy@csgroup.eu, bhe@redhat.com, hca@linux.ibm.com,
 andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn,
 chenhuacai@loongson.cn, davidgow@google.com, glider@google.com,
 dvyukov@google.com, alexghiti@rivosinc.com, alex@ghiti.fr,
 agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com,
 kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Andrew Morton <akpm@linux-foundation.org>:

On Sun, 10 Aug 2025 17:57:44 +0500 you wrote:
> This patch series addresses the fragmentation in KASAN initialization
> across architectures by introducing a unified approach that eliminates
> duplicate static keys and arch-specific kasan_arch_is_ready()
> implementations.
> 
> The core issue is that different architectures have inconsistent approaches
> to KASAN readiness tracking:
> - PowerPC, LoongArch, and UML arch, each implement own kasan_arch_is_ready()
> - Only HW_TAGS mode had a unified static key (kasan_flag_enabled)
> - Generic and SW_TAGS modes relied on arch-specific solutions
>   or always-on behavior
> 
> [...]

Here is the summary with links:
  - [v6,1/2] kasan: introduce ARCH_DEFER_KASAN and unify static key across modes
    https://git.kernel.org/riscv/c/1e338f4d99e6
  - [v6,2/2] kasan: call kasan_init_generic in kasan_init
    https://git.kernel.org/riscv/c/e45085f2673b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


