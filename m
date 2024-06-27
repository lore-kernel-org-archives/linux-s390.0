Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1219AD85;
	Thu, 27 Jun 2024 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512416; cv=none; b=ktSmnQ8dBCkBOEBJ8nOLm5Qxvo2blA/yzUf+IqpN3KV55SzGO5Rv4Mt9TRhdpJRv4vxnK+4xCAONTUBntCoWplBcWkCRKbCeTygZ9EdIBQ+uI+k1MlNaLDZO/L+80F7gOedq0la93LqVJaxG4gPRdw3acZoptJVyc7MkSjfQZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512416; c=relaxed/simple;
	bh=y9eJkH7Jg1Vt5xctuHGopZemtlOpYp/dVIcNN7DqL0w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EmUotRhxZ6o8yU4HGLXIHj03wYwTehTyLBGDFPQHmm9nvB6PqAzZYWdJlMK/EJQOyCsqR/az7rrjdeifL6iKUXj7t5RmXtIpPtXUPczWy56dHGOxsPqbTtxqtU4H4ow1VycECUgan57MyMlYgWgpEbWIZIqtRAAALBGepAf9pIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHnfsoQZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHnfsoQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DDD5C4AF0B;
	Thu, 27 Jun 2024 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719512415;
	bh=y9eJkH7Jg1Vt5xctuHGopZemtlOpYp/dVIcNN7DqL0w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jHnfsoQZ+zHq2lLtxxKS3RKaU9muZk50MFXGoDR+MfLJ/3GBmmZDbNzPyXzCNcsRi
	 7GNN90e8Z3PvPkf/q90uF57u6O767XSFJjqJEMCQR4XBJrluYwksKoqTJ37MqPLaPN
	 GX3G5irf5cs38BTV+mGChOec6L6jJDXfmrx0kC6Wy39lI10GOB964ob7Su/Pz4PkV5
	 NCMupQRT4bgfl+91Ge7Nk9+tpNF/YWOkUEUbWEXTanjyGT9VNCazN8g67H4XrXVMdZ
	 /Dj7DU6OJD1pgWcGOqOto2a5Br7zjIYdoMtxn1ubmgnf69FOUY7VkOo5sy4Yw+PSYy
	 zS85t38o/dYCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 930A6C433A2;
	Thu, 27 Jun 2024 18:20:15 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zn2K0ZLW5gU6rCxf@tuxmaker.boeblingen.de.ibm.com>
References: <Zn2K0ZLW5gU6rCxf@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zn2K0ZLW5gU6rCxf@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-7
X-PR-Tracked-Commit-Id: cea5589e958f8aef301ce9d004bc73fa5bb3b304
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d6444ba82053c716fb5ac83346202659023044e
Message-Id: <171951241559.26151.15156922276767048596.pr-tracker-bot@kernel.org>
Date: Thu, 27 Jun 2024 18:20:15 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Jun 2024 17:52:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d6444ba82053c716fb5ac83346202659023044e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
