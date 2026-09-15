Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC413CB2D5;
	Tue, 15 Sep 2026 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437192; cv=none; b=Tg8D3KKg1QFVZGUHDN3L2HXWd+7ebWGqpR4KOfTOPlcCBf2GV1TE9USsVY92VN7GRETnyxoXKCRjQMxU7nEsN0IXXdl3/1o/2flc8R+I7m8igjiTYPFfYYBVPYYLT8rFiuU+C7HKpRAL+D3VH4kMtbXdjdxAgx/sAVkWEOJeuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437192; c=relaxed/simple;
	bh=oAa7Smy/SjhwQPpYW5HJB1poWGvuvErPgfFxnAooXDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ib457CIhO45GHFytzDmj0cKFAfGkV0zFS1dA63dHwWEhJIeFqqla0p+jTjhu35uIixHaAiR1l0aeEwXuCkvX6GS5b58hT53H5yE1J1/e5XLY5jFrNtUsWf/crcmsxBZX2XExZo1cyl9jRMs0s41Hz1k29LtK1AiNj+QPhqVr/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCBZt9zU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCBZt9zU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6EC1F000FF;
	Tue, 15 Sep 2026 01:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437191;
	bh=/wAZuy1jp2IQfGiXX+HqmNhFw/6DFBlX6sFtzKowBPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oCBZt9zULUzCuveK3miuqkMcD2xWxE33hMlH+700c1fCt4/1LxUthrV0REc3TBjRt
	 7XZfBYp6s5bTs3bY0ChXBPJwLFqvusgEo0pDkrr8oNfcbrxhNr5LoNTBSj1b8phkq/
	 ZIAQDp3eVkXV1IJwPUGZyJ099Ps2eA2yYoAi+tbz6ORZxN7Uxkwf4g6CrR2rNTytGG
	 HMCe2S6doM/PW2o1IGpDxTFn3gvvrGmhxuW8+2+CnzFil9kAuPT824R4BJ30HwN/vF
	 RoOS3h82v41xFx00sfrhIE3gm1zbWzE2JQkWs5bxP8hvyToINGqJRx03qWHzQk1jxR
	 1dTHqDOZtSilg==
Date: Mon, 14 Sep 2026 18:53:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Bryam Vargas
 <hexlabsecurity@proton.me>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net/iucv: Add lock nesting annotation in
 iucv_sock_close()
Message-ID: <20260914185309.326ab184@kernel.org>
In-Reply-To: <20260910162919.2100124-1-wintera@linux.ibm.com>
References: <20260910162919.2100124-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 18:29:19 +0200 Alexandra Winter wrote:
>  static void iucv_sock_close(struct sock *sk);

deleted this line when applying per clashiko
