Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002A1946AA;
	Wed,  5 Jun 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577431; cv=none; b=MAR9CKn+buGPDZ/798OI6vszYt6xijbm7MdGHTuyUDE7YJUfQWXIaEcK0hZkKTzj4xhnOTyJ/pVgKNo5rTbhCHFXf+oXCS1xQB0toH5QrviK851wOKn4i/5IfRYju8GSB8Dbd3P4hokSW9PRnercvYP9EqfBgke5DQ/Cwhdy7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577431; c=relaxed/simple;
	bh=cmMrnBLmILI34bSTEqGAFTuSRh1IzjExT7ZUARg/WJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sj6H6zeq1AFWttKa080Y5HZ+PW3cPGzFjkN/2KhXgNN/ach2CNJYTRhTbXAf0afKVneo12ZdlrUNbxCmMmeUfDX8dBStNZmTMcsf81bCkwEuV0BQzjsslBh2Yin3cKvdik5VWg4eRi75Kq33BXx2LyE9qEeNUQUwXOC+2+mUDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6xtsRDk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6xtsRDk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4210C32781;
	Wed,  5 Jun 2024 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717577430;
	bh=cmMrnBLmILI34bSTEqGAFTuSRh1IzjExT7ZUARg/WJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N6xtsRDkaq49UIDroEsNvxouCqW8q7CcDA3lpeYf6sY4DDrKSmIwwB8gZOtLJ8Rf7
	 krBx8JxYUCWaDy2ekP3RhVd3dnmxxshy5iyj+9bWmqPgE2sO9PAfXWyiYNh8D5oXFs
	 BQUy9B8C2lcrEOtRTR51BLfqClYlG8puJUyJDLpmNh3iCnH6XgfdhGUDWM+IG+XS7o
	 23E66TDeg3Yh4Iu1beS1z/mNxel7paKJmXjC6Vqxeo0H+mveYzkNztNU2w0Vrlcvy3
	 YOazODgZxAeRBsnaugeYXZbLfLuohruaKakbINlF2aXdKdn/Y//ZMvSSIt9OWF+AsH
	 CwqyHcKug8BEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92768D3E997;
	Wed,  5 Jun 2024 08:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: avoid overwriting when adjusting sock bufsizes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171757743059.31154.18322845885224431622.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 08:50:30 +0000
References: <20240531085417.43104-1-guwen@linux.alibaba.com>
In-Reply-To: <20240531085417.43104-1-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: gbayer@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 31 May 2024 16:54:17 +0800 you wrote:
> When copying smc settings to clcsock, avoid setting clcsock's sk_sndbuf
> to sysctl_tcp_wmem[1], since this may overwrite the value set by
> tcp_sndbuf_expand() in TCP connection establishment.
> 
> And the other setting sk_{snd|rcv}buf to sysctl value in
> smc_adjust_sock_bufsizes() can also be omitted since the initialization
> of smc sock and clcsock has set sk_{snd|rcv}buf to smc.sysctl_{w|r}mem
> or ipv4_sysctl_tcp_{w|r}mem[1].
> 
> [...]

Here is the summary with links:
  - [net] net/smc: avoid overwriting when adjusting sock bufsizes
    https://git.kernel.org/netdev/net/c/fb0aa0781a5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


