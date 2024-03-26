Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A528EA;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422630; cv=none; b=fduNKdw27r90LFj/Mes77xIscXdqxO3fZLWVE0CBACi1WXpd7pH1fcYLRseOeTtQeYRvpFUf7JAp1nYv1zYiQwE9bGri/9mEx8MUcJD3gOFOeQaVMGpXLaumRMoAG6z4ZLP2J6hhH8ZVYAfy1fU8THmrBananI78XMTDfC3SXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422630; c=relaxed/simple;
	bh=kqqxP3V6Mnx2YjqyOSQ2mP/sTUu7sNmkxAra28wqfp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dNCrGo5isUSpRWRI2giT1Xd7WgiBASOnkNLjnx1zpRgYihWUEKLmKMvltWrbIto8+2cZ9tVqIlLQBXkdZKeFWLBncW1ZHbA016Ndsbt5kOUZM1txjj9ATzQ+Ov8FCwTZyNT5NNDs3NTVB002Vl5q1v4Ujp3f1q9aT522h4sP9zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqcMhz5o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqcMhz5o"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 630BEC433A6;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711422630;
	bh=kqqxP3V6Mnx2YjqyOSQ2mP/sTUu7sNmkxAra28wqfp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SqcMhz5oth36IckNTR7c6gpFKtALCRTz9nySV77HjvMbXQF/vDB8IZwW5IhsSAqTZ
	 0UWkxa0qHIr/4X9wo0GO6EkCFxQIbqNDk5tCJf7wSSpwM4peToJAofBHMTAnIvMQqM
	 XAorZK/9uZDZffLyMRLkoA0SlseScfIPNws4DjXjb4anbVbwDoQ5BD7RKMPl9oOaPl
	 CaggNrlUiEnvD6EuDsoNPKLBjB8UrO+l+Mc0NRJk5GSdC4Gi8kXByXrdVT94/+cuj+
	 tEjB+xZOHaDeQ1W2x+AD4lXd5MJUvWzABCQm5wZluRZqCoQms5pZPkWddrPZXQ0q4z
	 RvvVKQ4y2NN2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50375D2D0EA;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] s390/qeth: handle deferred cc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171142263032.4499.17962312063641438167.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 03:10:30 +0000
References: <20240321115337.3564694-1-wintera@linux.ibm.com>
In-Reply-To: <20240321115337.3564694-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, oberpar@linux.ibm.com, vneethv@linux.ibm.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, twinkler@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Mar 2024 12:53:37 +0100 you wrote:
> The IO subsystem expects a driver to retry a ccw_device_start, when the
> subsequent interrupt response block (irb) contains a deferred
> condition code 1.
> 
> Symptoms before this commit:
> On the read channel we always trigger the next read anyhow, so no
> different behaviour here.
> On the write channel we may experience timeout errors, because the
> expected reply will never be received without the retry.
> Other callers of qeth_send_control_data() may wrongly assume that the ccw
> was successful, which may cause problems later.
> 
> [...]

Here is the summary with links:
  - [net,v3] s390/qeth: handle deferred cc1
    https://git.kernel.org/netdev/net/c/afb373ff3f54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


