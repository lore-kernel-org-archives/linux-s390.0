Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B718F2DA;
	Tue, 26 Nov 2024 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612218; cv=none; b=QVUusKxOldZmf8TKaYa1ADJX3nDqsLxL9VRICEPmjwisb0pZrnkKxUkEiK90DutADKO8M5gCaEnBcYTlbefs8yuKVL11020J7q1eUh5l395JqYjJ+9Vm27GVxpiywbcfVOFX9KQyykNyeQ30GyekI5fqVHWLc5gY0K7GKvwlEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612218; c=relaxed/simple;
	bh=RKTl4ZHFTCDBw3opPPqPySWer7MgDg24OXtqlCf6FCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fSNUzrPlqTlX5MEOd7XFqpAldjUjnYm3xVMwAcrtdM0VIpRYr3KtCDMsYZmrgcWaxOYlQl1Oop97TxnzerP9+pPiYphYpb5gAqQRNCRM1XVkrZAirl0ngTx4AU8/1zJxs4iw2USuyjMCFFzZYHj6/qea++iWGXGwfjuJ7I6uAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHju/Ee8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHju/Ee8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9621C4CECF;
	Tue, 26 Nov 2024 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732612217;
	bh=RKTl4ZHFTCDBw3opPPqPySWer7MgDg24OXtqlCf6FCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SHju/Ee8NC8GX4VgkopikGbogKtOK4d/8yp6X13USAS/K0SX8KV14nyI5OtIW45Gs
	 Yimzhxwa3t84W236WKKEH4AoOoj8reVD7YgOWxtqwjySH/cdmapAnfyySpUaKounKP
	 w1UU0b2r1U6/hBtPKqgOV9HiR7/tKSPTVb9ZugAfT9cQU6YFcWB2X22HJSFb+Ez3V7
	 tgk0evyx/nlDycViEHlwtXeTGdMuJQi+s6NZ/wXvdvkvVptlgTx/dCOs6Xrxklxs0U
	 CusJnUeujTXkgelnZcqeFDOaL0M/9lxcgI9BqXsLVjs/au6E3OH4O6oKHuT/VnecmQ
	 A9LO/qISZbzSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3CE3809A00;
	Tue, 26 Nov 2024 09:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/iucv: MSG_PEEK causes memory leak in
 iucv_sock_destruct()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173261223051.316212.8347433268494188785.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 09:10:30 +0000
References: <20241119152219.3712168-1-wintera@linux.ibm.com>
In-Reply-To: <20241119152219.3712168-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, twinkler@linux.ibm.com,
 horms@kernel.org, sidraya@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Nov 2024 16:22:19 +0100 you wrote:
> From: Sidraya Jayagond <sidraya@linux.ibm.com>
> 
> Passing MSG_PEEK flag to skb_recv_datagram() increments skb refcount
> (skb->users) and iucv_sock_recvmsg() does not decrement skb refcount
> at exit.
> This results in skb memory leak in skb_queue_purge() and WARN_ON in
> iucv_sock_destruct() during socket close. To fix this decrease
> skb refcount by one if MSG_PEEK is set in order to prevent memory
> leak and WARN_ON.
> 
> [...]

Here is the summary with links:
  - [net] s390/iucv: MSG_PEEK causes memory leak in iucv_sock_destruct()
    https://git.kernel.org/netdev/net/c/ebaf81317e42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


