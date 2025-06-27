Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1FC2EACEE;
	Fri, 27 Jun 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041730; cv=none; b=pystnMPzFs3vtDdFpi3lVbJMaP+/T/iz1xBG3IZZ3uG3Tc0B/DeugUnfXsp0tHa827bFaWwRs8yrLZnTL+9sev3keYUqu8JeG4gHXOrfqIFhtJB8kSoTCkWy/9XpiXswvYsoD9MjjRgKjB4ndbxBqve8Fp29d15S1pgjylxWP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041730; c=relaxed/simple;
	bh=zccJajHHp4c7bwHuPvHIAEfCRoeMWJn4yaFj2VHAqqg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H7B8hmD4oK8bjTGE5gkTtsRivmavO2cyyDs6DbAAs4Dk3q6uy/qga7/qYZliTKqfAjHed5eMrFQtujjU/Ej23b3snCbTCTLujo1qh76Go92tAu6eESiwhnfVJi1OrkVkXLpDiL86vfSQLDD+KDUqF2vs/1nMgdTJv+XpUbbwkYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocha7P8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocha7P8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1367C4CEF1;
	Fri, 27 Jun 2025 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751041730;
	bh=zccJajHHp4c7bwHuPvHIAEfCRoeMWJn4yaFj2VHAqqg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ocha7P8y4mTUNp9WJMLs/2KDNMmdl9pdBbo3Rjkbweuwp7c2lgE6JNWUyhxmOWUj+
	 iNVmz/GdgcyhXpPb3o40e/xFyCgKpAOAkAZjTnhIkJETwc2/gdPZpgMseV+368GUit
	 7Ts0Od6OVHI29wlYoRRJ+TDOyRnZEWqrd9Gt3PmBQhvYfuemyb9fIOFvf9UlgTKEDK
	 sjr7vUgCCqqYodjbo2zhm9cwAAlkHuI5slItyceC7l/mz4zcFP+0h69aQ+6i1VHl2+
	 b4hGL2Ub/fY8Lb5NhQgqmb6PSfCvwaSVrM47pzY016R5jCr2hLJObINmvAGCEKXF/0
	 iPhxR67FHwLIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8B380DBEE;
	Fri, 27 Jun 2025 16:29:17 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <5038bf76-cdda-4ecf-a9d5-b5ded666356f@agordeev.local>
References: <5038bf76-cdda-4ecf-a9d5-b5ded666356f@agordeev.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5038bf76-cdda-4ecf-a9d5-b5ded666356f@agordeev.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-3
X-PR-Tracked-Commit-Id: 7f8073cfb04a97842fe891ca50dad60afd1e3121
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51df97f90002cb055e966189bd46d831af69e155
Message-Id: <175104175662.1986529.323673224830433894.pr-tracker-bot@kernel.org>
Date: Fri, 27 Jun 2025 16:29:16 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Jun 2025 10:21:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51df97f90002cb055e966189bd46d831af69e155

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
