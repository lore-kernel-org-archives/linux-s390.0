Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A82D1F44
	for <linux-s390@vger.kernel.org>; Wed,  7 Jan 2026 03:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767757728; cv=none; b=ISFyxVu/XIgGDfiboLG1rpIvqw6UisfBHbg4rWezbSuY4sibd9HK0UmAycpBDdDauQrkizZKv2CDM8SdpzgD4urW0DwfADkyIHiD7CCoiqFy0rx+iKMUHYiDe4McJbQY1vBgeZCRL01qkLUvGBR1dFeQpTWZA70Xm4doy3N7quU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767757728; c=relaxed/simple;
	bh=7b6FVIVpJo+xA4SNmeOUyxog3DMDCGrnHY6W6wXIjPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzYzHPULg9Xm4ZsC48YN+TUFV8dwTDwfEWbmxC7nurPup7TuBur5j/OciS346f0QFhT2MeT5A9gB4dH5AeEaNFahmFeUewhXEg7UiB+eDqMY/QERRohsDqGfKlIsZ2sR8sjzJbtbhNZyaTUNiuTi+AZiY8i6XOusbGCi1+/NvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuyPj14X; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuyPj14X"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ae38f81be1so1083802eec.0
        for <linux-s390@vger.kernel.org>; Tue, 06 Jan 2026 19:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767757726; x=1768362526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVfOOsMtVesahSpJ7NzEZB2a7bFJ+2QiFmRNgCZu9gM=;
        b=iuyPj14XKkoWH9MWkyK+ItoYjysm2xwZQnqd3XHofHxkQDmMGac9oSzcLBYDBeqLtz
         rM7Y05s+Vp6JPcTNmWjefnB/fGHoe5JvPk4EfglNeWSJ2uMUZ3hNg2M4jQmaQCVwWHwp
         PGn3RUeyEAQNdEzO2/KVXwyL7JmHDrVE+K0Ku6AXrcedu6MmC7f7MYeRluE5+IoOQ0gE
         M3aTso69uZ2l50bovlSz+mHhtXJXkrK/nwTmuyToO6Vm0V7sg7wCAM2ZIhjKOUJrY95g
         RPMB5Gryt3l8LxiQDX/ReWMNTbZuoWRjqyfyqMQEanatzzhStz8WxxAuXQT6R1EpDCLR
         8CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767757726; x=1768362526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVfOOsMtVesahSpJ7NzEZB2a7bFJ+2QiFmRNgCZu9gM=;
        b=Qc8pGRwqQHeYMImIMSnryC2dxKG/DP2B0FSrzFOCl8WQXnlo2K/KoDamppBAlZYoRS
         KE9zFelGjRS+x7ad9vimvhSb8WZaiDbWo4BUIlm2spO11xuk24sisIVgjlu7LJq4pSj9
         1nEMtQzprGXxBesEEHHQ78n+zjDPBE9WZnPYv9vmPjxkehb91Kz7Vlk8yXaX5ZVerlIc
         RpP5bq4TcPg6v/PZ7rOtkiBG7vzSlwXHwA8MUg+VlXbY2onNdZVpY8hxBWKL1d0Fw4op
         A69wz1Rn8zIO20cpL28xWBVYFW5tTPG2Q7r94d+NxVqETwBtyAXxlyzE7bNF5cEGmLL3
         eiVg==
X-Forwarded-Encrypted: i=1; AJvYcCWF6JOy3apEXcdsYB2PuEIrnegUVQkzsdgj8PAtc8Rhw7D6ruT7ADrkoND9qltDckErjrTFhv+xK8EJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLMf+CN8DbJI2XjQr6zK2SulRUjd47hxmKQNOHGVE688PYrVY
	q+RDAvGL7Z+6egEjg3wKHTmAMaBE2mecr17kF1hpNuMOKL3QKLTxyoLt
