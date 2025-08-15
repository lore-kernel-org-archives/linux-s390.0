Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150CBA3F;
	Fri, 15 Aug 2025 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218996; cv=none; b=eyYBtt5ZLmhS8R8q0vCYQsKCXQRzvolVT16OszJC1dM0sAeuaMNvBOqub3HolbQ+UK59WiOSWfWchkUtWeIY17HTf4pWK5S8QKh5H9CSzWMqpKpEUXW6d5JsTvXBw9hfgbjPJ+1uEmaQscA3mNlhvM+w/2tXtLcZRaLxCUxOmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218996; c=relaxed/simple;
	bh=qBs02KU1PyGFyvvu233JG7CvOGk9//zfnBdxMVVwg50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Iz5M0JyWgnS6FyScIDlPNzhIqD11AXBOM/WApm/29Q3mrzrrowepv7X96JJeiUwScDjuR3hDETaFxyoqT1Jwzcug0THF/bd24BezVO6NzPG2FPAxLeZg9kgQDCM0iUABGh1U+31Ly2SzwfDn2AIx3jm7SgZF9onrSKfAGqDVKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD+YW7su; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD+YW7su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30DFC4CEED;
	Fri, 15 Aug 2025 00:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218995;
	bh=qBs02KU1PyGFyvvu233JG7CvOGk9//zfnBdxMVVwg50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uD+YW7suEQM2xhWpocHZo7xlBDS/DKK4IKU3WMwhIqJ1qfu2H1MQK0eyemdX4KCrs
	 LFWOZJK4zfTqussVWrYKh6EwaGVPVyvVOqY/cmiTUwavFSWi/ATq8GXNcZq41kiRQ2
	 utayroOe1qOFZfmfeK6yJutvQRdZzayidk9zJQNhp37e1p4ewH72vkNQ//g7Di/IhU
	 O6Bl+hXl4SaPaNUcsAaP05IRbV/ET582WbWpMIo5+Hctd451o918wQ97WuXC/iFh2s
	 nwM2WKLyhrLj5+mvwrhOO/wXCc+1+NZnFJWdA135Pu0BmxShotXxBXVnnwSm3xPlrX
	 JlPrOfhapvRyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9F39D0C3E;
	Fri, 15 Aug 2025 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: update s390/net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521900700.500228.17334624999849439668.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:50:07 +0000
References: <20250813111633.241111-1-wintera@linux.ibm.com>
In-Reply-To: <20250813111633.241111-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 twinkler@linux.ibm.com, horms@kernel.org, aswin@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 13:16:33 +0200 you wrote:
> Remove Thorsten Winkler as maintainer and add Aswin Karuvally as reviewer.
> 
> Thank you Thorsten for your support, welcome Aswin!
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Acked-by: Thorsten Winkler <twinkler@linux.ibm.com>
> Acked-by: Aswin Karuvally <aswin@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: update s390/net
    https://git.kernel.org/netdev/net/c/1548549e17e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


