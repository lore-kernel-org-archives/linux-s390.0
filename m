Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE8444712;
	Tue, 21 Jul 2026 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667639; cv=none; b=MFyjB730laVJUGDTZmAPwK/rJ73qZgaaVaGYer7X/qDxVdBGfJZLLAnlz6FpH0I1yIH5KBu729L/nWw0o0Xs4CMapJQsTHf4fwpQTJT3Su6Tj1w+ZYhb6sZSc5ugWBM8KpUOafuSnbcU/AZT9BwWVcvJvtPnX+j97ctVWrWWRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667639; c=relaxed/simple;
	bh=hE+OkTYqwLD7hAZW0LjYV3oyyW9iTlPpgCkp7cbnST4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jB0vJs8jQGW0MSuEwlMDetlRWZpf6J4G6LdsZPY+5rziDcr9SEknwTkNoutzN7vpLfBKcd+mNntjZvMYMc1zMsVRNJjDzVOSAtkZ1HeHyQWRm0g7F/tvMOxciTPMjjPdRvZmeBlJUlwV0HLF2db+/TqZawmkZApJQgWZ7apCxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6I6SApa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6I6SApa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B671F000E9;
	Tue, 21 Jul 2026 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784667638;
	bh=Fkcvo7wNnzkTejnQdc1UeimxuoKuaxcdxPYR7KPDPpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T6I6SApaRFq7MPrc3mIcsJi97L9TAfhcnUDDHqaaKq1NnS9pooBZTe/4UA3I0/SNh
	 W9bq29L1WytKWjqTXusbudNtOhYZQfTBcQJVjnwpMQ7N34wc3qYo/qJB7JCGXvVCEg
	 bIwGgDNNBZ7NzXMhWR2jTvan556sb7g8HiKBOjO+QJJMTGJN5wWbfwTH+F4tNwtEYX
	 DYfUz661RXzll3engMUPi1UT01xwMT/zDrT1lzXCkWfo1Ni2l2W+H+i+Z9KMJajqaB
	 4sczs0ViMw8wsMxyFOMIhssY0pTNfXMA7CKiILNqe36Hh79kb5nNnC+FKryQBQVrga
	 hDjGbrAWkzlSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C7B3926249;
	Tue, 21 Jul 2026 21:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/af_iucv: fix NULL deref in
 afiucv_hs_callback_syn()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466760764.1059197.11934260585583972317.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 21:00:07 +0000
References: <20260709191732.124092-1-hidayath@linux.ibm.com>
In-Reply-To: <20260709191732.124092-1-hidayath@linux.ibm.com>
To: Hidayathulla Khan I <hidayath@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jul 2026 21:17:32 +0200 you wrote:
> afiucv_hs_callback_syn() allocates the child socket with GFP_ATOMIC.
> If the allocation fails, nsk is NULL.
> 
> The connection-refused path is entered when the listen state check
> fails, the accept backlog is full, or nsk is NULL. The code
> unconditionally calls iucv_sock_kill(nsk) in that path.
> 
> [...]

Here is the summary with links:
  - [net] net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()
    https://git.kernel.org/netdev/net/c/47a5116e56a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


