Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8491C860C;
	Tue, 11 Aug 2026 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407655; cv=none; b=fn+Yd13X5m0LV9i+G9J45RWCmWjQ+NJoNuWYEy8rYKTpr6Jf+i7kf2XUOIaxFHz7Ysn26vizL+hEAHA8YFz8ZoNaJS5HY0vhtg5iUo5VsgF5A5FXlbR2jKRQKI8k0MelZ1A79yLptq1ZcrJO7UrGFrZrPnI22/As9LOKE+r6Xus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407655; c=relaxed/simple;
	bh=uU9arNIDTc+2K3j9mBQWG8tLv4qBvAYSxwGRKhMrFb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lDIGEWayHGsf12MkRblp1iDdhG9M0dNcFYoLmRAWrZ6RK5kRTXN5h3sCr/Eu56kQolvaugvHGhrXZ0cPY3Jf4bxu+jZCkWUcX54LUXEWBhryA0X1OUqDhVSkxcdDYBarpdpCnvxuYYKUQI2ePxVdXWBIcIERy1aKfZtcAn7ZS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvOG5CF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvOG5CF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8C91F000E9;
	Tue, 11 Aug 2026 00:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786407654;
	bh=cnxjiqCgRvd58B8X27CVU2wBi1LPz6O1qAPXrdDwJmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mvOG5CF4xK30vAJB9uUhDuyTqV/rNp/w3e0TqROzRiectli/6ilNIiOcAwGKUo3Mi
	 VK3FLy++9BSoce7w8DNqMXjEZOTQZY1Hy3lLGIiMRnSuxnrbleISB9AYvEm58LBFQH
	 oDaA/0Hd3CzwdYWC2aRRVohXbjny4kWUeHbzU4MuIFL5qbRT9RiqWqaV4N4+zlKGKy
	 Pv6vw9OxLSUdLVVGFi1w2uni6Fz1xTXy10nmMKnzDw2LvZKipH8hZW78jHj8wUDSqV
	 9WzIDmxq5kdD6Edb6ZWIUwUziLRpGuxE9fEtgd43YDEczyKxTrljGrvfc1CCHznPQi
	 5/g6BoW4gEHzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1993E392626C;
	Tue, 11 Aug 2026 00:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] drivers/s390/net: Enable CONTEXT_ANALYSIS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640761064.266182.4455560086468858785.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 00:20:10 +0000
References: <20260805145032.1409325-1-hca@linux.ibm.com>
In-Reply-To: <20260805145032.1409325-1-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 16:50:30 +0200 you wrote:
> Enable CONTEXT_ANALYSYS for drivers/s390/net.
> 
> Static code checking for acquiring and releasing locks used to be done
> with sparse. That was removed with [1] and replaced with a clang based
> approach [2]. The new approach requires that each subsystem needs to be
> explicitly enabled for checking.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] s390/ctcm: Add __context_unsafe() attribute to various functions
    https://git.kernel.org/netdev/net-next/c/4d422c526fcf
  - [net-next,2/2] drivers/s390/net: Enable CONTEXT_ANALYSIS
    https://git.kernel.org/netdev/net-next/c/5da9639bdd20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


