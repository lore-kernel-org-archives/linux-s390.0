Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E22BD01B;
	Tue, 18 Nov 2025 04:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440261; cv=none; b=u5wdZ7gQH5xJQTA6G8RuShS91tNyrJymuihn+CtqFN03OB+4vwCh7HKTDXsmVr8GZhGI57G55Iit93qGU6N3mAh3pfxfigIfCcq9d40IMuQOC809/d1pBadkp9673DZybwUG+mwHxYXzVoawWNVc6i3QMPR6L5cCjXk3qlRt/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440261; c=relaxed/simple;
	bh=HWMyiBwKE2W6Sj+lpKnrUsKepO5aWdP8Gmo+uQv7bJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CpHbbvsV5EQvBu2cjWhmBlKulLMOqMUS6YgFHRWqxsc7TwFDBIPVJhy0iepCAmiqZD5zrP2ixd1YVLrmxCLl1OwyREMGm37noPUJWe9Qr1TAMwEdmSTPBQhfWvQh+3d/AyXz2Hl+7MeXzpPPwrl0YyhGYgXFuTgz1X3bhPj6zUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brVpmuXi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brVpmuXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C67C19421;
	Tue, 18 Nov 2025 04:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763440259;
	bh=HWMyiBwKE2W6Sj+lpKnrUsKepO5aWdP8Gmo+uQv7bJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=brVpmuXiQPLvZ+VAr8OHav0CIrvh4AMkxKH7pXfQWEY7IbViFtvbk988fDKGk8mnO
	 Uj1Ob/Gl3n5IPnfuJj23eB8g7c1r7lXQDmnwBnSf5V8/u5NzHfd5WJ13rbToRGcDDw
	 LRG/63C/xa5KBE0uD8+71ggCrnMaY2M7PHac9mHCNm59qQFer3rYZMuzGhjkGwGOiP
	 m6jqrbnx7wneuPfUoni1D0IEeTHT1Ha/czxhcv6RJmGyOkQ9nFR7/gQv46DTTG3mv3
	 O48NW86sBSBN469bgUK3FuD2u4o0yM7bn84/Rh+ZZA2jrR0xFVlpoPLDDV/IfdQS3/
	 kEf8Og4p6hbSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB23809A1D;
	Tue, 18 Nov 2025 04:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] s390/qeth: Improve handling of OSA RCs 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176344022550.3968687.8165181544114734135.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 04:30:25 +0000
References: <20251113144209.2140061-1-aswin@linux.ibm.com>
In-Reply-To: <20251113144209.2140061-1-aswin@linux.ibm.com>
To: Aswin Karuvally <aswin@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, wintera@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 15:42:07 +0100 you wrote:
> This two patch series aims to improve how return codes from OSA Express
> are handled in the qeth driver.
> 
> OSA defines a number of return codes whose meaning is determined by the
> issuing command, ie. they are ambiguous. The first patch moves
> definitions of all return codes including the ambiguous ones to a single
> enum block to aid readability and maintainability.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] s390/qeth: Move all OSA RCs to single enum
    https://git.kernel.org/netdev/net-next/c/eef1f5ae73d1
  - [net-next,2/2] s390/qeth: Handle ambiguous OSA RCs in s390dbf
    https://git.kernel.org/netdev/net-next/c/53e58437b470

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


