Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDEC61FFE;
	Sat, 15 Nov 2025 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763231219; cv=none; b=BZ9yVqu4J9SsUgRjoAmme3IChkpOBUAP5lNJhLrrPsJoqEFa/fety0DvzJ10SL0tT9dNftlOjvA32N5ZOxLYDfsy87DbeERKAnYdPpUnsyVJmUZmgiuMTZVApUKGMhnudPNhptb/ByYMD70czwqUwxXG+63Mizx66wk1842Kolo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763231219; c=relaxed/simple;
	bh=yUr1DQgTKw8Z9GLGZJGS2JZEfHc9aFTUpo5RTpZSJEM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NmxwKfJn8fHxUqY/XQ70TLXz62meFoZ08bEDJUBtHUWA2Rnf6QsRe9qr63th9qRBumeT5CrdyryinGQ4h1bNwkjA6URGmO2EEEGCs9hVbxF/OCD9R8JPCuWPuKgA93r/RTPEBtHyCWBOHV19bKjX1PKAjOB+oRSpOhKUsjTEV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNLKctCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNLKctCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD8BC4CEF7;
	Sat, 15 Nov 2025 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763231218;
	bh=yUr1DQgTKw8Z9GLGZJGS2JZEfHc9aFTUpo5RTpZSJEM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bNLKctCFxUX8dRED7I85vNyLdjbvu17J5wm/mFeI6fKhK0UY7dxB9s4TpyWPzsHsR
	 8leff2n6NOJwhLpo00C9gzQmPe2UKbBdd0U5TOsFXS6RSO0Aw5ojgx99he5HrNQ8RK
	 aj9ABCFjaONGrcvjjm0vDX7vL0V1RJjYpLsDIW7Lm67dEj40X9h+eYDpr5U9vOJ9ga
	 n/fuMieiZAhcnIvWcKRgjofSeFkKnNGaksdpHhJFrYsO5sntc69Ky/TIum9elnqPiI
	 gO7Ye0NKvHWGhWHGAfUHVsX2FSVMxfzZJLlQieAmQKam//JE1gMry9Oli19qV2J5i5
	 Kbg3OTOVRC//g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712E33A78A78;
	Sat, 15 Nov 2025 18:26:27 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251115162211.11983Aa9-hca@linux.ibm.com>
References: <20251115162211.11983Aa9-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251115162211.11983Aa9-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.18-4
X-PR-Tracked-Commit-Id: 31475b88110c4725b4f9a79c3a0d9bbf97e69e1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f824272b6e3fe24950abc527136e8140f67b0b23
Message-Id: <176323118604.2075996.10788006677638300262.pr-tracker-bot@kernel.org>
Date: Sat, 15 Nov 2025 18:26:26 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Nov 2025 17:22:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.18-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f824272b6e3fe24950abc527136e8140f67b0b23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
