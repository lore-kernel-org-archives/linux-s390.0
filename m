Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AFB9476;
	Sun, 25 Aug 2024 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724544824; cv=none; b=Q89gT8KLUb+VDMVH8k46Ikonlsocwj1uhQPvBYvPNsVQQ0/PbhIJclD4pxIMLWuaCQyNhMqYb0M3w+cH7Im8mKtMJmPLUD/p6onR39uDngFNOJwNrr1XULDrsKZIu/oGp8gjw55LC6OQ9ll7Tw0DobPsFeWRU5XB5Hs4lGw8rsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724544824; c=relaxed/simple;
	bh=WUTjoxIDWEcT1TQsz2WdEr8moq2EYX6mE5Cn+dCe+a0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RLRuL70MP7m5E4C8DOrPzIKQw28HPXERagy07iTUfXXOIieaDw8Duhl4lqRmIrX9/rbdEfbn/LFvEcPqngEeSCw3MRFvmmHoxRlu3E7A5vMT7vaNohfbjZEJmV5bXIXKFrwOHn+vlD+z+3xDB1vAkPvAPVQnJLjSY1dq+3ys9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNoLbCBA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNoLbCBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F67BC32781;
	Sun, 25 Aug 2024 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724544823;
	bh=WUTjoxIDWEcT1TQsz2WdEr8moq2EYX6mE5Cn+dCe+a0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bNoLbCBAnvZ68dJkNMOqQ4klvMxpIcX+7SXrJfoiOU54zokdZiE0uoAlsjYS6C7kH
	 +5AsqaeqHgy+4SFMIRTZcJTFt44sv3TpiY0ghvEPNgVe8SqKEEKt6/epjyqeuJd1Ex
	 xyfwRt6SLaho+Kw32thlBD0GC6MtoTGOVjNEZTwVBMjS7/9Nue559Z56FgiQjEIB6i
	 ZzBJ/2jaJPgpHr9YXNhFGYMHfWN8VhLFq/+J0/xl+v4D8qwobTrjxmp4x/v49yNnJu
	 tDY6kkK0nziCuccop6uTTndeK9Okx0yBJEqqW1zv06SsAODGEwhXWFSHaFRQ1ICgZu
	 t3+cEBVTE/PIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB23823327;
	Sun, 25 Aug 2024 00:13:44 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01724497059-ext-7858@work.hours>
References: <your-ad-here.call-01724497059-ext-7858@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01724497059-ext-7858@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-4
X-PR-Tracked-Commit-Id: 1642285e511c2a40b14e87a41aa8feace6123036
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48fb4b3d9b43ea8f81de06f12f83912f8c1d5a15
Message-Id: <172454482331.3301129.3184396891968445330.pr-tracker-bot@kernel.org>
Date: Sun, 25 Aug 2024 00:13:43 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 24 Aug 2024 12:57:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48fb4b3d9b43ea8f81de06f12f83912f8c1d5a15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
