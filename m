Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101241A3160;
	Thu,  1 Oct 2026 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790815222; cv=none; b=TF8Rgip4cvSkP3dK81zq6DB00JLQLjLQ1+EeOiw1r9B8ztJt/d9A8Rdo09svkM323FtXEDIPbXpTbnY1YALsTbjwtKD9wtRBB/XmCYbTNf157UOJ9sNwDGXt6Ya0Z/+dOFnBo2xcp3KjQR8eoa10XECRTPU9TVqJAmeQMnuoTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790815222; c=relaxed/simple;
	bh=oMIaEeEoP4t05NtYSsN9pnpsf/KG6qmo5wQqzyQTWWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z/H+Dkmxylxt/Wx1WcACYc9rphSE6mQx7B+t4dSy5eD7DA34wAfWuYlV9TC0x6qSgrqQ9xxKktRzsaTe7dsz3FLYoL72XTDaimcb+INGR9vTWGflZWVASVbWfVemkEMeO1PosccMLPNn9UiSgsrqk9LkImJj1OdnsfVtTn63YFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnT8NEjG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnT8NEjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052BF1F000FF;
	Thu,  1 Oct 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790815207;
	bh=fUtbI7rZ9fegY1v3Djr5d50iTf6BrLJeMWhDfB4fX2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZnT8NEjGanW77Wkv0CBg90+CYTJh+ReUQMVdwadreY2SmDXue5fOw67R2Wp6Xs5so
	 lZvIk8uWJN/tK6wz7oog7m5Y/Wn9piMZdTypk0K5nZe83jkFF+zzENd/v9CMYVw1E7
	 j+zlWDuDs/hm9AEwUWOsuteADMyqXzuW6wt8MJsP4RVK4+pO5SeUC2QDi3tHpH3uZn
	 T6SzyUB80yLE8LmJ9hY+4ql+fus3vvF/vPRJWUm2PoruxXMviRibEr0gu9GbOfAZeG
	 m/RHmYniDG/Hj8UodVy8lLcY70q6Lp8nbxh3zeYtdz5TNbia1lVq7l2oilSfyidRxx
	 GgUXRETa2rc/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F145E3AA6A61;
	Thu,  1 Oct 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] s390/ism: Zerorize dmb at allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081520578.2192623.15327890080313694045.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 00:40:05 +0000
References: <20260928151420.383105-1-wintera@linux.ibm.com>
In-Reply-To: <20260928151420.383105-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: aswin@linux.ibm.com, gbayer@linux.ibm.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, julianr@linux.ibm.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, horms@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 17:14:20 +0200 you wrote:
> Sashiko reported [1] that 'Missing __GFP_ZERO in folio_alloc() causes
> uninitialized kernel memory to be exposed in the receive message buffer'.
> An ism dmb is receive-only, so the data is not leaked to a remote peer. In
> general the smc kernel module (dibs client) will only push newly received
> data to userspace. We still should not have uninitialized data in a receive
> buffer.
> 
> [...]

Here is the summary with links:
  - [net,v2] s390/ism: Zerorize dmb at allocation
    https://git.kernel.org/netdev/net-next/c/a0227fa24e8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


