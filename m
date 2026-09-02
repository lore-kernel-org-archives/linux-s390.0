Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7035966;
	Wed,  2 Sep 2026 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309464; cv=none; b=i4x/+v32xBP2qQsLlh+2KcWzKYqj/I0wV/z4qsx3SuQsQoUiICIYoBSrcXWTwiL5m5R/n4LmAi03mvQfLL3JJUbLJ3zH/ce3rBtm2k8jj7G28SLYITUT586XvVI4Kyv3ZBCeQuTSilMOK3/hXilS+DKgrtpmv4fbepOb/I4/M2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309464; c=relaxed/simple;
	bh=NoTmUJEaxhqO9hG77vZ18iBlUcitaKZlJD3swhme9Zg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ENE2SQRo2YzWuiVABsBzt64XVkounHHObrOqIZhK5i2nGNrtc6M4RBa+wDIfL1zGk35nEMmO24mTPhIRC2mGVWb7WnOvYNXGBf6aK2uu/GgpUuPKxar50c/LdALWKFV8RWVW1j2g2PvoT7xBlVfaKiSlaeaFfgyEB68kHHpkV3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrrTs1aN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrrTs1aN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549B31F000E9;
	Wed,  2 Sep 2026 00:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309463;
	bh=IOjFesW3T/u0QIRfCrHTj73GkXzgo99hJsseYPUryp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NrrTs1aNe83GIdBZT4gxknFkR/nS66uBeC0x6issK2Dh8jg9K2CNbbXRW1WbWM5fB
	 4Kac+ugPFDaiictTZSM9yGzBTUSWov8u6a1UDKZNOBtXN1AM1sXYifE92q5f4Y0VMk
	 yZ9o2+h24pJ4U+asfLIIfvQTflULUeK0y5s0P3ph6sb5g7ypfZqMbJ2Y/5umAdtIMN
	 hljqxK08FItTFNz5ipl0c2A7B3KdabmR605a8/PD0si+EmidGr1xjjBleVYsb28Wql
	 KG+74BMmBoleM+Y0fmjez4MQxRaF4I1HqHERNBNkiu6fCkvTi/Gfm4Xye0v1dEjuE2
	 1pUj9FHE6UYVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2D3926244;
	Wed,  2 Sep 2026 00:36:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] s390/ctcm: Prevent XID null dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178830940539.1844276.5420614099617158307.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 00:36:45 +0000
References: <20260827063408.2168914-1-aswin@linux.ibm.com>
In-Reply-To: <20260827063408.2168914-1-aswin@linux.ibm.com>
To: Aswin Karuvally <aswin@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, wintera@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, horms@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Aug 2026 08:34:08 +0200 you wrote:
> The mpc_validate_xid() function sets grp->saved_xid2->xid2_flag2 to 0x40
> to signal XID validation error. If peer XID is NULL or r/w channel
> pairing mismatch happens, grp->saved_xid2 is never initialized. An
> attempt to set the flag in such case leads to NULL dereference.
> 
> Fix this by using the always available priv->xid->xid2_flag2 instead of
> grp->saved_xid2->xid2_flag2 for validation errors.
> 
> [...]

Here is the summary with links:
  - [net,v2] s390/ctcm: Prevent XID null dereference
    https://git.kernel.org/netdev/net/c/b264d8422779

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


