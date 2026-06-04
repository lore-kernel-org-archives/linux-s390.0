Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328FA2C028F;
	Thu,  4 Jun 2026 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605525; cv=none; b=p281CvQQ1DK0avtYUJaktgDwbA17cJBjCnIFgSFK48TnupMRspaMIqsoHNbo+k6ul+4YEGBZDCsy0gu8jDlThnocwfigaBDCKQzHaT86Kwn71dkGmUcwMAw+QufPhPG16/8Z2ARWG20k6usRVKSBloMoi0JqLh2MlGmJFS0yspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605525; c=relaxed/simple;
	bh=mMW8XkZ/wXYXP5QDtELklp2xNePhOlFMhVQYtUiE6pM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=byEZY2botJ6Bpwf1s/mhOHye5cC/G+gIi70P2ngWxO5DCe71TW38z26fR10j4hhYw8kqBWCRR0+BZjZqnHlQIziLNI7Ls4Pn+UdgnLX+E1IUpMg8SAK9B9+IJJ9oVyC28/NbX8UENx5UtdMT8ovvY6+KAmqvUV6CLr5xRR0hPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEeok7F+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEeok7F+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAB91F00893;
	Thu,  4 Jun 2026 20:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605524;
	bh=1MIxQhexAt5Z7qCyiRocHr15F20+HAzUJplRDaIidyk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VEeok7F+/soSTHNuKtSD9t6pdLMkkIeJCUWjAvfR74R0PdQjq4OHrV64X07KnVzl1
	 E6VdG+xXkYVc9Jb+Cr9zzb6ete7nwMFiZv9Yi9/z77Wy8Ird5RotSauU9PWtJ8TYqz
	 BR6d064GKwrxBwb3GxDh0+wgzNP96NjprtpeBQk3mUz8new4kDXdJofPPP4ei+ZXMm
	 GErq7op6Cs6axIhd7EYAhSlOob0BGn+a1UinumPiJdiX3jBUEvdhdCcirO6f3RdzzB
	 ohaEELNpcghq90O8UWQqdzj0ZP+UClxkw4y16mX9nmzrmLCzmuLcrHViGtURS0ecLb
	 FA9Hf6J2kM90Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A633930A26;
	Thu,  4 Jun 2026 20:38:46 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.1-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260604064416.1461269A9a-agordeev@linux.ibm.com>
References: <20260604064416.1461269A9a-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260604064416.1461269A9a-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-4
X-PR-Tracked-Commit-Id: 7c6535c37dbc03c1c35926b7420d66fb122b513a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a08076f009e3d9460bebae9f209c1dc1d8a46b7
Message-Id: <178060552474.3015695.17001244396675736287.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jun 2026 20:38:44 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 4 Jun 2026 08:44:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a08076f009e3d9460bebae9f209c1dc1d8a46b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
