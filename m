Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2412F5A1F;
	Tue, 10 Feb 2026 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770700111; cv=none; b=HOIhgVGg9XmRlGNLOCFkTRbmnkAIiRKprtB1jK34qFpx0Sjyf7awPA499iqjiNO0/bUg1TYrUbi8FMVC72UIYsA3C6SVPRqqWeR8mekOvFgehzMsLwZGk7XfmZvzp9aR+oas54wq1xbE1FJwErRxDu3za4ssUWcCMpvLRkzBsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770700111; c=relaxed/simple;
	bh=9h1qsQ8IGZUCSqjBkA8+S2AmHkHbZ1xhsgTLG9VsuW8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NSSxdWfAusO2ec2WJY+RP4yBd8+ZDGnmDwGmc4FC8zv/d+VC8FjuwVf4mIJ0/MXSGZFF00kjvHGHXCsf4jPxsfuZhZ5eapq0kbQN1FVKSzPv48JVq88FMdfud9wgkxMRvwdXmNCqQi+xOW6KAAOe2gMVmV5eQs7Y0Rme/YkQrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+5cnl6w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+5cnl6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40969C116C6;
	Tue, 10 Feb 2026 05:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770700111;
	bh=9h1qsQ8IGZUCSqjBkA8+S2AmHkHbZ1xhsgTLG9VsuW8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m+5cnl6wq2RrRSlXGrvEr3KtDquF+Gc6iNJRSgajvhMJxDRD6wcUYoDFWoiwFkSrv
	 AIP/u/jNdq6+t3ujAt2m4GlDEOOMRsn7GgFxauPy/CvnO7pLe5Er51/ltGORWNwxFi
	 GWLKBTYUMlCp1cySt0rjFWO5G5rREEo2Q8HRu8vo3C9hjxKTJyAfFsmFpPq0fmwZYC
	 duiHCLH6Rld50Q4KCqSF+fCKFFyuQcmtQw/WtEiOETFSiUu1wmh8c2jjGcUFZF/rz4
	 mJLRMfs3S3wNTw2p28GyIpUfQEwvZarDl0No109WddsV0cZgRviHEyeNKXll5tLK09
	 WcMPZYC8bw3AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1EC380AA5E;
	Tue, 10 Feb 2026 05:08:28 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.0 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260207175105.10023Acc-hca@linux.ibm.com>
References: <20260207175105.10023Acc-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260207175105.10023Acc-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-1
X-PR-Tracked-Commit-Id: 5ae76830c76cf38708399245606e4e07a33fe51c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c48953d81972bfe16a9e3551883992aa6efe541a
Message-Id: <177070010675.3352335.10173052945914625585.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 05:08:26 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 7 Feb 2026 18:51:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c48953d81972bfe16a9e3551883992aa6efe541a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
