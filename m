Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E24219E4;
	Fri, 22 May 2026 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459944; cv=none; b=XpZ7QIMBTPsoaxli1sR/M5XYgxycuc/MBYmN06fKJgoz8Y8QkKcInzGMS09NYemRgeJe1MMJP0Qa9pDySQuyD1cUY1vLRVaDCafJkkz9nlyzRhCmGFqGsvtPJ89Azuy24CLUbQxS5urnU9nH47pG4TC0MzEx+6N5tW5AevMpbqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459944; c=relaxed/simple;
	bh=C6ZGxDZC2v2WdRkCaAFanK9ncX9Y55GPPUWdYSdmpZI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M4omsjCeoJsY6unzCZBaL5AG6Q3q1WxPW2Ksicn6W1tgT3NCbigV1eRFNHRSKw6N/vS1q/vPgsjx6AHP+o+Dke93YT0rRUgXuO5HGkDLwJaSBhBOVT8p7uSGX1h8EJ4GDvPn2LRNvPV7xVTjM74u9/TsnpjzCJ0GuRNnMRwMH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEmsUTpf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEmsUTpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC021F000E9;
	Fri, 22 May 2026 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459942;
	bh=s/KgyfxMUVX4FCD4PdAXiBLnF+usce1Lr10igOVSszA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nEmsUTpf2mke0wQJrEw5QDsa+lEKZR6G0C8hpSa5VUKcxZYj9yC6rr/YMEMfWkwws
	 WFn4tAU+AFeSnUtoxj4cLpcRbX3j3llHo5nO6fEkFk/sJ9ikN4AGh+JYknYXZDKMoR
	 usslWup/G0mNt21KDTGWGjJMC2SnLZJxooBwKJ2qmPwml5AMT3S7xTe+XUVRlNUEge
	 Q3Sur5Q/dyhLxdce5bP8KEAI2t/DMlYBCAiyvRqGspVDSq8AaB/fwXYdd6DGusN9rW
	 Nxj4vSpJz99KeRZO3XUQL6Pqg5yHtj2UvKF/3q7aY06HWv2R3k0O6dDUh9NIX0eous
	 /FE6DkDL1FElg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19920392E9B4;
	Fri, 22 May 2026 14:25:53 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260522122201.3111318Aac-agordeev@linux.ibm.com>
References: <20260522122201.3111318Aac-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260522122201.3111318Aac-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-3
X-PR-Tracked-Commit-Id: 540f4a4f6ef806a28e794001bb4beac4840a6090
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbadb98b7cb017b6b7376940781cb108f7baac71
Message-Id: <177945995153.1238704.17138576009050447521.pr-tracker-bot@kernel.org>
Date: Fri, 22 May 2026 14:25:51 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 May 2026 14:22:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbadb98b7cb017b6b7376940781cb108f7baac71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
