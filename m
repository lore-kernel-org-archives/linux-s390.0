Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B1154C09;
	Fri,  7 Jun 2024 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717798072; cv=none; b=VLm8egWYCIt0xAH16azFjRKFAAVrqJK6g42cDbXVspR1werr2GIPdGoZvW81hIe/Pa8KhGgsL9GcLkZ7lJ3rRAjse3/mZsdGDHhnHGX9iR4IKPCq1MfEQzancL+BzbvxmLevXCUv2AmYlOwUkRxhNN9OtSzOiFZoXElgHDckh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717798072; c=relaxed/simple;
	bh=kQc3uyz5rcLUQ8DXfZdiGnT4ldBszqckC2ZqYRG8IdY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fHs2JCiiQl5xAMDvNc8Xj6/Q81p7zIDquB9TyJSOJvL+X0M3D87lzxg7Hx58aum/Ydz3fNl2Nb6hr36LCJpLQbFnzIA2u3hxrcDPhpUUmmwb0fLccKxNKCbArk+M5+6ffsIqyD9NPgXwgGMPnuwf03lr+0jd+aY3vZ1BegpC1/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3H6zkjA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3H6zkjA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68027C32781;
	Fri,  7 Jun 2024 22:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717798072;
	bh=kQc3uyz5rcLUQ8DXfZdiGnT4ldBszqckC2ZqYRG8IdY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C3H6zkjAyEbK+PyL//07vojlvhc2KIkvpagEK8m/Xg+Eyfcqh6CRWiCSH0Fmd037u
	 w2JPnlfL/PnbBStgTX6olKos3UAHIbhbDucsoCMTrK/UI/QllHOEMkuwKxmWlW4gX4
	 xaaibaOXB72IsJUxzdbDY/ypTUuuBRGqkKsUr/pmorZk4CXKO6UYjKxtPz43q1nYRU
	 0PNFKFoEU3wbr44qCLTNE53xnJ2xRqODCbXyH9xn8KrXtjj4fkimlLEiZwxCnlPa0f
	 rGYZPBwwozmFF+lnKD3JJ3ktrqQPZlPIIjDG9nx6LyuXUB7HFlz7iLEGrIvJ8HBdSt
	 k+M+xpjtWITvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C534CF3BA3;
	Fri,  7 Jun 2024 22:07:52 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZmMWz7/EN3YsRfOH@tuxmaker.boeblingen.de.ibm.com>
References: <ZmMWz7/EN3YsRfOH@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZmMWz7/EN3YsRfOH@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-3
X-PR-Tracked-Commit-Id: 01c51a32dc18f128d2e55a7b2128b77fc01a2285
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d6b029e15ab47986e486f52b2b768ca6faa5cbe
Message-Id: <171779807236.32288.14386927163885041612.pr-tracker-bot@kernel.org>
Date: Fri, 07 Jun 2024 22:07:52 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Jun 2024 16:18:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d6b029e15ab47986e486f52b2b768ca6faa5cbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
