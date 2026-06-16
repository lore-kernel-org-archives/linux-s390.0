Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1E243376;
	Tue, 16 Jun 2026 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570047; cv=none; b=Xx/j3mUWzeEWh2wjmk/Bg6fYHreMvQpJ89Zf5Q4dyMPG4iPlNmVE2YWsD3Z6uhEPWfBigEzSi0b1CmzXteQ0sTK8IuVyPDf1kETBZXxuBxYYGDBNi7VzWqCYaZL+oWlchV/avo9v6qKsJ85XSMMtFFMe98RQ50+zHEO/2+Vm4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570047; c=relaxed/simple;
	bh=ktycN0tqJK6K8nhD9Zuqu1mnFq7zxtISRCCwO3jMha0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ehC9PNc9sU4Z7KMvElvq7+OvFY6ee567ysnzYzcjEm5LwPu+ymmaVG4jigK+JdOWHRKDujFrEwpsejY7iwz4kOfN3Jt5VNw3v32E+js3+RI0I6Tm7efpkdsUjXH7LKHfF9y83h+YRClk8UZeiCgZDtR6SU2x7ZBJwPo0edD/oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olT/LSvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olT/LSvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6B11F000E9;
	Tue, 16 Jun 2026 00:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570046;
	bh=XfKHA5FbEbWq5PeLgKh/D3NL6E5nrZywNL2zWB1Qv3s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=olT/LSvy+mt+fBW2r8y5a3L0v44Bvc4awkCmKsH+vSAqo2rwyoSLOzVvc8gJ6Ehfl
	 ZWn6AxUHyP+FFFsr+WZ59q9BnJPj2FZlOLQ9ECoNG7Lz6Z8EWX+QPHG62HvyDnwNvW
	 ya8xRcp1yWEsDqj5+mIcHSUqUnHkGDKZIXbcQJ4He7MnSiRnDD1uUjG8w4ukB5ivxg
	 vuHFFXi4bHtn5qSYkf4S5KIef7vjuCP9Q+yIw//3YnvSo5FjWTATI5bxgSubHVkdMH
	 WO37Nbws/y66ctysclTsN8l8JvRGXHAC1I5S9pihdxDHv//aU5nbnYe/FAgAcR3kSV
	 vpOgIwGwnrrDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0DD83839A26;
	Tue, 16 Jun 2026 00:34:02 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.2 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260615122242.535455Aa5-agordeev@linux.ibm.com>
References: <20260615122242.535455Aa5-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260615122242.535455Aa5-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-1
X-PR-Tracked-Commit-Id: 37540b8c287fc817bdbd0c62bb75ad6eab0e5d03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25a01b5155d207e72bdd31b138406f37788403cb
Message-Id: <178157004146.358810.7454106325776137187.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 00:34:01 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 14:22:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25a01b5155d207e72bdd31b138406f37788403cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
