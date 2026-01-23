Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172E2DCC08;
	Fri, 23 Jan 2026 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769205834; cv=none; b=Zrt4++gCtNFwTwuOevaF/iUka6+fQuvIvvCj/V0ypyCUBAxSbfn1qwOaUNSNUdey15JCjQ7FoqckF/m1qEIXBnFrnTX0ZpfAQOdRW/IVAF4YcY1tBToNUPGuTorQbH7lnDfd33qONhIXECtsL9/i4kSS1a1+/3wKMCIoVNrQaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769205834; c=relaxed/simple;
	bh=LiccdBA0l5XNWVnGb7zG0viXzi4OUfyxG8BdG8TdyAw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ul4y/G3vssXph5yt+WSSQoiLCj5N4un1pN1GrTh33e9Afi9ZUkNCLuzMVaCKaeEmWPcHjeeimV5NsN5dRxmtSyE17lh7TZtwxxUtfvGoOAj2KsrNcE0VDvvFZWi0id+om0OfJlSi4UTtuA15Bz00FEIK0jk8Sclmxif+Hu1xrDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyUSDnxS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyUSDnxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B015C19423;
	Fri, 23 Jan 2026 22:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769205834;
	bh=LiccdBA0l5XNWVnGb7zG0viXzi4OUfyxG8BdG8TdyAw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DyUSDnxSKHunV488SrJIHACdBTRlgzVRo3E4jzd7yydmNLGUBaHR7PqsWqaWVqLR1
	 EM1i8M+EbxkWZzHKagbb12xvNm46SMJbZkRMJhka1i+WvemJ+PSb06JkL79bPPeXCX
	 9yB3qnqnEBhb4NrcKq/9LuL+7tRAXrAuJlX/sEu6J6+uzEG7L5PyhAHHC78vFJK8sP
	 wgc4ljviZelGZxnVf/uvpyYZlPZmWuQIVq13xsim7i22m/Fazv2Ykp57Td4dXIMfJ/
	 LqcIyBAK5ILSC+0F7JN8ZhdiyOoocoNINWYEsde8bRi0ktWp+gezoB7RvSs1gGFJfv
	 dUHZWWOkxEyYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8B8E43808200;
	Fri, 23 Jan 2026 22:03:51 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260123185252.8148Ac6-hca@linux.ibm.com>
References: <20260123185252.8148Ac6-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260123185252.8148Ac6-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-4
X-PR-Tracked-Commit-Id: ddc6cbef3ef10359b5640b4ee810a520edc73586
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a622041d78bb0737cc9dd507ead099b66abdda2
Message-Id: <176920583014.2729567.14014245996946142317.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 22:03:50 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Jan 2026 19:52:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a622041d78bb0737cc9dd507ead099b66abdda2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
