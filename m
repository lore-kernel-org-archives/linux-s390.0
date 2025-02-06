Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17DF1339A4;
	Thu,  6 Feb 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809004; cv=none; b=k7Lx0FeWhDKp3GFzhZb2uNR6QutTPt+Z2RI5ujQQcFz1qksfrbZadQGoGK+tyelyMpVRFZSEBL5doKiPSPCb+oIgB0m7pN2fY9ibxggxrMdxwKCqWWuBt/mmVhh1T6ZikNPc+HDl1aEkQ9IliwcL9Zoei4bK87MB3UUEJNyXl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809004; c=relaxed/simple;
	bh=Z+7WwaOqoB8lbYMJl+MJRy5YxMMtQ2ceeFQLgMAAG74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y6nYtiYKeUkTR/Ayv8sYL6DH7yp8glX5YEOApvPXjEbJ40N/Tm3ZL7qhzsoXDQEkA9LGLl8l95uzPE9zABf0X+xFrmH+8X6keSQ71v8ZHqXQjIKy6wE4XskKZM/XcwhTE3BMm4R3OZUa32mDFA/1dMnWAlIoqw54hUYYvbOk1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drQBG/vS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drQBG/vS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB073C4CED1;
	Thu,  6 Feb 2025 02:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738809003;
	bh=Z+7WwaOqoB8lbYMJl+MJRy5YxMMtQ2ceeFQLgMAAG74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=drQBG/vSF1o8mt2PJNCAWe02eZzTcLhv1C5UH598u+mUj6tU+D0EY/5aI1Bpvmc9I
	 WdQKycFF7Vtm0DiCo1Cf0OJTInc8A3hzlOAk7biebWMNp+PiUGyQsWGsEWW4AbhLql
	 u6h310XVMftOQRM10h5L3RSKjXZ2sZRf73N4trnXky0Xd6mNiUFxkrWGHf6nUhN+jT
	 fe5JDuicI/BaSPnift4FAglPeJuVqfz3MEn+juaYHgV/tCi5Mfqs7gFqeWfYwGB1AK
	 sZrFYpK+p24cgUaTEXIXdEW2oGirj7U5EmEJtOz/6Epnod76mfqlBzEzp1AwqTQAXq
	 22AUTP5KnrHxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717B1380AAD0;
	Thu,  6 Feb 2025 02:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] s390/net: Remove LCS driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880903129.977176.16252464144075540544.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:30:31 +0000
References: <20250204103135.1619097-1-wintera@linux.ibm.com>
In-Reply-To: <20250204103135.1619097-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, aswin@linux.ibm.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, twinkler@linux.ibm.com, horms@kernel.org,
 corbet@lwn.net, oberpar@linux.ibm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Feb 2025 11:31:35 +0100 you wrote:
> From: Aswin Karuvally <aswin@linux.ibm.com>
> 
> The original Open Systems Adapter (OSA) was introduced by IBM in the
> mid-90s. These were then superseded by OSA-Express in 1999 which used
> Queued Direct IO to greatly improve throughput. The newer cards
> retained the older, slower non-QDIO (OSE) modes for compatibility with
> older systems. In Linux, the lcs driver was responsible for cards
> operating in the older OSE mode and the qeth driver was introduced to
> allow the OSA-Express cards to operate in the newer QDIO (OSD) mode.
> 
> [...]

Here is the summary with links:
  - [net-next] s390/net: Remove LCS driver
    https://git.kernel.org/netdev/net-next/c/6cccb3bb0561

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


