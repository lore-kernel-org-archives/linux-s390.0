Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF632D46D9;
	Thu,  4 Sep 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001604; cv=none; b=FcoOYM1nKU8iDLsR55MySWPoPYkSEja076HZiXJ07KFHLFzkGRQbvaGHJUKojCU1G+ll0JRijLrkzxrV0ANqBsd03TKye0hG09pRc6XZHdWI4ZF7/z9jrxvdnrn5HbkZbGnWRjBagnxdprW88cpw7g+P+GiIYbY/ZW3KN3FV8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001604; c=relaxed/simple;
	bh=lolov3uCpPCGuy0ktlYST5T2fAnwkoiMuje9XHp4Whk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pb1VK8v2/3YuUig1s6cneVdt3gGIhQubg0NCvs2TsenZc2xWWPvZM47+ACOB50AngoLGZzX+b0UiPSo/hG90wz0cwecj6jXMY+R4og831145rTOkA2wgP6ZGEVYXPKVzOYm2PuIbC0Rd8x1pdl0huD9a4EbCjfU6XTW8fyWILnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0KCWZz9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0KCWZz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26177C4CEF6;
	Thu,  4 Sep 2025 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757001604;
	bh=lolov3uCpPCGuy0ktlYST5T2fAnwkoiMuje9XHp4Whk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H0KCWZz9BoTbXPDGYOrpYbri2qJsDdn8o1gvOvydYMTNUfconXlYKtNixB0kteWbz
	 YAay5ddeGJujWpOsDKZ4XKGRTBWXvRTc/XXWQnjmCfH24w7I2L94SAPduOUegtLe+v
	 /zYqj8eIc/KzLVAQyL14OqUwxI1vqtFIZOAgEyQ1vgR2F0+h9Zlb+wSgZZjHdNqFjk
	 V7gQh3TC1tLMnwK5j+OGY8cZirXUZHye7uLaIeHRpGfMmnTXwA+QMjZer+io0E/g/+
	 S7hzA4D70M+0dsftJuHXpr3uGHjpkzACJkeYS+iYGourWSy58udbfP2oseIxHXcO6b
	 Cx3y9lI7aVSwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1A383BF69;
	Thu,  4 Sep 2025 16:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net/smc and s390/ism: Improve log messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175700160899.1861500.7487799283370248516.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 16:00:08 +0000
References: <20250901145842.1718373-1-wintera@linux.ibm.com>
In-Reply-To: <20250901145842.1718373-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, aswin@linux.ibm.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 16:58:40 +0200 you wrote:
> Separate these two improvements from the dibs layer series [1], as they are
> actually unrelated.
> 
> Link: https://lore.kernel.org/netdev/20250806154122.3413330-1-wintera@linux.ibm.com/ [1]
> 
> Alexandra Winter (2):
>   s390/ism: Log module load/unload
>   net/smc: Improve log message for devices w/o pnetid
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] s390/ism: Log module load/unload
    (no matching commit)
  - [net-next,2/2] net/smc: Improve log message for devices w/o pnetid
    https://git.kernel.org/netdev/net-next/c/c975e1dfcc92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


