Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571392;
	b=eLxcl05CbRRCkS+vUVPMr9Ia5+2g4VRrNudk5/HPwKclxw8uIjxirl5pkVXmaDUfl6Oy
	 b7a34Xref5iNTkakHWZpDrvg2NQEw6RDxTUXcXuP56PzN85nptoQ3lyLSdnYUS9lopWBb
	 qqyvQwWOzxDTPoS3qMyqoub0iGn9YLJk3yAgE/NpLCXjHrF5nU1FdWz3SmZzycHH8cr19
	 8/svyYxbWcbJXT2sa1oWaA/w9yXKGCQGbVPVR8w2darXvcwwt7cFHe9Uj+RI4ESedXQei
	 G0l5slWoo4exY7aKHeNP41XXVKA02HzeEKKLhOTOkkji6CYve78k82AwqzmEML8RLBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571392;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=7jMaG7E0faIciRuA0j8698KDnNXPdfgqG5SZCjrpwFM=;
	b=v/MZbUthF9+Jdc4t5l5H4AQQIMWFhoxdOOoUJQlREtiuEX2rcAVAbBmR7FNY/j9oIbts
	 zVKpkwmQfqpBvj1t17rEtetATynziVj3CYz8rZue17bD4JrtIU+wdAczgoOKxEyPKLpQD
	 MvV1y2BZggk/UrjKdmXZcKYA1L1lQ2VbgTtN/ZJmHBlMELFQUBZRACXFaEcAE6B+Gs4w1
	 cmMkt7MN0yL/y55SUWCFXepem3gLE+KH5XOjzKyBsve6pYSg1BGEAlK/jurnUeC/Q/8Gx
	 C/Hi6N4GbwNnXKjVATYh9NZ/oqJ+GNj38bHK1U0WRjKmTjHcJ7C/UWmHUQmBOm8Av0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI6vqfud;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573C606E500;
	Sun,  1 Nov 2026 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI6vqfud
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4D81F000C1;
	Sun,  1 Nov 2026 22:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571392;
	bh=7jMaG7E0faIciRuA0j8698KDnNXPdfgqG5SZCjrpwFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RI6vqfudUDAPQJyogDLl2CpARmQSYi02Z/r+Di8qbeK3KcSdM0cWSldHGeHFd7Wmg
	 oZkcWTzbyfmhEOg5tcfCHfhpf6iaGm+isSH86qaujprBW88A0OM503IaD8+WPv9717
	 bpcrsoSfdrv6EFgcaHxAfgeqBVd+9Lh2jlei+lTKhKmrMmF1DDRxKwuNJ2YAzniH64
	 bTK3lBMxJ6uc9UCiWTe96qjtjhpAxsSnnRxROmumhMt3+M7z/8Bl4vxi21IO/fXVoH
	 wUHNq2epY1lAcTmYzulW8paMq9f4RX7rYBp2SAoAq4o7yj3fGB1UzuSY/Wrq1aK7S0
	 zpB9EvUeVfZow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5347838003B8;
	Sun,  1 Nov 2026 22:16:32 +0000 (UTC)
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
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357139104.2624073.10186400247460209292.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:31 +0000
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-riscv@lists.infradead.org, linux-mm@kvack.org,
 samuel.holland@sifive.com, david@kernel.org, rppt@kernel.org,
 akpm@linux-foundation.org, ljs@kernel.org, ysato@users.sourceforge.jp,
 dalias@libc.org, glaubitz@physik.fu-berlin.de,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, chenhuacai@kernel.org,
 kernel@xen0n.name, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon, 31 Aug 2026 11:13:22 +0530 you wrote:
> pxd_ERROR() macros have been provided by all platforms, which are very much
> identical and can be dropped off completely if these pgtable printing could
> be moved to callers in generic MM aka all pxd_clear_bad().
> 
> But first cleanups and re-organizations are required in some platforms that
> are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> macros have been completely dropped from the entire tree.
> 
> [...]

Here is the summary with links:
  - [1/8] mm: Make ptval_to_str() generally available
    (no matching commit)
  - [2/8] mm: Stop using pxd_ERROR()
    https://git.kernel.org/riscv/c/0666fc9d4432
  - [3/8] loongarch/mm: Stop using pte_ERROR()
    https://git.kernel.org/riscv/c/ea8763ac3af7
  - [4/8] parisc/mm: Directly use generic [pmd|pgd]_clear_bad()
    https://git.kernel.org/riscv/c/94d6c5466d1a
  - [5/8] sh/mm: Stop using pte_ERROR()
    https://git.kernel.org/riscv/c/6858e42cc2bc
  - [6/8] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
    https://git.kernel.org/riscv/c/3b225ce37f62
  - [7/8] sh/mm: Stop using pgd_ERROR()
    https://git.kernel.org/riscv/c/66a0441a1791
  - [8/8] mm: Drop pxd_ERROR()
    https://git.kernel.org/riscv/c/c970236c300f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


