Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C74D595;
	Thu,  7 Dec 2023 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8lO6UP1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2DB0C433CA;
	Thu,  7 Dec 2023 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701973229;
	bh=LDm1+QHR8otPnvd5qanmORyB5Bf/LNhiYArxQO95HWE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f8lO6UP1Sqq41OawP3hmxO8XqLS5s4UDhBRVSnBqbluAh1Ie+BOkuf9+Wmn4+fFkP
	 eyqdiS8t/eXheGxPdwxOoL+zK8fiQ4H8W66NyhFdCph2J/BQDtDAgpQxD7Ck2zEXwe
	 yMaas11FNBS9gONxXvmfHXU/6BPEIe1IWulwoDjJH2SW2O3/6MaeS7j6TSdK+cSsXr
	 EBCVF3PC3owTnoTvD+kecJ7iy7twB8eJMgd9Jz5XjBGAPShyhWnh/TdpPTAP946WLm
	 fEX4k3dvbdQinHMt6ryFbv+1CDhzFWbZwgk5PuTa6woiMzWUSy+oDL/Ya35LTGXqT3
	 0Ub9j3sE+hOdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D76C7C40C5E;
	Thu,  7 Dec 2023 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix missing byte order conversion in CLC
 handshake
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170197322887.20147.8322709345682789955.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 18:20:28 +0000
References: <1701882157-87956-1-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1701882157-87956-1-git-send-email-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, ubraun@linux.ibm.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Dec 2023 01:02:37 +0800 you wrote:
> The byte order conversions of ISM GID and DMB token are missing in
> process of CLC accept and confirm. So fix it.
> 
> Fixes: 3d9725a6a133 ("net/smc: common routine for CLC accept and confirm")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  net/smc/af_smc.c  | 4 ++--
>  net/smc/smc_clc.c | 9 ++++-----
>  net/smc/smc_clc.h | 4 ++--
>  3 files changed, 8 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [net] net/smc: fix missing byte order conversion in CLC handshake
    https://git.kernel.org/netdev/net/c/c5a10397d457

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


