Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1351D7E3D;
	Fri, 18 Oct 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260719; cv=none; b=h0cpI/LWEO1tCHCnZSG33GWjbhJz8KsqQo8sn39b7BgfylRbuQitN90SXq2e8skcr9c0wSPa7//okZBzrWPO1UTRLC8GXFhhU2NA7A2HLEwVUlzgMZhLa21YizGN19C3TSR/zN1wc/EvSBBJdFZW1jHXZ6xgE7xjl63qkzhRxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260719; c=relaxed/simple;
	bh=YtWQoTVzCMX7iW4ZGWZYcnxYrAuKVZhjpKejLyUsAA8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=evHwovLW+SoT4JylHO73C0+iG4Bl5IVVL8MSAKOCBSDgpm84HCLgJPC5g0dAWPIhjiNqWKGLfoMojGFEGz0/NzLdYB7KjEPiDX7rJa3ZVffCbJcTTKRyp6qNiUM8DJIp1r4DY+NUjmsovrE5lGoq915qIfA2Jjo9IV0Imbjj4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsqsOeLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsqsOeLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DEEC4CEC3;
	Fri, 18 Oct 2024 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260718;
	bh=YtWQoTVzCMX7iW4ZGWZYcnxYrAuKVZhjpKejLyUsAA8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VsqsOeLPCCAkqKPCcPjEBQb/ZPT4btPw4Q4RMM2pKuITbIfH/YJfOkAIx3tWxwkFO
	 pgLPAL05jb4RNwUgkGVCAdHBQf+FKHBs7G8i+4pX7He/sO/Y424vbDYO62zEB8I8lb
	 uYIzHZf0H6K/kkSqDJM/4XO+vZlITCMMdnGnez+uiNvhPAsmVcqLnPtHjDbtFKc3UT
	 ajmwdTYyIqloF3tjqYvlyNR3EKDGvIY4xkV4QflL8AtvQtfWIhPZepcWEveJJfJuGE
	 WNUs17mTH7AWtsiK5SUlspVQewO0EQbpIC0kxifxMYbZdn8ToLFWkIaygIvlBfR2nb
	 sc00RwrI6NMpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714783805CC0;
	Fri, 18 Oct 2024 14:12:05 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241018103658.17670-D-hca@linux.ibm.com>
References: <20241018103658.17670-D-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241018103658.17670-D-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.12-3
X-PR-Tracked-Commit-Id: b4fa00fd428bf7648d4ac5d0c8b61882902ec516
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c91c14618fcf4ae3cf3475e5461ea8b41bf76f6d
Message-Id: <172926072409.3128200.671499754675477798.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 14:12:04 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Oct 2024 12:36:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c91c14618fcf4ae3cf3475e5461ea8b41bf76f6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
