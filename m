Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BF1759F;
	Sat, 15 Jun 2024 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718420478; cv=none; b=MdIy99LFdt3CXWD0ui1XNCBwyvaXSwXRGZVldaP/E/YWGiuoDEOYFbx/lZu0w7pudvxjDkV3Elqe4HJFgJEP6b31UUfw67hMPiN4dWNc/7MOezXz+BOPGLhfyrjBZzuDHVqFT1XYt+4abFrTLF7Vk18uIVEUjx5zHOy7EYXcvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718420478; c=relaxed/simple;
	bh=pwzQjgwkGVbUQb8TtPz63fJcnGgiG3oBvBAS5otFwWU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=typHSoSeht5uKUB/gDPTYdrw1KzrUfYfjbXObkTBcWfkqnQi+IbW/jgGn4kt5D3huLDzOW7XvYQtVrZz+i+Mu9CjK5OFbBcRfnjMjqcXJ0BEx4PgcM72++D7p1wV0htkG4pSgfhVpLuFhA4rdrrVYnd1P5hIPOqhWNKqD2aIVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNIXrPp7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNIXrPp7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC402C4AF49;
	Sat, 15 Jun 2024 03:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718420478;
	bh=pwzQjgwkGVbUQb8TtPz63fJcnGgiG3oBvBAS5otFwWU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YNIXrPp70N7gw4X5HLtr0N3iX4PCDu1A9MPvJETXfeBFibyLodfjXiEFvlea7CMh4
	 K0e6pr4KoYYGNbLNrsMncAZrWtc0bNI0lOJGzAEFXKgzZQWenk/Un5xL7jKbjksFNy
	 kFoI7JE7qXDldF3zsdJm++/xVA/9g/lDFXnGIY7JDUCb66rxb1AQwVERdtLI/mKRH4
	 4K0i+Wg4wb7MiuQoKV9rTeUAqvaCKIoAYUuVzWBp5wRrKIdW4WyXM56Cb9peGZZg0U
	 TiaqxS1miWd/2EfTqRkOSCxAXvsPqRlyMrF5FdcWB6i08LAopoFuiC/sMVdS3IaOwr
	 oup33QM4Mb/BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B498EC4332D;
	Sat, 15 Jun 2024 03:01:18 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01718406121-ext-7930@work.hours>
References: <your-ad-here.call-01718406121-ext-7930@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01718406121-ext-7930@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-4
X-PR-Tracked-Commit-Id: 693d41f7c938f92d881e6a51525e6c132a186afd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44ef20baed8edcb1799bec1e7ad2debbc93eedd8
Message-Id: <171842047873.4182.13792396294821792386.pr-tracker-bot@kernel.org>
Date: Sat, 15 Jun 2024 03:01:18 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Jun 2024 01:02:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44ef20baed8edcb1799bec1e7ad2debbc93eedd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
