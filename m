Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F23C8E0;
	Sat,  5 Apr 2025 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743822519; cv=none; b=dm4K7xKB5jJsFUgEG/GFvDs22efF3szpied4pd2Tk/y0dEQPcwcx6TrEOMuIc5SHOVRzak+auEyT+WG+yXhwVZJ6FZ12qcqAfLlL3ZNdiK4LXuIszO2hyKcZLN7Z+RTBSCu/DOcpOtONF90d/ZAiB4MEL90U14ZJ6w4GEpiHhcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743822519; c=relaxed/simple;
	bh=e/scFmECGgqKcSZic7AuDsqesiVKC2vjEDZ1wqrQl9k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hhZbffvJPGWI0sW+wlBZ2UA0G6932BMx1lnRJWvnBxTUIzs6h6YqwfyWa+BvrgZKNOF2/2PCknv2nZSqNIvKVUkG+1XkmVcngLuaK8t/EQN2aSiiNop8rrRCdGJwR7u9Lp+VPkclF87MyS4IFibFORwVFGGWkw/cuWdzrlb5PgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5C2Fa1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5C2Fa1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21EDC4CEDD;
	Sat,  5 Apr 2025 03:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743822518;
	bh=e/scFmECGgqKcSZic7AuDsqesiVKC2vjEDZ1wqrQl9k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U5C2Fa1QiS5EkmDM6TGu67fOdlw+ozBB5EsxzSHJPIE58WUs7biBK2u2fBeFlzNVx
	 zSDD+8gnNhUeleOkrkW/JLXDP76d5NTC/bk+l79YtOQ+8Y7maGOAP2h+i4tJXa39m1
	 vMXXlL2C5yrXrh/aqxH6+mIVMHHBJGrmBBizHD9DYf7IdC0sYMNXEC1PUUkwh2nMVL
	 SO2m9kkHFpB5opfvV33HNoTiVeJ3KVo2MeU4s8QfIO5unI2ywmhMOnDr7IBnCjqYXj
	 5hkB/vpncOvg+aak72W0BsoS/LpPWR4m1AO0+36i3JPPhMIABvtvMinKmQvU/uP33U
	 q9AL6v9qx/sQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA03822D19;
	Sat,  5 Apr 2025 03:09:17 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.15 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01743810876-ext-9359@work.hours>
References: <your-ad-here.call-01743810876-ext-9359@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01743810876-ext-9359@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.15-2
X-PR-Tracked-Commit-Id: d33d729afcc8ad2148d99f9bc499b33fd0c0d73b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd9db3bff8ec419ab0e5f18092f89a8fddc37f15
Message-Id: <174382255578.3509887.16988107816757366805.pr-tracker-bot@kernel.org>
Date: Sat, 05 Apr 2025 03:09:15 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 5 Apr 2025 01:54:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd9db3bff8ec419ab0e5f18092f89a8fddc37f15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
