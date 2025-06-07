Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DF258CC1;
	Sat,  7 Jun 2025 01:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749259093; cv=none; b=KcSSdlXrUr8cwJrirn5Nj5uBwrkGxFs36Zz0Sr9p5AsO5uPuuVhgqqacJALUjY0M3NDu+8nIjcyiElliqWC0UYcctfEoYPui5aVWmnuH4DBnizOALYdXJZMvcjhW353SOTQPAEs+WNJpvZqmG6r+YjK7gbgi6l7LClA+638FOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749259093; c=relaxed/simple;
	bh=tfF6O5bOoO1jC637QaodBH4+Olm/DI+OO7qAt6lPb7M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EujkP9UzP+QgLv5FTvBy4Pqrxwqj6wqamFkbCqBrMGJlxhFS3WDz6HTEGWuC7+d1vfEOnJR8S2uEc2h7c9KzTUxiapMuv0GmU+M/sad7ezD/ndrYa71DbrH5ltpV1luWw4qc5SSYpUuxS1JjaD1cCluDwHf8zUbXDpCbj5QfQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO/cBNZl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO/cBNZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC4AC4CEEF;
	Sat,  7 Jun 2025 01:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749259093;
	bh=tfF6O5bOoO1jC637QaodBH4+Olm/DI+OO7qAt6lPb7M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oO/cBNZl6kh62L2OMCQKwpPXFZfwBZTZiJhIZux0hQ3fwmM7kQyv81uOBuJKjiHso
	 kDku2u/UAEbSpq1clQxMa0SvD312C9GmoX7yec8guqYHmbrWKrxR653WMKLVPk0NNb
	 bP4dQR1ZYbCISLMMQHMIFRMjeK3QqYCy78aGLZeM5s7oh5CHxndO+axLMND2hRd7O4
	 HoTzROwQE2An0stzie8zvs3jwGxhfL9TPeeBT6jMWPbJV7aa9fE/dxK21vVqEZg3h9
	 pT1g1vedDAxZdO1gh4WAajr+U3K9IFBzU73GvVe0UMzcgfhIQgyobJsUUzUiG8xa9Z
	 VbXRAH60ekXkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF53822E05;
	Sat,  7 Jun 2025 01:18:45 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.16 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250606152946.20790Ff2-hca@linux.ibm.com>
References: <20250606152946.20790Ff2-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250606152946.20790Ff2-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-2
X-PR-Tracked-Commit-Id: 11709abccf93b08adde95ef313c300b0d4bc28f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d94467aed34e5ac9cf26d6178a324eed7367e98c
Message-Id: <174925912464.4051830.9269396281309227245.pr-tracker-bot@kernel.org>
Date: Sat, 07 Jun 2025 01:18:44 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Jun 2025 17:29:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d94467aed34e5ac9cf26d6178a324eed7367e98c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
