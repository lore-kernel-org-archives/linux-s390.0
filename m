Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324006;
	b=Oq/xFYRJscRrAcfhxkVS3MsSLCFRDVtXgq5Em44m9gIrTxMuHaYmeVwYnTQ56tjRFdJL
	 X/QOLwx73Em+xs6DAMI+WrkYkuxkzqIJLXc0s8IUMCOr0SbjBsYJJ+D6bKEBgCv0WF+HP
	 6tkQgBNxb+4hP2npPr5UVJTZsXIrrF0z3EJVgMkInUxTx/fnghQaLFVuSzRawst9cVgES
	 wwXEDf6etqEke2v7belN4yb5CWFWSqCCf2fOY96WVnTjDI2gvARyDPupCmR7F+oIq7aYb
	 YB9vlOWbOJZFwpPtJ0p089L/IGdlZJZE2ja5iO7slx2KrXWlc5zMCMend5brsG5Apow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=aeU67Qnv5ODKedtFLe52Ejeb5H8ZvbxqFopWCikeBNU=;
	b=ZpdySWtdXZ66SRQHnvW/e5A1KOzb0bP7Zh9admW3RHbObm+barrXSl/dQ2clN6xwfMKY
	 bvt4PmM3w3c5g8SrSQ3H0h38zm48uk2UjN9DG35Mz/2EXJc7UgeRNPoUPrm3p62YPKJbr
	 TN1mHqByXd5WwjyG6JdLVOoAPMZmhQ2UE6IfkNCbgSrBfp2U8QJK1vf6CJ6dqWn28Xgwp
	 L3+g/2VdtvTnFZ+fp5PeNSmcc/cM2p/qV6W+yPtdHR8uG+jyREMGehrLHQCgh3IbFb61b
	 Ek0bbbkNyEDC+zAEICsIx5OCNz0qQxU3Dhw8w/c5AyTEA7xxeZgg9+pHy7MZOdgayjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JL877IxJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621A2606A321;
	Tue, 10 Nov 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JL877IxJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BEB1F0089F;
	Tue, 10 Nov 2026 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324005;
	bh=aeU67Qnv5ODKedtFLe52Ejeb5H8ZvbxqFopWCikeBNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JL877IxJ1EeRyvaEjo+0v0XDfLHyZxHuaICjN9VzDP+i7tVzcNbf6lR1T5OV/zJIA
	 TZNv+11q1TtDJ7SQHiL044SXnTP9o6YzPKHQC7/AU/f26hXyghUVaM7gIF8lEcS7bF
	 z/YeldvSmObrjAkK0O7oaoIwVyhLN6Pz0i4FENYfnec5GZrfeidIY3BJddATGJ6WwS
	 sUbCYZQs/B6nvCRIDptM0CdYwvfdyfWnYOnfU9i4ar4igbFw6D3AaF36mnr57eLisM
	 Zrov/HYLwdAotuX6g8tVEHrD2X8MMS1chMZm3qJGTpUVTqxVdKNhxoJVaHXtwcIYzy
	 5lqbGZ9UENZkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D81BC39D2677;
	Tue, 10 Nov 2026 15:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Add Hidayath as net/iucv maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179432400468.4036268.3651889022579763273.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 15:20:04 +0000
References: <20261104085605.2040729-1-wintera@linux.ibm.com>
In-Reply-To: <20261104085605.2040729-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, hidayath@linux.ibm.com, twinkler@linux.ibm.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  4 Nov 2026 09:56:05 +0100 you wrote:
> Hidayath Khan takes over maintership of s390's iucv transport mechanism and
> af_iucv sockets from Thorsten Winkler.
> 
> Thank you for your support Thorsten, and thank you Hidayath for taking on
> this task.
> 
> Acked-by: Hidayath Khan <hidayath@linux.ibm.com>
> Acked-by: Thorsten Winkler <twinkler@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Add Hidayath as net/iucv maintainer
    https://git.kernel.org/netdev/net/c/8373c4e8863a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


