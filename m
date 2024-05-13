Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5A41553AF;
	Mon, 13 May 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616907; cv=none; b=JngJONHzfOf8lFxwPoFNkSbKlge8OQ9m1WZ+MXfq2SCGLi/wdELgSWP3HFJ7yHnJeyCzfVBf+U92Sq8FTQnt/+lFNDaWIllJIBpPv+jvGRkQ9wXikwyJapz+r2OWMubNWLgkizafkEEg6C5Vl4rPqbm7qLZNhVjbiEQjMNcNBq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616907; c=relaxed/simple;
	bh=lFr/uwF6CWdZyPgPTxVDucYknA6sGiPVMiefsgM0mts=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O1eJZDcO+nfBFCQQzYDmjvl1l1XZTC5k85O7Vr1jekdoo/kewzCGn+/JDbkhVsrY8bgdDDlVYJb3UYFskBBg5YRsic42nES9rcXD8PrD/xfsH9wPFmdd7qx9UkdztWyXmM+BoHhu/88RscDHgI7OY3aTVoX0HtYWh1qeGJjM8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3tGKcjF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3tGKcjF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD8D4C113CC;
	Mon, 13 May 2024 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616906;
	bh=lFr/uwF6CWdZyPgPTxVDucYknA6sGiPVMiefsgM0mts=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I3tGKcjFnHk/lqi/Y5CqMwucngDDtAh7+ueKx3Xki48Selsxh3PASOUbCCUar3xGv
	 ul3HROkbhJGYD3eLg14lalME2hmRAjNWDQy2CI559XUkFWNh9j6EMUPH0JwWtmeKE2
	 BNdoWiTUJIHoztUYuszjt70l4pYS9hW8PrThQeXnqKOiJ8gcKQ1gI9L04fBg0meqT0
	 xNE7Y+1688jZ+7/bGZtNuismJ6+XMTfMNesmeEP98PQ5cs0+9y0Bak8QZ1P/+BPX8q
	 yS53wKw/A+vuuhMQmQbhvP+X0hwBPqqzO+Y2rzhbTjd9EpJKgnVhNHvzkSkdwbPXWD
	 PsT8y+FAomEuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1C7CC43613;
	Mon, 13 May 2024 16:15:06 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.10 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zjn312L7JK2rA8v/@tuxmaker.boeblingen.de.ibm.com>
References: <Zjn312L7JK2rA8v/@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zjn312L7JK2rA8v/@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-1
X-PR-Tracked-Commit-Id: 1812dc9c334f98227c65bc9c475f16fb6840a94b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d65e1a0f305ba3e7aabf6261a37bb871790d9f93
Message-Id: <171561690680.7727.4545950675147713043.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 16:15:06 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 May 2024 11:43:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d65e1a0f305ba3e7aabf6261a37bb871790d9f93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
