Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F41F0992;
	Tue, 22 Apr 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312965; cv=none; b=EN3yrxjhrTQv0Ix5XApF9ZHwBSPZ40G5vznQ/+g7Vo1pBOMtPHcNCpBMf5q/AJYlAvzk+brvH3DMj1uu7p+Lcevdn0M/pswcTQT8mQH50xDAWDwFxbnHnSfMv/bPLKoMSBoEwJx7Ju5acvko9NKYdYv2ISvMnvaTIXtrvJZZXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312965; c=relaxed/simple;
	bh=M8REwVuC8ERwbaL2NYwW6flRgaYxkvmNy+8nuosqI7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ANS7funW3XPN7eXP+Vp6vIn18O3IqyU++ncesp3QtrJUnHeU5iuT1qpVsBuGCe2VIb0exgpZQwFdWk4Pb7jzdWQwopox64XLk3mAGZhHGp/iVs0gMwq8ysdm5n7rY94ATEwHjnbBVHXVCWY55ZpSP4rYOuefonaVFJ1fw92XseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwWIA+ya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwWIA+ya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17417C4CEEA;
	Tue, 22 Apr 2025 09:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745312965;
	bh=M8REwVuC8ERwbaL2NYwW6flRgaYxkvmNy+8nuosqI7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pwWIA+ya7SDN53NdB4rUAiQdz8Umz8Tit18u4lcCAXDYgWJfj37fC9viWTR+mDEax
	 yscmNMewMfJpyYG/GqIhMSr6vRbDbpJhZ06NftRGM7ra6EMwY9pJeXt0h7XSpqEXJo
	 XriZ8qijYl6h5sIdeIGPjBHeT4gMUQ5aiDNgFOQH8OCssTjfoyyI41KVp72kwx8FkL
	 Vc71jtL6GVQHbUJPaXozkMhmBkSfogSsUwELJ4s8DWm91suZt38qbaYE9EWw7eksyl
	 Y89yqfyZsiAPMHS/BjSvtKKTtlP3J61EHkSBr1miZG7O54ae8HArSCc0UqOBODh4mt
	 iS6SehTxpNKCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4C239D6546;
	Tue, 22 Apr 2025 09:10:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] MAINTAINERS: Update entries for s390 network
 driver files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531300353.1477965.11879754920269902885.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:03 +0000
References: <20250417-ism-maint-v1-0-b001be8545ce@kernel.org>
In-Reply-To: <20250417-ism-maint-v1-0-b001be8545ce@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: wintera@linux.ibm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 twinkler@linux.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 11:15:00 +0100 you wrote:
> Update the entries for s390 network driver files to:
> 
> * Add include/linux/ism.h to MAINTAINERS
> * Add s390 network driver files to the NETWORKING DRIVERS section
> 
> This is to aid developers, and tooling such as get_maintainer.pl alike
> to CC patches to all the appropriate people and mailing lists.  And is
> in keeping with an ongoing effort for NETWORKING entries in MAINTAINERS
> to more accurately reflect the way code is maintained.
> 
> [...]

Here is the summary with links:
  - [net,1/2] MAINTAINERS: Add ism.h to S390 NETWORKING DRIVERS
    https://git.kernel.org/netdev/net/c/c083da15f06c
  - [net,2/2] MAINTAINERS: Add s390 networking drivers to NETWORKING DRIVERS
    https://git.kernel.org/netdev/net/c/e00c1517f2bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


