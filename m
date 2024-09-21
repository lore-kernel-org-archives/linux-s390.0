Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45761FCF;
	Sat, 21 Sep 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726935180; cv=none; b=oISySmlVbOnIygv9eKniQj9rK1ZKPbNgkNNqEQawGSFafA0fr4bAVeb4AtmKNY8DwvtpBmL126uGMC9Q8jYpx95hqldb+9WC72/GMOn+2FsoS0FVYEERnTsOfcKS5Te8VGuh3zLC9fr0xdSkaUP/2qXH4bu6H2vmMnEH9NSUzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726935180; c=relaxed/simple;
	bh=rsUA5AjbnE8ow3XkqVymzGU8XGPWJGTQbyzitvRqeFo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pOOLlV5KclFcpb/0oW97mi40MlZlnBGwxDJgHhS1SLmNj3XYwVnmr3HfhkCCS1EdkA16gGXAC5HFQqnl5oJz3U7l9HUyFL3VGxMwUm8IyjZhzGnqXxKSHlgnNAlmS/WXvkdpbh+4GaZ1t9mP/mzsuw61ZlFc1sa7C7V9FIRVbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPPD+uUT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPPD+uUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E249C4CEC2;
	Sat, 21 Sep 2024 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726935179;
	bh=rsUA5AjbnE8ow3XkqVymzGU8XGPWJGTQbyzitvRqeFo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VPPD+uUTH6h3KoTQ0DJRQwQOc62Vc3GSXjvbAvlpVfsmjZVy2wvcCuRRoY17pjUTf
	 lVdZJllWJMDvY7PlDHECiEihOVJ/TQgAothkJ3D7X0aN5wPD7AjFQO6l2ewD8vd4Ll
	 z7sKyzOoP8rGvGn5FxIYTBSBuELUAZ1hOg5OisgtNkTucPBdoZ/LjhvRz01v6s5TRa
	 LT9AsU4Ce+YlnE6uQt/PyB4BB1lkkib/s2y5rUb2nCbhOhHUVb9V5/97dAolI09pUY
	 wvITV3aULxjNwZLzhaYFf2e8ZL75rvzd4zeJ2a1Ia4XQ5MgXGAO4Yl20GhE98Y/UIQ
	 ENH8PUPOj303g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1FD3806655;
	Sat, 21 Sep 2024 16:13:02 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 6.12 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zux1iMM-bKAyyCUi@localhost>
References: <Zux1iMM-bKAyyCUi@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zux1iMM-bKAyyCUi@localhost>
X-PR-Tracked-Remote: https://lore.kernel.org/all/20240808135836.740effac@canb.auug.org.au/ ---
X-PR-Tracked-Commit-Id: 9fed8d7c46f37151037334ef5e8b30b945baaceb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ec6d097897a35dfb55c4c31fc8633cf5be46497
Message-Id: <172693518118.2522981.14454064442033381860.pr-tracker-bot@kernel.org>
Date: Sat, 21 Sep 2024 16:13:01 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Sep 2024 21:03:36 +0200:

> https://lore.kernel.org/all/20240808135836.740effac@canb.auug.org.au/ ---

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ec6d097897a35dfb55c4c31fc8633cf5be46497

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
