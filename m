Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9919CC28;
	Wed, 17 Dec 2025 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765946863; cv=none; b=joAnbqduNKzwtJhaghm6HOmvqgHAQf+ywAiwc1UYIhERLVpdR8V/YIZ8rEly/ZyqMISQQlsU81Y4bZp+yq3nMgwNkusDpV4nqQH3DMcWbOmw4PtuX7BEouogxmT0OF+wpMJwO/mdtHGAx+ukkqpxMjf/6m40CKEU47/2Z3OcEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765946863; c=relaxed/simple;
	bh=DS/9KmWbwiEzZaI9V56eok26pKUuBfYgEqmWJOVKqIE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bEB1Q0S3nNci5yV7GZQu5UyWJbWtSihloK2Y2GaGm9dMop+cSoK6oqmex5g+EYy3N70e8JivtFvU2+kvWhBDXw3fJ0++0fmQYtsYbixBgoJQSXJLKVG1eW6sJbo2eqhMTjDgm2i3cratY2yLjhaEyQFCpNli0+niSwWxh/I6U0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DziG6Ouv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DziG6Ouv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD5EC4CEFB;
	Wed, 17 Dec 2025 04:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765946863;
	bh=DS/9KmWbwiEzZaI9V56eok26pKUuBfYgEqmWJOVKqIE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DziG6OuvpYGwwdZ8fp3lOxIJVOXa9DRjPhikAkvs/Bhh44/S2z360Cht26YMnMK21
	 D99mAizEpQd7v5H+P+DO7+iFomKL/TW5jv3tEM+E1227DZPhQGB9P/hiMkKdttMkxZ
	 BImQ57kSagb/EieeEmqhV38tf4Clvfhd+wxh6ewGsuXa/szZCjVbAI3JhLmA0cV+qm
	 nZwEqk79C11W14fz23yi4TyWBrm3qGPqM5GkuoE47Aoa6d2C+GlvWijm0noz9qJjRe
	 w/boq+r+EruygL9T4MRLB9psEmLkn7Yudd+5qgmxPioNaWvyP6DWYYlDgIC+ABVkoW
	 OEwcGJWF/DJNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59D63808200;
	Wed, 17 Dec 2025 04:44:34 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251216133240.3233961A30-agordeev@linux.ibm.com>
References: <20251216133240.3233961A30-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251216133240.3233961A30-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-3
X-PR-Tracked-Commit-Id: 489e96651dfe59794195c6b2ddb78835edd9f2ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64e68f8a95eb771273d8d19f9dc1f763524e56d9
Message-Id: <176594667339.1854801.9113020311148126456.pr-tracker-bot@kernel.org>
Date: Wed, 17 Dec 2025 04:44:33 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Dec 2025 14:32:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64e68f8a95eb771273d8d19f9dc1f763524e56d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
