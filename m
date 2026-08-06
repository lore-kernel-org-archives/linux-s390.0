Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA7380FDE;
	Thu,  6 Aug 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035081; cv=none; b=TgSdm3sjuOKNUVIRe2b9ReS8sn04qwVpDEzr4GUv48vfVkZq4FoXUiBPM1ozivYwVH5bLWo3DY74OoBc77QzD09zEXj03hq2zuj0tWQhJL7fln/Cti5SwtkVn/Jtnx4zyOGbZ4306flDO1PdMPdugVLrvc42m5k74lReOrzGQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035081; c=relaxed/simple;
	bh=5QOLgOF5GA03ixxqefqlHoSmngn+m5FCeceXG6UrlME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fn6kYpzOOybPRbzp0f1daomCas3Y1vUQALi/EWX+cskax4mjkJ8348C7X1opWw9yFaVjTvdPoiOytiGYi5n4VLgJJvTzyzSL34JVc2d+5sUmeaioZVYzRvvJoxrWsuTNyyUIY54x91WYGGAhBodCV0ohyyHI+7VCHq0yHrtyXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1AJtjOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1AJtjOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6F11F00A3F;
	Thu,  6 Aug 2026 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035067;
	bh=w/uefEEOH9/iG6+Ql6DZWRZebcZnCVGNHfKrKvZ9G8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W1AJtjOTWqV6B++zxCIkpRlFmYvfbcAGK85zFmrKlKS8bZfPHjQuKItc3goG+3JKL
	 u47aE3AGi50Vw4oeEIKxkGc9GJccvoi+p9cn4hwHIAyMTGbYN8WT+z+5kJBUNo8KXt
	 77ad6Pzlb29BwOHcgd48ZfPu6rTbAWO/gLrt35jb6sP2y+2EsJYlG4I86IPh6+JCVt
	 L6aKBzJm8/xLZmqUX5UxgYKllI5ZR1aIfNEZXpOyXeYovX4RU7wXSaFUYKRBx1MIMd
	 PRkKyw6nM+o3Hx4MMkxVrPORZkcxJGaLCky4pXP3DbuN94yeSrT6J2f+3xxegpi/wc
	 nNTMZKEu409EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19855380820D;
	Thu,  6 Aug 2026 16:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/ism: Fix UAF of sba and ieq during
 ism_dev_exit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603502663.1375455.2308379407794585304.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:50:26 +0000
References: <20260805131043.954639-1-wintera@linux.ibm.com>
In-Reply-To: <20260805131043.954639-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, aswin@linux.ibm.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 15:10:43 +0200 you wrote:
> A ism interrupt handler can be active in parallel with ism_dev_exit(),
> accessing freed data structures.
> 
> No new interrupts will be generated after unregister_ieq(). Drain ongoing
> interrupt handlers by free_irq(), before freeing ism data structures.
> 
> Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net] s390/ism: Fix UAF of sba and ieq during ism_dev_exit()
    https://git.kernel.org/netdev/net/c/b1896543ce59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


