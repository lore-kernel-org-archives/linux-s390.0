Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857247;
	b=N8iDNT44J8G9KIF0Hj+Z/AJEFElybXGwIehIsD+pcD0cHWEUqLZUCkiPD5m9X2UU/Br+
	 LJQNVmVSxEqNlqUqRyukhNQ22UoRD1mboNrJ2xkcTct2yMoYBrc8AQsBKAhQOqrfy9Vxh
	 81A3i2AHZ6MlsQZElnS3fgsp8GrZhW+DxAk/lod4utp+X5EU+gmN0vcxojuoAdPA9rzj3
	 DuXkXzTiOOzsh6MCjZzSB4MHYU3lusTOFSpXlLGkt62LurFQlrqaYtIteeK/yiBxR3CJM
	 myT07/mVRAhUYyGP0VxJRT7FWm1F8CcNTYMeEAIaBZASQyUotGDL+Q8jKCd0ow2TvXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857247;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y7RZvtNOq2EyIwUIxQJHNYHE1gyEcNzlMgno1NCIEEI=;
	b=F8Jru3FhCz1DcBM9sJxdHIFBkuuHfZZkXTGJyEXwf2GDi/6uHHQyU7g4e5/aknPT4fnG
	 zELzmiaQy8xWohjjcTckKQbyMpg7DMrg9BM+gtJLWP6xqG6uXI4JZAuERY60ZMVUXX0gW
	 axthmC7n4+9U/xrxWYhoPMHf4j8PTFDLFAQmk+fvdpQ1LWj1402xBf6XNa/QvYyhwIHuP
	 pvQAleaeNALEIhCknwab04z0QM+iMmIlXnl8pD1HbplS7kONQ+nQFf+AHLiobxvplT15t
	 OpJuoVmolvS2Z7da6hOGjswFamg81Y8eo5QKfCTo/4G4Doz/oKDINHEZ+fRAUrJ4SXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7Bk6PqV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E5F87606A322;
	Mon, 16 Nov 2026 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7Bk6PqV
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D593D1F000C4;
	Mon, 16 Nov 2026 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794857246;
	bh=y7RZvtNOq2EyIwUIxQJHNYHE1gyEcNzlMgno1NCIEEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R7Bk6PqVNK21uwxd8wl6tZRCqFiVcoBOoe4qBKtGw0ALALL44Pzak5kBo7Tzagt+g
	 mCYBk+MV7lpmm5HkJUAcooMPamqA8uUsbMBusx4hvMbeicXCX4T0f6j6bVS6C4x74X
	 /TkUD1VeuZf+28fm5jjKcrQXI1N3wx+ThL3PdBttHFU3RknxBqzK53RPQmtrMHxZNR
	 gbRB1NrTFZ94yZ3Tc/SEinekdqSPdIXOiUpqEEtQg+fE0u4yHQRR6+dFM+FlRnPzqL
	 aX+xodJuwEq+5pKKmspNl7zP1EE9u433543oOskYVPtumWBLDd8DzrPP/9pxe365Uv
	 jR0keZBNhXoQw==
Date: Mon, 16 Nov 2026 21:27:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 12/15] s390/cert_store: Validate hash length in
 check_certificate_valid()
Message-ID: <avtZGgO0DtD8Vn9Y@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-13-hca@linux.ibm.com>
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
In-Reply-To: <20261116143534.158375-13-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:31PM +0100, Heiko Carstens wrote:
> Validate that vc_hash_length is SHA256_DIGEST_SIZE before checking the
> hash and use sizeof(hash) in memcmp(). This avoids an out-of-bounds
> read if vc_hash_length is incorrect.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index 551b538ea930..ecfb7641d427 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -261,13 +261,11 @@ static int diag320(unsigned long subcode, void *addr)
>  static int check_certificate_hash(const struct vce *vce)
>  {
>  	u8 hash[SHA256_DIGEST_SIZE];
> -	u16 vc_hash_length;
>  	u8 *vce_hash;
>  
>  	vce_hash = (u8 *)vce + vce->vce_hdr.vc_hash_offset;
> -	vc_hash_length = vce->vce_hdr.vc_hash_length;
>  	sha256((u8 *)vce + vce->vce_hdr.vc_offset, vce->vce_hdr.vc_length, hash);
> -	if (memcmp(vce_hash, hash, vc_hash_length) == 0)
> +	if (memcmp(vce_hash, hash, sizeof(hash)) == 0)
>  		return 0;
>  
>  	pr_dbf_msg("SHA256 hash of received certificate does not match");
> @@ -293,6 +291,10 @@ static int check_certificate_valid(const struct vce *vce)
>  		pr_dbf_msg("Hash type is not supported");
>  		return -EINVAL;
>  	}
> +	if (vce->vce_hdr.vc_hash_length != SHA256_DIGEST_SIZE) {
> +		pr_dbf_msg("Hash length is not supported");
> +		return -EINVAL;
> +	}
>  
>  	return check_certificate_hash(vce);
>  }
> -- 
> 2.56.1
> 

I'll stop here :-)

Br, Jarkko
