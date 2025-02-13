Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1A211A36;
	Thu, 13 Feb 2025 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468406; cv=none; b=K7SqyX22hcH3Rhxv90bvu5k1pJcAoPaA7AWAyGekbpuLer8i2VIffd83GrEeYIvTZa9ldl7DbroQMvLYBz09kGjsHSpbyVEKlFWHPzBwj2dBRQ2G9gQZ14NeDEEJXhT5RnMDAZaM/Bz44nBurNvjqzUkhps34NoEahb387Bjqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468406; c=relaxed/simple;
	bh=okz/Zp02PWPrwBd8hiza3ZcW4lXk0Cs566iIT1abH9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sn8DFMB1zujvQ0JSobyQBcddVGrWBkM7X/sQtgcYb3ueO6TJp4A6IL7ZD0j34vBvKVW2qha4vJGYRVBm0xPA1mRrQz1nPpr76PvyibBtENIyAm3FOWO7ffid+FTWs4H7RiVvDGRIN8IbYnFwbzLBRRq9QHerY6hZp2NFwa/ZzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksfHuv8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksfHuv8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F32FC4CED1;
	Thu, 13 Feb 2025 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739468405;
	bh=okz/Zp02PWPrwBd8hiza3ZcW4lXk0Cs566iIT1abH9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ksfHuv8/7kUOLamVE3TtiF7DPtGhEPXkPGjmSzpy72Vi+Cc0T9utZugjl/zqC+ySy
	 wTBI1oDP9KyQQSrIHIpaFAUwfSo8xdC00QKmy4j3mfSO5kj2SoJF0sGo00WRN+FyXJ
	 mft8+wzroWeH5wYdZlmUjzmAXO7IOkgoJL3WpdkNdDyrwnFHJZn/nS1G14NU5r4Hcw
	 eFpJHOg7u151ItdFv+OlFPaNVrVJa1lgalAC320Vx/+uzzXw7MINeRNXQ+jFoOdBhq
	 oTW4C6hsDQ0VJ3ipdraCiWUb1zHjBqgFn4SQzTntkeRU+3FfVmbg+ZLTbM2QD1wwRW
	 Z2sSES02Tmhgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB13C380CEEF;
	Thu, 13 Feb 2025 17:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/qeth: move netif_napi_add_tx() and napi_enable()
 from under BH
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173946843476.1311122.1215077839596322461.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 17:40:34 +0000
References: <20250212163659.2287292-1-wintera@linux.ibm.com>
In-Reply-To: <20250212163659.2287292-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 twinkler@linux.ibm.com, horms@kernel.org, kuniyu@amazon.com,
 jdamato@fastly.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 17:36:59 +0100 you wrote:
> Like other drivers qeth is calling local_bh_enable() after napi_schedule()
> to kick-start softirqs [0].
> Since netif_napi_add_tx() and napi_enable() now take the netdev_lock()
> mutex [1], move them out from under the BH protection. Same solution as in
> commit a60558644e20 ("wifi: mt76: move napi_enable() from under BH")
> 
> Fixes: 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")
> Link: https://lore.kernel.org/netdev/20240612181900.4d9d18d0@kernel.org/ [0]
> Link: https://lore.kernel.org/netdev/20250115035319.559603-1-kuba@kernel.org/ [1]
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net] s390/qeth: move netif_napi_add_tx() and napi_enable() from under BH
    https://git.kernel.org/netdev/net/c/0d0b752f2497

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


