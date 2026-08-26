Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A11418361
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752295; cv=none; b=XLEuu/E6h4DHV01RBabrNfIfIl/AOBvWIGziXrrSghi0CboVlflj7RJ+AGBPGNCG3OcMbyPGWV6LtNCMONxQxA53WMD6cI8Ew731sTmgFcGlLP4WnqHaMyz1z7vRIMu2umdXABDGGzBx72qoRWgJU9PhBnfHr/9MnMRnkHMLfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752295; c=relaxed/simple;
	bh=GOJBK4KjmDRwrsZszZM/3pZrl7B4ObB4TfR03fGbO7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kREpSnHIUEP+j8tNUdTA8DXDbNK7QpoXNGoBtte1GSl1sGVOnbohRQ2G5CUAC8kvcDTnla7GVp5fM+oOEh7SBdRP05NsOmo23QwTYEvhWCLsPfjdpo2DpU1RpHGK4+Ntd7uA0Lz8Stiim0Z8nU0O1KE7gnlOYqoTBJ3ks+QWN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APu2NWh4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APu2NWh4"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-482db627cd8so313049f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787752292; x=1788357092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e97wIfCHFlP2bmONNa4TZ5S7wpl5GPpCFNecvYTBfXo=;
        b=APu2NWh4mHpt6KNmVKwwmRnsbsJBSiF7cXKivxIku1ucmTvKqvJ0edCIE6tz4mvVq3
         icAXfowzBhws6K/m6eHo4jMHkgLXrx9o49z1N54tcmp2oRmzAWzbXIzzdObwl195J3GK
         Zi7Ig2gDXnZVufDXCwD7zVZc5BfEveOoy9oaA786Ka9kbuLwlf8CKnwPuCLdPEM1yo+C
         FqKsH+icCPLTHxfQnGb9FvdDYk4sLuPNrH+8TV+OJb0/pweZCRt6FLAdE0vwT30icjWv
         5YbNDz4610Fy9mT2pySNeCbOSaAE9oBRYtLJRlTC/sMpYod2sh6E3QkljoTdz0v6Lra3
         iixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787752292; x=1788357092;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e97wIfCHFlP2bmONNa4TZ5S7wpl5GPpCFNecvYTBfXo=;
        b=iYYAtv/ulqrdAQ9D2J624/ZntWWTU0D00HHaG85xmycwUccUU1NU+IW+wdY3YQq81N
         yheZ+c6TgIkIATOgR/jszCD53L6Vi8/Bpi8Q1DOK37XVRsv0oBU7HxZuUumvcjO79Tyd
         Eb0JHP+A4IgIHMzPHJzu+BbW973JvibFr020EtkqZo8NKVedZ+wiu9E7uzMaieoE8pxO
         oOu5ALM9iq59znm9xeuxxzTDKUnG0xlEgLYAljBaIS88FczS2NtK19eel3UN91vFY1sO
         FX0gKLIS3RPpqQsl3g5ok9aU3PTsLR0KfqGP2JCih+lm1T8BH9yPf2Ku/MLqn9x8cWPV
         XKsA==
X-Forwarded-Encrypted: i=1; AHgh+RoWu+51v4tzwgu4rmtGn/3soubGXB/fpUJpEgM4R2MxMLkwIDpRIa11Fri66yX40yVEKij0pFL0ZJ2F@vger.kernel.org
X-Gm-Message-State: AFuF++k3sTJudz0PrjTzIr5xI4cqTetvuVRsVQuyqasoSrDrfpwzBEbg
	X7HZvgB3J5kc2MPH+XMD6Y6rDoHGVMt6O8IkonY3iGMOeZqYUhGdtWHZ
X-Gm-Gg: AR+sD136h5xpU2e487GEWnJ5xvTPJXaUmC0CQvKC4BNwsUrmq62YIsvi6eFcHtxLpYF
	4ASoaANggz2MCxzY9AMAGSRYUsl10NKOg1MXkGjdUhMsztYnvghJoIZblNMwyES6G5R/dYtBCBF
	BBIxh6qTM+i+tPfw/xRlATOO1VWVoRTajs+CJS/T2sGuzm0f7cdsa2wTQBeB5GshPsb3JwykOJK
	+9fUpeEk9ouMHZ+b9KCXu7hKKTyTe8ktU8AhcXS5B5ZEalPM/uex/JZqWPlTzBqyflwfbLmrfeh
	WvD+IuVGw+NQ1OamySaHEgp5d0sUKxo31FT15KmdYy3ZnPwh1HbSBt9PsOFg2STViPh7HVWcPVh
	jtTMQR+Qeyb3fJaodOYJY7xj9zbmRv2MXGQWUl3CzRAX0tPzpTlPUjo9j/t9XVyzqdXfpSf/2P7
	nIG+O7dwlSy812Os+AbmY7Q0WOCis4apwDnFBi4IxugXjBC3dciE3Iq6dsc2da8bhPCw5OQVu8f
	Fm+K+b36Cty1VATHfxJgs8P+SY=
X-Received: by 2002:a05:6000:4690:b0:482:ea08:8c97 with SMTP id ffacd0b85a97d-482ea088f62mr942737f8f.2.1787752291706;
        Wed, 26 Aug 2026 06:51:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27a9f0esm2851620f8f.10.2026.08.26.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:51:31 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:51:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Warn if kernel command line contains
 non-printable EBCDIC characters
Message-ID: <20260826145129.204b6517@pumpkin>
In-Reply-To: <20260825150840.537653-1-iii@linux.ibm.com>
References: <20260825150840.537653-1-iii@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 17:08:08 +0200
Ilya Leoshkevich <iii@linux.ibm.com> wrote:

> Users may accidentally add multi-byte UTF-8 characters to zipl.conf
> parmline, for example, by copying snippets containing non-breaking
> spaces (\xC2\xA0) from web pages.
> 
> The kernel will then interpret the entire command line as EBCDIC,
> making it unusable. Distinguish this situation from the legitimate
> EBCDIC conversion by looking for non-printable characters and issue
> a warning.

Would it be better to check for the entire line being printable ebcdic?
All of EBCDIC a-zA-Z0-9 have the 0x80 bit set and most of 0x20..0x7f
are invalid or control characters (or punctuation).

David

> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/boot/ipl_parm.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
> index 6bc950b92be76..71c0c26d56bba 100644
> --- a/arch/s390/boot/ipl_parm.c
> +++ b/arch/s390/boot/ipl_parm.c
> @@ -173,12 +173,29 @@ static inline int has_ebcdic_char(const char *str)
>  	return 0;
>  }
>  
> +static inline int has_nonprintable_char(const char *str)
> +{
> +	int i;
> +
> +	for (i = 0; str[i]; i++) {
> +		unsigned char c = (unsigned char)str[i];
> +
> +		/* isprint() is Latin-1, and we need ASCII here */
> +		if (c < 0x20 || c > 0x7e)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>  void setup_boot_command_line(void)
>  {
>  	parmarea.command_line[COMMAND_LINE_SIZE - 1] = 0;
>  	/* convert arch command line to ascii if necessary */
> -	if (has_ebcdic_char(parmarea.command_line))
> +	if (has_ebcdic_char(parmarea.command_line)) {
>  		EBCASC(parmarea.command_line, COMMAND_LINE_SIZE);
> +		if (has_nonprintable_char(parmarea.command_line))
> +			boot_warn("Kernel command line was treated as EBCDIC, but contains non-printable characters\n");
> +	}
>  	/* copy arch command line */
>  	strscpy(early_command_line, strim(parmarea.command_line));
>  

