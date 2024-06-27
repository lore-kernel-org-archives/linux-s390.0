Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8360D13B780;
	Thu, 27 Jun 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525031; cv=none; b=eTlKHauUBOIJSlLAKkcO7JMcx1PnZBBzCsrvkSiWGn0GOHzSNvZufbIp7sXPv8rM3oFPjM1YixYv32vfs64avYTle3JmanlA47GYdWYRl8PT689PHxVwGkcc7Ka8JKsWXKNf1jBXYP9HDNU4rBrWobZr4Jq9Khk+kmchhjgsmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525031; c=relaxed/simple;
	bh=XkPxgHmsESYmdBThT7SlxwvBjshLf4TR6DxdLnVeaqY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KcuSZwWfD7gFiKYf5UbYxa16SLo5ve8WspLXJLsTQleHBI7cnB0KvCRCamA+1CL9QwWpE7kWb2+CiVg/vzzRQBmpDricjY1vboprt4dDsYvM/HY/RPWtAteqvQV5DSJCT9uGu5hlj1tdcVRrmsFoW1CtDVGmLDs0qyL5WTIIEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep5iHiTO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep5iHiTO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82819C2BD10;
	Thu, 27 Jun 2024 21:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719525030;
	bh=XkPxgHmsESYmdBThT7SlxwvBjshLf4TR6DxdLnVeaqY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ep5iHiTOGKrkMqiSLTjssZ0rFdfgc3EcKRpgyTOf9FHXXQGhfeqZr68iand1wAj+G
	 u3DxEDtsBnbzrjWldo9zGHgBeKRHAVFn1phsS737iZRCW2q4r7qbd/phdocUufa+nc
	 mkeIH6leppTeZdpaP8GZ2UUYjKrnV+wzvhZMN5seI+NEd8lZuDJmOIwJFv3ILJSw8y
	 LPec3b/0UsPmPqkrGNViUoBkoPxtmuUp9BosSPIgjfATUSk+E0N1TjBLzJJSyOxiFC
	 +JTizqeIY6oLITfGmUWhJubcrU2r6B7FiMdn/xa/RpZpI3akhknsAx/EpOuZXWV2dn
	 OhKm1RpZl0ioA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A450C43336;
	Thu, 27 Jun 2024 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] s390/lcs: add missing MODULE_DESCRIPTION() macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171952503042.25992.13672375382878224314.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 21:50:30 +0000
References: <20240625-md-s390-drivers-s390-net-v2-1-5a8a2b2f2ae3@quicinc.com>
In-Reply-To: <20240625-md-s390-drivers-s390-net-v2-1-5a8a2b2f2ae3@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jun 2024 09:35:41 -0700 you wrote:
> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/net/lcs.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [v2] s390/lcs: add missing MODULE_DESCRIPTION() macro
    https://git.kernel.org/netdev/net-next/c/346a03e5fbdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


