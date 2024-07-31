Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B50190473;
	Wed, 31 Jul 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423038; cv=none; b=pN5uu2HuK3cGz94c1azAoucikO7ied2ropGu/PRdmIAPUdRLWnmW3luRMyxUw0QaHvmyTsP+p1m+OFgAcUoOv80EbctYe/A/jIsXCylOaXZRWvCNAQSZtbIV5nLBCJ5POaoY7u4AjAgATUnzqOulyMnb6qWVPsr2AIZ36fxxcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423038; c=relaxed/simple;
	bh=YJm1ep1g8ELz+nBh8v01EWIR6uWcQIfa4UGaHdAFFs0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DFP0Hltn7109kC1Cc9wlydPFzVtcAi2n6+SxTDUCAfu+lJrXcVxvL7Eq/gsu60wk5tNEMiX6GKF7XfH/xyUBIv9ulIlVr9M790QUl5ZlEnFtqvI38OY/0AgkKpeFYhXg1SEOZIutxxzPWE5gIJoIo57KZ/Cjq1Wj9wzNkmq8HJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nswf++b4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nswf++b4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 515CEC4AF09;
	Wed, 31 Jul 2024 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423038;
	bh=YJm1ep1g8ELz+nBh8v01EWIR6uWcQIfa4UGaHdAFFs0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nswf++b4MdJ/loZYmZKBd3aOQ81Akut+KW0XKAKpXyYKEt5qynMJT9Tc5BduqgUfp
	 Gc2zmEMYd+ddiuzckDtPbNqHZdZ80aL3D/YMdTjbomRSiEHoH2+Zx6iLbe9nJKqRRO
	 /GRpCicXPvyJbawlzNNQa/uA7Vio0UbCmZgMhYWBJU4AAQElkQf5KGiZAURTLKZEw5
	 3MB2S4XqqtQ5XHTjELb72j0x5ocZHPWpxgaIP4jIC4W3ieHeC5GcahLJU/AKrKFWb0
	 2uLqpw8YhbSdK7kNe/Z2N2rHuwoZLKAph7bvMw70/ye8hNxT0mSfH0B4tO3vANW1tq
	 JwBDAi3tQYU0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 432C2C6E396;
	Wed, 31 Jul 2024 10:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net/smc: do some cleanups in smc module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172242303827.15523.13029075934728153529.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 10:50:38 +0000
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
In-Reply-To: <20240730012506.3317978-1-shaozhengchao@huawei.com>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 30 Jul 2024 09:25:02 +0800 you wrote:
> Do some cleanups in smc module.
> 
> Zhengchao Shao (4):
>   net/smc: remove unreferenced header in smc_loopback.h file
>   net/smc: remove the fallback in __smc_connect
>   net/smc: remove redundant code in smc_connect_check_aclc
>   net/smc: remove unused input parameters in smcr_new_buf_create
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net/smc: remove unreferenced header in smc_loopback.h file
    https://git.kernel.org/netdev/net-next/c/1018825a9539
  - [net-next,2/4] net/smc: remove the fallback in __smc_connect
    https://git.kernel.org/netdev/net-next/c/5a7957571126
  - [net-next,3/4] net/smc: remove redundant code in smc_connect_check_aclc
    https://git.kernel.org/netdev/net-next/c/d37307eaac13
  - [net-next,4/4] net/smc: remove unused input parameters in smcr_new_buf_create
    https://git.kernel.org/netdev/net-next/c/0908503ade5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


