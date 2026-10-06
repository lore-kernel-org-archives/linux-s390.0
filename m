Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA292BEC55;
	Tue,  6 Oct 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791247209; cv=none; b=XfitlTgJwv3S9sBJzevG5amIxMPzy64MMbzCTfrqmSf5aWQsQMYKo+R3TURMtmp+/3Oap+OXMC8yDMmeNjo0Ny8G9H0LYlP3eb4kdqcFJHGH3J7BQUqLukZn8HXMxexB8PA7sOTGWLs0eaezGnyGWoDKVWlDrl+PFU0hcV+x+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791247209; c=relaxed/simple;
	bh=Xo/x2hmlfdj6ZVF7ptjWRCgpynoVX7s7/ALAJ+6nLv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oaSrDOzKQy3ABRywdBfpi7oJ4AXaMS8dzsRay7uxim4v1ZrZooxqSI43lRVsx4QC++7uwScGJaKdWx2mPqDXINpy5rQUajBTmlE+XAV8LqjhK4FfYuuSMxnmPZn1XHXASOmACaJOJVmsRjv0wO4wQKZ4reWuyEWSWyL0VSnLZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7KTxpnG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7KTxpnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A8F1F008A5;
	Tue,  6 Oct 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791247207;
	bh=C3WNIcjRysqH7rtpmCRMZFQJYoXx3GkPOULA+/zR7RI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c7KTxpnGuqR5+kTPF4dcSi4gBu0IAHjW9YVcQlGxfdpgDBa7nCevSsE+pb95Yzn8T
	 KOkqtLbGJ4WKLE5lK4zKLVOfNZgFvthfWM3k2vxE73Ql6jH87fmM5F6EkUc6/aIK9I
	 hnVgIct9RaSg3I2bo1y4Z8tHRTaurn56FfIf1QxgaxTYFfYMoYdudbL3PF/uLJWyh7
	 U/nJe/6dj5MrF/tQPrN3SRdrZdGpQjlPbT/KO1d2+FHa2vhjWXHaqd+Ax7/AIxMNVa
	 5jP3S7yCeGXSoqYMf5WrEk+sXxgrNuDgiSKRusas2OfsxakSUGeS5/DOCmqApsR+5u
	 KGE99NmQYQB6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1529392667F;
	Tue,  6 Oct 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] s390/ctcm: Fix timer corruption and
 use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124720578.1957713.16069268229683495407.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:40:05 +0000
References: <20260930070234.569500-1-nagamani@linux.ibm.com>
In-Reply-To: <20260930070234.569500-1-nagamani@linux.ibm.com>
To: Nagamani PV <nagamani@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
 aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 09:02:32 +0200 you wrote:
> Fix two bugs in drivers/s390/net/fsm.c and drivers/s390/net/ctcm_main.c
> found by Sashiko AI code review.
> 
> Patch 1 fixes timer list corruption when fsm_addtimer() is called on
> an already-pending timer - timer_setup() re-initializes the timer
> list_head while it is still enqueued in the wheel.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] s390/ctcm: Fix timer corruption in fsm_addtimer()
    https://git.kernel.org/netdev/net-next/c/10c339aff290
  - [net,v4,2/2] s390/ctcm: Fix use-after-free in channel_remove()
    https://git.kernel.org/netdev/net-next/c/65629387fd4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


