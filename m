Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FED1865FA;
	Thu, 30 Jan 2025 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263380; cv=none; b=ni2d1QR69mGiPCyU/MXOqHtgMdjEAT23zIqvaELOBiyr8w4R1Ngt0MAuc+FZjASwPAC5LALt38L2Z+cYU3EV+3GjD5f1sq3bG1dUApOUuBL7xNv9pq12GI/u10tVza3yO9MkiLuA7QkRm8a9TKT1X5q4uJWM9Z65CXf5vUvKElc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263380; c=relaxed/simple;
	bh=c5/Bp0E/9gxloZG3/e7YG/TdHmLVmW9bCx3/vhfpXzs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rViHcRmIpO6z4V8rl4wfAwnBDBYfGpk5fGjrzSkvY+xdhHisLdT3Ta6xwfRQ+23Ubl8PQxNsWXcvUujGO37BOxBzhAbOaERL5ZftwaCjWPhL33UK7vvYMjnSRDX5Ol6UuLxmPCyLkdb40cWH79SREYyaiS1fHY3Ze2Xc1ybuy7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqA6iEiY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqA6iEiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F49C4CED3;
	Thu, 30 Jan 2025 18:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263380;
	bh=c5/Bp0E/9gxloZG3/e7YG/TdHmLVmW9bCx3/vhfpXzs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NqA6iEiYLgS/A8jM7yJchBuz11A2CoKAQXJoY3YSye0GF8hCekEjAFmxm7THzZ6sA
	 A5ft6/kVQdo6ui/S+WSF8RQObfkAf1620sCcgHELQVB6hw4kEkiDEFGPUPhJ+4m2Z4
	 jTIvZPbodCLG3QimsduHKCvxpqKaALj9YHLFIE0+nIO2DlMRbzaQcuSNKUiexxcpR9
	 jaKIA8dKgAJpnsASnvgmiLXp3VZeULDe5vI9qXn3DhgWECrF4q7dcM580Gk8y9N2L0
	 2pdtbD+x1ev7A10ZINvRnQlQ2+9pmzrFV5xLxFPuZ9p/3q68dGanIml5Hun07nJtTz
	 CIl45Hpq/nK5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC7380AA66;
	Thu, 30 Jan 2025 18:56:47 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.14 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z5uhk4LusN5aGRwM@tuxmaker.boeblingen.de.ibm.com>
References: <Z5uhk4LusN5aGRwM@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z5uhk4LusN5aGRwM@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-3
X-PR-Tracked-Commit-Id: b999589956dd3ae096b7d67b6fee4e9989a2e430
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8a1c9f4b7106c94d95c83416d34277ee689638f
Message-Id: <173826340665.1052698.8061535311779636283.pr-tracker-bot@kernel.org>
Date: Thu, 30 Jan 2025 18:56:46 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jan 2025 16:58:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8a1c9f4b7106c94d95c83416d34277ee689638f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
