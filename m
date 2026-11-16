Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854703;
	b=31nyTCAaWOgG+i14nqs+zRVqFGZnmKl5CwfombK8GwpOZGOwjXjEmZajwLOxHPXytICH
	 1+kQTbgFLspArYzFX48z+ujZMWRnvI+O0gX9Y3EumowwzufSsr/c7nkphiVFlK70mQYuw
	 IKIjQbrEQ9xrYdD0fi5hb75uxhtA59CWrv/xWF6tyzll6AGV7atJNp6JXeS4tjN6L2jBB
	 uVjKQEQ6aLFp7Ty4JZg2j8lvSmw+xxo7vM4Prt00LGWRryL0wid0n2GGFQI6xOaJR0ZHs
	 6Tqd1/Wv/eCz5vDyiHLPTN5HWWRXzRQG0F488CT0c/bVhHuCmaIzjTzF50GMDwkHg7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854703;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RDbw5bW4eqI95VpsTXry4o9Z3EMsWjLMV7+HUlMV7B0=;
	b=p+4QcMTZb1RDcZBc+YzTFT2K66ApG+0NH0XhBpSes5n25nixmVGC7Dwq7yDPR/47chVA
	 LITU0md3NpReryfWJZicnd7W069qEia85s+QtUXCo0ra3xkqUBzP3GiPt3JxYT8CnB/YB
	 TBpcO/P4zHIMaWSwR0aUERHgOxEXBq5IqVrPQED1khZ1wdajVZmZWEFnT3Q9PIYiwnykP
	 Q3cJSQFBWZdHaTU6GoaRf+K87XEZ/UfTMUl+5OlN7OR8gfXT7o6rMMOUGy9z2dli0U0q1
	 Mr8jgfdszJ5SOEZmXu3sh4MObDxNUJ27PqRFDWM59qVyf9/zDg265/dwQlEbOW6zRBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvH2RHeG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E7BFD606A322;
	Mon, 16 Nov 2026 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvH2RHeG
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 258521F000C4;
	Mon, 16 Nov 2026 18:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854702;
	bh=RDbw5bW4eqI95VpsTXry4o9Z3EMsWjLMV7+HUlMV7B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nvH2RHeGYIzsD7hZZsiRAiMvyiXPkKE52F8mAaS/TlHxo07+bFotqXf54IZIWWlyx
	 1nqvQYAuGVP7a7foNttYzjdFVcQk3CYXYz80Cl9S/gU+WlSGBRZCMXV/RvemrxuefP
	 d7/qMjIVIYice7xDs+sAy40/jjhA1kWgR3lhU6yBIhXssgbJHigpyc6BBOhnniDbb5
	 tHaeYYqrHGAXbJqrpeFH0AaBuVRnx7AgPud7THURZfdbC0eqwZIU4TvWK5e3QSCZXF
	 Q7ug4oVWyOK8JVWojR2Wj1yK3vvy0GYJ/75/NH3lUit0e7Txkh5J3dnG1ACGx9pCoR
	 EyAVjPwjo4nXA==
Date: Mon, 16 Nov 2026 20:44:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 07/15] s390/cert_store: Fix potential use-after-free
 caused by find_cs_keyring()
Message-ID: <avtPK9FsNvLkCp9n@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-8-hca@linux.ibm.com>
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
In-Reply-To: <20261116143534.158375-8-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:26PM +0100, Heiko Carstens wrote:
> find_cs_keyring() drops the refcount of cs_keyring before returning it.
> Which means that callers operate on potentially already freed memory.
> 
> Let find_cs_keyring() return cs_keyring with a reference. Since
> cleanup_cs_keys() now performs a balanced put via find_cs_keyring(),
> remove the separate cleanup_cs_keyring error label in fill_cs_keyring()
> and drop the reference unconditionally instead.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index 386fe39fe8bd..b720dd26a557 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -367,17 +367,13 @@ static struct key *find_cs_keyring(void)
>  	cs_keyring_ref = keyring_search(make_key_ref(get_user_session_keyring(), true),
>  					&key_type_keyring, CERT_STORE_KEYRING_NAME,
>  					false);
> -	if (!IS_ERR(cs_keyring_ref)) {
> -		cs_keyring = key_ref_to_ptr(cs_keyring_ref);
> -		key_ref_put(cs_keyring_ref);
> -		goto found;
> -	}
> +	if (!IS_ERR(cs_keyring_ref))
> +		return key_ref_to_ptr(cs_keyring_ref);
> +
>  	/* Search default locations: thread, process, session keyrings */
>  	cs_keyring = request_key(&key_type_keyring, CERT_STORE_KEYRING_NAME, NULL);
>  	if (IS_ERR(cs_keyring))
>  		return NULL;
> -	key_put(cs_keyring);
> -found:
>  	return cs_keyring;
>  }
>  
> @@ -720,14 +716,12 @@ static int fill_cs_keyring(void)
>  		goto cleanup_keys;
>  
>  	rc = add_certificates_to_keyring(vcssb, cs_keyring);
> -	if (rc)
> -		goto cleanup_cs_keyring;
> -
>  	key_put(cs_keyring);
> +	if (rc)
> +		goto cleanup_keys;
> +
>  	goto out;
>  
> -cleanup_cs_keyring:
> -	key_put(cs_keyring);
>  cleanup_keys:
>  	cleanup_cs_keys();
>  out:
> -- 
> 2.56.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
