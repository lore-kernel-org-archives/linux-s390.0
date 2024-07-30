Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206B1E49B;
	Tue, 30 Jul 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345033; cv=none; b=lPPCtcjJmazJUB4cPV3xdNSTiHxLoX1eiCZqRIuazNkF16NONFuun3YG3sVQV+GHFGu0kvKTXd5k6LNfXJZKcXpi9Zk0Ly5rDOu4Xe6IVpX3hUl7L+PNHrwXSEi82tw+p9vN4+32hVxqI0ybHAsSw80OJAsTXfT4f8tNx0UbyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345033; c=relaxed/simple;
	bh=lfgeEtagBWoltYQ7zCsWYAqcsvTex56SB8Q/IT3e7QY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sN40qaNzYsdH7BF+nP6TL5ME9Y+GGKDMGN/3faTEBR7O6YLYNzEBj6WH5OtAFbPp/uYYFCEg5khOVBVRiwEvGu/CTYtuh7e8xNFCyXVhMt1/wTJSu6IsrAbCa08K+k1N5+KVD7GvWluNLrGQVJGODHcYgMynyfRFlkAYayEqBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+8Kf660; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+8Kf660"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B22D4C4AF0A;
	Tue, 30 Jul 2024 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722345032;
	bh=lfgeEtagBWoltYQ7zCsWYAqcsvTex56SB8Q/IT3e7QY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P+8Kf660+oJ8nNnwO+GwMd1aZKtNwCYRLeN1mRx+UdKTnEmXIYuxCFpqrpdp+KtE9
	 pfDfPMNRcvDmU7dTu8n7C2yXIQKgkBT9OfJ5ZuaYhmNnarIuvWTRmoazN83fUU6mCw
	 tD54zdas00J6VXIu9+fN20WzTA1lw4WVQx9H0Jh1T3Sl1l5lKBTcDQPtY+Wp7bwipM
	 2LUwe1/V1q09FGbF2b9bJL9KbkqwaKqiNGIC/IgPhqTb/AibKskiAEa2P4cRj5y4I/
	 Rgbm21hEvqc6p7PSjl2lbp9Io9c+EXd/IV0HniwNWbqd9aEA1hFOPxzVplTcSGGI1n
	 6PkWsGooIeGlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FDAAC43140;
	Tue, 30 Jul 2024 13:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/iucv: fix use after free in iucv_sock_close()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172234503264.9596.13836669168003742879.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 13:10:32 +0000
References: <20240729122818.947756-1-wintera@linux.ibm.com>
In-Reply-To: <20240729122818.947756-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, twinkler@linux.ibm.com,
 pasic@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jul 2024 14:28:16 +0200 you wrote:
> iucv_sever_path() is called from process context and from bh context.
> iucv->path is used as indicator whether somebody else is taking care of
> severing the path (or it is already removed / never existed).
> This needs to be done with atomic compare and swap, otherwise there is a
> small window where iucv_sock_close() will try to work with a path that has
> already been severed and freed by iucv_callback_connrej() called by
> iucv_tasklet_fn().
> 
> [...]

Here is the summary with links:
  - [net] net/iucv: fix use after free in iucv_sock_close()
    https://git.kernel.org/netdev/net/c/f558120cd709

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


