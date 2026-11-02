Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619311;
	b=NruqolSh8B9Kju1vcQAoWUUY3X23Vqi7aQ3il0bQ25UmXopIh0MNQNZ9prECScJJdip6
	 h8NhvdJfUXcHcsM+LHIt9OCgWTb4pNBgOdmfO2Yc3kDcz5Hn/wgAK6pfjti0tqKEA2tBG
	 1rK3yNmRsSgVjWbYG+hhZWEjoaR7rk2Tm1Ue5LfzOyxtX+/K7OfSfcZHJ72jkpgPyVOZT
	 q1hm+hSpQ4wKtcZ8Bkq6Wgtd9wjdHicDsh/0QiZJigcGlorVNUVtovjKpUSBwFgKvPcJh
	 jMeLB48/bxbuEEKbN/YD4j3u8b6HPI/4MIrWQZOceVWh6u3k1PAn1qXTPYhWWKyi0qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619311;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vR0MOdE6VqWSATr+1Il0VzNgeR3rfufNqV+M7Kt2OcI=;
	b=DeQYnusgWxkjrXdefl/6wHVu6YorMPeKsYLZypuCOLtZxRWqfMyL6ixHYUxEr9UF7Z7b
	 sutRPHHpezoL5MmyORbrQxNBPzEHNupxt5OTC3ewydQm7kbQpThY0IItyyahKnbay5qiz
	 uKXXVLQjQs0/lEzIf9ln7sRJDwt9B7ic67nj9vVzkM1QSsxEkjQWWim2WWiiw1sdOZ5Mk
	 gjXIBWVBNS3DVF5z+Q97b5iOLW0zfWKubMGwiwK+om/tEyt/GjpvzKRGuzDPqxR7T+dXC
	 SbsosW5EbvsUFYop7LyIh3nQlB0fzrf31yfrdifG6pn2Ykc95ErVrosTa7dked4FAGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6zkhLwA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C238606A324;
	Mon,  2 Nov 2026 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6zkhLwA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579401F00A16;
	Mon,  2 Nov 2026 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619310;
	bh=vR0MOdE6VqWSATr+1Il0VzNgeR3rfufNqV+M7Kt2OcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g6zkhLwAnoufeUkSHBbY1muUICbYtYW0myU8YFpk0XArDOylrRviClHs9P29yaRNS
	 gYSF+H1Xj7pHMFjecDJkFkggIPjZtB+IouV9m6J3/v/Nwt0BXEE9CSt/9yVpxGTYLA
	 M0i3HkmQsVAy7s6U/D/AUMJorCPb4vWxAhaR4/XDTxnP4DgdmyyquhZ0u43X/M21r2
	 z9ktjFgecvp8tA2LL0I2z9XgCY1qH+SYoxzURQK41xoygeVUSyUzx2qFMpLlakYczz
	 P8isBcP44v1vbCFNHuUDXmnmxKiNXRC29Rwb9tDSiL1LlUF4FQlIfi/yD51Rmq4P0g
	 JF7HKHAxyd5mw==
Date: Mon, 2 Nov 2026 11:35:05 +0000
From: Simon Horman <horms@kernel.org>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Hidayath Khan <hidayath@linux.ibm.com>,
	Ursula Braun <ursula.braun@de.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] net/iucv: take a private, writable frame before
 rewriting it in place
Message-ID: <20261102113505.GY257209@horms.kernel.org>
References: <20261028-b4-disp-1edbbc34-v3-1-13495411f5b9@proton.me>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-b4-disp-1edbbc34-v3-1-13495411f5b9@proton.me>

On Wed, Oct 28, 2026 at 11:47:13PM -0500, Bryam Vargas wrote:
> afiucv_hs_rcv() rewrites the frame in place -- EBCASC() on four name
> fields, then afiucv_swap_src_dest() swaps them and pushes an Ethernet
> header -- and can hand the same skb to dev_queue_xmit(), without making
> it private first, so a packet socket that also gets the frame reads the
> rewritten names. An ETH_P_ALL tap runs first and leaves af_iucv a
> cloned skb; a socket opened for ETH_P_AF_IUCV sits on a ptype_specific
> list, walked after ptype_base[], so deliver_skb() takes a reference and
> af_iucv runs on an skb that is shared but not cloned.
> 
> Unshare, then cow, in that order: skb_cow() can reach
> pskb_expand_head(), which has BUG_ON(skb_shared()). skb_cow() tests
> skb_cloned(), which is what a rewrite of the data needs; skb_cow_head()
> tests only the header. Asking for ETH_HLEN also covers the unchecked
> push in afiucv_swap_src_dest(); on the ordinary path eth_type_trans()
> has already pulled that much, so it only compares.
> 
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Closes: https://sashiko.dev/#/patchset/20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me?part=1
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> v3: skb_cow() instead of skb_cow_head(), as Paolo and the netdev AI
>     review asked: the rewrite is in the data, and skb_cow_head()'s
>     skb_header_cloned() test would leave it shared with a nohdr holder
>     (none reaches af_iucv today; still the wrong contract). One-word
>     change, rebased on net. v2 carried Alexandra's Reviewed-by; v3
>     changes the helper on Paolo's point, so it is not carried. Same
>     s390x QEMU A/B as v2, re-run on v3: same eight boots, same table.
>     Unpatched, the tap and the ETH_P_AF_IUCV socket both read the 48
>     name bytes in ASCII and a SYN with no listener never reaches the
>     socket; with this version every frame arrives as sent. Drop
>     skb_share_check() and the socket is broken again; drop skb_cow() and
>     both are.
> 
> v2: https://lore.kernel.org/all/20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me/
> v1: https://lore.kernel.org/all/20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me/

Reviewed-by: Simon Horman <horms@kernel.org>

