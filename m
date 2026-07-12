Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAEA370D69;
	Sun, 12 Jul 2026 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783883609; cv=none; b=fiBRNH8/hotf/x97wXgpV4OZkc/bEACOyNFMecSYyCYTI7d7ub1gk7pySKplyw6UkGdsbbbsqRFElfU1Tm6o5QId9HA6FBFZThYU78ydmYFBpW4f8SLTzKzTeIZqolnhsQISCNl3pByqiVyIhbuhKg8mMG6yLpdAXhFvTIlTWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783883609; c=relaxed/simple;
	bh=Ba1zuai51pTsilV5WO4cXfIzKF82Wri0xt03g+shrEU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o93AW+mznr28l3LGQgXpEc8s8Pe0xCB1s9RQR46hZeHJNB5CaIrGNezzXm1MlyS5nippCkoR4e3E/3P6TvhbaHqjX1xJdn4oQXDSFVCYNN2zIy+dgM001cVkWdTrSwz1GWflOS7JZ9x0nE4ryPKQVtKqxnBhtnjTbaNtK8xzunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG8WQr5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG8WQr5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575291F000E9;
	Sun, 12 Jul 2026 19:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783883608;
	bh=c5KAVzxXxLCTRjwnC1HPQZRDM/GO0n1ZvP19cisxPnA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=FG8WQr5FT73sgmdfrYNgS/SdN5oJ1dMejUmhRJ7NI+ZZ4mEqJQk4tIySsscVIzni2
	 MaTq6bUo7Zr5rQgjn53fkd0hDsbQrIsb4kRwhnNHcpEEikJ1y4iDABj3LgVmo/UDtD
	 ArKK/Gbn3rWJf/ZNoOdPGF3IiGZQZrzGfolxvbiViceXCpufDW5pgFHDkFwQakkggo
	 yMs4dfAGU9pp9BjGWbxDuVAX6X+YZjMcYRf7cCdHDgg0j6lSrr2mpnCnE6IKj0l8qd
	 Ol5HoRVQp1JGzDEfT/JXMvpQhKSplFkY9jddbhNNV77sKY2aeH/UyLEIECzB8fIhM3
	 k90yhkMIvkt3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93D74383BF4F;
	Sun, 12 Jul 2026 19:13:05 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.2-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <tti2qag@ub.hpns>
References: <tti2qag@ub.hpns>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <tti2qag@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-4
X-PR-Tracked-Commit-Id: 7d5c2f679147859c1db97d9f66366ff16909abee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4fb100039e96211609dfc44fb24b9e4a8a0f2f9
Message-Id: <178388358422.1462520.4995308511635258115.pr-tracker-bot@kernel.org>
Date: Sun, 12 Jul 2026 19:13:04 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 Jul 2026 20:06:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4fb100039e96211609dfc44fb24b9e4a8a0f2f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
