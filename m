Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E492F50A6;
	Wed,  2 Jul 2025 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475980; cv=none; b=JXibGtRWW5xCfXPJ2piUW0THwPUhctV9o4JAqXKqwA8qu4xEBNAzIVjkdY2Rr4dwmW4iK/mNp6E2ZjSt2suuZWlhN5X/Yb3BrmG5szvOxD3d3lzN4XrLIDSGGp0oKZX/lrn042Ly45gOFYdbbzgqaofjP7g53M8gx2EthfPLphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475980; c=relaxed/simple;
	bh=SS5WjG9ciU0is62oTGBUTmsQ/HoYLWJkqHyZ316UcXY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JQvZKkYL7dfaooky5kvG+qhjiJ0YQ/QKtwAed3Qua7rwV7zoH53Y2QDu/RsMAUpYpbcvKo0qaJeZAgfzmhfFAxYX9fZATQy6ZbxWhE1J9OwfdCmlPOLXOMc7hmRwDZcpJaFo3nuNHzB1+xFT5ZFoJ1fiLtz2pwI8Pb0RENL6xYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSDZUO1g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSDZUO1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF43C4CEE7;
	Wed,  2 Jul 2025 17:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751475980;
	bh=SS5WjG9ciU0is62oTGBUTmsQ/HoYLWJkqHyZ316UcXY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kSDZUO1gCtnw+NE9t4yrLbdHnbR5oDtcfp/fJucvtb3d2/sgadVMk1D6Cw7eSKLEz
	 EdZ+h4QjHKmovf+1V2vwN20kRMJGM161TECMiZDYvd/+ZAklt0wXUzO/5UFCCqa8TZ
	 growX3wxEUO96GtWRUOOKfpWLJSjRuU7bIOyp/130CWP5f54y90IPJVQ0ZIZxqimFi
	 8J18rY6TO3HdvddFReQCVPrMzUIg+Eg4Ld6Ky48yjj9YbeQ9RSG919hvO/XDn87ctC
	 KPQK/vJQXS8gzT/QkqeJ6BU8Zbn7tGOxKVDG4GlLR11zp637SgrwrKcu4WxcTOMOvh
	 Y+M78JvwIqQ4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE0383B273;
	Wed,  2 Jul 2025 17:06:46 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.16-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <02f08dcb-fcdf-45a9-a598-c252018153cf@agordeev.local>
References: <02f08dcb-fcdf-45a9-a598-c252018153cf@agordeev.local>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <02f08dcb-fcdf-45a9-a598-c252018153cf@agordeev.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-4
X-PR-Tracked-Commit-Id: 62355f1f87b8c7f8785a8dd3cd5ca6e5b513566a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba6a2f25d3d0c813bc5f70c4437002ecc90b85d5
Message-Id: <175147600481.796050.6100271038912961977.pr-tracker-bot@kernel.org>
Date: Wed, 02 Jul 2025 17:06:44 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 2 Jul 2025 16:15:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba6a2f25d3d0c813bc5f70c4437002ecc90b85d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
