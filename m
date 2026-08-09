Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D272F12CE;
	Sun,  9 Aug 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786282460; cv=none; b=byyU947sJ4pUeDkTZ/JWeYt1CByfh8DWPdfTaudwz9e6Z8Nw2LEd8kzN6711tLMqeWFXl14XDSgLoYlqDFMm+rHfTeSSdcxvaBwRqytGPBhKRxgyB80689zfEPuzwXXYgUybQvvoxVBHOf4kqkuv9iPjWnpJywrePJ+p4Xu2Ax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786282460; c=relaxed/simple;
	bh=EcOpG6iItyBP3CP7cZZK+mn5EaPw6UynrdBTisq+VYw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uzsaOyOCn3YO6e3amqu1cdQyDBEAafs0RiayPyV8QhJTLz4Eld6be56hNJKDu6DSE8f/UgVu6oEQvOPkRCcXe5/+OpuutG+2ARD6KwxrltVP7kWhBwb458czUQHgD7Du5AigL9GJze0V8FFjIpIoVwddOmKvY5uUNLlneC+j9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4Fn7xap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4Fn7xap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D351F000E9;
	Sun,  9 Aug 2026 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786282458;
	bh=u50STay8Fw7IFng8Yf0ZsjGvbshX1q1FPtCMY4bi5tw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=k4Fn7xapRpl3WR+jBtk2vIKRx5MTQZekfRbLrgXkKiJ/IfdGCpQLRMf8rV5TbCHD6
	 /PXQ5YZ5Y0KM1Sfxn/OiA5LgIc6L8dyS3LCBP20Yh+E+2CSv2qf2oLBwHjfbbRMyY+
	 adpsZOEB14AXwH3BHRt1NkTYHZexIunG5yWZvAu0vFe/rC5XDpEclM0VypQBlp6n9N
	 Nl3tsi1+PLLOiJgOlz/oG+QUnzTSdPQkluLQx5FryAUFwUQqhnuu+IFrNot9+HnqYm
	 OSbULTaSydtmhmmA7I+0kg+PIFaRMVx+ypTlePWynfQg+RAIFTLeRSkdvWul6FstUx
	 sjhH2LI3+iCsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698A3924456;
	Sun,  9 Aug 2026 13:33:37 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ttji2de@ub.hpns>
References: <ttji2de@ub.hpns>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ttji2de@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-7
X-PR-Tracked-Commit-Id: eb363254472493e3458156fc11fd56dca92f4333
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b643e495ae92e2aa75a54c557a756e02f049781d
Message-Id: <178628241582.2940447.751712906866510368.pr-tracker-bot@kernel.org>
Date: Sun, 09 Aug 2026 13:33:35 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 9 Aug 2026 13:24:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b643e495ae92e2aa75a54c557a756e02f049781d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
