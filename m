Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935A23BB;
	Sat, 15 Feb 2025 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739645190; cv=none; b=csfeaKkUrHhi4XOHJF1Ql6cbtLInm/sx1RX1tYwlI7ZmHQhoXSTRjcABWo3+ffkd1MuEJQVOW1kIR6NEvpGaewvZ2rPiNLHUnKkDsYDT4gF3lxsCqCMgQPwJ8VAxjBDaAzVJ+EnNPhSpWCBNpXt2Fg+XcYMof1oYXK3YPLxb1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739645190; c=relaxed/simple;
	bh=PJgqYc5lvK4psd0OxgFEM8EC6vLLypFsfG5A/jTqv+o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KFe2KjD/3Os2pC5TkKMJ5HYEuJd7MSnGHBhxAS8+ChHXOn8U/jpJXMHEyODktZenAHbASVvAe+nkGpmFLd5+IoU0KvZI+hYVGrqQCVfNPk/fYoCBYlnhPx7NrQ2KzlWeG66iQbtgfPFHeBJzp4sQlQ4JomyBlW735MBS1bfoLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1bpHkTY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1bpHkTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073BC4CEDF;
	Sat, 15 Feb 2025 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739645189;
	bh=PJgqYc5lvK4psd0OxgFEM8EC6vLLypFsfG5A/jTqv+o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f1bpHkTYgis7DfIyE3KF04/301ppe51PcOnYjWBlOxBSMu+yXw2r1KRW2ixQgUMay
	 EwHfzcJGQCtkzmDyh0cFGyFu3VnSebLMBRwCt4l+jljgnOEb10pGl5q61Uz+Hl/6ab
	 RD3iokKohYg+GpX1rdb3NTPusAFCl3rwRRPyE1djjr3Gx7w3XvaBZRzHvj7kdISnFA
	 7HWgv+H/5UXmQbVSUtGhc9bMdEFUlylsAazULYWVXMrnE7yaPNuduDA88EYmSaeZnc
	 6oiaXMkNK7MBaWBllgppbgc9WbdKivlajUNpM+gNMSErk80GeubuGu/Dlp99tI1VPo
	 Arq85YV5LieEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04C380AA7E;
	Sat, 15 Feb 2025 18:47:00 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01739638874-ext-6275@work.hours>
References: <your-ad-here.call-01739638874-ext-6275@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01739638874-ext-6275@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-4
X-PR-Tracked-Commit-Id: 2844ddbd540fc84d7571cca65d6c43088e4d6952
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3d8b0ebaec4e755317e2e8b863a4004d6505288
Message-Id: <173964521919.2320599.10766084299809939841.pr-tracker-bot@kernel.org>
Date: Sat, 15 Feb 2025 18:46:59 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Feb 2025 18:01:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3d8b0ebaec4e755317e2e8b863a4004d6505288

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
