Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D4253B42;
	Sun, 19 Jul 2026 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784434658; cv=none; b=NEdOoHV3eIiNph8mNE1BvcSVNXZZUQhRzxib+kMzVe6mKDg224/0UauUnzRB95rcQcznNYXt4HjfzRwM7QGjak+axshHHKNUrY+4satR0h+rA4GOAI2WQb8ZpDvlWlbxgUEXy4QkuFqHk0+Q9fj1zcNkLddtfPa1g6bpIa+4XAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784434658; c=relaxed/simple;
	bh=knIAAQaXmJPzsdsEma5+okBIAQDOdsbECk2L647Kibs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NwlQgBG56JcrPpKtUb02rXzqtO55v+93gQTV8S+vVaM+15h1QYM5uSlu2uLgyN/0JlI1FUjf8I6qepkyVLrF25fypsa9QKmZkRR9/sjbVqkeU3BVmm06WCs2mB44zOR9U7nYf/JZezb9kPcrgwqaU1Gc9vVJoBpvDwOCWDtobHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbCIMNUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbCIMNUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3231F00A3E;
	Sun, 19 Jul 2026 04:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784434657;
	bh=1llnhZ7aJQJUNLR0AFJbn87Osy0vq86v4g27Bzqumpk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HbCIMNUwtbPtd9fRQb80a7D8q3RQLwitTF4WDdVH8BGqwYC7PYLXJ9bnDz+cKKcDW
	 Rfwp7K6I9cxaOn51IkwXpV7m+JZkbvkIw6Bj86Xq2nVL7BpXgP+3Arj3WuF36hCOjx
	 8HoDVhTL7O1hrwmF97MCCgi7BnqD8n1bU5cbcWlkFZhHs0wC/LFwkCrHVlqKBTGiBy
	 2W1RXuaO0VKcSSXKBx9qMEKkMTxXe8F85twRpzkG1vVo/y44OoyGd01S4zvicdYfbS
	 EVguP7E0AaFEKRiNnCwzyjtmVO3F8zlB+86vv5+/2Yq+2EpbEeK/Pwp9qq0xvq8Oxr
	 LiwZ+Mw89dZng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0DE3381197B;
	Sun, 19 Jul 2026 04:17:09 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ttiea3l@ub.hpns>
References: <ttiea3l@ub.hpns>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ttiea3l@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-5
X-PR-Tracked-Commit-Id: 49145bce539117db4b6e9e83c0e5ef528e361050
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6859eed755df351a3978b33cb92365f9b3e8f06
Message-Id: <178443462854.2648133.2226732306485980055.pr-tracker-bot@kernel.org>
Date: Sun, 19 Jul 2026 04:17:08 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 19 Jul 2026 01:47:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6859eed755df351a3978b33cb92365f9b3e8f06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
