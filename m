Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270314B95A;
	Sat, 22 Feb 2025 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740252162; cv=none; b=lmpuEpXoCsOnIftQ/a3U1i9vmpf58eOZPXnwCepOpYTTDj/AykZNe3Z8NF5vhk6BuqnlLGgEtiI9OG/obFE61ua9Ym4FSCFmG8jtb1KYKnov9J4NpBYOoiGXKM/auGaIxy3OmgHtU09ZuG1EH6mC+Lued+GLMh4IFOMGsuTT48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740252162; c=relaxed/simple;
	bh=ONQY9nvvsPGrxR/sZC8rgOJHJjFV5kP+o6rFhNEDB+Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IIfhqhvb93pxts+0BHOt5yARoxmpoDr1sjFs9lAhIUAOvDR1p7HiLi1aOFaa2FM52ZuPi5YdB5UTo+lfYRxApuQ1177NaDDRn4h1wZ77erQVJ1T65f9xnirBchgmcDEDckA0avdWwnBfdt/3fCPHdxFjot1g8SP8piKAjliY5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuxHFaTn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuxHFaTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBEEC4CED1;
	Sat, 22 Feb 2025 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740252160;
	bh=ONQY9nvvsPGrxR/sZC8rgOJHJjFV5kP+o6rFhNEDB+Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SuxHFaTnVZErxjMLIoJ8DJ1rUF57UjBphPXxlTfIEH7r4kU6O1ncYBUdqSBpxiFpS
	 VPJhW5CdAWlMTdwqoxsEr8XTpiWzVRCtnUH8eE4Eq2R3JqWypyvfpblRpE6qLxtltL
	 j1PKyrv1pYUC/XidlsefQTvscA+cWmUkgXAPm0jaEgFtKzF7Ydn+Uaf7DYz4n+3nWY
	 fIrjTmpGBvaWB/QXcPjcNu8IAn6NAB2m1K0P9IgHN/GdjnWMcDbUOnKm04Eq5Rb2oN
	 uu/pgZeRwOcMWqFHWuEHBbyRkh+hq8QVImo4jxUoTLdq1Xh8KKAXpkU67brtcaiDAK
	 uQA8KDMsnoULw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341F1380CEF9;
	Sat, 22 Feb 2025 19:23:13 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01740181568-ext-2995@work.hours>
References: <your-ad-here.call-01740181568-ext-2995@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01740181568-ext-2995@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-5
X-PR-Tracked-Commit-Id: c3a589fd9fcbf295a7402a4b188dc9277d505f4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd59f1d80a6d01326e37318218a072a46899d237
Message-Id: <174025219181.2429034.9993177131152894805.pr-tracker-bot@kernel.org>
Date: Sat, 22 Feb 2025 19:23:11 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Feb 2025 00:46:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd59f1d80a6d01326e37318218a072a46899d237

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
