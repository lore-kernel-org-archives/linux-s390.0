Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846864F472F;
	Thu,  3 Sep 2026 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457287; cv=none; b=mLSe7vb9oF+Z14pDeiSuuahD2vrTwuBssE6hFCpGRPeHagtVnX7QoTAyTmlVVzrm41gwJRTE5bSUJVn952L1pP1ikUvXhXHBtG4jGJiYD6pqTJtfHykFxViar90nFRyG/SYhxXvf+IoRaRYQVddbjMcpY5ByRP6YwTExqp5ZM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457287; c=relaxed/simple;
	bh=OhunVaI0DjXRslHsiPU58E8HSh43ME2pUqjqWZilprY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KbBpWq7AULEPx8sX7+GXHfr5PqWG8k3bOsgIHaveRQ17HznkqLKu0Epr2NPwHJjqX0Wjk/bak6JYlkdhIc8UVnFE5lRm3ugDO/zylgYegE6jYZIbLUkpc/1gVb/jJm+3NHK0C9ClnlGUoyaFEc4wZ28qdaoQ12IRuNK4F4NFH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an6R+Rt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an6R+Rt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599071F000E9;
	Thu,  3 Sep 2026 17:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788457286;
	bh=fncYBMi9cAUWGtLS8pTnJHxDEUN6DvniO6GrVIw4BDg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=an6R+Rt9xTZ5JaTpGxpr4pNVcWyJ8ASPrT/wHdqaAx/E/ZG16juEmAvShR5t5rscm
	 actxmZXjXXu7A0eUZDQOW69My3qxk/IG+Wi8g+zV94z1w//Iy6PiTHU1huX019xH/z
	 wL3eHCVbGsYeozIl2kz+514GULRFlnVbg2PxszQ2rHwjQnIeCgeld6ccnTz9XgGbIi
	 U4FZpD2H3J6W9CzccdCT529DE7PbKclA5SdrtOFMSxFvJ7ekgMZOtvuU0SnSbmdkw8
	 +0KU2dBWRad+B0JoWVDLTGA16TsHUvutgADlKuyczv+OPY5uE2eiR0dOv7BKJHCC/U
	 39agoWBpb/qgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D1EFD38119DB;
	Thu,  3 Sep 2026 17:40:28 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260903171054.12158A58-hca@linux.ibm.com>
References: <20260903171054.12158A58-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260903171054.12158A58-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-2
X-PR-Tracked-Commit-Id: 98d23edcd41432286cf03672252507a841323c8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 841e384b841a3d89c50b4b2d6c5bb6abab1a7e39
Message-Id: <178845722741.3905140.12812867794130935742.pr-tracker-bot@kernel.org>
Date: Thu, 03 Sep 2026 17:40:27 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 3 Sep 2026 19:10:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/841e384b841a3d89c50b4b2d6c5bb6abab1a7e39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
