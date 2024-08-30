Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC5192D75;
	Fri, 30 Aug 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021025; cv=none; b=U0hCHmsrFVxmFHHnovaZkOk9OteMoOfO4iGLMTwaoYVV4wrq2mvgugq/r4vlH0Q/MJhSGywRMjULtDlmJi2zmFylQ/ln4pDwN7YDhX2mi+FcrFFL/ieRyJVwTEuOXLoVCSXPXaUUZ2fQkeP1AJNvsypGBZ14csBJoLA9uO41ft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021025; c=relaxed/simple;
	bh=xgMZfXbzDCIWmQ0U4CZQEU03diJia9Y6QR0RLV86l2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a9Tnm6qQvtge6o5fDWwi6rX0Y5UseKEMjksKKvzYn+NjqLt85hoG0lfBgJrt6HyOxBP7Aesw5kgSoVSZE6ak78KCxHlhUorxZ7vSfLvxaBXp7WY7tuzJADYSmoIF0eMzudLD/5kqFUXMlCdjBupZkz65BM0Fv9Txhn7uqWRQpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkY6uLmv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkY6uLmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE73FC4CEC6;
	Fri, 30 Aug 2024 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725021024;
	bh=xgMZfXbzDCIWmQ0U4CZQEU03diJia9Y6QR0RLV86l2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jkY6uLmvtylqu+4aAYJtIIMIDp+ExzAWwSr/s9dUmudyR+TZZ3DuRhHpA1lo+g0lV
	 O8V9+Y2bujTC3cEPb8dlxceoK/OtVIEdOVURQyTAbicVTq31GV6ouJTDp1f9xH4sDR
	 xses22Cg0J43kMWyi25IcN891USavNyHI+FUUgr8WEEEfOAxSZo/y1bJ7o/fh/3yxB
	 7U/F6DzTG0c4lNFsr0cYdTGp4TzwXGvYPR0zOOh3iEssvvMxzTed6vlQ8kAFGO9uZt
	 gLCpeQ347QMz2dtKga/EgfqztuI3S2+Ezxcfzihfxz45Y6P+xCqJA44zITZsusCEbK
	 RTe2LHvTbUoMQ==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 611DF3809A81;
	Fri, 30 Aug 2024 12:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v7] net/smc: prevent NULL pointer dereference in txopt_get
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172502102638.2576424.109691224137525490.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 12:30:26 +0000
References: <20240829035648.262912-1-aha310510@gmail.com>
In-Reply-To: <20240829035648.262912-1-aha310510@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Aug 2024 12:56:48 +0900 you wrote:
> Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create()
> copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet6.
> 
> In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> point to the same address, when smc_create_clcsk() stores the newly
> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> into clcsock. This causes NULL pointer dereference and various other
> memory corruptions.
> 
> [...]

Here is the summary with links:
  - [net,v7] net/smc: prevent NULL pointer dereference in txopt_get
    https://git.kernel.org/netdev/net/c/98d4435efcbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


