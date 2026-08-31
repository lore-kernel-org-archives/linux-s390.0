Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E93CCFAF;
	Mon, 31 Aug 2026 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217266; cv=none; b=MiaCJdJvAoXyXr/qsjck0IvU6jGhIeB36WKV11r2+N6atJ6qkk3UKRpc/psd6B2TgXNr1ZLkxFcS1Ttf9e32WxJodCKvJ7U3OykpQK0dOhzNCSXldwz0APngJ1OtwRLHR/vJXI8Mylz9vWCf2jeuCaa8QhL76WTUGR/TBwgNgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217266; c=relaxed/simple;
	bh=WowIQvha/ugYa7HKZ2uSPYoLHw5bqGE5fVHfqxYyb8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZpqBLB9Jr6bJH2d/XQ21k/VT/tbt1KpErfgqrb9SRH7YvlI0JPXUnD2nACiUeM3vROwuXPqhj2ix54n96tQ3IN9YSSoANWTu8WKCJBr6nEU7eHMJ/YlkxKhrIecDmYWhp2XG/kXj5Q35oAjq6T5Nwsc5QjVKcJGniOjCy2dQ1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMcajyzk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMcajyzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E9E1F000E9;
	Mon, 31 Aug 2026 23:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217263;
	bh=V3LhBL3GC770wSMu1d/5OJgV4ZFsOyL8kra6Xssw91A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GMcajyzkUOYkmHZJYaRxUrTcO/NajzbfhWfvJRBLea3ycPhIhagBIWxvM0DWRYceB
	 vqgwS748txojEwiZXV5NN4YEnXtR+o57j1Z075Ypl+D3ZHAIIdnHUrpc9i+ELJMG3B
	 KEVxCRgR+G0h6QtcTDQiWa6cA5ZnIaL89MgoW88c4NOMbUP9h4LMkrMtF9qfyXAvdM
	 vz6gaIMpGV204xmP4w6iMWerx746Vw1K7z31Itd1jtG2BUzt8byLyV5C6SQVT996NL
	 gZJ3wrY1seTvFeEK7FOqNC3+bIyVa1kO4VUwM+dAMvVUJC4wexlJ7l1R3uEVpdB/+U
	 4LV0GzHFmnRQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987F3924471;
	Mon, 31 Aug 2026 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/iucv: fix the recvmsg window update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178821720568.820683.16551074706319520837.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 23:00:05 +0000
References: <20260828-b4-disp-33fac0ed-v3-1-e6d061880ee0@proton.me>
In-Reply-To: <20260828-b4-disp-33fac0ed-v3-1-e6d061880ee0@proton.me>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: wintera@linux.ibm.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, twinkler@linux.ibm.com, edumazet@google.com,
 aswin@linux.ibm.com, netdev@vger.kernel.org, horms@kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 hidayath@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Aug 2026 14:07:47 -0500 you wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> iucv_sock_recvmsg() sends the HiperSockets-only AF_IUCV_FLAG_WIN without
> testing the transport, so on a classic z/VM socket iucv_send_ctrl() sizes
> the skb through a NULL iucv->hs_dev. SO_MSGLIMIT accepts 1, so msglimit / 2
> is zero and one recvmsg() on its own socket is enough for an unprivileged
> process to take a spurious disconnect.
> 
> [...]

Here is the summary with links:
  - [net,v3] net/iucv: fix the recvmsg window update
    https://git.kernel.org/netdev/net/c/fa5acd038ea6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


