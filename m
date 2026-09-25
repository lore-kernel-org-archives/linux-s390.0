Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A254E06CE;
	Fri, 25 Sep 2026 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361781; cv=none; b=MyRaW47LMpw+kpwxP9MKihYb3I0pIjLZQHdAqLWJgotEaMTKCp7LsCTLq4THdXFoZNAwHJOFpq0o9p6j3RtUBK0zTbiYWNSXm6EC5G2Y9gNvc4gHNeF2alU7xHjeLm81rG+dFwFNLi0MGb4YnmrW6WLWbQ6fPcVucObKJlCJboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361781; c=relaxed/simple;
	bh=qJ6iNjSxn7OZPN9weEi9W6xgCTyYeFpawwhJ9EYKX5g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ws5CAmCAaFU76Hz/KwLwmDTxgr129wCo4PQCvCrwpnXjfLQ0biIsjTyzQLuCtjOnGtu5D5nv3foUCv6IwsjEDD/XjgRJoP+wqWp+BX8ZhLrCQQUDISPQLZpRbup1R1jJieWUZNky7y0IapFchRsNc25sl6X6bIFfPuf0vzCHVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8DVar+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8DVar+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCA61F000FF;
	Fri, 25 Sep 2026 18:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790361779;
	bh=tgSZ+IqtUcEHBc+ASLfUtYudJCjAcQm10AuG0lcZAD8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=j8DVar+pJX53Nw27zk9Boq0KiF5Kv+YZlehNhwtIqhZ1B6F1FMRuL0C9wPyXdLtfw
	 WP2Zepjl+vuzHwW8JHE81ijE5CBCPRZtwuWGQrZcmkFenDsISf4jic+0BsVl6lGpPl
	 HRvG0I2ez7wgQ8cuMv0XgSvKCMUhDK8ugA5KKW2LqwHQVTieCKBUKndsD7hR5ZOYsA
	 BO4e3/cq/Hv/pDfaWO4VVYNAdmN4HIcOW9wzS4s/K2rpEkJfDoJ9Tu+RU8aaAOHknW
	 PdzoKyJthy+DiuAquUl8E/Gn/T+B5FLVs9OVNu0Q64YsOJaUdrtiE5IKSLx4HaAdmZ
	 afhMD9U+sdHIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C0380820D;
	Fri, 25 Sep 2026 18:41:48 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260925113755.23528Bd0-hca@linux.ibm.com>
References: <20260925113755.23528Bd0-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260925113755.23528Bd0-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-4
X-PR-Tracked-Commit-Id: 5b76268dac968612f7283d59b539036de955b7d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 547463efb935dec67c476f90917a0ff4baf6d0b5
Message-Id: <179036170710.3089752.11767014661345954443.pr-tracker-bot@kernel.org>
Date: Fri, 25 Sep 2026 18:41:47 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Sep 2026 13:37:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/547463efb935dec67c476f90917a0ff4baf6d0b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
