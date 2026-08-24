Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A06388862;
	Mon, 24 Aug 2026 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598672; cv=none; b=oQkR/SiuH2OS0Hb4GJ9KTzVNVmtszc5IsX3UJL4UDau6WVCTCeSoqo3VU5bAfowtn4TiYmO88Xl2s+aKzQVkVgXaqO7HdaAjryk0hXc8F7jlhmWbf9Gzmoly1yPFNqnsTQpKcPGxM8m9cLwjmS/J4472oJc1AHkCkK113trXJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598672; c=relaxed/simple;
	bh=FXWJXyN/mKulL+f9lDpH+/dIJm9BRIj0rXSAiI1dvYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pbHDx030U8VIi4fON9HBf8SMvGs5XtJf5qwweS8fQpf/owsDTpUT2JcjoDVtX05i2JjcyvVZ92df3aiS4S6szVilC2Bev1LqyfMJCcFrgz2UufJlMdr0Vicp4Z9OPvFZ0zy+dmgYacBd+OLJlheeTUXdcL1Kzdm0QRGmd75X5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVl7FgWR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVl7FgWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB7A1F00A3A;
	Mon, 24 Aug 2026 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787598669;
	bh=1XQHG9tJF2dhP6jjsu2Mr5B6Kq/UMcHQOkApQzDlgIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QVl7FgWRjxLTlf72hJDQJI06m4nFQ5HZ7dh/nzdX2omxKGypU1OcrdpPvmGR7Z3J/
	 en9sSKgwePflDQjHKqB6OSZlTf+GMf4QTMYkHEHFpxbX3eJlCJoTV3ZhLjT6Ob6yP9
	 MBNrNaTXA35bXeGT2qJrrhAUvvol/h+wuGvZPcIeO/bRQOZpNVR9wdktMBdjzSdVOt
	 zf/fgjgeTielArkt12DxWeFswbZKWsQh3Mzr9vsiD2p3OKvo9SJ3MRrPf1kZapWUGg
	 Xtymx7JgZDyaZlsTVJCes7GtvlFhsdi+NJWN/99WL09snxNyI8n9YWXkiexHphgeUE
	 FdO6D/5ngBnEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199033924A4C;
	Mon, 24 Aug 2026 19:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/iucv: filter frames in afiucv_hs_rcv() by ingress
 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759861660.3069565.6430583853807571931.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 19:10:16 +0000
References: <20260821125501.3718748-1-wintera@linux.ibm.com>
In-Reply-To: <20260821125501.3718748-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: hexlabsecurity@proton.me, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 hidayath@linux.ibm.com, aswin@linux.ibm.com, twinkler@linux.ibm.com,
 brueckner@linux.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Aug 2026 14:55:01 +0200 you wrote:
> afiucv_hs_rcv() selects a socket from iucv_sk_list by matching four 8-byte
> name fields in the transport header alone. No check is made against the
> net_device the frame arrived on.
> 
> This can cause a frame arriving on any netdev to be delivered to an AF_IUCV
> socket. Three problems follow.
> 
> [...]

Here is the summary with links:
  - [net] net/iucv: filter frames in afiucv_hs_rcv() by ingress device
    https://git.kernel.org/netdev/net/c/80230a18c164

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


