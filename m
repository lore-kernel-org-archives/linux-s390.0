Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67051E7660;
	Sat,  7 Mar 2026 04:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858031; cv=none; b=gHCmhlI5scj7Qr2fcGU5tXTZmHTbemL8P1/54jdvkTAVittv9bQv9yEP7ZuqV6QgYVmcUxNHDXZN+bmWWZqN8rSCAeCAcHSA08mk03bHwPtoutV1Z+BxEbU62SMs6RmbNv5Xg+illlErgRoibuY0DbCtdTtqgprwp147X1iM0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858031; c=relaxed/simple;
	bh=lBWYaLJmFquQT23fELgcOygCeoDVBzWCUplTNyRKFvo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KRERvNu/X117gL0iN0a9ThAi0LKM8F67NtVRic08E27zIjmoAj2JI76HBZScDSqWN10+/Gbv1+sl0hgZNHiJThCs/GFyfJ8jXUbOZYZxjAQGsJ+EBXsclqpkRbYAoYF62zpkv/o/I45rcpwaBAjp43Lndg1sp8C++U/Utjr0z5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g72bgmxu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g72bgmxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA11BC19422;
	Sat,  7 Mar 2026 04:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772858031;
	bh=lBWYaLJmFquQT23fELgcOygCeoDVBzWCUplTNyRKFvo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g72bgmxux7ozfrDGUsWdOzippxr6trJNkCrS0oifxxspnwiw/0K/cWeJ4QFJOXckU
	 PRHkHdNJp4Hb1z7pb5PPbYp9YNyxmFZrx6jT+koIASJu38z6gdQ4UOFYlbPN5GbzpC
	 o8hT1gzTnLfhFbBdsHse+kBxnDhsV6OVT8PSPFW4yEDthF99/xe/xwM2v3r4yRhNyn
	 xOOOMQr2Rj38LUQCxu6jBWX2N/OtTvm8xerXSvt6a2gbSc+vIeQxzdW8/xU3+LHIOH
	 nYSzNkTnAihQhV2GYqNSGxolMWdmezyPqCdiv5T/86wPvPgc0faJSRBbegayzk8IGF
	 76K4Kq/k27jcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DB33808200;
	Sat,  7 Mar 2026 04:33:52 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ttbi5la@ub.hpns>
References: <ttbi5la@ub.hpns>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ttbi5la@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-4
X-PR-Tracked-Commit-Id: 674c5ff0f440a051ebf299d29a4c013133d81a65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 591d8796b26ff707e35aad00f1274049126feba5
Message-Id: <177285803042.165831.12680354609582419963.pr-tracker-bot@kernel.org>
Date: Sat, 07 Mar 2026 04:33:50 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 7 Mar 2026 01:05:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/591d8796b26ff707e35aad00f1274049126feba5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
