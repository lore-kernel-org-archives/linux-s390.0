Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C2219E8;
	Fri, 27 Jun 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751062780; cv=none; b=pFJp5vkBzqelwEiFi983VPd1ss6r7Oln0nKV2ys2dADTHqMvmsf9dHsFWHxnPU+ChLsAMQCy81HVjj4S0/GHJiu+rA6Hm94A/KY5D+q68s7d5yx8hfuiEDD4Dw3sq0AVDmOxjL/yzbxigjwpm6pS5q98e/qofrClSS33a4MnFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751062780; c=relaxed/simple;
	bh=6quqVvu/Z9JLnoWia/dIUJKzUyovKEVlzIcedxWAH68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X0i7J6Ge/Pa4y3UenMOyqQGnlJFdQ0R0gF8ZPJJ3qAp1g2hgV3J9F4eoKqTwShAwEUIGOeUrS45BC6htObiMkx2iEwEFgMLLzY8B52XodT7SSswQ2xAAeADc7FAFkXmEviFhqSkK12SlLSPtGV1Shkm5NFtq9ob1yBVazNnt9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP3lW8ad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP3lW8ad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5152AC4CEE3;
	Fri, 27 Jun 2025 22:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751062780;
	bh=6quqVvu/Z9JLnoWia/dIUJKzUyovKEVlzIcedxWAH68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rP3lW8ad5MjlhUOgE5Z52zH5exQsBOT4ErWWrJhzXupEamVOZCZ/pY9HgaC2cb2wN
	 FyMtR/JSv42CKkylLDVJIjClemWSo6DzsTTD+QLSmByIkjYw+zVd8ipsAaqZxS2WZs
	 on7ZrmKQTrHekO6uDXa1Ax3abb2BKb5NEImf+sATLT/B0P09ASFab9Yf6udoW6eGY9
	 Jdw+16gHmRTkoC9FUdlHPrFL1IzFli6oK1Ja1XkvZf0ty+aZWaFZoI8I8kw+/HcgyR
	 pcSJ6icMihM16B7b1E+toi8dhkSQ81Lb+tlpxU+E01eul+SURLoomWuHxA4qPS6BFR
	 lU5Uv5FtY3Q4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE338111CE;
	Fri, 27 Jun 2025 22:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] MAINTAINERS: update smc section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106280626.2076129.2564280805496966509.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 22:20:06 +0000
References: <20250626051653.4259-1-jaka@linux.ibm.com>
In-Reply-To: <20250626051653.4259-1-jaka@linux.ibm.com>
To: Jan Karcher <jaka@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, wintera@linux.ibm.com,
 wenjia@linux.ibm.com, twinkler@linux.ibm.com, pasic@linux.ibm.com,
 sidraya@linux.ibm.com, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, alibuda@linux.alibaba.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 07:16:53 +0200 you wrote:
> Due to changes of my responsibilities within IBM i
> can no longer act as maintainer for smc.
> 
> As a result of the co-operation with Alibaba over
> the last years we decided to, once more, give them
> more responsibility for smc by appointing
> D. Wythe <alibuda@linux.alibaba.com> and
> Dust Li <dust.li@linux.alibaba.com>
> as maintainers as well.
> 
> [...]

Here is the summary with links:
  - [net,v2] MAINTAINERS: update smc section
    https://git.kernel.org/netdev/net/c/8550821a1535

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


