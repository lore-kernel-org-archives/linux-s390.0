Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C91A724C;
	Wed, 10 Dec 2025 23:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765410876; cv=none; b=mUrCbwymqBdkixwlpiPHznMXpVs19hcJdm9IKtb0fs5zSHatgPYr9FUlsCK4lf1ffJB22uKXSvdRX2lnWvAKpeBAm+jb9qmSCpLQdbhzBrMXJkH65iVEAhBGkWTV52LIG36wlrDBRXPoHqXT4sJIoR9E3FyF1/Wofy2GEsiXCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765410876; c=relaxed/simple;
	bh=0WiXhVZqiwkQJA1xjEvQ9BYkLb3SSINQKSPBkmty/H4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O204p/mUWhn6jjcqOzN7a2ZFiViLVUMqWQWI5x1Rt56uQLvFbRzU3uiBWeHVOcgXybeqe4S8jpTzmCzFvIupotHHx1jhGNOPaOgnCGf9D7cH9h1KXPWCYY6jagqfFJe8hFD7gwr3ITY80qvcAf25q7QKG9a1ABoENr42Y0uZb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9hDNRbz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9hDNRbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C15C4CEF1;
	Wed, 10 Dec 2025 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765410876;
	bh=0WiXhVZqiwkQJA1xjEvQ9BYkLb3SSINQKSPBkmty/H4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B9hDNRbzynhj6pJHDqEM6R6o9+RWfna0UnONltX2vF8jVHlM/4KubuyddblHE9KyA
	 AhvxnkbRIHttdbRnwOwyGaqAzqRKnZBHNdtnBS8RukYXl/SldXRZY9oJjIhr4HF1+r
	 J0dUlMTefFs2XRkdxYZ5q+O1e6Sjm77ZuWyQoUcn1kDQY0GJQs4vpqPEcIkL+eLDbO
	 1c20C/8rAsptLdQDTnKTE4StAWJ30I3AvWD3J4tMyJPg4X/WJtNRODoKnxq+xXz10m
	 KnBnONYMrXXqLXTkQF8JR6wWC/E2LpmF4kT2NDfqBoPq3FFeHID460erlCStqPcXcK
	 0Ll3S4jwf236w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2E233809A23;
	Wed, 10 Dec 2025 23:51:31 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.19 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251210114816.40732Adf-hca@linux.ibm.com>
References: <20251210114816.40732Adf-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251210114816.40732Adf-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-2
X-PR-Tracked-Commit-Id: 70075e3d0ca0b72cc983d03f7cd9796e43492980
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0723a166d1f1da4c60d7b11289383f073e4dee9b
Message-Id: <176541069055.769338.18298602786749397982.pr-tracker-bot@kernel.org>
Date: Wed, 10 Dec 2025 23:51:30 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Dec 2025 12:48:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0723a166d1f1da4c60d7b11289383f073e4dee9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
