Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A612FB0A;
	Thu, 18 Jul 2024 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343967; cv=none; b=sI80dXGF+5pXhRBgVI+l6dxYp3bA8gIYfic1Rep5w1XWHewri8USr/0alXYrze6IKJRQsTutNTWRl6AvVI08paAoyd0vTUWCfqJBcTI/HU/yvOVqzGlTilyoqPiXf+e9zf7o50cQEztWnnYwaEkaTR4Tltzw+8BKV6DLrVAhlF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343967; c=relaxed/simple;
	bh=BeSnoBV0D6cUCjOyt+tSSFpNxOsdVXsJHVyeVB2Ncgk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VhZkqkyjJG1Cf1jw4nBgkynmDl2jRct+ujEstIVaDCZVvjTLriDvQR1UFa4WDonWfvryjYm9EyIgW0hd0oAHN2EO6efwRz1l+wmRFGYEXNHKiXDFwJBse1/MU9X1thQGyjGFROVVIPtlnDmLs5YtmQjTOCWRkLbQZ1MX+0q+6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQMeQ5Bm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQMeQ5Bm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6A8EC116B1;
	Thu, 18 Jul 2024 23:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721343966;
	bh=BeSnoBV0D6cUCjOyt+tSSFpNxOsdVXsJHVyeVB2Ncgk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZQMeQ5BmjbU+aOg7DtpGnxa+OWHQjho6PmwwmHezAmRM3prZltzAc2MExArI1cZvm
	 84XQMBRKp/yE4NhnUOOMIzGZ+4WKrOAD451iWKDg5XMI83TsFxvfqOD3ZO2tNvzTbK
	 T9BdCX7ONolOlJO65G71lAMc4zDn5/Yfgwh5H24QVM8TTnBnFj1dZA+/akh83iU/dD
	 VZfKls2Txy8YEZDs/B9aQ10L0GJPdkbgyWpYG5UuENaFR59wCLRg9xmK38cwGyluMY
	 fMaNQZ9sLX43OaMw3Qq9ByyYtBWx5AhMkzrtp1E5o6Q8YC6kWnSLtJS5Nk66wIrsIX
	 uihv7OG3YA10A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC7CFC43443;
	Thu, 18 Jul 2024 23:06:06 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 6.11 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01721246975-ext-7833@work.hours>
References: <your-ad-here.call-01721246975-ext-7833@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01721246975-ext-7833@work.hours>
X-PR-Tracked-Remote: https://lore.kernel.org/all/20240627150405.27663-1-iii@linux.ibm.com ---
X-PR-Tracked-Commit-Id: df39038cd89525d465c2c8827eb64116873f141a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c7d0c3af5cc8adafef6477f9416820fc894ca40
Message-Id: <172134396669.16085.7253506528451652809.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 23:06:06 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jul 2024 22:09:35 +0200:

> https://lore.kernel.org/all/20240627150405.27663-1-iii@linux.ibm.com ---

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c7d0c3af5cc8adafef6477f9416820fc894ca40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
