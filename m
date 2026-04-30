Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC134B404;
	Thu, 30 Apr 2026 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519547; cv=none; b=VuuMeyqCgYPPcRpQ6nNWnod1SYwYfBKvIQXakkLOb7R1EXP1wJWFryuSvu/sOkvkSB7gCw4K35l09SC8WFjO/MYQG331kKgmCB9ON6VJiPIJxeK/32qpwlsd65alYR5EgGWh2ANDMX520SSnLW12C/D6Qwqej8FF5oKAux3NwcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519547; c=relaxed/simple;
	bh=dFN6b0A1gSAjmpxBdfCzLd7sjLkkLRUt90cBNTEzJS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s3zNbQUqbFTWu6vaPiiGlleeRQiQ+Hje4Z6wPUPYFFW/PeZrvrRL3xWjcPkBcvZIdbhBLntPLnupBxn5KrCCEaZe5yQYqX894dht+JqqtCkGfafGzuoGFWYvRMN8qZqBzdsMLCCfxWEMtC0WqnCZoPd0hYSgalpvxsLG8Cgpkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK4W1kKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK4W1kKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE62C2BCB9;
	Thu, 30 Apr 2026 03:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519547;
	bh=dFN6b0A1gSAjmpxBdfCzLd7sjLkkLRUt90cBNTEzJS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oK4W1kKQ5frD7xBp2Peo4k+zymjuUiJnLNz1vcnh5EFW4Atm0o1eacKZFX3kxsdMB
	 Z/9Bybkbt3e4DSKls2D0XjOElY/uAFwJmkXI/D33yiz2mgpn1fh1pHq8wwtdcupk2H
	 lxsRxcmcLT6uUAPcxQs3YzTqZheDJf8qP4uhFGhGgLv/DTlHLkFL3nUxAt6MFMm3Wn
	 udAWzPlFVeqX0qf5lNmUGifS42MtZaKyGgO3cIqnJJYyJsJWf51lM0MqpG8QFB2ry2
	 1jlaoCGMchkNV4IFNSmAKO5kJWwGEnpPKMc5ZEWOTjjRj0oKTos1CMGgTRvfcPXQMF
	 j0NI9CkIJOSPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDA63809A07;
	Thu, 30 Apr 2026 03:25:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE and
 cleanup CONFIG_MIGRATION
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751950193.2274119.6306882784421764696.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:01 +0000
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
In-Reply-To: <20260319-config_migration-v1-0-42270124966f@kernel.org>
To: David Hildenbrand (Arm) <david@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org, ljs@kernel.org,
 Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, linux-rt-devel@lists.linux.dev

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Thu, 19 Mar 2026 09:19:39 +0100 you wrote:
> While working on memory hotplug code cleanups, I realized that
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE is not really required anymore.
> 
> Changing that revealed some rather nasty looking CONFIG_MIGRATION
> handling.
> 
> Let's clean that up by introducing a dedicated CONFIG_NUMA_MIGRATION
> option and reducing the dependencies that CONFIG_MIGRATION has.
> 
> [...]

Here is the summary with links:
  - [1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
    https://git.kernel.org/riscv/c/078f80f909ba
  - [2/2] mm: introduce CONFIG_NUMA_MIGRATION and simplify CONFIG_MIGRATION
    https://git.kernel.org/riscv/c/6ebf98d71f9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


