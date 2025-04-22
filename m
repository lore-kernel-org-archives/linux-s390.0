Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941725B690;
	Tue, 22 Apr 2025 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313021; cv=none; b=IvxteeNFNWJAHJwDVLF5Q1iObGjhtlKfCNPxLUPxbfcl3eIGk+nk5y0VUrOsH9Dhlr7P79sh/vW9HDMGQmYAXrgoSmnIQMyF1tauMhNkj/+9n53ExTNB8zmLfEZ1C9TprA9ktRm0hwMEzWRDXsLcB04iUf39C7DRwqqMjYCfR5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313021; c=relaxed/simple;
	bh=rTFl97stjjs2a2UIbOlESEtFYiAc0rhT6u+bOAyltWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iGUTD1Inrt6XIkoZMTlk/6CmkpAY9osNGzNhCMu7/FzsrDUVhDSPCTxz0bj22idVWSXRsm0yfiB5ijDvPB5rff5B5OWhI2PLnv0FKdPkyeZ3Ifc49eaBBuibEw9sluzHmopjTlHM7nOH+8kovPXexFmE7BCs7uXd73OmdVklcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF2t4odc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF2t4odc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE8DC4CEEA;
	Tue, 22 Apr 2025 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313021;
	bh=rTFl97stjjs2a2UIbOlESEtFYiAc0rhT6u+bOAyltWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WF2t4odcFN3TY6plSYONe3IqBqimE+ihFfPB1fJrwx790v8tCJh0z6EhC7fO2NiDZ
	 d2sEnNPeGDEcmFLTty00SnKAac0Eg3szH6rVtxoRvMAiGOHYygI0FTLTno3mvhQMY6
	 0MbfLzTAJD0WPIVRThzIoTx8JI0bniVR1sKtlqA1R5XwtUzzWM1lCnH0TSGpAGNJiO
	 wJdPJio9pzxbKZqt/aLt2wdwzKEpi3uNYyFgdlWu5d3Ft4lE2rWXfxfucesKbNaNIu
	 t12njwDz9WrYDR9zRZVWHZyafk7s5vEp5IVsKk0SYEQNFkyiFmobaPlE/wN+q7D4IM
	 aQQ8Zk4SC8UHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC439D6546;
	Tue, 22 Apr 2025 09:11:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] s390: ism: Pass string literal as format argument
 of dev_set_name()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531305924.1477965.8234488898422063716.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:59 +0000
References: <20250417-ism-str-fmt-v1-1-9818b029874d@kernel.org>
In-Reply-To: <20250417-ism-str-fmt-v1-1-9818b029874d@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 11:28:23 +0100 you wrote:
> GCC 14.2.0 reports that passing a non-string literal as the
> format argument of dev_set_name() is potentially insecure.
> 
> drivers/s390/net/ism_drv.c: In function 'ism_probe':
> drivers/s390/net/ism_drv.c:615:2: warning: format not a string literal and no format arguments [-Wformat-security]
>   615 |  dev_set_name(&ism->dev, dev_name(&pdev->dev));
>       |  ^~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] s390: ism: Pass string literal as format argument of dev_set_name()
    https://git.kernel.org/netdev/net-next/c/199561a48f02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


