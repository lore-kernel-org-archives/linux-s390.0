Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE2238C1B;
	Wed,  3 Dec 2025 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724939; cv=none; b=tJSQtUGkyPz5llZA55pKmtlj3wOxSwJsBaEDun7DlngWZ4RQGp/VpfKnrszPxqADpgPTsxoFJUDLmtxLy1u3L/Ez/W1nCrwTbNZZA1lnIpo4HO00yaxV1tDQImAkWZ9PioHmAQkxdQrrIM8/D2z4XKqrB38vs2hNMC2Apa7Lu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724939; c=relaxed/simple;
	bh=nWWRt4Ry38PrVgvZX5fem6QkOpOoC/mOGlFFIYDqO/Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qIsLVz198SZkxK0mZOyfCuDxYV8j/BNirCrSlp1GuivOWsRF6VCPdiqlBCl/gS8klwpMIgp8a6zSO+D3s9+nlvzFFKZdWeoyXdqlELdHUmrc5lXho/NPBFvexF2tcUxCwes4jNgbvsfCpmdUP1f4ZZ93wVLBfx7zZ3v5lKdx6hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR11x/kZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR11x/kZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B523EC4CEF1;
	Wed,  3 Dec 2025 01:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764724939;
	bh=nWWRt4Ry38PrVgvZX5fem6QkOpOoC/mOGlFFIYDqO/Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UR11x/kZdiUQ5G77yDjNsRoKI00rzNvPEsdEla1pLNfgL58flG3I0OLMDKYvwRIbH
	 gCgLsOwXhoO+HNuD7/DbgMn3EzG0HRjmLd+X0HX0oOew5Yc92vzBmZ6iUZVjeAV80D
	 FcR2pmiuSQ3fy2aMfIhNrffbxcyugL+JDOXN2k155DoY/BTNxGXmPAm1BrLepwLaZJ
	 DTnw8ZrLjVGyYNcgUd67UMvPHYZSj9U1pSfizjiGfR9mvmcD4Aac5O5iIV+lbyDAcS
	 DraMEVQ9lAm5YaYl9wpUY/NZ/ba3zsPdUR9M1SE2wIQijJ6DZkg/GzJUFaEfS0BSpX
	 0fYioEW1x4Mhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7AA3A72A63;
	Wed,  3 Dec 2025 01:19:20 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.19 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251201102713.22472A5b-hca@linux.ibm.com>
References: <20251201102713.22472A5b-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251201102713.22472A5b-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-1
X-PR-Tracked-Commit-Id: 283f90b50de077970c429e5b9b2745d5e94a5a45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2547f79b0b0cd969ae6f736890af4ebd9368cda5
Message-Id: <176472475875.3463594.15508711753602368397.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 01:19:18 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Dec 2025 11:27:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2547f79b0b0cd969ae6f736890af4ebd9368cda5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
