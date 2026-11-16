Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855666;
	b=5ZLfJeIwu1kYx+6reNonWD82QwP9ijzOztZedr2u/PasW/DdQiqSIDt9pCE+MxY4+cuG
	 yyDrMKB0rlXozR6C+g1fLUUYh2oMifb1ce8gGyWbnDq/ooqSaIElZZiIJyODF+B1PL6gM
	 dbZbIx6/dJrJ/wkbGFtrip+ZZXwPH+IhZogN+FmJbIL6N5ISF99Ei9Dj1y2kKJQWcDHj+
	 r7IVlCQ7xHvusSttRPgsZmg/eS4Jmc56P8yu5TZeEyN4ApLbFvZzIP51cu5Con874CtUC
	 I1iAIlciWVVJfT0XjcRC4HpYnqRV4e1Ne4Ekxy6kkHiDcrvoBwBj5mzplsAdZ/pYTZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855666;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=D52FdKUmx2gXL3AM3mr+8alRPG7HSlCHrLzeq4ipzmU=;
	b=4C1Pc+dbZIs/fhSYHKkKTP37Hy5sdqQTKiRvZYJPVUXVbZEDfM4VmyOBvYlWrCOpKG1k
	 8cpQt/laZI97hOrizAttjLrtu0WuE4V2mENsgNaJJhxMVz3UIx4lujeGeZGqkI8kPZCkg
	 P5hvT3oiUnGKe+nwBbzaVDXiaxnM9CVAFuCBCf4vPahr8zt39eUhcs+GSmcvfXd/JND7S
	 5Tf83DZ+CWVlTsfCz7433z/UeSjSuSruXqrq9lBG+rLIbblbw3byL+P3jOQgffMpO7wu/
	 ROnZE5BwKYT6zAFm8HIFdzKL75BuoVpNfIFE1goFv5slgGEexXvj8pXanLIuu8eEoTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWTPSFZg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 95945606A31C;
	Mon, 16 Nov 2026 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWTPSFZg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C510E1F000C4;
	Mon, 16 Nov 2026 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855666;
	bh=D52FdKUmx2gXL3AM3mr+8alRPG7HSlCHrLzeq4ipzmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FWTPSFZg8gspb14AIS4CsJ9lku21qOnKjp/mcXvB7WrTu4TwZuHJZBtWoi7Y6geOV
	 cbIzDXAzD1IjhIHCJ+eRrZZyQcxqZbfWq3nP1GF67e5jETzYz16/eL2yDhUCKK6cSN
	 qcKlRTUmfZswCXS6x20riSToeWT5jDFJCMSZP+j2oXsekLoZWDMNwlAg7FDLVP2sKZ
	 0Q/Tp3Hp4+9hACpyuc+1i9PT04nJ/6VIKZyjqGFUJ8JEDBxvg8bRhWEx+Cqfv/o2ct
	 UJukRmeTFycSxICNNFcz9jGyDKZAtW7Wp6RdecJ0ZVh0oynSSTtKpLg/fwGxzvAco7
	 2DO3VoevcVs+A==
Date: Mon, 16 Nov 2026 21:01:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 09/15] s390/cert_store: Fix error handling of
 get_user_session_keyring()
Message-ID: <avtS7my9DRVFxMF7@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-10-hca@linux.ibm.com>
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
In-Reply-To: <20261116143534.158375-10-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:28PM +0100, Heiko Carstens wrote:
> create_cs_keyring(), cleanup_cs_keys(), and find_cs_keyring() all pass
> the return value of get_user_session_keyring() to other functions without
> checking it. This can lead to dereferencing an error pointer.
> 
> Check the return value before using it.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index aefbefb40c74..d11637c85063 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -361,15 +361,18 @@ static int invalidate_keyring_keys(struct key *keyring)
>  
>  static struct key *find_cs_keyring(void)
>  {
> +	struct key *cs_keyring, *us_keyring;
>  	key_ref_t cs_keyring_ref;
> -	struct key *cs_keyring;
> -
> -	cs_keyring_ref = keyring_search(make_key_ref(get_user_session_keyring(), true),
> -					&key_type_keyring, CERT_STORE_KEYRING_NAME,
> -					false);
> -	if (!IS_ERR(cs_keyring_ref))
> -		return key_ref_to_ptr(cs_keyring_ref);
>  
> +	us_keyring = get_user_session_keyring();
> +	if (!IS_ERR(us_keyring)) {
> +		cs_keyring_ref = keyring_search(make_key_ref(us_keyring, true),
> +						&key_type_keyring,
> +						CERT_STORE_KEYRING_NAME,
> +						false);
> +		if (!IS_ERR(cs_keyring_ref))
> +			return key_ref_to_ptr(cs_keyring_ref);
> +	}
>  	/* Search default locations: thread, process, session keyrings */
>  	cs_keyring = request_key(&key_type_keyring, CERT_STORE_KEYRING_NAME, NULL);
>  	if (IS_ERR(cs_keyring))
> @@ -379,7 +382,7 @@ static struct key *find_cs_keyring(void)
>  
>  static void cleanup_cs_keys(void)
>  {
> -	struct key *cs_keyring;
> +	struct key *cs_keyring, *us_keyring;
>  
>  	cs_keyring = find_cs_keyring();
>  	if (!cs_keyring)
> @@ -395,21 +398,26 @@ static void cleanup_cs_keys(void)
>  
>  	keyring_clear(cs_keyring);
>  	key_invalidate(cs_keyring);
> +	us_keyring = get_user_session_keyring();
> +	if (!IS_ERR(us_keyring))
> +		key_unlink(us_keyring, cs_keyring);
>  	key_put(cs_keyring);
> -	key_unlink(get_user_session_keyring(), cs_keyring);
>  }
>  
>  static struct key *create_cs_keyring(void)
>  {
> -	struct key *cs_keyring;
> +	struct key *cs_keyring, *us_keyring;
>  
>  	/* Cleanup previous cs_keyring and all associated keys if any. */
>  	cleanup_cs_keys();
> +	us_keyring = get_user_session_keyring();
> +	if (IS_ERR(us_keyring))
> +		return NULL;
>  	cs_keyring = keyring_alloc(CERT_STORE_KEYRING_NAME, GLOBAL_ROOT_UID,
>  				   GLOBAL_ROOT_GID, current_cred(),
>  				   (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ,
>  				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
> -				   NULL, get_user_session_keyring());
> +				   NULL, us_keyring);
>  	if (IS_ERR(cs_keyring)) {
>  		pr_dbf_msg("Can't allocate cert_store keyring");
>  		return NULL;
> -- 
> 2.56.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
