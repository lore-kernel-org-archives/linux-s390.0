Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855694;
	b=Cllk35eIhRS2xU2pvBFJJyMMxjEliI4OOnez0cElHG6nxFSKEeRr5clPNOVC9uOlDcYf
	 OSc74/JEh6gOA61XKcVm+PGaT+2k/O5I8FkwHmLlOl/wgeLgLAXlNCKWC+RvN2+CwiKwJ
	 io8YnxubMrAy5kyld3z2aYW25JRGcbHh2GVNvZrEnH/Ufp5DvTKm8FhHLfoDrwKgkIskq
	 c8ZhieADUkX4xQEn5tVdmE9O7eJjI0E/3BOvEL1p78SZ+BizN/9bKeDKRg2/jTZW00Jvk
	 bTk6O17fbcSXZ+QGOugju/LLLEtmLFS0m1umqVW8PKSyUOou3QTJ6tumNaI3RGBu4Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855694;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lLKTdifdzCi8rJAyFxeA2J8JWSb6RO/ELaLTSq4iLFQ=;
	b=xaZqT1l+mk/JHPB2Oj+++8OECaFRnLLjbFuziBqK1K9uSh2hT9dSx8jv/R61r5fSK6gl
	 dFu3Vu7lPEbn2Mxc6c8VF+vajPsPUc+YzrTKQbyT8vl3VIis+MAPH1BOnAyu4aPdWf8yS
	 namCBvrmDgxuIqVPr0iLIq9JW6Ra3rdzWMJFBDxmamHYPakkiG2i0BoQ8ynkTohJrVgc+
	 luk2AM3l3OGqUgOvhJbmMgpbn6NwZScOLrqC6j2A74vMxBDkdNls7zw/QVDLIJbIyaR8W
	 g4XlKSd7UO0rWIRRvH6hsD/Ppbcr4Be74QjzuCfeXVZOuFXDpwp+EGahaAzgJAN8OBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIhsoNGV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E7CDB606A329;
	Mon, 16 Nov 2026 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIhsoNGV
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 42A751F000C4;
	Mon, 16 Nov 2026 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855693;
	bh=lLKTdifdzCi8rJAyFxeA2J8JWSb6RO/ELaLTSq4iLFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IIhsoNGVqX6fkBsnEfTHq4UTrMdQDun5ieMyvO+NYh2vrKuDPWdAUOii2kDR72EEh
	 wsVDqKXxLG3pPUdN55Z8MQ/vy6wsNN9/mzt0/Xl/cwcAy+CnZ1hpHJu09oSFvGxJIC
	 UcN9BYduABHPmUENRwgQGv4KouSrlj2eefmh78m+2nVgUXZqWv6uyCHALCjKnbuuPo
	 YwIEAP+YvunIad/Q8L3/xObe7XMYYlK+H+vU8QH+00uNk/snAZ8xHbEZN/VSCfkQj8
	 /+nvMx2rwCr3sW1JrbqIH8EIuIPCKDyCWYsIy/eoOv0ELrwGYE9j9vVcIB2/YIgJXu
	 7Taw7SVUzf6qA==
Date: Mon, 16 Nov 2026 21:01:30 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 10/15] s390/cert_store: Fix keyring refcount handling in
 get_user_session_keyring()
Message-ID: <avtTCl26dvpNbtFJ@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-11-hca@linux.ibm.com>
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
In-Reply-To: <20261116143534.158375-11-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:29PM +0100, Heiko Carstens wrote:
> get_user_session_keyring() drops the reference of the looked up keyring
> before returning it. Callers therefore use the keyring without holding a
> reference.
> 
> Return the keyring with the reference and let callers drop the reference.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index d11637c85063..ec6352528a2b 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -308,7 +308,6 @@ static struct key *get_user_session_keyring(void)
>  			   PTR_ERR(us_keyring_ref));
>  		return ERR_PTR(-ENOKEY);
>  	}
> -	key_ref_put(us_keyring_ref);
>  	return key_ref_to_ptr(us_keyring_ref);
>  }
>  
> @@ -370,6 +369,7 @@ static struct key *find_cs_keyring(void)
>  						&key_type_keyring,
>  						CERT_STORE_KEYRING_NAME,
>  						false);
> +		key_put(us_keyring);
>  		if (!IS_ERR(cs_keyring_ref))
>  			return key_ref_to_ptr(cs_keyring_ref);
>  	}
> @@ -399,8 +399,10 @@ static void cleanup_cs_keys(void)
>  	keyring_clear(cs_keyring);
>  	key_invalidate(cs_keyring);
>  	us_keyring = get_user_session_keyring();
> -	if (!IS_ERR(us_keyring))
> +	if (!IS_ERR(us_keyring)) {
>  		key_unlink(us_keyring, cs_keyring);
> +		key_put(us_keyring);
> +	}
>  	key_put(cs_keyring);
>  }
>  
> @@ -418,6 +420,7 @@ static struct key *create_cs_keyring(void)
>  				   (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ,
>  				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
>  				   NULL, us_keyring);
> +	key_put(us_keyring);
>  	if (IS_ERR(cs_keyring)) {
>  		pr_dbf_msg("Can't allocate cert_store keyring");
>  		return NULL;
> -- 
> 2.56.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
