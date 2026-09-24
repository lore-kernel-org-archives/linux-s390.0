Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3634AA584;
	Thu, 24 Sep 2026 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271088; cv=none; b=hqp+KPHUiqNEpzqOZrOnabga+ZGnhJrAmwMcm/MTs5fRP98Y++n85cJiVI7MbN5qYinbwU/MvSxUkPV5gFg/ISJF9IexssChYF/AuSvsXcsa+1DoY2y/9fjOgpPrkAGALMnNLJuNpAHtMQDM1NKS6uPutO+vNBY1e3Fimw6vjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271088; c=relaxed/simple;
	bh=06ziL0RQRL9TCPSmcLvBn8CTd9XAoKLt2E4pSpKn6OU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=alJOj7DG7Q/UMJebv4mnhynTpLCEWtDwU7V39vYLruAW8HIK/RY1VAgp5w+t3/jak5Cey6mCQ6aEB60Fp/tEaUbkl1UeOEJE7EXXA3YtyBhSbzQqcSVNLsOXGBpH7xU8TkrVhhqRFbhA0mkBjcXcVw1jUAcZ3wGRwlnfkgeuVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWaGjnF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWaGjnF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75761F008A5;
	Thu, 24 Sep 2026 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271086;
	bh=iWOLNo1mLwckcIG0wWd96JZ1/dAzhuTPrH0dhPCBKls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZWaGjnF/6T5MTmQBuc67S/Lh9z75vV8/nYDDWrVNv6X0q1ZDrD83gh4jUBWBNmSZl
	 LGmGdGPL7xVzis6V4N8XwrwJUNV134svitBEQ/1Yi2ybCY9dTVP4bWmoYkKOTmLVjy
	 olR79yGL64Ug1XP5mBow/P9o0PFsv1KcUsLmXX8r3NetWGs+ju7GklLtKJenSIMkit
	 dEbRHusrGHbf3I6BJ2fhfI6bysFHqhLOawLP2jLlBqaMOw9iLwvP/28mc3429gDyge
	 9/DSgj5drWrb6xmMBxQ4kkyBVoHayxwzoj99BOOSOci5liuheMWTiBtb7DThkZ7inp
	 JWBXEacKzN06A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0DB03A566DB;
	Thu, 24 Sep 2026 17:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix UAF on lgr list traversal in
 smcr_port_err()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027101539.1669750.15408132491451759751.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 17:30:15 +0000
References: <20260922073149.474762-1-sidraya@linux.ibm.com>
In-Reply-To: <20260922073149.474762-1-sidraya@linux.ibm.com>
To: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 horms@kernel.org, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, hidayath@linux.ibm.com, pasic@linux.ibm.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 09:31:49 +0200 you wrote:
> smcr_port_err() traverses smc_lgr_list.list without holding
> smc_lgr_list.lock, allowing a concurrent smc_lgr_terminate_sched()
> to free an lgr while it is still being dereferenced.
> 
> Hold smc_lgr_list.lock across the traversal. Update
> smc_ib_gid_check() to call smcr_port_err() after releasing the lock.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix UAF on lgr list traversal in smcr_port_err()
    https://git.kernel.org/netdev/net/c/61cb282fe97b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


