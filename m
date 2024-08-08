Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C986EB5B;
	Thu,  8 Aug 2024 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087835; cv=none; b=CpTw0bH9rpmumEHy8OWg4+bRS78Rn9cUGaMnUKSxjHJvSTIvnNVLmM/JT3ZPK9mHQ88YCeAEs5l6MT69pGQUop9n3uKit4cPqnjoxx7rE8RGs1mX7AHG48z2VQYlRkkH/O2/ecGvCcOLmmjNvKt+q1LYdXUZl1qcEfGUhuX3cfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087835; c=relaxed/simple;
	bh=ayc1JQ5FIzlncriQlhskTbwePOJ8AfkRCYzPyqcCLT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qkj62rAu0KgfU26yIpKvwYktronkQpsc2Py5CLaCSy9HAQUu3TA59kN7DR9BALFx8EgXy6Jni8e712FrZ4oCj3F4wX0H4i0KXxEvKmN+RyJL12hg+W1QyxYYN9tBBXYis9Zf156uVKEkNcpnjrHhNmEDdOTys51FwklviZZRLKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iypKuctp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iypKuctp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D22AC4AF14;
	Thu,  8 Aug 2024 03:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087834;
	bh=ayc1JQ5FIzlncriQlhskTbwePOJ8AfkRCYzPyqcCLT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iypKuctpIbpOY5INJA8X8DzBqZUqmKLAlZpcjCZzZNvw4qHNuKjH9IHrDirrasmQc
	 GKXOEXylEY114ST+NcGXgjyMm2xwIv8FLcx8/s9A/dj+NnR2jTCpU0IK5pvr2PhhyA
	 XSTxev5N4IBqCUpUSWTQjQ1U9z+m9uecRAN2mUwCrVmggLo6fYs1ejkHygzZStHrVB
	 uUsj1YqFrOWBASJRatVvHgkv56sZKZLyuPiirUR9h2PrDjUtNSUkzVYGQ3AMj4biGH
	 emKL4fI8PEVblYvkGG08KD291SlnL8bwjM0DbUwXddUpjaN84YDhkb8MDOyrnAOrBy
	 HE/oTPs1ton1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE15A3822D3B;
	Thu,  8 Aug 2024 03:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v2] net/smc: add the max value of fallback reason count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172308783325.2759733.12875720909280525414.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 03:30:33 +0000
References: <20240805043856.565677-1-shaozhengchao@huawei.com>
In-Reply-To: <20240805043856.565677-1-shaozhengchao@huawei.com>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 guangguan.wang@linux.alibaba.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 Aug 2024 12:38:56 +0800 you wrote:
> The number of fallback reasons defined in the smc_clc.h file has reached
> 36. For historical reasons, some are no longer quoted, and there's 33
> actually in use. So, add the max value of fallback reason count to 36.
> 
> Fixes: 6ac1e6563f59 ("net/smc: support smc v2.x features validate")
> Fixes: 7f0620b9940b ("net/smc: support max connections per lgr negotiation")
> Fixes: 69b888e3bb4b ("net/smc: support max links per lgr negotiation in clc handshake")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net/smc: add the max value of fallback reason count
    https://git.kernel.org/netdev/net/c/d27a835f41d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


