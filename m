Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091F1531F9;
	Tue, 19 Nov 2024 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983048; cv=none; b=tkAqmNl2Y02aJfCRb59poLNv3eVfiwqNm2msoo4TUzQAuAz1q/pu/ireQLM9TTjwUIcTHwgQe6SaIe+dme5E+zTZ6mQsAKsX+tTXeagEbDKtiysZULJVPDt5jvvIZqmEzwYnaEzu5eal7OGNVPpgcrRttgHCLKmge9gUiF7GB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983048; c=relaxed/simple;
	bh=T42bl5iLgX65jCVnuprF2CFgBNxAhSyWSSH87e3sn2w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HG5zaagH1r+w3VxdQwWFhyEAZWqLVc8HifFqFrbdAIuvHsdZXqG/aUAXuUUwA4Lk5f7kXmAVje3lFSym03qnfrI2q/kbpZ8tuJj1lCSHt/tTIns0A9YXhb2OpiuN2GplARXH7FL4xjjxG7viZHhZkvJb+EQIBGLmQKG9CJcBS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPWUuDA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPWUuDA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1A9C4CECC;
	Tue, 19 Nov 2024 02:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983048;
	bh=T42bl5iLgX65jCVnuprF2CFgBNxAhSyWSSH87e3sn2w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LPWUuDA/wQW2yM3wMZUDfLsEjTElxsh4T6FgV2OUZBV6cA9+zcWLTu4q/RvNCn49o
	 T4oU5u6Rs4+EPK1bThezrpEF5is5Z397fJf2y5yqcMq63ZId5Y/gxk48d1nVgR92KU
	 QolU+9OZjk++kk1xGLmAixHlB0JnXCinU1UYsCb2T4ibnMS7VuftjFmHj1WKxKY5rn
	 1k+QY9/+C8LKrUiDbgN2wGEWOIuGY2hIZZMClSwD6UOs2+uf244mDhXPHG50+L/UPD
	 MgM5toAoBAhc//beau8Dxpn/mGVDgfiJh+B+rcgfbn3gDx6OB/5QlP3QUrWaNlZggy
	 K1RAG7Hu9aiVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1463809A80;
	Tue, 19 Nov 2024 02:24:20 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.13 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115153054.27184-B-hca@linux.ibm.com>
References: <20241115153054.27184-B-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115153054.27184-B-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.13-1
X-PR-Tracked-Commit-Id: e200565d434b66e5b2bfc3b143b66b8ca29666ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0338cd9c22d1bce7dc4a6641d4215a50f476f429
Message-Id: <173198305938.73657.1348444864287404165.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 02:24:19 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 16:30:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0338cd9c22d1bce7dc4a6641d4215a50f476f429

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
