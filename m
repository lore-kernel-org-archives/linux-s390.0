Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854525;
	b=URZ9ON/aX0mrQ2PfgrFnlBUE2xnfypOb3jSxfDzsZOxpGRfjxRKg65qyX6UB6GcjxGJs
	 pLbGNTQfrlBPciMAQ/zAdlsRU43HALu7rX+/LX/Y+wPkVpYVKjFMnAabNhRYVSPf45WcK
	 vd5veiaKAyUSlXe3uhyXJm7VmdpjuPC4uRyncbrrHMaAzIPEEk9tF5LDO1on2Z1fPb/A5
	 K+Vzq7PKZR5zSU69BF4qnnMJwANbEre8twojLbVagb+KwobvdqMwVvZ/ZtrdpGxJsXbrb
	 lbvgvz1GOpBLKD4DdTb2M13nn6P+EM8jSxzcSG97Uqfg8Bu51upg2zJCC699cqh/hGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854525;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kroGRLnuQISDtT/NjGsF8MtS/o5kwdgbFXcNCNQWqUM=;
	b=Gl6Vxz6Uusf4XqWhtdZf1e4SBO6XjRFZT7TsTLEluGh8xLY3UKJqrZtHXqz3ICeZaErc
	 TdajsDircU4LgybOiGuIgvNrdQ/yR80gqJY0BoVyCakFHbzyeE2SzH7YU/Gt9JYhNM/Kc
	 X+7xO6iepshaJcsFyw+QHSivQgkOgefOvvEs6wmyFdIcnKg65gKllRRlVPD/hR2Z34OMk
	 5w3m+Ly5QqgksnoMMWNY1apnRl0nnnImrtHMoJjV3S9kRaW+hVwroR7mc68rj/MOcMmPB
	 TemDAtNV2pVYAHazlpvbYRKv2Gf+Ea2/8Bt27bpZEUzGmvd08/D0v+DTvP4j9mza71A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZkGHgCx/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B9212606A32F;
	Mon, 16 Nov 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkGHgCx/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 076C21F000C4;
	Mon, 16 Nov 2026 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854525;
	bh=kroGRLnuQISDtT/NjGsF8MtS/o5kwdgbFXcNCNQWqUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZkGHgCx/mEVO4M6gpNadKqF6F4rKSC6nADDFicHJ6XQNcKv0VkSO/+I1GaC6YDeXQ
	 2GybaNj3HcDrnw9jBy3cgnkUdQKo3kaM4itJu6QiXv/D7oNhER2LcV/1bRqfUsgPWc
	 crxOn3ltD6JEZZTRNmZPOxSRBB1fw3XSWkqWrvYd6yBV0PBEwpkfh1FE4uSz/eeHak
	 t6ytQDDQ+4cwfLgrRb8bZoop1kSDkAyQjHX+WXZsQA7N1kLkgTJwlKNMGElUK3EsYe
	 iktZu/7CyVIEB2wG/8tkbuUXc8tTp37/vL9lOGQXNz9ZBKDbHb4sNC6M0Ggu+r27ki
	 A69RfO60voSmQ==
Date: Mon, 16 Nov 2026 20:42:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 06/15] s390/cert_store: Fix cs_keyring reference leak in
 fill_cs_keyring()
Message-ID: <avtOegkQF5tsO90Z@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-7-hca@linux.ibm.com>
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
In-Reply-To: <20261116143534.158375-7-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:25PM +0100, Heiko Carstens wrote:
> create_cs_keyring() returns cs_keyring with a reference held. On the
> success path fill_cs_keyring() never drops it, leaking the reference.
> The keyring is kept alive by its link to the session keyring.
> 
> Drop the reference after add_certificates_to_keyring() returns.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index a69eccf6affd..386fe39fe8bd 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -723,6 +723,7 @@ static int fill_cs_keyring(void)
>  	if (rc)
>  		goto cleanup_cs_keyring;
>  
> +	key_put(cs_keyring);
>  	goto out;
>  
>  cleanup_cs_keyring:
> -- 
> 2.56.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
