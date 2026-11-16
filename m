Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858257;
	b=MLhyzf0kNmRU+fq4SFOE41Jjwq5pJ2N1rbRfciip7py1JLxLYKDgxSTk7TC5c0tKtj4f
	 Xg8IK1o/KUwJw/GVL+VdWUzvgKNo+uf/OgX2KcJr4Dpa8DIiFaq5dhipx8BPn5yiLpnuu
	 b7h9GFd3XKqLF708t6H1UHSTJBWbcrUN3bBGifqx1NUtRePcVFCYAie9x6ocBA8eNH/Cr
	 HAvwJJWh0GKVQ72p1Ki8Leb278Aj3tpTHPIZOTLo/zQNzY23h6L3loLHdTE1+m4sPLqvh
	 khXcU2tr8qHd0rWflM/B81XeiKGBUiIVlqnQrkMbnxOd96LqQ+utKTlguDAcls1Xajw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858257;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Nj//MY1klixReHhr5EQrz2kM3vh14KTz7P5mfvBMhRE=;
	b=nzWC46I4wADoyWHi/gB5+SOeHS+JjbtVfNf+XZWzMYMkPGto3cbxAkLcq2/IcX9e2Huc
	 AvP+lons8nnZjSlD5ldbUtc+TwrlsZuiuIFjGTRJgPd5Q4tJzbPhvj4EWneNJxyCs/X7e
	 3VQ5X4KKPEoflxccwenxMEQmFxNYYxt5rFNHuhDtv42Vl66mTabuhkFqzvFbOohc/AATz
	 mZtFRMRbJXCc9s34WDg/75gAjURQaecsbdLpYMXSx/95TKWikYvAKeLQ+cEAPRxU5KYLj
	 bUXKHSCMO0UZRCBOPwKbkfBsVEPsTkq3jFfPDlbTsZah/AoMDir0URsnfsWUdHus/AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REhvNARK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8629E606A31C;
	Mon, 16 Nov 2026 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REhvNARK
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 924EF1F000C4;
	Mon, 16 Nov 2026 19:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858257;
	bh=Nj//MY1klixReHhr5EQrz2kM3vh14KTz7P5mfvBMhRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=REhvNARKxEw6r7b3GHQUsU+v6ZWtOwzAYDqkGsl0MWDmMxatmvyDEGGMEBGCiVheG
	 DOYl60h0bjBZK9hc7q0Doi9mWV3mBQ0OUwUQIKlUbAmsnfOI7mGFM656FIxIpCOfKk
	 /juMaI/c07x6c4ms4aDZpRas06FM5JIN0VptgtZBDnIWBbnQ87+DiIvJOMkOI1ziPb
	 Wnb/2dAgf6r9mJe2yCGoLaVWISwmNMornMDJtdrnIH/66uFCu20O/QGmIjhxYJGgG2
	 S7vC5c0foL5ZLC5dy51TJpu/73Sy++XXO7J8gM8xl69GkimkvqkmrChcSQDU42Krod
	 /g2gUng8H2rGQ==
Date: Mon, 16 Nov 2026 21:44:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 02/15] s390/cert_store: Fix return code handling in
 invalidate_keyring_keys()
Message-ID: <avtdDc-udpCcf9Pc@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-3-hca@linux.ibm.com>
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
In-Reply-To: <20261116143534.158375-3-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:21PM +0100, Heiko Carstens wrote:
> Add missing error handling in case key_type_keyring.read() returns an
> error.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index d35b1ea22507..89cc3a1683a3 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -316,15 +316,16 @@ static struct key *get_user_session_keyring(void)
>  static int invalidate_keyring_keys(struct key *keyring)
>  {
>  	unsigned long num_keys, key_index;
> -	size_t keyring_payload_len;
> +	long keyring_payload_len, rc;
>  	key_serial_t *key_array;
>  	struct key *current_key;
> -	int rc;
>  
>  	scoped_guard(rwsem_read, &keyring->sem) {
>  		keyring_payload_len = key_type_keyring.read(keyring, NULL, 0);
> -		num_keys = keyring_payload_len / sizeof(key_serial_t);
> +		if (keyring_payload_len <= 0)
> +			return keyring_payload_len;
>  
> +		num_keys = keyring_payload_len / sizeof(key_serial_t);
>  		key_array = kzalloc_objs(key_serial_t, num_keys);
>  		if (!key_array)
>  			return -ENOMEM;
> @@ -334,6 +335,7 @@ static int invalidate_keyring_keys(struct key *keyring)
>  
>  	if (rc != keyring_payload_len) {
>  		pr_dbf_msg("Couldn't read keyring payload");
> +		rc = rc < 0 ? rc : -EINVAL;
>  		goto out;
>  	}
>  
> @@ -345,7 +347,7 @@ static int invalidate_keyring_keys(struct key *keyring)
>  		key_put(current_key);
>  		rc = key_unlink(keyring, current_key);
>  		if (rc) {
> -			pr_dbf_msg("Couldn't unlink key %08x: %d", current_key->serial, rc);
> +			pr_dbf_msg("Couldn't unlink key %08x: %ld", current_key->serial, rc);
>  			break;
>  		}
>  	}
> -- 
> 2.56.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
