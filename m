Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3665346AE3;
	Sat, 12 Sep 2026 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789255537; cv=none; b=DEIYbRKphAisQDsnYgkOyfRNmhqvvFg1VsjKmPXQEXQWXi6OxHmt4NwajsMbvk+KCxxnrQasPuPx4FYjgj7+CvPR7GKKJya+aehMmUfOi0IDaXJYK17eE82Bod6Fo6BAKpHS7YGXm6PBJgAYg3TGcUi0zRmtWzWKODhTxMi+nnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789255537; c=relaxed/simple;
	bh=Y+0cIVDYEX0lx+Wj8PDmckS3rvJckVriGwD+WuWmRcI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DwpzsWD8FXWF7HithYve9kwyiBue87e1NH2JU6RSW/zR+w7EkiNNM6WWkXXv7SPaCOjahwTidEHBQuroZ2rtNcNhzYdr6Mm6WmlOlQ+ZJjVtJACsFXYcKYhM7FTVLvw1QDAwLzPvh43UOMxixFQjGShJG4lsqcG2fDJPfb0nyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RS20AU6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RS20AU6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3121F000FF;
	Sat, 12 Sep 2026 23:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789255536;
	bh=/i3BITzSksdrBPnMiLh5bjDIrkhBcoA9v85fgAq4gf4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RS20AU6jy9wuH1zBWdnNlCfUSnPWQQPfjLFTQudDd/j9AfSnksOW98Nsmo4sqCq8n
	 Xvz0ashDJ+gmZHPP5sccdgujjVot53B9Dz+G5YJyR0WjYhzBgQCXHNc+CTlEaEYvew
	 q7jZJH9f4je53BKfYCUufHafAPhNUlJNFq4rVviCnRHFbKASBZ9czyt/9StCuEQvoZ
	 Nnwjn2j7F35n02fQEd4dTjx9JQsoNe2W/BHXuEmWWTZ7S/kPwWiaPjXMYdE29XJuyT
	 cTXaZc3BUZ04RuymeBoNVhAJToHiFkyagUh+HjPIZ1Y1LqpwplIlOImdzfXHt53qlZ
	 Gq/I/QrgWmm+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199413809A22;
	Sat, 12 Sep 2026 23:24:34 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ttl9vau@ub.hpns>
References: <ttl9vau@ub.hpns>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ttl9vau@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-3
X-PR-Tracked-Commit-Id: dc2136341be9835e70ba7c6b36904cf3683fd029
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f0c1cf72f4682178506f513bbf015e591b1aa4a
Message-Id: <178925547274.3683640.16305973719527497062.pr-tracker-bot@kernel.org>
Date: Sat, 12 Sep 2026 23:24:32 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Sep 2026 00:18:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f0c1cf72f4682178506f513bbf015e591b1aa4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
