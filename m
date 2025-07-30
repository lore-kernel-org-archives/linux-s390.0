Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05191DC994;
	Wed, 30 Jul 2025 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846767; cv=none; b=qUlVWw8xxcl8p2q2stsk7iBoHN7HcfI6BGOJWqWxsE486RE18xPq7y/lJH36Hog7KRtBZX+v9uI6fNA5UEFkJrmTjHJmPqqC9CRmkMRmTZ/6ylqCq4OeMUAbIQTb8WQBZoj1FL9garbU2pE5abJ8pppqpIZNbklB1yk7TnCPB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846767; c=relaxed/simple;
	bh=4i/1kSbhYBvPO0boqYSM2v7SEHkp2x8ReAx/E6+epHY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=smgkF95AHbuljZ8kMPezQ9FB5FOge97keuMKoJME3yW8lxUQ1MhvBwifAoUyiz8BmosalhGBT2nCwrRfwnB362Y0ChHqHb4FEz9Nb5YIGX08gwmQ9uT3Q/TZ/xQrAGo1lv2qWdgZGDq2UBqisDgswILCI1ue7k7Ly4/wZhSCgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rraROVK5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rraROVK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED5C4CEE7;
	Wed, 30 Jul 2025 03:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846767;
	bh=4i/1kSbhYBvPO0boqYSM2v7SEHkp2x8ReAx/E6+epHY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rraROVK5e5GHbY/+RKGjWYb6l7iunw6PxdRmrKBO4QngQadyg0j7urcu736hi4OmL
	 ZMbY/FZRQRQwVMF82zioLWYWmeF5dh/GIhIdeHPj02WmVuoaU4AhHbiy3szBcosTx3
	 ZP83L4iZ/sh+olyR40ZVwWu+lC5oQY3kPHs+rvReAoFvWnZaC2Z0smWUzpQLz+bcAu
	 1N6BXV24nf95yx+DeuuhHHB10ppmCbinm1d9Gqr6A3n4O31yE7VqE134GO0yy1OxER
	 QLCdNdngAAWIIAmrLSN0eFHddoVnht6PjqnchPnblfJErg0GAjzEN5G7SMkkARDQak
	 njxc0uoosuZMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE14383BF5F;
	Wed, 30 Jul 2025 03:39:44 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.17 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250727102936.3091421A0e-agordeev@linux.ibm.com>
References: <20250727102936.3091421A0e-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250727102936.3091421A0e-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-1
X-PR-Tracked-Commit-Id: 5647f61ad9171e8f025558ed6dc5702c56a33ba3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc46b7cbc58c4cb562b6a45a1fbc7b8e7b23df58
Message-Id: <175384678341.1749338.5862311175264772546.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:43 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 27 Jul 2025 12:29:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc46b7cbc58c4cb562b6a45a1fbc7b8e7b23df58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
