Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010D1DFE26;
	Sat, 29 Mar 2025 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743278149; cv=none; b=HXASAgXrbdIs7oWlrrDpWjEfDxYFBOUn8U25KCuCrNOJNmnPZIOxZ3hFL53B60IfMOCiOpQY3JuYe19E+voPmGEzZ2REGmNuHCyehBcKOtEYT/EeuvV/RgLsw5cSoMKqFU1vDZqbigYMUDbSMigaw87gaMn4ocUvsL1FYaB4+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743278149; c=relaxed/simple;
	bh=QjUI84qnFpAdGc3tMmWysVeuhDRpw69hgPLIgPW+9Gs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rhE5K4gWhO9ZkavuGPWewmNsKvOD2XBPJdbh/iRRCSYUGQydz2io2GGNPwctd+7+zzLP/koXeZgchyWarvziLE56KM2pJl217kOuIZ7Rxlo72gEgZrpPcfE4cPd/LNhGv78bwue4gPIZj5wHNv+itd8USzBQwg3+0zT9i7j3PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BveZ9fyg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BveZ9fyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA017C4CEE2;
	Sat, 29 Mar 2025 19:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743278149;
	bh=QjUI84qnFpAdGc3tMmWysVeuhDRpw69hgPLIgPW+9Gs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BveZ9fygMHB5JYjWxgjBd0kmv8PcSdZDnA7C3zzEQfDq2UwDEA4WGIcG/pei2r543
	 LNASIRgSKaf2Alof0qvWaD0AD4NJFxKfB/7IAxNQXPuZt03zKnOJWvny8wpy1snf6b
	 iBFHVEfrq27vseGVKmSj66LnbPRjmbmMfuEqBQXuCKTsKBX7asgd3INRkfiN9AaZ8V
	 sKy5V19HZqgh5PhEnDpt3nHcFhTi1xVgxOzma4juduegfIgUHtlggYec/dVvCD3EB7
	 ek8jZaJ7fesWRF7Wb8aOQAQ0Rb+ykGLLMSt1yGU9XHxxtp+xGijwwlJ8LoDfgToWdu
	 PA5vqpHL6cWeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9DE380AAFA;
	Sat, 29 Mar 2025 19:56:26 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 6.15 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01743175835-ext-6464@work.hours>
References: <your-ad-here.call-01743175835-ext-6464@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01743175835-ext-6464@work.hours>
X-PR-Tracked-Remote: https://lore.kernel.org/all/20250319155410.3cdf01cb@canb.auug.org.au/ ---
X-PR-Tracked-Commit-Id: 0dafe9968ac7c78c67ee6bb2d970d413fb493b95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f90f2145b2804c0166126a6c8fbf51d695917df3
Message-Id: <174327818526.3264055.1643676859891727202.pr-tracker-bot@kernel.org>
Date: Sat, 29 Mar 2025 19:56:25 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Mar 2025 16:30:35 +0100:

> https://lore.kernel.org/all/20250319155410.3cdf01cb@canb.auug.org.au/ ---

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f90f2145b2804c0166126a6c8fbf51d695917df3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
