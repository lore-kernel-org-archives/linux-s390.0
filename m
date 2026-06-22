Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF422579E;
	Mon, 22 Jun 2026 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146221; cv=none; b=cKUW1KRDN/hNeeeDTFdKccWShPNAJMLeLdQ2jJp6niRuZKgCXv71N8ll5YRlSO86wx9P1QrTVQSUvPzsigGIuhNTpC9jwT5uC84RXUPEbX6miXWoofZMmlpFgAkKObBPlc43jPxPkYVB2abol7dSceVYY34flZVwvqgBumrBruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146221; c=relaxed/simple;
	bh=OgMwpc/6q+EKZALzX5KiJg/COU8HV/Nyz0Rb8fLF9f0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YQRFyDEYjeVN2u/9jEVfwPti0os+3qqaBjsL45hdiFq0+WpGa/lMMf1vRmoYac5QF2LqBjQYg6KcI5eauhdtJqWGBYaI/OCFx0iP7k0EcJrbEPqGsLeFfupq5FpQcn7aDZg664G6egRZcp5PvTxldNCTMBWEaNugk+yOMIapUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcwLpWu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcwLpWu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476561F000E9;
	Mon, 22 Jun 2026 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146220;
	bh=QhiOy9Tg/ZjtE3P4f0w8kywY9aCJ+Jli6IrpFKMI82o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HcwLpWu4U9pIBryRVd83BOVF+wpfMzj+VHf5D+7JQM2e3DPzzLLlcmmReZfdFNzSZ
	 4DrXWuc541B306QrG14/5VPTvpPGOvzgP/2rqlWvxQFgeowMIb8n3sF9Si99M+cSfa
	 DLycJSpCgqAUGFDX+Sz0Gn7CFJpxJ/Y+3vkEO0bzUK7mHWD7uLCpxT3LmSCQVVVE9p
	 8k624wJjs06RCzCFZpQfhzhd6KXxsXbApOEzoohbP2krOrMxMjxZgDPhZbRdY5stGV
	 SLnuaG140+zzjT+jUGjvW+gcMYKfWoZgCtgF5ar63rKEPDSxa1UokeKE05LJp7krW5
	 AoUlysD6N2prw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B3C3930907;
	Mon, 22 Jun 2026 16:36:52 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 7.2 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260622142639.2082404A0b-agordeev@linux.ibm.com>
References: <20260622142639.2082404A0b-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260622142639.2082404A0b-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-2
X-PR-Tracked-Commit-Id: 1ac287e2af9a9112fe271427ef45eceb26bce8b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2580f89860460f38bcc13fce75db8626d555c0cd
Message-Id: <178214621060.1310507.10331342306449967038.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jun 2026 16:36:50 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jun 2026 16:26:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2580f89860460f38bcc13fce75db8626d555c0cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
