Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F493CF217;
	Tue, 15 Sep 2026 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437673; cv=none; b=ukJ11rziEQvQ5zuGaQVS5DJ3UYMsgkcT6PECZHL4QjdzNRiOBBpWyOlxlsblpeg/JtLksmeCMOIcrhrb3yZ0hXKfpLOBl3QpErj3vAdRSPfhiVt5dmoOWlFGxOcFrgEC+li6VAHPPlftgUy0Rqxp4JLO2KbJdf8yb6l69u2SX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437673; c=relaxed/simple;
	bh=pOKLiBkk6h56uT15U2FzuQQmJDNXWE6STh9e32iEa2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nvvGlr+zibMDFzEc4Uq28lx7HsF9mEDpItKHpi3COBaBcV2RVSRYlu8/eRSxIwx3iyUi+a/vEfzLkGMfUADLrF0zuSfvlv7dloIS8r2KLAMS5wkaf9ZIkW81lJabHQTOJ03UOCpVm0/4KELrLliymC2RVYrEniQxvOcYAUVQgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U15btlE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U15btlE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF31C1F00898;
	Tue, 15 Sep 2026 02:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437671;
	bh=v2upER/kE5TOu0045Rd2yombH8b66fOZGC2q12TcFUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U15btlE56ZLOX3UIQAOxz87kXxLuILmtDb3st0fRcZoimqED90x2cgq1Sjdss7FAx
	 I8h1dPM2/736QtWQXc6XsAwLNmFOsOnXt/idTTVlybqUgIBfymH/fyqKnTjXs7OquI
	 RgIHtRI2HSb7bCJFbSWk49XajrGTBMUduWXqMB3Ek38+ly8SesO0SBAfN8TFuThHmp
	 JSz5FEPRUusIr+LSXv0ISepTU51qN5b92u8pOOCENmBPYYKommwoq9pRVgOUqv4uj4
	 KvtVlqfu9mYWiKR0uQTu/I6SmR9J7vmkOp+NGnSKWkwFF1oHU5v/e1Scsbi7YfRWkP
	 t1TQR02u7/x0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF83924FFE;
	Tue, 15 Sep 2026 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/iucv: Add lock nesting annotation in
 iucv_sock_close()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943760637.1310948.18076350629366107082.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 02:00:06 +0000
References: <20260910162919.2100124-1-wintera@linux.ibm.com>
In-Reply-To: <20260910162919.2100124-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, twinkler@linux.ibm.com,
 hexlabsecurity@proton.me, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Sep 2026 18:29:19 +0200 you wrote:
> iucv_sock_close() acquires lock_sock(sk) and then, when the socket is in
> IUCV_LISTEN state, calls iucv_sock_cleanup_listen() which acquires
> lock_sock(child_sk) for each pending child socket. Moreover
> iucv_sock_close(child_sk) is called on the pending child sockets.
> 
> Avoid lockdep warning by using lock_sock_nested() in iucv_sock_close().
> Split off __iucv_sock_close(), so iucv_sock_cleanup_listen() can call it
> without nesting.
> 
> [...]

Here is the summary with links:
  - [net-next] net/iucv: Add lock nesting annotation in iucv_sock_close()
    https://git.kernel.org/netdev/net-next/c/aa5ec571b93f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


