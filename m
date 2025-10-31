Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F788322C60;
	Fri, 31 Oct 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946206; cv=none; b=BDAORh1biYIIrm7MuDmL2/rPgQspYwYJs9I2izqBmElbSnpegcDU1MNc/mB3oCqpnhBRb8cL5UrQMoBLHPEyd2Azwf/BmcqMKqTX7v6Ez1yOmasek23BJ67CFfHoUJhQkrHiNRYg8AG+GxGglZwhOg44L6PtXOFEmgbJwCHzxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946206; c=relaxed/simple;
	bh=ZIuJsDtHZvzlfyaOITPU6FhtXznA0femcp0YK6vJLBk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kS5kdvorj0GdpSwRMWiGwiaECxrV9WcfOVFa1hlQtxmRMSlobsNFG4TF8gEKd+hoIvrlLKomJb8NQi3t79ka0zDx1eIDI1DGg59KKNTzoEXPC9FDWUR3vb/K7v9qLyc/qwMw4+3332DSWf0LFpQZuGRo54aqLH9qQR841PgVIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4vrI50P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4vrI50P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3147AC4CEE7;
	Fri, 31 Oct 2025 21:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761946206;
	bh=ZIuJsDtHZvzlfyaOITPU6FhtXznA0femcp0YK6vJLBk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q4vrI50PwRBI50nSd1dLRe7T5fmrhiYDoGvS5CO/gspBmfLVrX+EVWPI2+Zr7ItNg
	 PpX5KNMkpo3NS2EJV2nu4MwFxOc0f9Z8VW26JBb68nskTnyCjWdmCHEAewBpi05+jr
	 aXQm0Sd5ZxlALBtZ34TSq9gxlJa9jvw2BzRdDnOLQZTaW3Pa4sIJEUu/FVd5Ra1Grw
	 71sfIQ2tXppo8irR2d4yStZv04GQeImPd3ppCso6VkT0+3btMuQGX1ILkc46Cx/n8P
	 QiA0lcZRxMzjDXVHicLKetEVkbPUy3grV/KXForBN3iNd97blD96bpOwBG5QMXY7Wb
	 D2P69CVrvLpow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E9C3809A00;
	Fri, 31 Oct 2025 21:29:43 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251031170207.14424A48-hca@linux.ibm.com>
References: <20251031170207.14424A48-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251031170207.14424A48-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.18-3
X-PR-Tracked-Commit-Id: 64e2f60f355e556337fcffe80b9bcff1b22c9c42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4f7f01ea14fe3654a0f7b7152ded7c15acd5e5f
Message-Id: <176194618201.642175.13287471361507243245.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 21:29:42 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Oct 2025 18:02:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4f7f01ea14fe3654a0f7b7152ded7c15acd5e5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
