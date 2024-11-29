Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED161A08D7;
	Fri, 29 Nov 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732906470; cv=none; b=Y+IjP39OTzgwpst0bZ31SkNaVBW+PsXKCkDCq5f1k9BJbylIcuWMeQjGsOzoVsu4hc1OZTXFO14lRQzZo4NjUEGGXmM9IbNaGsv4yXr9wa3cpWfdse+UefXxXd++URQIkVRP9XPpHTR7bluxOGdLIiPFtppiAJ3cIvFwXseA9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732906470; c=relaxed/simple;
	bh=sdgGh0uy2btKUN56DLTgiNCLBS9u6cZXv0Aa6RgluyU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ErVP9C6KYh4bozNiQ7+NWeDVb0YPe7lovX0IcDyzPhhRtgWuTct3LUwzH+1hMlgcafd3sjGVOKfEa1KQiWQGPRyINZ1syEWugX++kETvbDxryincW0OxDw0TtrIE0E9fgJ6Iz/FBmMDe/VeBxRRFbPGXL3EVxDsUCucM9CbICZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruKYSZI8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruKYSZI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F576C4CECF;
	Fri, 29 Nov 2024 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732906470;
	bh=sdgGh0uy2btKUN56DLTgiNCLBS9u6cZXv0Aa6RgluyU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ruKYSZI8+Q8A5hd3ZHfuIXwK+FnFzf5pTImywWThJWopN+YrqCZi273iGzZ3e3eRa
	 dqVY/9iz64BGDtpoMH1zB+gkHBGx5bk3WyCgeLeg85bt3WX2mEU/genjaqmwaQ/VkO
	 B+PdGMOwXMRv6yGuDJUl0gJR5ymahIJCyQjbyEvR26Mk6L3vI7TNu1MOz1ZjAFQNQL
	 bJI3j/55ao+6sTGtvhmc/oT9rIotgi4XqTNbrMQHWDDzc+JGV7cPxsZ4NCaiXs6raA
	 tJ6MFP8w4D7a/Q5ee8V9Zj0sykjXKS4YFpar1frR+K6e7096cj9V4j9CZ5rK2oWMk6
	 9fkMptSH9xmDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E82380A944;
	Fri, 29 Nov 2024 18:54:45 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.13 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241129154542.8578-D-hca@linux.ibm.com>
References: <20241129154542.8578-D-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241129154542.8578-D-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.13-2
X-PR-Tracked-Commit-Id: cc00550b2ae7ab1c7c56669fc004a13d880aaf0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 509f806f7f70db42cbb95856d32a9a0d6700b2e5
Message-Id: <173290648377.2148737.1954028872899410049.pr-tracker-bot@kernel.org>
Date: Fri, 29 Nov 2024 18:54:43 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 16:45:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/509f806f7f70db42cbb95856d32a9a0d6700b2e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
