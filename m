Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E717D8A8;
	Fri, 26 Jul 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017259; cv=none; b=aoa2S9arPXedeHqKp1kyEjn3SYvMnV7lqw3JyUqXD92pMncEA7zp6mVRsTdZW7/JjJuMGddpnQW/yCaDSao8X3/aVQLNePMdKjGITrCZzgcemuFrQ6VUwxTuc+n+1mr+EmbVp1nowwQ8BHXIgQhtLtqM8/PmdpBpgVVyvqNJDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017259; c=relaxed/simple;
	bh=yzXR0ofMeysqzAf5g13djaN1LIRXwIhI8F+g3n9Riy8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XEJpivWTnvHH4l5iixK651g6o8HpNuK+GV/wSWF1V/jRNdj+hS86uel898Rl2XDExJhXZtzS8VEf3HEUW46Mpg5JYdTXH2txMjNySlbYfEwS8KrtxoPWA5SBkA6KLLIPr9Q6ARxTq0OCUllEpvoKR0G/FxSmyh9US0GsDmXw3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUJXQ7sL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUJXQ7sL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F581C4AF0B;
	Fri, 26 Jul 2024 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017259;
	bh=yzXR0ofMeysqzAf5g13djaN1LIRXwIhI8F+g3n9Riy8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PUJXQ7sLx8zis3zWo8+4oH8oZ8baa8chG7xVLFRbdSmB3J3R+avbGlYMCpii73Isn
	 ZPQGu2U2ayQ8BOqGc9k0FtJ1sUAkLKxgmyFuIuDu5Eac0UIFtbC0goNeTIODqcdcRk
	 vfcGKdgdAbCL1PBv6/RsH06LXkc3oMXYCrYBh1bxYQHpgt4JAQbw5tu5E+2onZl8LH
	 zqCk8dvOuefAuN4isWWRoVS0rAd3Af6nxqFtpRmdUiZxLQt2U/Jh8o+8+azgmcCYjb
	 Dm5bBbIefaJVUbnIOqB+5buRodLefUXdPtwYAki7It5RDaR3IxtjL6HhtDw1DinNGA
	 GMVonl4PrWzZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0751CC43443;
	Fri, 26 Jul 2024 18:07:39 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.11 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01722003454-ext-3193@work.hours>
References: <your-ad-here.call-01722003454-ext-3193@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01722003454-ext-3193@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-2
X-PR-Tracked-Commit-Id: 6dc2e98d5f1de162d1777aee97e59d75d70d07c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65ad409e6388ea59d8ae73e99857c565da69612e
Message-Id: <172201725902.32235.11982719294698947095.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jul 2024 18:07:39 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 16:17:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65ad409e6388ea59d8ae73e99857c565da69612e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
