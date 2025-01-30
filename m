Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929511F1504;
	Thu, 30 Jan 2025 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263378; cv=none; b=oOI6hDsDrQie1E2Cmx6YqvksbT+buEe2UUiDlvndCpgV47zPNbQpBSEtw6Xbt+yMfWc0loa/d4W2Vtrd/JnnYQIFmP8uFT91FVnjxmWPDuhCw7aDfAZ7vFlv//l78+RqHdwrNrOWrc7gJXp7fTTGEume0JHq61w4kUeXTW/JE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263378; c=relaxed/simple;
	bh=GRzhjo3ll16LC+kWxfe+5Mc7JHDwUoyXfZ6ExxCAvnk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cIUJFwHL/TPxX9bHl5QoiS8x6wewpeTfbQDiu4wZLvyyt56eiWbtOP+fj2DVn6i9CXXv5rjbRtM4Rmc+e1JpNUOri2WwuNO/xytW/5UX5ZpUhVkSH0wvhurt/crXikVs2aMQy3ibj7S/tKCRxVoBdk37BQXBH2F3kKoX6fiUH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQIztA4d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQIztA4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BEBC4CED2;
	Thu, 30 Jan 2025 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263378;
	bh=GRzhjo3ll16LC+kWxfe+5Mc7JHDwUoyXfZ6ExxCAvnk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PQIztA4dCFvQ6fPwkVhgfEhuEdRW8S9lDZG2MPscJ6MIg4oxO0dT1P3kiO0Wz16hq
	 Gns4EL1O/ubkg+XSrz7/utVjFO3FKIErYd77JIvoMN387plLpN12b2lzxzn+ycenCi
	 H6Pgpo/zvn+Eum9z5UYcJZfuOGHKBMVJoXwYsHZt0ZcnD22onM6OqD/ewSYg4/3onN
	 z5y5BSHG2UnqGNvuoajCy+M5oC5TzFPyA8gnmtInCa3DillL+QPprJN89OEbErcY9/
	 yRm/VhWx/VOm7o5QFQVBq3r3aKTGMYgPYcXYBx5+77V7UfQlvl7UPk2IUodAzpL/JW
	 5ao2XWRkZFhMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5BE380AA66;
	Thu, 30 Jan 2025 18:56:45 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.14 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z5t8i_dUC6KbOO8P@tuxmaker.boeblingen.de.ibm.com>
References: <Z5t8i_dUC6KbOO8P@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z5t8i_dUC6KbOO8P@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-2
X-PR-Tracked-Commit-Id: 87f017d0792befa83722b99cb21f9c8f574cd71d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b731bc5f49651bb85ef31fa1db6e76a0fe10d572
Message-Id: <173826340463.1052698.17530246867961926559.pr-tracker-bot@kernel.org>
Date: Thu, 30 Jan 2025 18:56:44 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jan 2025 14:20:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b731bc5f49651bb85ef31fa1db6e76a0fe10d572

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
