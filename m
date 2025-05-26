Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A192272634;
	Mon, 26 May 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748295503; cv=none; b=Pl86H8VyqjbdRK50Ph3atKIcF2sX5wvgVucjyr8raPIDbX5bgzJKk1XOFQ8P2KTs6Y0gWZWVv+m36XWccet+t5K4uyFjSbPztFwkZjb6y08x9CKZHePoIcIx0His83lw5+Ky+bjV7l3lgFMt3TL3fyhIP3Im8Dwd4d/idgkdIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748295503; c=relaxed/simple;
	bh=HNHbJPr4s4X8lIPy4ONb7Rh9zCsz2STlmuFHms6xtT0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tl3mk04TvoMTM9buKX+h/WMYQESo9NuL2akDLaJH5J0eGeiv4PBBvsdp0chFWFURCo07iYMkhvzpBauOzUJYdqFh0Sft2U71b+/zrJbD+fbeaPu7RG+X2sAjkFgUPMo2wpGc8Y5eVs3Jmb2/74GcV3xIIc3YlVgyZUEC7+qrvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGhc8l8K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGhc8l8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A32C4CEE7;
	Mon, 26 May 2025 21:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748295503;
	bh=HNHbJPr4s4X8lIPy4ONb7Rh9zCsz2STlmuFHms6xtT0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KGhc8l8KNg1j2L0wCj9wBiHaLokdEHxJEfQcJgwQSvJtTSmc0z3OvLg94Q9dWTn+Q
	 0kxIZ4j6ue3QtX4PNgbesUuJ8hncRpa7bkkoaw8t1nz8DtdWzkWhpOjtoxZ0+ltw6P
	 VZcIhJYlWth7bHe7okx8jbYeRaNFssrwy3PFevXn3zUPoxfmItrGsYWRHC+PpOHvB6
	 Tos3G79ApRNAgxG2T3oJ4263hXBCVug9L2l0oKO4QelGbMv8Upfl6lh5+qXTVkIxWL
	 heH2QsYxa1lnH0UUnm+R25GaZq7B+lVdABrWH8RPyacQOn9EyqCjrNULpZxa7zgLZt
	 HqY6OwMy+98IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F6D3805D8E;
	Mon, 26 May 2025 21:38:59 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.16 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523183412.8641Ac6-hca@linux.ibm.com>
References: <20250523183412.8641Ac6-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523183412.8641Ac6-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-1
X-PR-Tracked-Commit-Id: 774a1fa880bc949d88b5ddec9494a13be733dfa8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8cb068359f6210d790828714081d4ccb47014ff
Message-Id: <174829553772.1063943.6963269122441410821.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 21:38:57 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 20:34:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8cb068359f6210d790828714081d4ccb47014ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
