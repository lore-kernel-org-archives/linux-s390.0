Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B2363C51;
	Sun, 23 Aug 2026 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787512825; cv=none; b=WmS1xEvE31+Gjin4SUJxpjtkG7keMSz38JHRlg1MBVn79r0BJi3KgIVz8TgZv0SqiYgrlvVkHQ6biAt8riVzDGgkisbSbKgxgNURtDYNmMoR0aD9pmgdNSaCVeGe/PigBuK7C7WFrwdg18vcFtF2qQWnFh6Xy3kpXCUxrszOFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787512825; c=relaxed/simple;
	bh=U/q7YdZ8HrMLeqii78+wCS2Hgc++bK3rkV+M9PWoCY8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WDsmw9t5cw6BvhBV7FfA53aI717B83sD+uK+wW1MUWWrt2RS08dSzN8tlVqDDXDp5AP+xfeBO5CzjSnyhvIrUUX7EX40v7XGcZfiU6+LbSHGevq+5yVcz6e0qaRnM1/eCNZKDVBfxQD+x8eti6sW550lAlBp5nbAdNEHL0yiHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLJ70+h7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLJ70+h7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346E81F000E9;
	Sun, 23 Aug 2026 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787512824;
	bh=GIPfJEr2QM2OvZAXx5i6v8XIxfiU3lvoYmhG7LzMTPM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=fLJ70+h7LQnIQxVtqcIyU3aa0i/AtCm3/055Zv1Sy/Mt4VuM09WLkWvocpZGcb5nm
	 qRe9gWri7mXbn5cVDf+ZlSWeV56pfr41b/DAuQ6LRVFad+h4qlLJdm9Zkrcjub0h5O
	 nmP47dzis1s0vx3g7pVP7dWL+f+zNxygcTfk9gcZ4X8X31u7CINdSflvx9xwwXrUF9
	 Bb6inoH/ELZFL/pl4WGiZFbyIzI2LL+68pejAiU/xzrtTqMI8BKhwerrr50/j8mkd0
	 YJlVPlf4k2OyfJtdfX1FahQwX1jGYjaipllC9RDSbpyS87zoXWHK7b1sTGwPldKxsu
	 dN8cKbAcPkNVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B81380AA78;
	Sun, 23 Aug 2026 19:19:33 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 7.3 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <ttk8fg4@ub.hpns>
References: <ttk8fg4@ub.hpns>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ttk8fg4@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-1
X-PR-Tracked-Commit-Id: 101782f8945a125044347312d74d488c05741c4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66ec24c5d7a047f5b06ee1deb1d0a2869b1791bd
Message-Id: <178751277215.2120410.3915127310429473753.pr-tracker-bot@kernel.org>
Date: Sun, 23 Aug 2026 19:19:32 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Aug 2026 19:04:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66ec24c5d7a047f5b06ee1deb1d0a2869b1791bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
