Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36B820FA9C;
	Fri, 11 Apr 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385993; cv=none; b=dDH7ayw2MxRABWhrij4spHvAsCr3mzt5Ho/YWhCRgG0WNgRLIdaRPwbl2+xrrofumXnu7v+uG3i4WKoi2eRm7x1qbG5eEDg0wUenzhuIRC1QP7KHdp/jwryx/NNWKcq1G4D5ZeN5QHYnZqZyWxpFpRgoXWaRAh6HTLoHI1qdT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385993; c=relaxed/simple;
	bh=oXpQj4Jey0fOE2BRwcS5yPkV5k3ttozPyAIh7BlG2Cs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YABakS2+LzwlYb6QrWjWzqoe/pjnG868cs199mFbuP88FFWGxwwQQHUW6J/m7nvUUCdlDmRQEPVoj6jsqoyu/5d0yFER07GAICu0T9ojZY5WOV/jCDdSJU6bpEeNnaP6cSWFPDEtuyP9w9limUyW8/+8Yau2nbv4dDmQn7kfg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt+Ywgjq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt+Ywgjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C0FC4CEE7;
	Fri, 11 Apr 2025 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744385992;
	bh=oXpQj4Jey0fOE2BRwcS5yPkV5k3ttozPyAIh7BlG2Cs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pt+YwgjqEuBk4XS8X0HRWxfX5QKJABf3TwMqd/RPIptQTgIFXu0AXJMBgeeSG0i/U
	 bhauH3RSSmYFSEAybcBSeELEzJsL4mwPWvZYqQL5eGnjkCikfAqT2cSegREZ8sEPde
	 TLgpANA1i4YgjMeA3vVKsCyGYeGDwsbfI0VG3PHEfQHl5tPLRkf9FbF0r4mGGZslUF
	 ZOi+fIG1PL3MI6katvV/WeY/VKHptDegyVKHN5ShHfp9d8YfDgX117qt3ydE7XDqCy
	 ow+K8z1aqINkZRyBaGK/2uN2fzByURoWBgR1J6eX/echfj5GBmLPHRm27QNT0Flfx0
	 pEVK8TROPIDYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04E38111E3;
	Fri, 11 Apr 2025 15:40:31 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250411100301.123863C11-hca@linux.ibm.com>
References: <20250411100301.123863C11-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250411100301.123863C11-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.15-3
X-PR-Tracked-Commit-Id: aa1ac98268cd1f380c713f07e39b1fa1d5c7650c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b03fa105c6978f0e20fd311ac903226a9e89890
Message-Id: <174438603023.318080.18369081447786268654.pr-tracker-bot@kernel.org>
Date: Fri, 11 Apr 2025 15:40:30 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Apr 2025 12:03:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.15-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b03fa105c6978f0e20fd311ac903226a9e89890

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
