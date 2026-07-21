Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC22AD2E;
	Tue, 21 Jul 2026 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619037; cv=none; b=fp9BxArDuIOGj2DqOJo8DjtgBKDuKc/8q4rVmRnnKAstw4kET9bv+pbC205gfd+3eyOTwyLoE2JoJv4i7ME7fojcca7Mp9rHjLhC9rlskRPRFywiKnePCiLsrAMvZzhKY2MaX8pM3lsDzrJeJkD0rDCiy0aHs/1op3yrxYWOcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619037; c=relaxed/simple;
	bh=aaxU8zSg2V3tFjMzPJJ0jOz7PllZBjDEGCI0KABTeeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OCowij1xnScMKoZb3YgLXqvHQ3twSddfWt2ycUTUJK/AoA+J38xgP5f0ubFyMemcIHcdgAfxicX5GmH8TrRCHDqplNqcsVfS+gHVYLH7PYB+lp156htlVjwl8pyMndDcQufUvNKxsa6iJftpTb//DkxmevojwLwv919GqQpm8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFMfHrdh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFMfHrdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846E11F000E9;
	Tue, 21 Jul 2026 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784619035;
	bh=owyxJZnjps7R+ItXwXPF9krKCbFyqv6vdTCOSmqm1e4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DFMfHrdhHvR6YmqjfV8xyCBfZU3EriC1rg4YPI70itLmjo9JZ3E2JkrbDycREoKDO
	 e6/Kc8e88u/gAwHuxK4l2EZo52ZsabmF7s7HOBhEfB9O9xP3jC7ASuQytt7gl6rc+p
	 QBvnWNlj79WEbmxjeCHoShEW6B2GJvt5LUjIttzaOsJ9a7cz98eniZcid+Tal55F05
	 VMD2U4xsPt4oEkr1Re0N09uD9NPz0uJveMJxwUl9PvHebNf+e39/1xfnw/yfZLxGtK
	 4NDCZcZAi4+OvnY7nLimhIYLIicNn97RWwci+wtclK4Ebc3pSOTwKdxJTMBhVW0YZW
	 jbxnGZgF7ML+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939D53924A27;
	Tue, 21 Jul 2026 07:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/iucv: fix use-after-free of a severed iucv_path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178461900540.131537.16161978052316384549.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 07:30:05 +0000
References: <20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me>
In-Reply-To: <20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: pabeni@redhat.com, twinkler@linux.ibm.com, kuba@kernel.org,
 wintera@linux.ibm.com, edumazet@google.com, davem@davemloft.net,
 linux-s390@vger.kernel.org, hidayath@linux.ibm.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 nagamani@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 07 Jul 2026 02:00:54 -0500 you wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> af_iucv queues not-yet-received message notifications on iucv->message_q,
> each holding a raw pointer to the connection's iucv_path.  When the peer
> severs the connection, iucv_sever_path() frees that path with
> iucv_path_free() but leaves the notifications queued.  A later recvmsg()
> drains message_q via iucv_process_message_q() and hands the stale path to
> message_receive() -- a use-after-free of the freed iucv_path.
> 
> [...]

Here is the summary with links:
  - [net] net/iucv: fix use-after-free of a severed iucv_path
    https://git.kernel.org/netdev/net/c/be7cc4656eb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


