Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96624886E;
	Tue, 30 Sep 2025 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200902; cv=none; b=WhJT779HjRNvMQXzITcmygbVUJPBhDQMX+HCODhJ/xgK84g+AdQ3sFuuNqY7mszn+L5OfNrtGxkqcOtZS3naERTqSjwmCenF24iCyrLLPd/zNydJ142MaD95L5ePNYL6RK5v/+TjwT0MZD33BZq3fOVBpO5F0GUdRXjm9laIqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200902; c=relaxed/simple;
	bh=UZIP5tXuiH28wTU4+R+9M/Uhsg4soThQwmkqZvfyfwU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZIVClL6Pg+9kX1WMLbF/EKOaAWseidSC8Til1NQPD5ccmjR/o8bXRR5KSdWuDj4he+yfhRCAQOBHCRcSh0p1Pu7l9P20EDilKy7JC7mcmOblMFlKbax2JHDoeEMRPTTUOzYlbIBmd50KWJo/I9SKReMLH82xjVnRzpUGkmXtpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0u5ZjMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0u5ZjMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17BEC4CEF5;
	Tue, 30 Sep 2025 02:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759200901;
	bh=UZIP5tXuiH28wTU4+R+9M/Uhsg4soThQwmkqZvfyfwU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S0u5ZjMbC3AN7oQ0H3812AH9rel8VA4ZKDawjf0sVvca0HwVaJpa9eZV6eJJpvdji
	 MsB73cT2P+hRcKsTR4CBuqtV9HX2XXC6mniJ36x7EiJjfsM1gTqHvTU4Qz6oAj0EDy
	 w8Vsj3Wq7Q4NTNmgGELhsJFDlyevM5yAIFbVHAj9AH0qX+ceIw0ZeDtJbUB+Zs5l45
	 BzcJJVp3XNOtl+4AQt9ufqzc2ZnFu7xbsbu8YjurcEtKZWIeLSjp7pEYt1WPO+Dw+p
	 eJ8IKInRTj/QHFyik57tyP0P1vQavZIAsvikfF2IiVWlQL5PiElMPgAJI3O5sE7nNV
	 fuxHkB9QdpOyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF539D0C1A;
	Tue, 30 Sep 2025 02:54:56 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.18 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250929093828.2714469Af2-agordeev@linux.ibm.com>
References: <20250929093828.2714469Af2-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250929093828.2714469Af2-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: https://lore.kernel.org/linux-next/aNKbgf7GyU5JP3Zh@finisterre.sirena.org.uk/ ---
X-PR-Tracked-Commit-Id: 088bb10e37252034ec58a6152f20bfdc8a837f54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cc220a422113f665e13364be1411c7bba9e3e30
Message-Id: <175920089511.1805104.10466150803522848237.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 02:54:55 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:38:28 +0200:

> https://lore.kernel.org/linux-next/aNKbgf7GyU5JP3Zh@finisterre.sirena.org.uk/ ---

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cc220a422113f665e13364be1411c7bba9e3e30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
