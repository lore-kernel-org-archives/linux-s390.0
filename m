Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300224EA90;
	Thu,  9 Oct 2025 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760034400; cv=none; b=VaEazuZ5eTJE+uJYrrzTdSrRWLDfwH0bGSYws+rEHjKVbSLfLygKPt6YnTQeu90y4oYADW/qrbfFBEwL0MoQUSpOC3I7WeroLRWHE1EooI6NL9ztheDAUFWxpOl9Bb908jSC3YqaWvefivD+Qnv54VXNYCv9aGaVq/E26NSKaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760034400; c=relaxed/simple;
	bh=5v4y28fPOLd6ic08VSrdi/2kmgTOODteHO9hPS9qHTQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hBKgo1rJQDZATEDOXMJxbAy9ICjT0dq3NTvay2yEd8yqiV5wUv1I+SoO1LCjA247VvsmW9fSroExUEGxPHo40hb1/x89h9cwF/+YLlz6yY0kne2eGLbYVL1TJa+BGObeFhBct6psg6O8Us7hKc0YZ28Uf84cN6Z+JeuFrxCwBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuwEnCSz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuwEnCSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED078C4CEF9;
	Thu,  9 Oct 2025 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760034400;
	bh=5v4y28fPOLd6ic08VSrdi/2kmgTOODteHO9hPS9qHTQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EuwEnCSzwNgN3k1LzJnAgS0bfEp7v1+EBlLe4hUNjLmgLiEOz+AQVPJDeOEWtqD3r
	 k7BCOcQRSUusIKxnY9J22ypMaD52y+3XCpKOKHzXqKNJaTw0otv2AZ50zzEDi/ZcGV
	 YKtNrWlW2BaaliuikIbDvBHw4BQTohYhcIsq2zJ3iXIUoBvoSUfKbR3cRpGQkm0tqL
	 1akKNxS3Pecu4f3nSJQIWqBgm3xzlnbg6F58OW27LpA4g1+mptUPNpd7BwTuwflnTA
	 7d/GVyVZ+aPPwo5/rGJmx8MMQfK1ft3SKxbM4YsQUwFRZb8HkZHCT8S1zEEJ2uZsNE
	 1rGAkekdZmPkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9F3A55F9E;
	Thu,  9 Oct 2025 18:26:29 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.18 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251009131240.3363697A73-agordeev@linux.ibm.com>
References: <20251009131240.3363697A73-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251009131240.3363697A73-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.18-2
X-PR-Tracked-Commit-Id: deabb34b66b96c941ac0b3d01a6a6804c3274a78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9361cace0d07954ad8f2345c057976ab1bf44488
Message-Id: <176003438786.230640.7510590176443464843.pr-tracker-bot@kernel.org>
Date: Thu, 09 Oct 2025 18:26:27 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 9 Oct 2025 15:12:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9361cace0d07954ad8f2345c057976ab1bf44488

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
