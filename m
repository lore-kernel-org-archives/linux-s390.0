Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077CE1624C0;
	Tue, 22 Jul 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145392; cv=none; b=iHNkwnNeOUrX/Vi6Rub1E/JonAOoneLtPHsk50EMzQZJo32DqbmE+Rofqej3CyPqYrNVOfS64DxmQXLf67x5GiDrvQd9RTT9k6Xue1ayDPS/6kuA7XP+SaXyEGvKyDSDBTmfi/33i2O0TYXfLHf09rlN2T2n6gbyYWZpUSnqEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145392; c=relaxed/simple;
	bh=lh7m0LgtL9aJE/iOfdTHANgA3YGFDv5un0xLUHMKMMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tod3dYM7aVVqX1xgOdgLyxkwrnYrU0dQBso5PK04P9ybKt6+OSIHq58603PEU8lB9maFAQa63ymxDWZEnDBH9l1BrqqKbiONfELRJKW9N+57ouDLBpo6g1TRR2sWTzvqMLRkUFDgBJJ6bAURsXlvLD7PIj5ELdGSLF/VgFa6WqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5xWR6xK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5xWR6xK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F0BC4CEED;
	Tue, 22 Jul 2025 00:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753145391;
	bh=lh7m0LgtL9aJE/iOfdTHANgA3YGFDv5un0xLUHMKMMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U5xWR6xK3gRV9FkoOTUARHsXZi1vt7TD3gbGuGCpSAjhGuNqJ9vn8mvJARf7vkeka
	 Ff41y/8sRxwtY7jOKjw+41ykuqWgpEnHVYTSatYZhpwF7j//YM9pd5zYXD4NPJOMLt
	 FlmHliRhe3FaCmpz/h1rUu9JSCyth7sfkZBG0fXv67Y8wmcx8kCdOxHLld4s+/tTkx
	 WOwsN+LQOgygTRu1Z6eS0dUUbC+RtDrA17j4DZxOBlHoMWC/MHuN6IHT5irv427RkY
	 gcDuTMlTjbummbKEPV7eib6zqtOfhETCEYdLT/x6WsOjZjOH6S5dp2iHnOImvzQcur
	 YzI1W7Wzjz0qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC7383B267;
	Tue, 22 Jul 2025 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] s390/qeth: Make hw_trap sysfs attribute
 idempotent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314540996.247888.18318407456120980462.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 00:50:09 +0000
References: <20250718141711.1141049-1-wintera@linux.ibm.com>
In-Reply-To: <20250718141711.1141049-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 twinkler@linux.ibm.com, horms@kernel.org, aswin@linux.ibm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Jul 2025 16:17:11 +0200 you wrote:
> From: Aswin Karuvally <aswin@linux.ibm.com>
> 
> Update qeth driver to allow writing an existing value to the "hw_trap"
> sysfs attribute. Attempting such a write earlier resulted in -EINVAL.
> In other words, make the sysfs attribute idempotent.
> 
> After:
>     $ cat hw_trap
>     disarm
>     $ echo disarm > hw_trap
>     $
> 
> [...]

Here is the summary with links:
  - [net-next] s390/qeth: Make hw_trap sysfs attribute idempotent
    https://git.kernel.org/netdev/net-next/c/1b02c861714b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


