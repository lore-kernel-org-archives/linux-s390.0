Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6C2F7F02;
	Thu, 20 Aug 2026 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260860; cv=none; b=K624aFjEdq1ZD6ImdkWuuOEjNGjQEQNpnQfecP+gXaGGIh/bhMRC2bhhoxmmVK37ApGt+X1OFTp/rpEIO50nD/gb4BLgk+bi6XEUxdNDhdmqs2H7aBx5WspTYMpviPNpsToII63x4Q7U6wpUcU9aC37DkzynGMbjURuj18a0Gas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260860; c=relaxed/simple;
	bh=XKNaCUr8XaPY1QTjhk4MQjJ9UIRD3+zFV8Ex9ZPzGEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tmJw2MmQvJdHwIQxaWcC0dRHOJGLNJ7HMpZT0pMn7ql7Q6yYFqqBlZgCdZKO/pCh/LZ2KXe3zD0pqbGpkVUk9Pm7dtvtuK6cqmvRV6AbMfx7/rgBcd2LSd3lRsRa95OGAWxBCmixElcttHqC6TmCV6DJXIVF4bxvhaxqVn1Sz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOF32POR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOF32POR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B7E1F000E9;
	Thu, 20 Aug 2026 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787260859;
	bh=5OhYN0TpWYahjIukHPSp3b4fhuj2pgqkED4aawKOhq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cOF32POR3LGbMbn+8+GDzsfqzNkkLkqQz+kvcX6HHcWd609DkVbAMfPRIsEG5kxSD
	 QUP9irccdOgTW/UurjzCP30ORw0eNjkN6PjW5H/zKnyRAx9n/3cl6so3fwBon0x8t2
	 uFfOuCX4ahZvKmw8EXZHmtyEoiAjCJ06PZF32f+1or7LlZ8KzhVM1okstRrSf/+5rV
	 suKKiYYMnsYjwJanGyeEtcnWGyiwB0yGsCoiB35EzDY928qE1APjxUXXC4d/IYwuJA
	 Hv1WDjOZSr744XpIPrN5A4PdDFT09rMstIHQg1fOp2LVfFChPBKnn3IxRLLhlgAeBH
	 sYTA3z66HbOug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A6A3924468;
	Thu, 20 Aug 2026 21:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: free pending qentry in smc_llc_flow_stop()
 before memset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178726080939.489531.13527567712780542803.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 21:20:09 +0000
References: <20260818073943.1108383-1-mjambigi@linux.ibm.com>
In-Reply-To: <20260818073943.1108383-1-mjambigi@linux.ibm.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, pasic@linux.ibm.com,
 horms@kernel.org, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, hidayath@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 09:39:43 +0200 you wrote:
> smc_llc_flow_stop() resets a flow struct with a blind memset:
> 
> 	spin_lock_bh(&lgr->llc_flow_lock);
> 	memset(flow, 0, sizeof(*flow));
> 	flow->type = SMC_LLC_FLOW_NONE;
> 	spin_unlock_bh(&lgr->llc_flow_lock);
> 
> [...]

Here is the summary with links:
  - [net] net/smc: free pending qentry in smc_llc_flow_stop() before memset
    https://git.kernel.org/netdev/net/c/5ee0ceddc778

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


