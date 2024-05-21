Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6A2AE6C;
	Tue, 21 May 2024 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318856; cv=none; b=JCyCBDnHSPCC6P/WhDlejlKYOd72P5wP0Xg/8fmAsNzjig2HiEMZX7+M5j1yHzDR/5A9ZtIsj6j4rKqSVKaD03hYZPm9Tc8/Na+JaHt6TKcrxYoyR/yYu/g2eTzmG4wD4UCip+dttM7F0dHojPlox4oh2V83QrY70mQBabEeo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318856; c=relaxed/simple;
	bh=Vvmx+Z9h1k+UZOf7mJSUqmjA90trcer537p5MfMdPd8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uIr6MEhRzQ78Ezug2PzWC7VQ4guku23Pl7QYAESj0+ZgqEl0WjU0g3cKBrja9/igDisK3jB2LKs6G2DbEOa1JonLkGUGnay+z6EvIMBWJgQXKWqIPrvwxqr4fH+6rrnOLry1+QLj4xe7C+dYO9YRzRqFfuXZUokCOSwPE1P4peI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJseu5Dl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJseu5Dl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28E12C2BD11;
	Tue, 21 May 2024 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716318856;
	bh=Vvmx+Z9h1k+UZOf7mJSUqmjA90trcer537p5MfMdPd8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pJseu5Dlw7pnmTRhvCotHHzHm0xRCojpIYaNkrOFCJf4OPVQGccwPj5ACpxdLcDAS
	 uDBsLOCzEZCm3AZcEDGmyMWvY++dqQfCOtkxhH4uTdL7o30pQUoj/++wOFFgBUJeBF
	 gdcP8dWUDmPbhffhO4ttWM243VcTenKLhHKLTqSJut31k/TTW0fV90Onq6KjmDMQGw
	 P3DNNKmau+uyZvU6xZmqtnxbGmNt3s6OyJNefzQFI44RCh8DedjPdkNP7JaXykX8Ps
	 kmHeKEppFwsAMn4gLknXrHf3ALseMZBajMRdvBggP+MYxDbQ7kUndi3jfhdanKLet7
	 pYtyAg85W/9nQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20D14C54BB2;
	Tue, 21 May 2024 19:14:16 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.10 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkzQVaKfNZFEnd2j@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZkzQVaKfNZFEnd2j@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkzQVaKfNZFEnd2j@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-2
X-PR-Tracked-Commit-Id: c1248638f8c35b74400efa7e02e78ecda23373f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a8120d7b4827380f30b57788ff92ec5594e2194
Message-Id: <171631885612.10007.2656224583706190586.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 19:14:16 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 18:48:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a8120d7b4827380f30b57788ff92ec5594e2194

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
