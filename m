Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214736EAAB;
	Fri, 13 Mar 2026 22:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440117; cv=none; b=iz3rfIT65dfmyH9JtKKdx1HYlpQhXx6yYzPMWZ2Vg6Ay7nxfK0tLoyRFpJIfZ4VFPUW1zgSoiYz1TxxVHrfVzi1M/8v6V7PWUf+/uPNzw5qX2bYuk6MAVQIpOsMo7Mt9pqHl0u45oU7O0P8fo7B3hFqlsKIPHiLDc0D4osCtSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440117; c=relaxed/simple;
	bh=S2XCmLsC8lUaB4aTGu13ng8JJGinTFRzgR0O/NT4WkQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CBLJ2BxxCSKlgDe+WBQc6dK8QMKSXkf0uzmSMhRlL/Ri2riKxDGi3Hom1eGD9QEhWikjD2dLgBkQ/3Tg3vuqLXGWtNxCvasQut4Sni80sysAbB2/bHfy0xNGBZK0C7x8O2v7iN5ikPbpLceh4BozpIQDtEievuHZA00BfYqZitc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ/3aGUH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ/3aGUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17108C19421;
	Fri, 13 Mar 2026 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773440117;
	bh=S2XCmLsC8lUaB4aTGu13ng8JJGinTFRzgR0O/NT4WkQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BQ/3aGUHaTxBqnmLAvy8zvknxW6q+Nh3q67CPxItaLDEuxXGwOIbQG/0fln3qJhp9
	 bDkMRYA+nhXeFn+fuWQiygHxmqNGyqEDH+vZA3rKxEI0ANVoOkjRJrMb526Zo9WQ4Z
	 MPosoL1Kj8Kdp6eXCT5et/TEHPlNfJ3D6eqNtfU+ymcfnkoxMeEq4mGrvng3heARjo
	 Uxq+zkONRyBiGtEB2X22FBHLhqq2pTZuF76k5E76dK4g9rS1n8G/SK34YDSnvfb+dY
	 4d0PoC8bTByYXDUjyhjbzpLsVYrhC986e5phldB793A620kNcXwP+rfcpL1k1o0qke
	 HJRlEOeosVfEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DB83808200;
	Fri, 13 Mar 2026 22:15:13 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ttbuo5c@ub.hpns>
References: <ttbuo5c@ub.hpns>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ttbuo5c@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-5
X-PR-Tracked-Commit-Id: 598bbefa8032cc58b564a81d1ad68bd815c8dc0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d9968859cf4efabf39b4c22eacdb990e5f7178e
Message-Id: <177344011149.1522840.1488634847146587061.pr-tracker-bot@kernel.org>
Date: Fri, 13 Mar 2026 22:15:11 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Mar 2026 19:17:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d9968859cf4efabf39b4c22eacdb990e5f7178e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
