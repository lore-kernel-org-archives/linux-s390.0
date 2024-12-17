Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29C1F76C3;
	Tue, 17 Dec 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456279; cv=none; b=PaEfdtQiUyq4oKvFjqAEKRwQnv2Btw7UGK2wuPVwdKEQUoPTwnV1UgipjCb/Ce7Mad8z82O3hBI7TQrGOB7gmu500uQC8zSNTClm86UXMZMdWvnFK9GnGNgknv1SqefWQSSh4sO7yTGAofE4mASYO2Ep3+i5QZbcdCforFys5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456279; c=relaxed/simple;
	bh=yL3UTymbdz8wWOWYn66MSn9Kw59a88dQ58qzQr9x94k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uxEH8GYmwoOCw2wfh+V4JnTIwlRgJoB2LDqt6JoecUq4LG6TtwGzyN6JY7ibxvFkJzQvUoy/iieX0THw7DqVzzCpfUkQqRksPwK/sLiILK1p2UQ+HdGaxJCgH7NUs8wIYilYV8wCGvupfX9jHO4n9kUPIfw2o6uULqD+98oyetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGENcA5A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGENcA5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F663C4CED3;
	Tue, 17 Dec 2024 17:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734456279;
	bh=yL3UTymbdz8wWOWYn66MSn9Kw59a88dQ58qzQr9x94k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pGENcA5Acuxe8GYIfJWnLnfJLritUn9+m285wpZVxzobZ8YZ/vV1RcIPr6wr9jrjQ
	 sWq0UkWEv7MyjL/i3tkcZFCIbMmkaMx9c9IrWx7s5t4PtDaiNUp966uAVwBPa8t9/F
	 3vvWbz8AIJBVPV0U9kYsXXnQf+gWicb05BFMHVKXNrmnFspUfAK/wqCMrz3OgE6Fgd
	 gSSDNPtb+z5/gw5z4sOsUVjC7jmNEWc9RI2zdTDj2YlhDGbtS4IDEuSpDWHOmymeTX
	 1HkFfMZAJNucbEXmBP8dWS/pkGozKbwA4dR3ONIwo8TgoyUB5CtHvaXr6KKpwHRF+9
	 sO68rW6QbFY7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFB03806656;
	Tue, 17 Dec 2024 17:24:57 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z2GQ4oCwZobLsNpp@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <Z2GQ4oCwZobLsNpp@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z2GQ4oCwZobLsNpp@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.13-3
X-PR-Tracked-Commit-Id: 282da38b465395c930687974627c24f47ddce5ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a241d7f0d3a289a52b5245ec1f486d57c8f3c97b
Message-Id: <173445629646.974395.17848215415786156194.pr-tracker-bot@kernel.org>
Date: Tue, 17 Dec 2024 17:24:56 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Dec 2024 15:55:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.13-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a241d7f0d3a289a52b5245ec1f486d57c8f3c97b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
