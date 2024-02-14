Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA9125A2;
	Wed, 14 Feb 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903196; cv=none; b=aV5H/j3R0dMRzqL6eUwXJ1SDk/4MkBUeifmQCbeqeV6y/JbwwFYSF8XACEWj2s+qaFeZscbijdKC3/hS7l5aiJFGfwLXCFc/7lsnmxWqq3Vv6zBaOaol8mf4TAWXk0EaJjs2gIRycbRluYl/csbx9Zu339tZOblQgrjYnaCpizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903196; c=relaxed/simple;
	bh=UISQVml4jbrLszXUXlZ5VcCn4BnTwKFkb9pedFDrCp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bB24cf/JQghCKRovPlSiHGqt/WzNGZmy1pO946dJGSSLPQ/pj91YT26q3u/OaOaRXsaAcmdoIsS17AXUOLuTWDbb/GYadTlrsuvWVwPh679yJow46621SM288dEb/giLCwrNnYMCi7pDRS//GlgufCanuJ18ZHkLLkbgFUUDhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv+CDWgu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv+CDWgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DD4C433C7;
	Wed, 14 Feb 2024 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707903195;
	bh=UISQVml4jbrLszXUXlZ5VcCn4BnTwKFkb9pedFDrCp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zv+CDWgufLAp+veVNy9g5pVHWDgVo4OmEQ1iZF8AJjSQmFKeD2pk+pVW0p8QVX//h
	 3q9tUgOItRcKJOS6iR5C/eIjXgNLGwJlAxw67KaXsGX5064Lcx9EP4p+xEsHzfxZj+
	 FykGPnlrlBktKaqjr27tCOP9/9umyX5dFNQUg+GIV48V5pj2w5wFTZIaZCm8wuykb6
	 Qpx8TLBIF0jYP2RCRFBSnIthz4V1jiIjDjlTdC2W24120Nr/zc2vCLJ19P5QBgZDWE
	 YsY94bxLXUNEJSx60Jn1J+Tsm37P+IyoAS2Og4yMGj5v/WQRkvX6/FlzivEccrnREI
	 UVYvHHUXOlMIw==
Message-ID: <60d7072d-392e-489b-8889-404f3c753620@kernel.org>
Date: Wed, 14 Feb 2024 10:32:58 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG
 bit.
Content-Language: en-GB, fr-BE
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <martineau@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-s390@vger.kernel.org
References: <20240213223135.85957-1-kuniyu@amazon.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240213223135.85957-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

On 13/02/2024 23:31, Kuniyuki Iwashima wrote:
> Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
> remove SOCK_DEBUG macro") removed the macro.
> 
> Now is the time to deprecate the oldest socket option.

Thank you for looking at this!

My review here below is only about the modifications related to MPTCP.

(...)

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index da37e4541a5d..f6d90eef3d7c 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -81,7 +81,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
>  
>  		switch (optname) {
>  		case SO_DEBUG:
> -			sock_valbool_flag(ssk, SOCK_DBG, !!val);
> +			/* deprecated. */

If it is now a NOOP, maybe better to:

 - remove SO_DEBUG from mptcp_sol_socket_sync_intval() and
   mptcp_setsockopt_sol_socket_int()

 - move it just above the "return 0" in mptcp_setsockopt_sol_socket()
with the "deprecated" (or "removed") comment

By doing that, we avoid a lock, plus going through the list of subflows
for nothing.

WDYT?

>  			break;
>  		case SO_KEEPALIVE:
>  			if (ssk->sk_prot->keepalive)
> @@ -1458,8 +1458,6 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  		sk_dst_reset(ssk);
>  	}
>  
> -	sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
> -
>  	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
>  		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
>  	__tcp_sock_set_cork(ssk, !!msk->cork);

The rest looks good to me.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
