Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A9143726;
	Thu,  4 Jul 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121821; cv=none; b=RQgTbKJkmrddJzDNHR8H6PMAS6kRJISsc7hGGFW20+o9tSSurvgPdJs2r3IZ8QK1CaPvLIY/+LhPT8e998hHFu8ZCRG8XtuRJ6mLhD8QC5PMuW7G6GegiC8chvsehLWhI6nMqtf0LExGlQA4lxggxdbL5xlZ7tDzgg75bJ3OLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121821; c=relaxed/simple;
	bh=ngMMW+EaJQHk73RStJ7KsQLWCrfvittHsQsJ4HLFrcA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NMW4pY47wEudhIT7XuapU39bjmBufYuzgr9wrX/lFAc1AHXrXf5sUHonwVTxd3GhfdBYULCRpkXQ1pAVj9HAmIOsHSrxPF2oPVF2k1p8tmWT29uZoEyKFIKhD3di7vmDP9muWtkdEz3bqr3mtlFKDJ1D6X39hhRO8sXLmvcV620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr3a6Nvb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr3a6Nvb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1961BC4AF0A;
	Thu,  4 Jul 2024 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720121821;
	bh=ngMMW+EaJQHk73RStJ7KsQLWCrfvittHsQsJ4HLFrcA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mr3a6Nvbh85BDFIu/ZYRDaYfYh0W7nGUeLRrQxbjauRs+ShQ4g2g3wrjGJIxJ7+rq
	 k9ZEtbyG7DqlYapMK6ZXs/+GBlN2X8aKaEuoT8F3YpiBihRWIA9uKjyBMDZWXyScD6
	 OQmdOtVLdeVPOHgfkqCN1yyIGXValXvNLUUjL87FnYufQu9CeFAfDAqn/Nz6krCZiG
	 6klOWy61/peDmxKwdQTzzGhaxYZou4B3Guu29NwqkbsEbmQDqnyL17UGgG4B0EBvHI
	 nQl3DDF0FD/gU5dlV2mnBLFLsuMI5zJLgmV89pIHx4qUCrbZKNVuwFXxfDRC77j7uB
	 seSz2atRFEbrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B653C43446;
	Thu,  4 Jul 2024 19:37:01 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240704143932.7696-F-hca@linux.ibm.com>
References: <20240704143932.7696-F-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240704143932.7696-F-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-8
X-PR-Tracked-Commit-Id: b3a58f3b90f564f42a5c35778d8c5107b2c2150b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d470e9f57d2f25a85a547701655672a48cd2a170
Message-Id: <172012182104.16688.724879391151222863.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jul 2024 19:37:01 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 4 Jul 2024 16:39:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d470e9f57d2f25a85a547701655672a48cd2a170

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
