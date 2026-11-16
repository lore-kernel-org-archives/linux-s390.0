Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855724;
	b=RbNeXW54w6hQbWr64Bk5mHdAFfyhOh5B/CQIBLhJriFieSTI17DbZ/Cm1yv0GkxuUqPq
	 XWi4gVLa07nulLKpQrQnlw0cV9tKO2AiGZLemRDpfKApqWWJdkSzqUFdFmF/egz9IB0s2
	 j5zklTgbiPDQ6Iu5eIcMCVrHrBC3ULyJjk4HCAieuBSh3EuYujf7a4t92DoDpJsxlIBK2
	 RoXnoeZ1mzQRR+tJRqqzvWwv7kNEZKAJdt/lyRwcNZFa7kuA+j/nEOxZc2+L/HEdCGyX8
	 17fuflKdI/42shkeq+EFuqStTg72k/VvN/Vr9zQLUqliVt+WGxjgrUERw0ZaMAg74nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855724;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bwytYs5NRmKMFLgLTgesctAAqnQss7rwPl3d6Mhyn/U=;
	b=13cHxr5B1Qr8ABoOjBiRoXcd8UkGkkcj1wEHEiLcMjrlCXi1m8cuPKXh3N32WShaXqgo
	 XlMPSb6JlKtGCRGrstRPP//zRdELcaRle5k6/cFcSyPwiZwH2k0w9muaJadmrtKfqXwnV
	 2/wbtzNfD4SLeBRTSXS4Rn6jci7+Z4Wxav5uB0/wYXx2lrjS70z+phDY54UBmMp54g/XQ
	 xetW/FtdIbn8DGFd3x48dIerPQJxkMjDH7wC+vo4BwoNncm26XzicjjesKOOyDBpS8pQN
	 XZBew0lIkO1aZDNvXZGqan1XeIUzFZiP0aY1VJW1aaZn6HLlFzK4QsXe0t/ovt+nJLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnXUSXqu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 93630606A33E;
	Mon, 16 Nov 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnXUSXqu
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AA5A91F000C9;
	Mon, 16 Nov 2026 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855724;
	bh=bwytYs5NRmKMFLgLTgesctAAqnQss7rwPl3d6Mhyn/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lnXUSXquO0oihUHrq1aTCJB7tCWlzZHuWccxeFfubFeMwrlkFaHr+E87eZe7GYf5c
	 7OlzazO5j3GmH/VZNOVNJZQUBC//Hc8nY3NgoQEy9HplsvHCUmL7OKjB9PFRjoOEMz
	 F0CXTHBTg1M4AskUyh2QUK/+yy4of+qUXuZJea36yDAa9ZlVtyrWmbJkavJOO5m9bb
	 LcZ7Qt5aCA73rcZBFAVkXBkCnH1F94xmP7Hv3L+C6KDfQZPYwCxsPKbPAUBk739/D8
	 9woSrREZGKzhVaGx6Ol1URlkvPv348tNgzkdC77FxOdUB+ZiIXPhfaT/Kle6X/Qf0s
	 vR7wADzSLySjw==
Date: Mon, 16 Nov 2026 21:02:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 11/15] s390/cert_store: Do not search the process
 keyrings for the cert_store keyring
Message-ID: <avtTKGLazlUEmQOh@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-12-hca@linux.ibm.com>
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
In-Reply-To: <20261116143534.158375-12-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:30PM +0100, Heiko Carstens wrote:
> find_cs_keyring() first searches the user session keyring for the
> cert_store keyring, and falls back to request_key(), which searches the
> thread, process and session keyrings of the calling task. Any keyring
> named "cert_store" found this way is accepted.
> 
> cleanup_cs_keys() then invalidates and unlinks all of its keys, and
> clears and invalidates the keyring itself, without checking permissions.
> If the refresh is triggered by a task which inherited a session keyring
> that contains a keyring named "cert_store" not created by this code, this
> keyring and its keys are destroyed.
> 
> create_cs_keyring() always links the keyring into the user session
> keyring, so the first search is sufficient. Remove the request_key()
> fallback.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index ec6352528a2b..551b538ea930 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -360,7 +360,7 @@ static int invalidate_keyring_keys(struct key *keyring)
>  
>  static struct key *find_cs_keyring(void)
>  {
> -	struct key *cs_keyring, *us_keyring;
> +	struct key *us_keyring;
>  	key_ref_t cs_keyring_ref;
>  
>  	us_keyring = get_user_session_keyring();
> @@ -373,11 +373,7 @@ static struct key *find_cs_keyring(void)
>  		if (!IS_ERR(cs_keyring_ref))
>  			return key_ref_to_ptr(cs_keyring_ref);
>  	}
> -	/* Search default locations: thread, process, session keyrings */
> -	cs_keyring = request_key(&key_type_keyring, CERT_STORE_KEYRING_NAME, NULL);
> -	if (IS_ERR(cs_keyring))
> -		return NULL;
> -	return cs_keyring;
> +	return NULL;
>  }
>  
>  static void cleanup_cs_keys(void)
> -- 
> 2.56.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
