Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631007;
	b=ykBTrnMocQHz3L9LSRkxqZpwI7ybHyEr+0sJFQ7JbSvxjhZzSSHBIkvicU9y6Qz4zySs
	 KltqTB9Or2mX0AgArINZF7xIe0u1jM06+3ThLkxFO9cC8CupZ/EiQhZN69c0K1+kycZAs
	 /qo982nRwVlpcJtFk1uEtaDiJCY99VTIQk6dbsKFc9ViuodRC9VSP9zDsQY4r8I5QRqYB
	 fzlW1mZVfXnToXJk4Fprx8qXTA4jpIS9e8fMUIU5mGa7YO1D8HBM7S3orfQ7tODLtCUJf
	 jBP3Q/IlJ48wUQGl9XV1+u5vXlpwAI9NPo+9qKtzCDJwNt52JRhFNS3R4Org5bSIMnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=HNx+fPH5kZhTfn4I49WOc3WnlkHXXq6FOZR3hyrHaVY=;
	b=UWAvH3naSVMF/iaPxBD+SVJznPi4DXr4kPEdEXX0q2f0ou9vv47iZo6zqNUEy84/49vW
	 EaC0h9BpS/4DF1ry2A/NCEItqICYvADSMgVxTQv5mG662y9VEPSv/C7fwTX2dUbjGGhHG
	 ImGMstD8cqvx/1FhGm48QqjsCBPEqR8YBHW2BojBrKZTY+A2Ert+0wxe5dODEl3rfXRcU
	 IFH/cJiAyaBX8RIqf2SuzEu4IVpKv+6YNY2i7E95kA6yFr4uUqLquDZzqrH/dO+kFHEVP
	 c/NXA0BufLCXjNPccZpvesorFoQoXHYgt2/SwpJWUeDOFIK1BJFIsd64M9hv0Vr9lMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJEicUyi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B6606B0EF;
	Mon,  2 Nov 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJEicUyi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBF01F00A16;
	Mon,  2 Nov 2026 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631006;
	bh=HNx+fPH5kZhTfn4I49WOc3WnlkHXXq6FOZR3hyrHaVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kJEicUyiGlUNs/gUT8/mzeLX04sVLSX+PYmFYTFgOyahPZ/F+zeA6Bco8FdM5rXGH
	 8kr/J86iNKNkEYPaAoWrVWpNjogGYAZd6aKUOEQ+UCv9jU2oV7hpxGuJnslWhyLHst
	 kLELOg68X9AS4Og3Dp+KBZxfZSHQ9nXxqY30GTt4yBG7A/xlXNfEeLOOIeEBBMTEDv
	 6nS6R1VYmFbstwzBP0AB1SXyyI5Jm4C+fqUJXQe6s8ipjgtLEhAA7IjGXY/drGVFNG
	 9ZYiUBMZWbKlwMbgoiDJFe8fAYOFka34nOGJ+tFAaqzMo7pBsD8Kn24dntewLYRDKj
	 gazSVWo2rwmrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4033C380821F;
	Mon,  2 Nov 2026 14:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3] net/iucv: take a private, writable frame before
 rewriting it in place
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179363100506.4107809.7403285775750444334.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 14:50:05 +0000
References: <20261028-b4-disp-1edbbc34-v3-1-13495411f5b9@proton.me>
In-Reply-To: <20261028-b4-disp-1edbbc34-v3-1-13495411f5b9@proton.me>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: edumazet@kernel.org, kuba@kernel.org, wintera@linux.ibm.com,
 pabeni@redhat.com, twinkler@linux.ibm.com, davem@davemloft.net,
 hidayath@linux.ibm.com, horms@kernel.org, ursula.braun@de.ibm.com,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 Oct 2026 23:47:13 -0500 you wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> afiucv_hs_rcv() rewrites the frame in place -- EBCASC() on four name
> fields, then afiucv_swap_src_dest() swaps them and pushes an Ethernet
> header -- and can hand the same skb to dev_queue_xmit(), without making
> it private first, so a packet socket that also gets the frame reads the
> rewritten names. An ETH_P_ALL tap runs first and leaves af_iucv a
> cloned skb; a socket opened for ETH_P_AF_IUCV sits on a ptype_specific
> list, walked after ptype_base[], so deliver_skb() takes a reference and
> af_iucv runs on an skb that is shared but not cloned.
> 
> [...]

Here is the summary with links:
  - [net,v3] net/iucv: take a private, writable frame before rewriting it in place
    https://git.kernel.org/netdev/net/c/f38bce9af9e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


