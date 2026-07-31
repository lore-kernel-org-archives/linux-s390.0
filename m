Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5346984C;
	Fri, 31 Jul 2026 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541245; cv=none; b=NhxpU6Bv2UnjTNL0l3mt4vyiRPbtitlVWz9bq/Q/zA5F2NttGG2V73/HhNYJ8P1L6qmjw0xpFBEHl2CbKIG7X/WXYGK5Hwm5sFgNGZBaNtIPtldKM8064DqPU7MWsuZa/G9l6gm0i4gfqb3ymLczTLlmWClmvuX6v6zEIsMH49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541245; c=relaxed/simple;
	bh=XRTxxKWzYXVhzKB5EJGHyX69r9lyo5VCFc6G5kgpZZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YbSwnYjraXYmXLmw3HWvo0mtpw7YnZnckyGJGxZNJmVJaGjf/uSQklh/zLI6SPVCYH8zOAwah2sDL3kwMUhWlLnbLAF+lUPElfZ80h8MEdV/tj/HJfhDWsbynUA4M8Y+j+rsc5mKp+gYNHIIN4DtyyCQaBcIDMiNTgEsmYZTKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObREuibM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObREuibM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DF11F00AC4;
	Fri, 31 Jul 2026 23:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541244;
	bh=hZSAmr8CC7cFdKREjp/PS4yN8Aon/mFMCFm/muWH+ko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ObREuibMaqfFDQeA/nA3ig4vlr86zMccCGlwUr6Y3pLOOOB4yTW/ISlIl1/KTMwuS
	 KrPVMODThL0VxhR6FN7gV0/PjiyMBVr7tGzGAFMIss+/nLiWmJ6peLlJOQqldtbVCd
	 FYCF1tzCucRr9UMYxSb+Gzj78lubJnpVZ+/f+0jNRyHGGLhI+UAXPBN754y1qMeIBi
	 yCXrLosmieDl+xrng5hC3Y5fOtd56ophU1s00O365fLGXz3S/Exy5YZxxUGkW4tYm1
	 5ySJZmnEpiPNREsdrGjGnt7NxvBNbEPMffgiEmtliiQf5HP/YrVu/UY5ICHTBn+1ob
	 77VcPDwqpzYIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E4392665D;
	Fri, 31 Jul 2026 23:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix qentry overwrite for CONFIRM_LINK and
 ADD_LINK_CONT in smc_llc_event_handler()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554120689.949682.10784934094137290193.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 23:40:06 +0000
References: <20260729130153.970800-1-mjambigi@linux.ibm.com>
In-Reply-To: <20260729130153.970800-1-mjambigi@linux.ibm.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, hidayath@linux.ibm.com,
 pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 15:01:53 +0200 you wrote:
> The SMC_LLC_CONFIRM_LINK / SMC_LLC_ADD_LINK_CONT branch in
> smc_llc_event_handler() stores an incoming qentry into the local LLC flow
> without first checking whether a qentry is already pending. If a malicious or
> buggy peer sends a second CONFIRM_LINK or ADD_LINK_CONT request while a flow is
> active and flow->qentry is already set, smc_llc_flow_qentry_set() overwrites the
> pointer without freeing the previous allocation, leaking one kmalloc-96 object
> per spurious message.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix qentry overwrite for CONFIRM_LINK and ADD_LINK_CONT in smc_llc_event_handler()
    https://git.kernel.org/netdev/net/c/976245094925

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


