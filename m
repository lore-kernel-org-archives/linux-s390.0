Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DE44A3E0;
	Tue, 18 Aug 2026 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047858; cv=none; b=C6u788FfUCGCP+D19PMsD+E6anctnKkyyVvUwNECO8Rn4CDM3mEMlB8+EVmGKVEI3mUSSNFDV1C+MvewF7z0WG97asPKhe/24z8xLpn3D+1d5HtL+GqLa5ZqfHMCZWsJt7HZnVYKSElySmIpwwX9Ak+a5c3A4FvzWALZq33KiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047858; c=relaxed/simple;
	bh=fUDVVJv5lLqekB9c1UDLw54b9y2QlM0mHzmh6r0Aod8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i8a46QD0fTtohtKcZ/rVNPi3vqvWyrKtVSgWnk4qSqtGdfzd1EACIsSZUyPorzP6uWyCn8khxRYq6d6JYH6l5ipH/O3LfK4qXrNiBHdu8se9hQIHnQQH9V91RljgZhHu6iwKttCdJECb+yudbILQFWJQb0uRIONpDr07Gr+VjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH65A0+6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH65A0+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E08C1F00AC4;
	Tue, 18 Aug 2026 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787047857;
	bh=0jwFKDbt4DAytBIRaVDTKH8dGkigR326D8swtFNzEOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TH65A0+6vxoyz7mDt++NqhO6CU0J72VbkKB9Jd1vBFYQItRDtiteHR7HzbVr0apuj
	 zn1yXpAcWPD7NGy5Fj1rn1RB4uV1g2XWQTA+Mw1ITjlx/RsiRy7MqbZw99mm+043hV
	 6oGOT1qPx2bLakEhGXoxbdveYoNoWJcG8aAGpmQUCAoJyTKKUdziUNNw7yrdbslCPu
	 y4SsofgSP675XX/WDdopBGIQadLXDITXTY3qhmNWWkkq7w7DdGXeihWzAdC1QNDl5j
	 o/1119Ki8OF0HdA1dDhRGsBbUrCME+L4RiFcsQR+hD/TKN6Fw+8Hu3yF2PMt2G7yyO
	 cpTC3xjRC4Rfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197A93926645;
	Tue, 18 Aug 2026 10:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: hash socket only after full initialisation
 in
 smc_sk_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178704780864.2000568.4734388817870408144.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 10:10:08 +0000
References: <20260813074315.554926-1-mjambigi@linux.ibm.com>
In-Reply-To: <20260813074315.554926-1-mjambigi@linux.ibm.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, hidayath@linux.ibm.com,
 pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Aug 2026 09:43:15 +0200 you wrote:
> smc_sk_init() calls sk->sk_prot->hash(sk) before several fields are
> fully initialised: clcsock_release_lock, the saved clcsk_* callbacks,
> use_fallback/fallback_rsn, and conn.close_work.  Once hash() returns the
> socket is visible to concurrent hash walkers, which can then observe
> uninitialised state.
> 
> Move hash(sk) to the end of smc_sk_init() so the socket is published
> only after it is fully constructed.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: hash socket only after full initialisation in smc_sk_init()
    https://git.kernel.org/netdev/net/c/8acf691d8017

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


