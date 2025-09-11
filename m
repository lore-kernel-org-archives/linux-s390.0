Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DB3570A1;
	Thu, 11 Sep 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606031; cv=none; b=FcayfIIndU0DVrHCHkkeK8ttJ4IHZFKxKq3IWaX0EUlr6O2x5CW5lUrCvl4+/D0lceoGaCOxM5BBuImdafQ6tvC+lm/lTACuApWuBAkKrKVDZ1l4MxR5/PBfqU4ZIi6MnlyGcge061QgwOoNxwyO5BvN5oPNA768vFkS53bGxRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606031; c=relaxed/simple;
	bh=aIF6P+44ZfenGabeqJRGL+UVRldmH0UoKyjlpQjs7H8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LD6eXapLc/gzafBtBtp1qxt3kYgd7RMW0OO0oWb0J6qSMcf9oIRh+8T4uHsW5SzRzDyh9RWBg+oHR67mmm+QzcjhkOBlrmzXHvergGpWpbsQLVKJdE4kFU0eyxCrSH4HDyUqv29/oQ//BVdOyKqZFLw8kvZJmlIgSsD1kIYjW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ3p6/C7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ3p6/C7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FA7C4CEF0;
	Thu, 11 Sep 2025 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757606031;
	bh=aIF6P+44ZfenGabeqJRGL+UVRldmH0UoKyjlpQjs7H8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YZ3p6/C7rW9Cebtcc5J1KB9q2U1phQAp/uFuB02N+hy5sUzWNtV1JZUBoa6Qz48ep
	 BRzJ7T3igY/Kru9vxxm2qZ8H7MPrw6hxWxrtuZOQGoVklNzC603zb9IuHXwujr3+wt
	 afpYARUPa116T9OGIgL1KlNg2kWiIb1kc9FsD9on+Gg6z3h0jf9dNbLxLdAJL2xTD5
	 ZbvpoEnwP4dCCauyI4lTuEGLva0pm3aKBM6Dxe5zHhxq5Jn2zwLtoVCeJQaLd9UpD9
	 bbv0vu0hRrNVoFbKt6fIdMcdfh09xyQeUy9P1wJBUVLBvgONsLs8iQpNSiEgvHrX+K
	 2uY+g0mrxSXgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71584383BF69;
	Thu, 11 Sep 2025 15:53:55 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250911143354.233232A3c-agordeev@linux.ibm.com>
References: <20250911143354.233232A3c-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250911143354.233232A3c-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-4
X-PR-Tracked-Commit-Id: ce971233242b5391d99442271f3ca096fb49818d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e59a039119c3ec241228adf12dca0dd4398104d0
Message-Id: <175760603406.2231751.1970967982519591156.pr-tracker-bot@kernel.org>
Date: Thu, 11 Sep 2025 15:53:54 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Sep 2025 16:33:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e59a039119c3ec241228adf12dca0dd4398104d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
