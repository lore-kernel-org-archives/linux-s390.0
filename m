Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193444;
	b=zFFYxBjxp1a9sllkFsupS9gptrd9U0GbglvPny/fjXoHorky3Ds3koGVgm4ul53h2Xjn
	 9TpEzT6CMztDqYSRniC30sIFOlmtWizBpIkm/EpkXXNjIAFukbta4J6wP6ABl21EuIEtA
	 5qDlzzj3k7hYzqgAJHAXZl1tnA0xa5BY1kBSBl3gL19n6bpyued/TVjmyb8Fso5ls+MOm
	 ssv6hsbT2IoUwTMwJxJaLnGlLZYLbfMO3Heryt8stcP+irdWILcLti+NKaa6C3nKkq3Sd
	 rH2DQ1wfsxfKkycT4FDmHLvsdnMXYt+E6NXFsnXpUM4XBpjzexJVSJSyUET8swVg8fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193444;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=5iRs7QUSdWbHxhGC7pZmo2mIrU5fUg2zfS83g1/oGp4=;
	b=ITz2K8leRHDUdKJrCmCqTvMcyGB5U3M0mbKHWS6MV6qQ3PjaA4dmky7Mg4/4bUEqpKJU
	 e5Vf5RB7visMnBlwIpwPawjzsd50rFO5zzKZFOZw7wIMwHfQ5OBpz/HNgqG1wPJWxz2LL
	 ues9FxGqTqkmF5DL4UdTYkusASBYQWmoVpbydDxuzT1+5dZvmu1s1qmScvEYaHd6WQ8ys
	 GLwgoMueG+jzKzxofkxX2SRISF46JeMRcQgTxkTTvCZkh29RUKPIwxxBv/NE/+1koGB9Y
	 jK3wws7y53EOpcCtZC+3ai53OeB5uWP6zSD+oXKiwf2KK21xy4nQKXVS0PUgz0lPDlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoVpD4cM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4D606A325;
	Fri, 20 Nov 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoVpD4cM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BCB1F000D1;
	Fri, 20 Nov 2026 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193444;
	bh=5iRs7QUSdWbHxhGC7pZmo2mIrU5fUg2zfS83g1/oGp4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DoVpD4cMSVJSFJEVnBkjw0Ga2eA3sf8iydraPVKkOO2i7dSDYcqUnhoxLfWL5uoR8
	 DzUJq8+ukz03GIO9KeLHhiaqhfz9luD0BCCe/SDRCaTWwAe8G92MGlupO4dfk75IRK
	 Nxc/LdpZ9nUn4Fz2QGCEXja2ptQ4u3Yj7lHkR977IoVRsBXizWTRuwAvthsk2PgNLP
	 WRir1Mf2v4qGMjEs+/ET1h6NBA2inpEMuKVQgdXcWUPskYHYerZnG40tpHaUhocJWe
	 WpebmU2uECqonB427QTh58i/rPZH+6WOWGIKaEo/hzRJ/40ze2hIqAenU6pwND3CFW
	 OVTNfeEkrU/PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15663809A88;
	Fri, 20 Nov 2026 16:50:43 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261120075922.3382525Ad6-agordeev@linux.ibm.com>
References: <20261120075922.3382525Ad6-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261120075922.3382525Ad6-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.4-2
X-PR-Tracked-Commit-Id: 64ee7f863655e67f26947420516daba4e232675d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a1a8c335afe05d011d6c17f4d14cd9b267dab02
Message-Id: <179519344249.239574.6437758007491993129.pr-tracker-bot@kernel.org>
Date: Fri, 20 Nov 2026 16:50:42 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 20 Nov 2026 08:59:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a1a8c335afe05d011d6c17f4d14cd9b267dab02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
