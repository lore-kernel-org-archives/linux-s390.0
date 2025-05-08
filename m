Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3AB14D29B;
	Thu,  8 May 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719180; cv=none; b=kcYmFC1ZBw0nE59Z0vRQFnxFY5mieFfPBfPiKU03VdbzQgT3qbswQCMN38ku3Vi27WobOKlDCOGpbC6HVZNyno4tyxowVvhhLYTAcQlRDglv6/iWde8+7AQY85F43HZe0jEeVTNroHKxpi/3/hIqJ/jbvJA5deUGNgJAtl1fM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719180; c=relaxed/simple;
	bh=Jg865VS6nfWblZCGYMqkA/C2hUt/KToY3bYhf/A6Klo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F3eHm8jxyTszNmLS6rhRHw/zmgjWXWOOvQ754pO40ahV3MOGlS+Wy2opIqLVJnjfSkDE7ZhVgoTrZxhtZmFov9ZeUCWM/RyWRE1j3cFioKSfQpUBI7be8mWjsZF0wrCQinIctH7aataV2OL7WiE8IcPEj1Nmo+0Ol1TS7LNHYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJlynbU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJlynbU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14D6C4CEE7;
	Thu,  8 May 2025 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746719179;
	bh=Jg865VS6nfWblZCGYMqkA/C2hUt/KToY3bYhf/A6Klo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aJlynbU/4JCoavQ6HZ9HjPgwUv/zR4bPAarW5UYEIb7kDS5EiGVeamidd+IqgK2UH
	 VR5IYq8GFfbFCeaID6BMI4T7+pWLPDUjTFG1SMBa9vNYNg00Mv78oaiQ6IMKSdEYQl
	 kPGtcVrjInKyooS9Ir36+siRVFDqgrvnbSpb0Vu8o73inNUm44bUZo8yc5/3cAS9gI
	 Paym0CvxfHOAQ0jwZxg0Ds3hkOOSlpLxAoZa7x7YB6czWFLbyUby/x6MrR93cQ782O
	 NSpqcVNjjOHavNk2eNs0MwSVNDPxWp1oKNszUmZlF49psY9A+7x3AlhnApzlttFwSo
	 cWwPyO6vZBFLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF37380AA70;
	Thu,  8 May 2025 15:46:59 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250508111920.8929B8c-hca@linux.ibm.com>
References: <20250508111920.8929B8c-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250508111920.8929B8c-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.15-4
X-PR-Tracked-Commit-Id: 05a2538f2b48500cf4e8a0a0ce76623cc5bafcf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26a9a47ccd485759df22ff2be73a74753869976f
Message-Id: <174671921826.2957681.14904432441914206290.pr-tracker-bot@kernel.org>
Date: Thu, 08 May 2025 15:46:58 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 8 May 2025 13:19:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.15-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26a9a47ccd485759df22ff2be73a74753869976f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
