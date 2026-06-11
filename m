Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6F4D9914;
	Thu, 11 Jun 2026 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211536; cv=none; b=UHl9hB9uaSQZnesMxlkkP3GVMBsdbD+1w8d6jZbgFXhIx1pY7S/O8d2jBgtMxO0x73CdHXfUUXre7+srZ0J6IwIYdDM3xSmdoPKDE71sNVFkRq7Tw9vHjzjEdm+NIndoZigS5hUZKoNKzstXAudB6PcmWfXQSORFLG/c0QECZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211536; c=relaxed/simple;
	bh=jVYlTn4deprSNAmDB4bHrDF5Yspcy0Y4BJpwXOSgnqM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rlM3kLsHYMDzSCYDgpg9qEoCmNqqAxLjAfuxSkGICJgotv4Qruuyn25Tg3mB6JfCJa29WKm5GV8vq06QuH7IN8W8rYOa1Gl0iKzN68FnRmADhVvqmoz5KsLxaDm4TTjyOrUZrSAq2PFoJXUj/5PgoKnK0rCSc91DI/gmSmEkTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqoEwNRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqoEwNRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269FC1F000E9;
	Thu, 11 Jun 2026 20:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781211534;
	bh=/r/GRHT5zJQB4AUU2KpAMr9jhT+8MyCyhkPs90XdFDU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PqoEwNRct8T0D4snTrsgUVDcZHhwYmD9Fmg6NzoEI9U6/2OlfFt3m0QRjL5WOe3JP
	 MBIHGNuN83fo2QhtOtOa6cd14xMqxy6N/tNI83WEhPSXTURZ/b2j2vrIzbspdu0YqK
	 eiljUHTimnroy9rnUCzA5qlQoQFiWyQs2UGd+2TIoZjGJKdMNjg178MWX7AdwigV7O
	 3VUHp0ExLR5eq2U4ImlCexqump3zF0AUs+++165RTltlP3c8lsMKoFMfYIRhpzuvD/
	 Elxj8RRztuQbC3CVeEIZDVSKD9/6J/r0FKVOm155kTYE26sjpdBwJ+Xe30YWl8PAZ7
	 qB1kigHPJNesQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9390D3930FAA;
	Thu, 11 Jun 2026 20:58:52 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for final 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260611142254.3501080A79-agordeev@linux.ibm.com>
References: <20260611142254.3501080A79-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260611142254.3501080A79-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-5
X-PR-Tracked-Commit-Id: 1f57f68c4dd101e5e8ffc9ffa6428f45bcdd776a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b414a95b8f7307d42173ba9e580d6d3e2bcbfce
Message-Id: <178121153112.362744.1910205287356269043.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jun 2026 20:58:51 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jun 2026 16:22:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b414a95b8f7307d42173ba9e580d6d3e2bcbfce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
