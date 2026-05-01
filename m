Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A8D331203;
	Fri,  1 May 2026 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667000; cv=none; b=hCjEG2Z2uy4lZbpp6l+D3zkI4dnPBhgwh+1kRuIeqeQwkJwNxhxDHpY2+k5TqBAEqIP1cl1sDsSYyBj8TVZRSzbR5/hWFjpbTgsQ87RGwi7Qg4JrGkRxUYp9BYRqSOUPZM0VyBWFPMCCLk3++KzFGAcut3iCRBGM770+m2sqbZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667000; c=relaxed/simple;
	bh=ZGQBFwiWDck1Fd5DnQ3nT8M7R/E8QL+PWm0/J1lsP7I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dhASTahrWBUt7OeeY0/2C3xZmzwJFtS5HbUeANSE8QhHCuXbJAl+l/smXQo9TosK8HODOEC/9fNl83wPBHTTkNcQ03kBIoHOCGznM66wMZ8Tuu9h8NdenuCCs3BHZYu+VgaDvTtnpqeY4/Fn5X/+bKXtYUl+hxTw4gH9tE1twHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrJU39kC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrJU39kC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830CDC2BCB4;
	Fri,  1 May 2026 20:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777667000;
	bh=ZGQBFwiWDck1Fd5DnQ3nT8M7R/E8QL+PWm0/J1lsP7I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BrJU39kC4i0YHtWcx8/5NirZ2YNVCfwPD94XtJhsgDLy4KN2mHyZF4ZpJ0a7M3O5P
	 fMFE0V2vuoOOstW7PYnXthnijp6g8/BiKF6wnfzU+50rIzaHSZP5iMhn4K1ZVYgObU
	 oEEE/r89elFI5LRt/25li7B4XVqT93tvCPNUq+1QBVEF++iazLXlDQWWfAqwWfslqw
	 82R1eu4IFZcJxSqVt594ih2HPr9kmnqb30AMprK9VpXuHTv15BtOC7aU+Kyk51h35f
	 OO+rl41Xl7Yl48Vv/xhSUx2EdBCoU8vyV8trbrSuRI5bod1y2w9COS1JIJ/3a0Cq7Q
	 tgpF2gvGtuZcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DA6380CEEC;
	Fri,  1 May 2026 20:22:35 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260501162212.806358Add-agordeev@linux.ibm.com>
References: <20260501162212.806358Add-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260501162212.806358Add-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-2
X-PR-Tracked-Commit-Id: b95e0e792822bad8fc9eb33ea3a90005e29e75e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb1d73f2cddccf717307e88c24cae619a9a80295
Message-Id: <177766695363.3609975.9392918638623609182.pr-tracker-bot@kernel.org>
Date: Fri, 01 May 2026 20:22:33 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 May 2026 18:22:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb1d73f2cddccf717307e88c24cae619a9a80295

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
