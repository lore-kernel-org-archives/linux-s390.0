Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E1186294;
	Tue, 21 Jan 2025 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737437394; cv=none; b=s2EPqr15rN4HYyWJiRksC7egAxKgpDpjoPIMYddsbKZAQ+RIRrNsZ/Pt1CotRv8uYy7Lu7DtcXS9OW+zMuFAoIMIKCr2Jjqu6FhjBZqTCSAL94iKqHhc0/qi2Q8rer8NF9t/jLDrpxhyfcAW1u/t8rVohlN7QjLeLJb476lDuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737437394; c=relaxed/simple;
	bh=20buD/YvfEA3bBj4tn9uEVn7Lx2/dc4DUbsRBlOb0Fo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rTtRx7nUbXZSjgitoiDLaZqVasojWhZdWdU2XmnKSZSdGfJ5SO0KUwoNtti5o9ah5B3e8EW/Ww/eooI6WJt2Oryy0r24ndqAyY3t4vSDZtcsz3v5yLaz5aOYugxyW8Wyc1Yw9RTd1dJyC4ojUk8PzXe8OSKozrilqgeKqj6e5Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIDlr0DL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIDlr0DL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B77C4CEDF;
	Tue, 21 Jan 2025 05:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737437393;
	bh=20buD/YvfEA3bBj4tn9uEVn7Lx2/dc4DUbsRBlOb0Fo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KIDlr0DLYmG4EgzrNBaXR+b1YxPr5ssS7rvEtYyznlVxuzwOzAGnEg8DQPEteskd+
	 aNnY8kjs9TY1p2n0MMGE3nuTM2/hWAo8C7mvqcYjy1mlYP3PBNkmrxqivimFy0UrV8
	 sckUGSMExUVqgDkzvR+matsK3Pt+XgIxtO0OBEGOOF7BkalECnxVsOwcSpJ12N22gK
	 V6WEatHxB+80mFF3M0UmTnXPojpcSNcpVbB3ZaaglrPG6Jo0F512CxO4fKsWyzCO4Z
	 QKuNy4O5aE6BVR10D1UbDDq+a7vL5x2qrigoLTqpo2luddi9m8WJIHrofAnH5PolXF
	 QyX4MKMHDb0jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D89E380AA62;
	Tue, 21 Jan 2025 05:30:18 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.14 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z4uGVvRYa1JaoGWy@tuxmaker.boeblingen.de.ibm.com>
References: <Z4uGVvRYa1JaoGWy@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z4uGVvRYa1JaoGWy@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-1
X-PR-Tracked-Commit-Id: 26701574cee6777f867f89b4a5c667817e1ee0dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f42d0bf72253dd01e9a8d168e28706803c98a9d
Message-Id: <173743741727.3745731.551795067054226221.pr-tracker-bot@kernel.org>
Date: Tue, 21 Jan 2025 05:30:17 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 11:45:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f42d0bf72253dd01e9a8d168e28706803c98a9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
