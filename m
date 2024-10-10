Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1501C5781;
	Thu, 10 Oct 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577225; cv=none; b=YGLMyK6PldDmBthDABBkAH4kOdcXNi/XJAxhES896r+kb/k7wZogtzbm4InBD2JfwIazJTrl9Vpz4LzP9mgG++5tEjREwoEieXn6hnnqImlYoWTp7IsI+mEzdQ5YVRhqaDQHCJoEcSoVh1CpqKMXf9IYeHNE504nxvnhY24KmPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577225; c=relaxed/simple;
	bh=Y/vRwBC0NSixedfhhf3nsNRU03AZ8pw+MI46eJNDABA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L1gjqHwgtXyYBm3HFB7fK0h5MVyED9QPOtOcDuz7rM3TnLno1s2EHqjQyut6mP9dZq3lmELtuCj9s+nwALltr9Ur0EdtbG6IuO8eqsgrKm0gcvHYEkKzDW1bOVRg7nG6iiS5mZqPrMlUx2MgWa5vM99zewfb2MmmjshYtZjpek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7SNCwwS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7SNCwwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB81C4CEC5;
	Thu, 10 Oct 2024 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577224;
	bh=Y/vRwBC0NSixedfhhf3nsNRU03AZ8pw+MI46eJNDABA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D7SNCwwS6ktFwXe7UUHfjcxLPqCy3UTizl8MnlVK7EhWaFWHJ+9CVHnoMiL/f/pS1
	 OgSik506uStiyoFQsLUlKAo1OxdMs1juWzWXd1y+UUFGS4jFff5l5Gb9yvzca6ohOG
	 IUgFZmrhZMIXgYZv+/miRTE8PGb/fcoXC7+JMxxjhNDNxbaKN54dF/VS1vyxKqzw4D
	 CgH3EGalMID0oW7VVGTqVBoUM3LGikOY9PYMnBD9vnh9obMIDZL+cr2LVMPHLjWj2B
	 yYupTzPyvWoZqWKWCFy3o1rghggYWsGHLgUwosKRbWCPICZtrIHZes3gk1sB2LfWeg
	 c98N8acjvMSYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D113803263;
	Thu, 10 Oct 2024 16:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: Address spelling errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172857722926.2085114.2841272713422190930.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 16:20:29 +0000
References: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
In-Reply-To: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 rdunlap@infradead.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 09 Oct 2024 11:05:21 +0100 you wrote:
> Address spelling errors flagged by codespell.
> 
> This patch is intended to cover all files under drivers/smc
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  net/smc/smc.h      | 2 +-
>  net/smc/smc_clc.h  | 2 +-
>  net/smc/smc_core.c | 2 +-
>  net/smc/smc_core.h | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net/smc: Address spelling errors
    https://git.kernel.org/netdev/net-next/c/cd959bf7c3bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


