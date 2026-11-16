Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855604;
	b=Q4Ol0XPkMXVECsUcmHz8MbXz6ofgZtXnvvWtTFKcuWcTeQ0fvZ+8ZLBil3pKbLvHEfLj
	 Xzm0pby25u5wnHPM4GggyEFV+zNMcTpNPJFiOMji4PNGexUCa8UWqrIDzVl1GG/L9uOSR
	 ZW7rDFJhFpp4r4Urb5xdMEoqU6VrDPl70TALXZixbrLytd5U8o1D91fywwOk9l6Ev9val
	 z9EGrYvuFjHb/51U093+6XhL2F0aC9lHw9P3fi8+FPPXkjKxX3vxS/8ZTmLeEzlLsrTgX
	 LfXbTmj9gzJevp3qeCIq4TgYukqat5Ir2EDuYSLefReQ/+CZRsxQVOtKu5Ccva40ySQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855604;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LYejKMYBQmJkNXNhWvrmTG84NverDard2JGkRnE3Zfo=;
	b=y3hfOakJCg0GsO/RcMOzrAkss9er6agHFE91VULfZ0kKKcBWKDrWROAxijKgIy+OMNPh
	 DFGWHDBcmsSCA8d1YXxinPVUIVG7ZVBZE4gdwRdReuJL31cMnaN+GqvrDv++Z893BitfX
	 ffTiz/cieRgfYpvwi1kigm8uzx3IJh5tpU5rXPqLNLppMIVMq9olc6H1dO/W+ab95M/v2
	 Z/dwYS+LVgKhzUMpCAIfAELJ4US0HxIbb2bjt9mO+yjCR2ihZW+Ii+QbO2/OcILcts0xp
	 ZLexVrw2TJKgv4Yynr70WcfScuPCdXsaXFrIKVVuJWQEXN32lbJLcWKNbY9r/lpyeog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oStAhFfY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3F4D5606A33A;
	Mon, 16 Nov 2026 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oStAhFfY
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B755C1F000C4;
	Mon, 16 Nov 2026 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855604;
	bh=LYejKMYBQmJkNXNhWvrmTG84NverDard2JGkRnE3Zfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oStAhFfY28fNnStigbBA4HW05/I8lwbsBltRkXjT0XyD5MCNDB7ydW+kZcS5rCOX0
	 iRIH5CctPR7ojCgsPzCr3xE2uTTYH5TZn5cqQsAXjwSsFZFp8oUf+m+4zMyJ47QaBd
	 /f4RQdfXs7QjL3HyFQfUqwSsth0cgzaSgk80Dvf1jvvAxVe9IYnAf1hOW1as6weekN
	 CHfPVI3KTnDyZS0RybCIqyGsRRh7o9MqOxL0VpIzt1haSY36R9qgzO4Lu0Z796ZSOX
	 9yMjXarms6bZJ0wqIl0E4SBOW8qMTXfd/hoQBO1YFATOMBB4dZ2iifTGVQfzoAdWpU
	 RS0AJd/R1n1RA==
Date: Mon, 16 Nov 2026 21:00:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 08/15] s390/cert_store: Remove unnecessary static
 specifier in create_cs_keyring()
Message-ID: <avtSsOivOXPhKZ-w@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-9-hca@linux.ibm.com>
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
In-Reply-To: <20261116143534.158375-9-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 03:35:27PM +0100, Heiko Carstens wrote:
> The local variable cs_keyring in create_cs_keyring() never reuses its
> assigned value, therefore remove the static specifier. Callers are
> serialized by cs_refresh_lock, so this does not fix a bug.
> 
> Even though this is not a bug fix, this contains a Fixes tag since other
> commits require this as a prereq.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/cert_store.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index b720dd26a557..aefbefb40c74 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -401,7 +401,7 @@ static void cleanup_cs_keys(void)
>  
>  static struct key *create_cs_keyring(void)
>  {
> -	static struct key *cs_keyring;
> +	struct key *cs_keyring;
>  
>  	/* Cleanup previous cs_keyring and all associated keys if any. */
>  	cleanup_cs_keys();
> -- 
> 2.56.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
