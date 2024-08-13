Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A236125A9;
	Tue, 13 Aug 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723515029; cv=none; b=B0R85jdwNH/fNcdd1gvf5o8M/zo/m3hSLFodD0oj1RqeB3eemRkqlXp8O3a17oAyGbrnFVem5Hrqo6Z2CcufcU7nY3+DCyh/dTiQNKLQQoetJc/S7sTXky4CSRq2e6n9tvUfo2R2bkgr3s64UX9ZMfC+A0gdQR/u63y58Z86qO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723515029; c=relaxed/simple;
	bh=oXHJvcXHc6GEnu1fyfXFbIqkUIV0JIuL9A/eeWCsNqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sV+rKMgGXFg+2BmT6y9uvHnRK/f5lYEMfvhZhAyLKiJjZisKXCbSCZdT4m6COzhyDUJ+XfYVXQWeBylrerB4QlkBIfnJPu6fskuWbVSIC/CIhAKr+hyWpzVZiRAC+N5JmNcxqbkscYH7uEwh+mkL3BIwMOTl4rnffhwutshYR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tss+J63O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tss+J63O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD23C4AF0E;
	Tue, 13 Aug 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723515029;
	bh=oXHJvcXHc6GEnu1fyfXFbIqkUIV0JIuL9A/eeWCsNqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tss+J63O44u8b2RNW2g09/UwYHPL5F8Flgrst84QHm+yLz6jff3S5+jQ1dWOuJo3M
	 6+7uPojD5z1n7I2SOeFrRfGA/HMVUogkv1L8SX3kkN6U0r8yK74hYFQTdZ7QJUZpV1
	 RpIgrQfT6ewcIZKJyb06IGkji7q/5YZFWzF26vcqu3uh3Ju38DNlL3S6Jp1e7+A+8Y
	 Tf1uJiFSu4ESdk6wmvAfDlC0LRooGPUgNSwk85XQ4bsOQxrieW3f4uwuh0r0tYN2FN
	 cnmgFTtJyoxSq5ydD9GwaSmWC72iORg+SqVqHcv//JGAzjAQOkMb/BxbEZ6dgY8aop
	 HRYrhXCpOQz/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3400D382332E;
	Tue, 13 Aug 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net/smc: Use static_assert() to check struct sizes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172351502802.1193412.326253813411945396.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 02:10:28 +0000
References: <ZrVBuiqFHAORpFxE@cute>
In-Reply-To: <ZrVBuiqFHAORpFxE@cute>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Aug 2024 16:07:54 -0600 you wrote:
> Commit 9748dbc9f265 ("net/smc: Avoid -Wflex-array-member-not-at-end
> warnings") introduced tagged `struct smc_clc_v2_extension_fixed` and
> `struct smc_clc_smcd_v2_extension_fixed`. We want to ensure that when
> new members need to be added to the flexible structures, they are
> always included within these tagged structs.
> 
> So, we use `static_assert()` to ensure that the memory layout for
> both the flexible structure and the tagged struct is the same after
> any changes.
> 
> [...]

Here is the summary with links:
  - [next] net/smc: Use static_assert() to check struct sizes
    https://git.kernel.org/netdev/net-next/c/0a3e6939d4b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


