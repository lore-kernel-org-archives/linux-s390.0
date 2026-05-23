Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00441C6A;
	Sat, 23 May 2026 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779497398; cv=none; b=B0L2pzpQyGYlXlZ+dFwMnsmVLrWpqNqxPcAnLZdbEwahqyxF0Ngt0jBL8Zq1ko6vMK+J48A3WSOuRzj6Gf5BlYfgSe40iq0tbpOK1HaSedxWgPpVKKo4J+gq3tyl4lS1/HkqAGqFkybLUCWd4MPUMdobKMaglojWQumJPmCtEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779497398; c=relaxed/simple;
	bh=E/fanjf9lHURY1SC411ZExDg9JUlYsQwtr6ePvEKd2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z2WECXBzIVMx+ej773P43pj+eeEJIfRwWp4l3JOhG+NulkoNe38y2qVPsPTKpJBsoIzcqGmHs+kCwwKL4My+HyeJnI35HROB5hee/2yW6OGDuPh3cUkGoNUN/WecLV4kObkiV+u6tTcnVMbdhhq34ZPZAoYbmDkuPywhaGpzE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGYIiaYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGYIiaYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC07D1F000E9;
	Sat, 23 May 2026 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779497396;
	bh=xIuOq11z5GncTcUAggi66NcDbtHIM4F6WWbtRE5yPWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jGYIiaYAgifDVbuX3Co7WmYjYE23P9Mulonrs+FWU+tk/oQsNdu7N0zJQkCTfbvUl
	 0+IzNog9ZTMUYtAtWhdW0rzmun9QHSGlxN4CWxN2vI09Dr7UwRNAhATiguiKkSgrDY
	 P2/zpAqA3WoLpEVRC7f4rDjcs7bDGvAZppgYbVcgkpsIJIQXgj+Gok2hIGKo528rTD
	 ZBGB7IzuM1xS+t0S5UyX44SXtTnawHwEwjza9AWzDIBalluODKdnze3kUEl9M4kNmG
	 he2daFCIBDqCjmFJL7yEsHcml5TNo5nSA2EXo8J+H/U4wHIaoYeyBG5uFP4kwfCyEA
	 TZP7wa5z0c39A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B693808205;
	Sat, 23 May 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/iucv: fix locking in .getsockopt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177949740565.1429997.1649694232488490214.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 00:50:05 +0000
References: <20260521-af_iucv_fix2-v1-1-f16b1c510aa9@debian.org>
In-Reply-To: <20260521-af_iucv_fix2-v1-1-f16b1c510aa9@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ursula.braun@de.ibm.com, frank.blaschka@de.ibm.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, sdf.kernel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 07:11:45 -0700 you wrote:
> Mirror iucv_sock_setsockopt() and wrap the whole switch in
> lock_sock()/release_sock(). The pre-existing SO_MSGLIMIT-only lock
> becomes redundant and is removed.
> 
> Any AF_IUCV HIPER user can potentially crash the kernel by racing
> recvmsg() with getsockopt(SO_MSGSIZE): the SO_MSGSIZE arm dereferences
> iucv->hs_dev->mtu after iucv_sock_close() (called from the racing
> recvmsg()) has set hs_dev to NULL, producing a NULL pointer dereference
> oops.
> 
> [...]

Here is the summary with links:
  - [net] net/iucv: fix locking in .getsockopt
    https://git.kernel.org/netdev/net/c/3589d20a666c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