X-Gm-Gg: AY/fxX54h+5vBoxqicoxHcEfEBPz2sYc0FAsxAsNcgmTJtDE+MYKB4yarK9/o5DmYuz
	aIj2UGki3cNUED/HvrU3Pfx2yBCfAXz2fCBrMmrvC+29ufDAivgywmc+IIH7gz8kYqGZe9NGHZ8
	Xor41FFqeW2cV8gC3u+mgn0s6ummbz+jsspUcKlKgH8HA0oo9l11RFh6ZXaEUjA0rkDlc58d4ia
	pMboRQEylS2/a362hI2YYPFgNZ+zENPOYgwE7de0S6XBjlbyJkDMNW+pOT+wrA8uyQO8mwHA9fH
	/uktGbkLEudXclA5h7X0yRZ15R0jtH8hveUIEZzZ2y0jeAUjQ10hDwQyl2pTKuGYgM3O6VE0iii
	443zE0wUrmlHWfz0vkDwtjktlzObQ/Enun6F/BDgts0aUgHMl3kFz1bEBk4oEOaA=
X-Google-Smtp-Source: AGHT+IH/ZbpZvf+ufhdSrgq15FQAA5DMOGdsUeBWMvuc3LZNVn+XAns8eGMqcOV8TZ1Q54ktkq+I7A==
X-Received: by 2002:a05:7301:578d:b0:2a4:3593:c7c5 with SMTP id 5a478bee46e88-2b17d1f058bmr978905eec.5.1767757725777;
        Tue, 06 Jan 2026 19:48:45 -0800 (PST)
Received: from gmail.com ([2a09:bac5:1f0d:28::4:33f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b2256sm5392191eec.25.2026.01.06.19.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 19:48:45 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Holger Dengler <dengler@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH 30/36] crypto: inside-secure - Use new AES library API
Date: Wed,  7 Jan 2026 11:48:33 +0800
Message-ID: <20260107034834.1447-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105051311.1607207-31-ebiggers@kernel.org>
References: <20260105051311.1607207-1-ebiggers@kernel.org> <20260105051311.1607207-31-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  4 Jan 2026 21:13:03 -0800, Eric Biggers wrote:
> --- a/drivers/crypto/inside-secure/safexcel_cipher.c
> +++ b/drivers/crypto/inside-secure/safexcel_cipher.c
> @@ -2505,37 +2505,35 @@ static int safexcel_aead_gcm_setkey(struct crypto_aead *ctfm, const u8 *key,
>  				    unsigned int len)
>  {
>  	struct crypto_tfm *tfm = crypto_aead_tfm(ctfm);
>  	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
>  	struct safexcel_crypto_priv *priv = ctx->base.priv;
> -	struct crypto_aes_ctx aes;
> +	struct aes_enckey aes;
>  	u32 hashkey[AES_BLOCK_SIZE >> 2];
>  	int ret, i;
>  
> -	ret = aes_expandkey(&aes, key, len);
> -	if (ret) {
> -		memzero_explicit(&aes, sizeof(aes));
> +	ret = aes_prepareenckey(&aes, key, len);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr_dma) {
>  		for (i = 0; i < len / sizeof(u32); i++) {
> -			if (le32_to_cpu(ctx->key[i]) != aes.key_enc[i]) {
> +			if (ctx->key[i] != get_unaligned((__le32 *)key + i)) {

"key" is big-endian. Casting it to __le32 does not seem correct.
Did you mean "get_unaligned_le32", which also convert the endianness?

>  				ctx->base.needs_inv = true;
>  				break;
>  			}
>  		}
>  	}
>  
>  	for (i = 0; i < len / sizeof(u32); i++)
> -		ctx->key[i] = cpu_to_le32(aes.key_enc[i]);
> +		ctx->key[i] = get_unaligned((__le32 *)key + i);

Same here.

>  
>  	ctx->key_len = len;
>  
>  	/* Compute hash key by encrypting zeroes with cipher key */
>  	memset(hashkey, 0, AES_BLOCK_SIZE);
> -	aes_encrypt(&aes, (u8 *)hashkey, (u8 *)hashkey);
> +	aes_encrypt_new(&aes, (u8 *)hashkey, (u8 *)hashkey);
>  
>  	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr_dma) {
>  		for (i = 0; i < AES_BLOCK_SIZE / sizeof(u32); i++) {
>  			if (be32_to_cpu(ctx->base.ipad.be[i]) != hashkey[i]) {
>  				ctx->base.needs_inv = true;
