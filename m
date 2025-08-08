Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE101E51EC;
	Fri,  8 Aug 2025 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754625579; cv=none; b=YR4bebyWjGWtAtjc/B3wk1Swrp85//I6CmpkE8RhPC1tZhoMkbgwUsAEmx9c7yduF1ag1AXOY6RNvAqdw+iLnxrRt1rtsvJVJIU1DZv1fi2q58zmwfw5zvoisYrSk6Nrzcu6COxa6d/wCQ6QXca/LirbpJ/JfWvfONe3CE3l5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754625579; c=relaxed/simple;
	bh=Fye8ziIpotRJnx/DuT0UD9ZtU5LN/M7BZL+vh8cMTDc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F0ySKInN7IV6wEXuM7xgZ5MKLXK0VIxJhagm6dSWGahWzw6O7odB3rV/a8VR3a+9fJp4xz9WunuThQT66QztzGCK4Ci5ewkD+hglUW/wnym1v5PQWgvpgCZk80ir8ubLBleBUMCnHXYEZSyqtEXbdYorlcvhb1oUPXT8O+OGRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxoTW5Ma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxoTW5Ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAC7C4CEF0;
	Fri,  8 Aug 2025 03:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754625579;
	bh=Fye8ziIpotRJnx/DuT0UD9ZtU5LN/M7BZL+vh8cMTDc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bxoTW5MaxHSKxSp/xoYgZU41yAqZ2N9oOSunjDOHUDZXw4RerD0LPIDeKLLsRLNRn
	 QIbFwMPRf6VGMmx/5qzYAfHoEjwo0hHL3JLjsZ90KJXfeezNrJYoJWPU9cXxY4BAhk
	 L47mPAorAd2acijOofgtriHKE1CCwzWczTpC5kfZ/o6vOUpmUD0CdPkb1IIW69tzyC
	 rMZVyTbp1XC3C3KB/UAasQmYFxHt+h+3/2y70EnMkaLpBfIRUEOgrkYbEvCASp9aDl
	 L46NCsMnL0RV0qDvcKwvlLpcfLpgEuefv6emXOSWB9WRUvAzYnvXj0RTYt/1cX9x5k
	 799RmiuYyWy/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0D383BF4E;
	Fri,  8 Aug 2025 03:59:53 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.17 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250807130950.4053091Adb-agordeev@linux.ibm.com>
References: <20250807130950.4053091Adb-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250807130950.4053091Adb-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-2
X-PR-Tracked-Commit-Id: 2baf16f381decee303da406ca5a0991134260270
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bec077162bd0017c21288919757809656094a157
Message-Id: <175462559258.3795225.15037481834266940166.pr-tracker-bot@kernel.org>
Date: Fri, 08 Aug 2025 03:59:52 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 7 Aug 2025 15:09:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bec077162bd0017c21288919757809656094a157

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
