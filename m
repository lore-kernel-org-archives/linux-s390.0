Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468083DC84C;
	Thu, 20 Aug 2026 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260862; cv=none; b=olxcpIsM/Y6GU4nIUGUrqzPiLsYHOk01JWIXC8YrYx2MLOiRE0vs7aYBxIfAlCz20q1oT83d5tmQvKZc6+bapEsPdMfLJ3RYLNFDfCZ4vEQ2S7IllLBBGPxuT69KSSP6ojA++Ik+fDi2997rdmYf9DSGoPexQorj2LPR0ILFiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260862; c=relaxed/simple;
	bh=/OZar+hXES8NmK99LVUKSS/Gd2B13Fbq+ROqEj/YGgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BghCTauTvk9WBeM3ovyWG8W63QCeyK7DezTnaZ97cY64olV5cLbaUP5BUAL1bhHmEm7F1BCMNoZgrJjdxXMTAtTKZqAbgITabuT4bjEFnfuks9fNHnOgsCgd+MjUZHVANU9qznkZAq6DXGy6JlWyb450xjMVREa2F6IRAf3lDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyWRgRSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyWRgRSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02211F00A3A;
	Thu, 20 Aug 2026 21:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787260861;
	bh=uDNFb2ziRldfusGy5sfr09/4Uuh8b7cSYJ/ewjTv5bk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XyWRgRSZRaaOY4P841ayCzV1hbM64tESeWyIG7blReRfFtUgiYtPZBu5BzkmJNFGi
	 vNYYuALhSPssu5KsZEAch9kFBTcBAFTC0ed7HBiloDuNsDJrBTQ05DAxIa2/mY90p/
	 /uoDpC164nANShnhonRQzcewPJ8JmO58njL7bZIUb03ZZZjXuZqid0mjEZOWCk8YKR
	 R+PyeReByjTaXr4hGZavyetecF0cRj/gUaTMazGmaY5i6dImqjFa/Fu+M9SAc4ZLF6
	 kGA82KZVwlZ2AhKHUr1r7m6cOKQRFaGoTDpYQNp7IMrCyaTR5DIL57J79iJe+JJYoL
	 1eSevKy/DZUxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567D23924468;
	Thu, 20 Aug 2026 21:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: free stashed qentry before overwrite in
 REQ_ADD_LINK to ADD_LINK transition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178726081088.489531.2829353523689897272.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 21:20:10 +0000
References: <20260818073107.466506-1-mjambigi@linux.ibm.com>
In-Reply-To: <20260818073107.466506-1-mjambigi@linux.ibm.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, pasic@linux.ibm.com,
 horms@kernel.org, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, hidayath@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 09:31:07 +0200 you wrote:
> When smc_llc_event_handler() transitions the local LLC flow from
> SMC_LLC_FLOW_REQ_ADD_LINK to SMC_LLC_FLOW_ADD_LINK on arrival of an ADD_LINK
> request, it calls smc_llc_flow_qentry_set() unconditionally:
> 
> 	if (lgr->llc_flow_lcl.type == SMC_LLC_FLOW_REQ_ADD_LINK) {
> 		lgr->llc_flow_lcl.type = SMC_LLC_FLOW_ADD_LINK;
> 		smc_llc_flow_qentry_set(&lgr->llc_flow_lcl, qentry);
> 		...
> 	}
> 
> [...]

Here is the summary with links:
  - [net] net/smc: free stashed qentry before overwrite in REQ_ADD_LINK to ADD_LINK transition
    https://git.kernel.org/netdev/net/c/036322025d6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


