Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218D200A0;
	Thu,  2 May 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636831; cv=none; b=O6GKIyJO+e9sCT81zuM0HnYVGVgfT5nVVRazqg9AhchSQXunI1fAMBi+9d2LNGednvxiNqOMpsokW3w4auBZTjvwb/tFiz+1iqqUZCchaU6kOJr0HnEey8tHj0K5BH6BE/cGEi5dkVevtguInikl54RVcp4vHneZwMU4RcUNzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636831; c=relaxed/simple;
	bh=+mqEBn4LYyIDvatHH5ciyy89qzxftjOS7yojeGalSTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G7wi/QLRCw6DJKK0DPlR1mtmnOa0LerVb+Ng9jCq84GIkzya6nX46Yu63hxmd5S45d2/4A45RMG9vfEeSyUC+7ZUb4zp5Hjk5nFRbi6TbUHv6LileVQrRnOxYm5u3e6BU6sUuamHVL1mauVByfXMqNpgMQemZWhz9DwM1I6HSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP3nx2M8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP3nx2M8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE1EEC116B1;
	Thu,  2 May 2024 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714636831;
	bh=+mqEBn4LYyIDvatHH5ciyy89qzxftjOS7yojeGalSTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sP3nx2M8j2c5zR/a7SqlVVfvafIB3qXHUb7gLB0NBItg3PilWj8gBd7GgDfh9hm4z
	 G3GqLnXt8uPo+5WsIocmEcLlTRqFukrkRXKvADLF+em4dTrNSLrfwMc5IbLNcqHCtM
	 4uA9UrTfCE8FeEkvBp1hkqSgbR9sc7eeS6XMMf3fKdwB4FN8PNjhC0rHtlXkE38n5X
	 jtfRKDD2WW7KAK9nTSlpw7+OOxz5SKFTJ0QumMIA4PWY9EV5Ze19hzu+gifjlUJahi
	 4GAN/f1VqJ+zuHx1eoYfPxtV/0R3XA1IWQJIAX/cK0wnRXdk5H5NJQe9ABmEcjjcNL
	 VhI/v/BzBWMSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA1D9C43336;
	Thu,  2 May 2024 08:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/qeth: Fix kernel panic after setting hsuid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171463683088.19132.13776000447707999251.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 08:00:30 +0000
References: <20240430091004.2265683-1-wintera@linux.ibm.com>
In-Reply-To: <20240430091004.2265683-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 twinkler@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Apr 2024 11:10:04 +0200 you wrote:
> Symptom:
> When the hsuid attribute is set for the first time on an IQD Layer3
> device while the corresponding network interface is already UP,
> the kernel will try to execute a napi function pointer that is NULL.
> 
> Example:
> 
> [...]

Here is the summary with links:
  - [net] s390/qeth: Fix kernel panic after setting hsuid
    https://git.kernel.org/netdev/net/c/8a2e4d37afb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


