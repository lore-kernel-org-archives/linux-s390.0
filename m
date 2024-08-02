Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8471537CB;
	Fri,  2 Aug 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617585; cv=none; b=lq590Q+NaWLpYLBZ9GL+8XE7P+ZSmEZ3hHxaC3ZUeVs4/ktajFJr1dq/us2ue+0ceaRjJRK62cON8o8Wd7sBS9/6lXVIZvdWp+bPZOIRQx+zTd4tug6K0sI02uvgdT9rYETYI2XqmBFW/eVQpcVwCV8PdcDrVlxn4dVggKiEQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617585; c=relaxed/simple;
	bh=tBx3czLDQuVst0jXQJP0UeYBbvi5L9KwX8x5eZmXcpM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Pq9o0AWNzbOgFytjnnSR4tCYer6i6PUX9t90EA+65gxS+w2oDoSKMYZqPR0Kq5XTcA8qiVR8ppTJH9H70MJ1xm9HR4IdkzdRw6Eb26fV9MO925g/qHH5O4iKqqwV97Rxnrq3quygz0doEjDVB4woA1ARm2WMfOcUyyfpIEIF+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJqptY1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJqptY1T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 332D5C32782;
	Fri,  2 Aug 2024 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722617585;
	bh=tBx3czLDQuVst0jXQJP0UeYBbvi5L9KwX8x5eZmXcpM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CJqptY1TmXk7xcP4m9tQAhgv8/BQSEEOAqTMrLG+99H4e+74vEC2jkxevuFUogfwU
	 KzflB/14uTtR24ptTHEKnV6vzvzVTP9MT9X5g8Ox6sz7XRd0AvtLq6WQIF0ouQxkHd
	 eigwi77/Ax8lgtLSujQZoOsZHODvqI3IAtPHJbkMZ0smlKJx6FZfoLFqw3H0tGmblX
	 7ay7z9t9YeuCGwNjCDXT1rMZkOi8pPsWk86azGFR/ZrXN4rcd0jPvQmyon9yfDn7ME
	 wMPj99EImR1bR6/dHJiP3ht7NzuuUmS0Byx+7w4dcCOVqfZZ59x0VbWSqgk/GgR7Qi
	 Tis3xADhb3XPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2744ED0C60C;
	Fri,  2 Aug 2024 16:53:05 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01722607265-ext-9466@work.hours>
References: <your-ad-here.call-01722607265-ext-9466@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01722607265-ext-9466@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-3
X-PR-Tracked-Commit-Id: 33bd8d153c337ba9b30a2e5994437ca703ab4ed8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66242ef25eedc5b48d46c4b60f5d453763adf2b8
Message-Id: <172261758515.28369.10064380943770688283.pr-tracker-bot@kernel.org>
Date: Fri, 02 Aug 2024 16:53:05 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Aug 2024 16:01:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66242ef25eedc5b48d46c4b60f5d453763adf2b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
