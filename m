Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC02D542F;
	Thu, 24 Jul 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349389; cv=none; b=L1BfB1zMon2ZxuEsYB/4Il64iuuFYQkt72MKU6Ld7dwPEJJJB5E3+NuMgmRVbgZWg5687uFXALDSo/11F1aXAXC3FuEZ72sBUeW9F1OzVOTIM147uToNxIWx1insN3WAvXz2CH3gwzSLmit5m5FDbwOGLCPeWK0oKyX8vmakn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349389; c=relaxed/simple;
	bh=7VUgA/o0b6RFbRejKpPBapjkoBoZRgaJKUAf0Hd6azs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p3mYCfpl9geYJpWy2RlQp/Aj7SDM0w072EuL+RloBfteSg8nS+efJQVlyqdzfAwbpmoMI+WDyUyF5opQTG1EQVvYyFR9XWs6SpxgkBkR2in643zubgl4cZ82mprBvZeLAafi/sOlgxlLwP4bju8DpFdm0UZ8C6YjlOs0i8islX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upfqs7Xh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upfqs7Xh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070B2C4CEF8;
	Thu, 24 Jul 2025 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753349389;
	bh=7VUgA/o0b6RFbRejKpPBapjkoBoZRgaJKUAf0Hd6azs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Upfqs7XheYHgzHajvMldUuib0M45pW6g0lQxl/f4JwBVSKcYdr61Leng6pKT7ptyO
	 fYECEoLok5maCXFIF/nPntC9Maqp1B/vC6PHye0o0K9pic0SA3pujEb7a56MtEBlf+
	 CmLFAuFR1sts5wvEc1fFCARD0yAWRJ9R8Vvol8XTmLG4ybWigMSYESXZIRYOQWYc59
	 mR0hgirn1yzSqU+wpmmkQCY0x3FonKcLVi+d90NNpE1kDK6SqVrhsY2XbvYcnEPk3b
	 Bd66HMFpWFTRmt3bSlGP9f8QogBgJgA0OVMspIY6EHrocGrmAvsRG8p5+pMBTPSOJy
	 r10iG9tbX2ScQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCA383BF4E;
	Thu, 24 Jul 2025 09:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] s390/ism: fix concurrency management in ism_cmd()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175334940676.2317042.14697331243549647154.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 09:30:06 +0000
References: <20250722161817.1298473-1-wintera@linux.ibm.com>
In-Reply-To: <20250722161817.1298473-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 twinkler@linux.ibm.com, horms@kernel.org, pasic@linux.ibm.com,
 Aliaksei.Makarau@ibm.com, mjambigi@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 22 Jul 2025 18:18:17 +0200 you wrote:
> From: Halil Pasic <pasic@linux.ibm.com>
> 
> The s390x ISM device data sheet clearly states that only one
> request-response sequence is allowable per ISM function at any point in
> time.  Unfortunately as of today the s390/ism driver in Linux does not
> honor that requirement. This patch aims to rectify that.
> 
> [...]

Here is the summary with links:
  - [net,v2] s390/ism: fix concurrency management in ism_cmd()
    https://git.kernel.org/netdev/net/c/897e8601b9cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


