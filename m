Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E9182CD;
	Sat,  8 Mar 2025 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741403195; cv=none; b=KYUTOQm3rzxGn2JGdoKVgVzMUtDHzZ+NMbqQ4NEKkl7y4/5zfFQDwwxiXHzYEUYF57lzABfVnluO41tWIoI2UvWPYyF2vg4rs1ovuVsQD0pJxSaYNPdDva/HvQ7CToNC1q78fKCXReopdfv8D5fYH+HLGH8MJSwjW27/lAcPj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741403195; c=relaxed/simple;
	bh=/X58aJlajNubapj8G4hkuZOrsx6c2STFNdFZx+8DB8U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SfuMK6Tz2GepH6C6DNW4TnLPUWcqxYzvaLibuyAInY8tOqHXM9D/ScKVr2lpLlP4nX+Q6OZIQnu7F8OqFVnrE2rAtAJXMghCa7Iq+KhQ1/c37rhcHYeYLfNxE8Jv8LIyb/wJTED6X1nqdc9sz460l3llapbXU2X3bjJtNQJXSEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/IbsMoR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/IbsMoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D884C4CED1;
	Sat,  8 Mar 2025 03:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741403194;
	bh=/X58aJlajNubapj8G4hkuZOrsx6c2STFNdFZx+8DB8U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V/IbsMoRF7VSqINDcNFizB81kjTgKdAk5pBCW0koxFxyzzp8w3sE+MSFbgFoEcMO+
	 n6E1EQZ48IBAoHJR4MfpRGw4+lyPSmfiv52DkSBkXcFgY/NQVuyEMeoF8OiFPVRaNR
	 e1cBzZXUPtJCv0xH3QrFDtmsucKKX7L+4shQfHrNscnW/Tz11C52e6us5iJmcB4XVq
	 zaU7Qi68klWYJ0N52xeNpLwE1LNWqvAjcLJu/+6CkxwQa24NYxvrZdZQvmtmiehSRK
	 pLZs40uaDO7HJDes/E5w+61SQcx8R5u/G50OyRAqYKQz6abmVOdYqSdDQwOaLK5lBe
	 uaTAIA2nuDmNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB5380CFFB;
	Sat,  8 Mar 2025 03:07:09 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01741389235-ext-8883@work.hours>
References: <your-ad-here.call-01741389235-ext-8883@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01741389235-ext-8883@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-6
X-PR-Tracked-Commit-Id: b4a1dec11793936ffe1a9fb811724532ff3b1174
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a520073e74fbb956b5564818fc5529dcc7e9f0e
Message-Id: <174140322787.2560613.15705664915690538882.pr-tracker-bot@kernel.org>
Date: Sat, 08 Mar 2025 03:07:07 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Mar 2025 00:13:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a520073e74fbb956b5564818fc5529dcc7e9f0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
