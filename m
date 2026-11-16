Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854450;
	b=czxKK2BzvqBqzxTcRLReKWv1hmQOI1L+ia63iWV8rsXqXQTEBf5DoqcdVwwc7lWEQpC7
	 CcRhhrr8QlS/8p84yYJLrZMSkyDT+xR1oiRuxzmlGNcHUcHcAXMoFznM2801W1PBWMf0S
	 lUR78VL29a1hXmqmeSgSp9CXUeFssMj0RducuZA3QMuaEaUdFZwCNM+HmmHCnGUXclBSO
	 UhUIKBruVC6s2A8XKk3R6ZmvpjJvfl6MaqD6+KMPeozGD8M6obM2hoU6i79U+pkbgazt1
	 iqceKxp4nyKo62xTXxKXw9r7V79qDkwmRB29Y4Kx63fY/KZjk8tmGxhItSLVgwC2JmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854450;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6S5DXRhFto9Buyw4ZB9PCZW+zUxe7QjX/mLLATt2xeg=;
	b=AiV3zWX4+RYXFIhEGCHOTVe6BY5LOvl3D8g4gW9Bi29i0BZ2gcrngSvGTe75tmpq4n+r
	 KVlbLy9TWf1ai8zDQnwB8s74z8RhKIa32MnqN31zghv+lleOkDZ+wVio/PiqWt1f2XJwT
	 dWFeQwX3uf3LZOD9AI39NzU2zY6GFNXGpXpKzawCvd/N4vVwTqQ4KhwjXIlRCXj6004nZ
	 Zay+k6ahX7Ukqpw8aDFF4EJN/+VtQpfuvOyV7yQkYtLAvus/dYglRei8qD3ORBpTe+JIU
	 eTR7EQupAfctZCnLwcZ0B1xEvuQbm6inFKQY+NwRhU4/nUYQfFlxJPVFibJAxMoESIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfFRChTN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id CA434606A334;
	Mon, 16 Nov 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfFRChTN
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EDCAF1F000CC;
	Mon, 16 Nov 2026 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854450;
	bh=6S5DXRhFto9Buyw4ZB9PCZW+zUxe7QjX/mLLATt2xeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MfFRChTNSPaNo0GzUFEja2A8YWEIGsYzACAntpeplXvVbPeCm/JgbqK1XxlixVKpS
	 639WzcNS2qq978N9qpIg13QDt+CFXddydYNaaZ+z6OvaNzUhaQzKXSFdufx/l6xvhD
	 JI4L3vd9cx092NpTBFUW9ZL7cjcy6oqzqHlfu8MdE/eDK1M7Nn1C/YCzLvvPj3UtPB
	 b4VrdaTLy95Sk+bORvff3V7NrIb5kJXyRBpyd4LuTnqCJCxgCoC+bHZgKP3CiVJH01
	 DJxT/CfnL7usVOZwHqCGxUeiVYfCC7RV+UZBCQ92sdhoUNXBRRxl3JxI7FUK/vcarh
	 Wy4vYdgUmiu6g==
Date: Mon, 16 Nov 2026 20:40:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 05/15] s390/cert_store: Unlink before invalidate in
 invalidate_keyring_keys()
Message-ID: <avtOLkZ_7VhYXUlq@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-6-hca@linux.ibm.com>
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
In-Reply-To: <20261116143534.158375-6-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:24PM +0100, Heiko Carstens wrote:
> If a key is invalidated, the key garbage collector may remove its link
> from the keyring at any time. If that happens the subsequent key_unlink()
> fails.
> 
> invalidate_keyring_keys() would then incorrectly return an error, which
> would lead to unregistering the cert_store key type.
> 
> Unlink the key first and invalidate it afterwards to avoid this race.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index 8eb32497ca24..a69eccf6affd 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -346,10 +346,10 @@ static int invalidate_keyring_keys(struct key *keyring)
>  			continue;
>  		pr_dbf_msg("Invalidating key %08x", current_key->serial);
>  
> -		key_invalidate(current_key);
>  		rc = key_unlink(keyring, current_key);
>  		if (rc)
>  			pr_dbf_msg("Couldn't unlink key %08x: %ld", current_key->serial, rc);
> +		key_invalidate(current_key);
>  		key_put(current_key);
>  		if (rc)
>  			break;
> -- 
> 2.56.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
