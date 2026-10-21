Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543278;
	b=LDwE4ChBg2CM1+DV40aRzemS0K6UjhHjR6qyikgwsRgj7ITd9JtGak89il0aUgogeHJp
	 V/8jNVokuhOv3pJbpuHOky99L6p3WZhRBlh5+Q5PnRrRNfNywW/yUVJrcb2RfJtC0wB7/
	 pyzdKL97lc3Xcez0cyHtQ2KsM8+4GOSWmw7F5AIpkgDkfIMz8sYci0OVGhj9hjhbtyrNA
	 ybBjARKSEXia9482PQSDCSJhRnenSBtop/QoiKuNeTZwsPxQ40rj5AH7TzISXqwg6B5pm
	 nUKCNZiMlFlhe36E6U6NwHM5p+WmxNVLz/P+MamcKi3l/RFer0oNScCNPdOZ951M2MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543278;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=4jFmdhgMuuqNWHGPZ7xAH43H6ajdHm0uvRRAj6HDcWg=;
	b=iac4ovFxZmGqqq6NDkT85mR6RXqTV9U5wHHUEqHDIe3M0bi1Kaim1OXIgmNaIIeU35TO
	 x9+opE7b2NLGf9+s+iDojMo1lI8+ZErfRzaPWnr5AcUjdXbg2bjiOq4bAstwJfOjJcoiA
	 FoZkXkdkYsrqfLiGqIRk8qMgYu/fBR7XxgvPNrXDeo6Co5HJajXo0BeJtcsGDFs/7F3Am
	 SGeaM8XqXSKjJDGR4NXK6n5hZ2HDMavUVYzhBakuATduWLnfebfUMBT02g/pvfKgFSITD
	 YEHIOec7udeZUBVdrdsnWGRqwqm+Zdh/WCG8rIf5e5qevBfHHxHGnsKLIiwNlTqDNSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTUVs+rk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B353606A31D;
	Wed, 21 Oct 2026 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTUVs+rk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A551F000CF;
	Wed, 21 Oct 2026 00:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792543278;
	bh=4jFmdhgMuuqNWHGPZ7xAH43H6ajdHm0uvRRAj6HDcWg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=UTUVs+rkp3E3smLz+WpUc/qZxgpSmXLYd3hxJZ1SOtGSgTgGMzLo2dZC9F1fHuBmz
	 0Giwxg1OeOUd6tCtf1u3w2LeaQFca71U5Pjemtl4LyfqAR0A9Tc19m2Y8bCzEs6Z23
	 /y6WvPjzXGA4UNc7WT3Gpn5gMXDBr2VuPA1CQgqm3Ci8tBB49C3+6QDfziDBaSwnQk
	 yxNMO5eNJ4/+FuW9V43FejRqXORYG6h1J23mCrJE4AmORU0HkQlpBI5VbqWw4Onflj
	 604fEY5WiOkH2R8Knq9zv5/k+R5Ma5cfzRYV4RDyJ4Dhmwbcflb27jqGU4DBSyUFuO
	 R+NDoqZJaVwmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7B4053809A0D;
	Wed, 21 Oct 2026 00:41:18 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.4 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016181724.34355A7e-hca@linux.ibm.com>
References: <20261016181724.34355A7e-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016181724.34355A7e-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.4-1
X-PR-Tracked-Commit-Id: 3e30b96fab780110f62156d5a8cd5240152b3c59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 375d5d57545f53d2bc3e15ada0e9da360fc68bea
Message-Id: <179254327738.289274.8518010733726961969.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 00:41:17 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 16 Oct 2026 20:17:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/375d5d57545f53d2bc3e15ada0e9da360fc68bea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
