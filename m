Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371C63501;
	Thu, 15 Feb 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991167; cv=none; b=nYBZggS9fxQdlb7+9LiNYmzuF/DOd3pPGdFQ40x21epQb2OBUc8bDUzvfmZgUAFbVSseGbm3rZaem0a1Y/wloeNyiY2tiO29vu1VlQPKQGBWF7ok/8HzCmouNHko5YWNEnB0ZGZSrt/kPn1y6N4psMKi8uvQ1ReWDRYwx0vqRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991167; c=relaxed/simple;
	bh=AZDMowTxyTvTLYyKH1fH7EoIa5hD+V6eCp0zQN6Wb6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdLqlqOElK67UNyb02E3M5xSbyi8yT56/HBaxQlr29r8+/zbMc9JHaMZ9hmZN1lhDNeSIxIKTVW7xYGr3i9aLostMCE8LdZVTvAEIrOh5a+VGgPxhWbOgRQZM5NVNnVBftZ8blTWHuqMc6+gRcgMibTjaAs3vjeOFn8HGkhKCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVeTeA5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVeTeA5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642F1C433F1;
	Thu, 15 Feb 2024 09:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707991166;
	bh=AZDMowTxyTvTLYyKH1fH7EoIa5hD+V6eCp0zQN6Wb6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uVeTeA5NaMQilf5U9sYfGlbnQziksn1Ag+jPKd1wmkP3THGmkaRqmQ0xZgvuvIFs9
	 r3fs3jGcxWOKls9vf3mTGXJ3QGrCj4UTF3dv3dniLYAnYiGM8ixOtXGDDK1f5Bfeb8
	 QFCGqUB2OKayIhGa+wDolUYyLN7yiVBijWDzkjTDTNN6y3ZXLjnjLk8CFOtGtToir6
	 iGaBp3SACJ7PXC4shad6RKszD7dRvq7UaW52Xz06LfYkgryvRQ3lcSAZ46Sk11Wpi6
	 aE6XagQRPFTRqA2nu9nfUiCHmjN7iQTdR+zuFEFEQ8auAcW97OVqAxCuLXX7uOYWj9
	 3wcBW5QGt7+sw==
Message-ID: <28ca6b01-248c-43f6-b20f-79ff39f03974@kernel.org>
Date: Thu, 15 Feb 2024 10:58:58 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG
 bit.
Content-Language: en-GB, fr-BE
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-s390@vger.kernel.org,
 Gerd Bayer <gbayer@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Wen Gu <guwen@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 "D . Wythe" <alibuda@linux.alibaba.com>
References: <20240214195407.3175-1-kuniyu@amazon.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240214195407.3175-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

On 14/02/2024 20:54, Kuniyuki Iwashima wrote:
> Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
> remove SOCK_DEBUG macro") removed the macro.
> 
> Now is the time to deprecate the oldest socket option.
> 
> Note that setsockopt(SO_DEBUG) is moved not to acquire lock_sock().
> 
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v2:
>   * Move setsockopt(SO_DEBUG) code not to acquire lock_sock().

Thank you for the v2!

Good idea to have modified that in net/core/sock.c too!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>


I don't think we need to do anything else, but just to be sure: do we
need to tell the userspace this socket option has been deprecated?
SO_DEBUG is a bit particular, so I guess it is fine not to do anything
else, but except by looking at the kernel version, I don't think the
userspace can know it has no more effect.

I didn't find many examples of other deprecated socket options, apart
from SO_BSDCOMPAT. For years, there was a warning, removed a few years
ago: f4ecc748533d ("net: Stop warning about SO_BSDCOMPAT usage"). I
guess we don't want that for SO_DEBUG, right?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
