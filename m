Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28350183CB7;
	Sat, 28 Sep 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727541914; cv=none; b=HDQJeoPp9nCTbxw/UbYWscAlEzWTzMZPlqDlr3/4x4LyW57s1SMDsXoaBzkiSXZKApAxGczGtnes8pqYF8n/eMZWaWKkE37MItLfOATJoTOBpxzRrCB+gU7yFepg+WQJfelTLY2EFt7SEyCDOazbt5mcdmVxRn/BMOlSewfavZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727541914; c=relaxed/simple;
	bh=gdfTIDl/BrQhCCZOAT431hRSLk+HRBq3++tt8aDStks=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lccRBqPCmCI25VEJJItUjTD9zhV/E7eL8f1uPYJebmwePbBS7CSyNkQCmWhHOCf9X4gzfN6SrWbX02tkHSXpFGCAhnxT0u5XYkk9ZM2BMgcG02s5zHKxOnn/g2T+OLiyQ1e3DNM177wceGZ+E/66IMuUN+7Rs5wHLhuA26vHBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6qunZNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6qunZNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BD4C4CECF;
	Sat, 28 Sep 2024 16:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727541913;
	bh=gdfTIDl/BrQhCCZOAT431hRSLk+HRBq3++tt8aDStks=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b6qunZNcVye/KsO4ibEjLCvnoL1tt5frmtZzhRHJXzNAuGXiNs1e/6mj748D6kOw/
	 686Q//h9evL85a/dL+JD/Px83uZQBbpjpm1t+j1AI34q84UkKoXdGYOZZBcNqUuBi2
	 eSqTU/rkMggiSqyIsG7ZK1heXrYRlJFFVmySP2wByx8QWFJIurQRtrFCpuRlktWjE2
	 7lb1Dh110hg2dPVy1fYwwvyY6LP4lSTHR8Vi+RQa8lrZdXyGQQfvvCmjoXuK6v/rai
	 yrCp+K9qfrxEQbaFjESllNoo6LT+DS3+dsYINg+AG4FNl+orb9Qon7CBXqfzNpmPxw
	 5X23c6MoI9OpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE61E3809A80;
	Sat, 28 Sep 2024 16:45:17 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.12 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zvf7rJHDO45f7kuQ@localhost>
References: <Zvf7rJHDO45f7kuQ@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zvf7rJHDO45f7kuQ@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.12-2
X-PR-Tracked-Commit-Id: 2d8721364ce83956d0a184a64052928589ef15df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e08d227840bb9366c6321ae1e480b37ba5eec29b
Message-Id: <172754191635.2302262.3004624381565592130.pr-tracker-bot@kernel.org>
Date: Sat, 28 Sep 2024 16:45:16 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Sep 2024 14:50:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e08d227840bb9366c6321ae1e480b37ba5eec29b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
