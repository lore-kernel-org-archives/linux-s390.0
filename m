Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E63303A04;
	Sun,  2 Aug 2026 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785699093; cv=none; b=OTNPZiieYLojO5QEIMJCKjljPiVM4Ey/X+vc2td3VgR0CwfR7CUqTX9N1R/p6cS8Gt47ORSGECUR9EHKTGdd82CJIncB6cnOSkNgJK00TJIjplrw6nk8kwv/31hbjDN5BorPpGr7lDuXkFE+b179nZzUGnFVMnnlCVF+xAGTjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785699093; c=relaxed/simple;
	bh=3705bnVrGmfa3tB+zdIQqh+9ke5+mardaXHZoI1I5u8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NVoSMaAnUzdl9RJspVfZciF6X8v5nwwxRWeRjUQMAXsF082KELdzdihSZgdmh9sSUv8uMYyxHsrkVRrbAsDtuf5OEWEWZf56w+7ar3ZZafw3A2qbGPI4jPZ8SUlgS8R46tD4oQqId9YvRVCB/LKF7yoKV6i6tsulkcmGd4HxGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqKOnDp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqKOnDp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4064D1F000E9;
	Sun,  2 Aug 2026 19:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785699092;
	bh=E3PZePhNhvVghqhjbA7s9NC3dcGyiO9quzisWRUKkOw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=oqKOnDp9QKx3/X4HKem717hLFTVQhSVwjgfxRTp6MGp1Hp5ZoWiH0KmfcWQBWZ7Tm
	 4wsSuljUz9damqv5y3jUntwyHL5RM+1sEgbMcBMr5a2kAiR9pCSNNZE7zie+pDT6Iy
	 1amHpV+ydFwAHEuzKkgzH0JPf0jwh0oAtiEOQOSqAnDbIhrit/PSqq56r0xDRzb4w+
	 Npp6WmBvfFiEJ0SQo1r+7LFOj/9et1iHWPaid6UmVnUqz9Ecnj9jDJDH8fv8vUUZpq
	 z7I15Oj1RAr6SgdFM5e15sQOlA0Z9L7OANUxf5IeIxALIJODuBZuENVkmrWbwETSys
	 6t5neoPG5jKpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199363809A38;
	Sun,  2 Aug 2026 19:30:55 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ttj5bmx@ub.hpns>
References: <ttj5bmx@ub.hpns>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ttj5bmx@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-6
X-PR-Tracked-Commit-Id: 01476391aecef36a3b789ee844357b22fbc90665
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e672789d442d3ef08f30b7cd50cbc685f7956a2
Message-Id: <178569905364.1467519.16394930945364255806.pr-tracker-bot@kernel.org>
Date: Sun, 02 Aug 2026 19:30:53 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 2 Aug 2026 16:16:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e672789d442d3ef08f30b7cd50cbc685f7956a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
