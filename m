Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840CD23E25B
	for <linux-s390@vger.kernel.org>; Wed,  9 Jul 2025 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088253; cv=none; b=WghuP0si2Zj9DnOj8i/7szGhdu3QRIuaLSaLW0uWyACEFYeXyE6EXOgUQa1GpxC2Qsd+MaSLYSEe8lUhKO32LuYbQUy4AmK8zlkghN5T+WINmfCBYxSVBAtvAxXHcAS1E1RWCJfZOQ+05paX6+KkqwlncdYDUWNzTtMwYPdGCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088253; c=relaxed/simple;
	bh=PmkYRiLMc5g+4nEIOXkTdL4lqElPgQEmy6qv9jf3/lM=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTzcBkEAVFFGRnYbwfLAv72BAOp0QJ9xba3nwFfH80nPm1EJaWF8cLoue9/kozSRg9fGw1hzF3kq0fvO8NJy9LbWtfrc0ePeTZxW5Tbpu8adwvdJtfL7vZknV84yb6omB+t3mjpf8PONmlUv/ZBqV6cERXyeochuFRjjHRRIcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS7LXKB9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS7LXKB9"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4f64cdc2dso34689f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 09 Jul 2025 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752088250; x=1752693050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4HYMfQVxot69EFTq0nmXg9Y09NJ5mR4ci3/uzyNYY0=;
        b=MS7LXKB95xdo8xgKf4XJhVu74yFVmFFtpseRqn/l8KwrosPXUCn6k2M+YdVsrqpjZW
         wv4FdoPKq9bZdRvedDjZ4NIms8uXLuYHRKiuhRdNTHYBJgo0n42kHI0jlHgbm+Jky2ZR
         wwmpxel7Mt+M9Wqnk67vnna6WOKOTzmBIfQQtr35pLJoI+ZFg/gaJ8WxP5POyb+8mpmB
         zc6bx9G+KQwpTwn1HMSviTZlv1hxF5bdqWHg8JZAz5pQqpyn+0lQ3epLzaZqIldxq3Ob
         Pj6KnQ6DAWx5p2EV2TebejmE2tuPfIAWEeVjYamJClY9GHwbbEoecZvsWi2XDy6JZBrm
         ScUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088250; x=1752693050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4HYMfQVxot69EFTq0nmXg9Y09NJ5mR4ci3/uzyNYY0=;
        b=tY3wKi5GYk0Qr17kkNRtgE2c72Vc6vzfAc0ZaJBMzARwSrBgy5VvypvtfscpFXl4kq
         Liij7wESA8GsGHCF5LLmYTVyksnzmNxfkzMcLLyZ3J+5NwCwBc9B4O5KQgCyvgb3QROQ
         xR5AiscAUw86fO3JuZyPHiu+jfrVk0W90AUYWfMwt5ikHxpi+M71ArNpAmQGQCz+ll9h
         JuRp5VxoZ52KtzZZ1UA3ndL+g5mdB33g4575ab19YYXGzfpyaiV9cRHMawBijkEWs4dQ
         E5kdYTKKzyyyTHW2Jq9JJp4oiOIsqWJnBUB8WA6t2KIsX2q+owh1X4P3W/3t6XDAK7e0
         e/iA==
X-Forwarded-Encrypted: i=1; AJvYcCVod8WIaavRwbqfafZNkTRLNypi9eQg0EbpV1d33DLMAXv9MeIAgQRDJ8fr46djlsI4E4jZ/sutictT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DtJKw03k/ZCmLYOCzBTEBwJPkLSsEyVYtcqw+9eiHWzXLcA8
	30uaeAT+YgvvXkR1yEpiAjBwajtqoU1AmAPZxgIN0oFPPMqq0SAZNog=
X-Gm-Gg: ASbGncuCmMhoLOML/LQBHCqDhzE0g01xPgOxlkbpQ+caDpITkYGSaZCocJNmisPdS1R
	oUA1HvLXHc76ZiXHimWJa28Ljd38CoUUyFb1q8Ga0Pt+3gwcgRzGjCgT++M8bBflVWkAfApm/os
	Ew2op0Uxr4z+fXmphbDUH75Z93TuUYFlVmh9ad/atHDI9oHJO6OAbES6odGof+QZ/UsVqT5BZZO
	os06kirMOOF63EGUfQFWUiJrLqeCJpdt6KciYjrOdIjWwymvUZRp9Jg+HfCfHJVr5cou54SPzwZ
	t2a1wbkveuQ08lqQdLCXwGlU5dnj91bi10stEGjmDhCZA9cvHZvKG72xe92xN9eWztUmOUTo6pp
	RPfs7cV1J+AiNYV7I4AdRgX0Ndw==
X-Google-Smtp-Source: AGHT+IE2S5xqyCNu8+bzdwbeXiYVmaFl/hERHsAfM9tILDxKS9v6LqI3Uyxc+tPN5bMFun9u+xnnTQ==
X-Received: by 2002:a05:6000:2408:b0:3a4:f912:86af with SMTP id ffacd0b85a97d-3b5e44d43b8mr1098209f8f.2.1752088249629;
        Wed, 09 Jul 2025 12:10:49 -0700 (PDT)
Received: from localhost (182.red-80-39-24.staticip.rima-tde.net. [80.39.24.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032e9esm35369675e9.3.2025.07.09.12.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 12:10:49 -0700 (PDT)
Message-ID: <250ea316-a699-4f52-bafc-1bbbb68f6f19@gmail.com>
Date: Wed, 9 Jul 2025 21:10:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] s390/con3215: Use macros for hardcoded values
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, S390 ML <linux-s390@vger.kernel.org>
References: <20250709180054.11372-1-xose.vazquez@gmail.com>
Content-Language: en-US, en-GB, es-ES
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <20250709180054.11372-1-xose.vazquez@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 8:00 PM, Xose Vazquez Perez wrote:

Please, drop this one. v2 is out.

> Similar as in sclp_vt220
> 
> Cc: Heiko Carstens <hca@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/2=50%)
> Cc: Vasily Gorbik <gor@linux.ibm.com> (maintainer:S390 ARCHITECTURE)
> Cc: Alexander Gordeev <agordeev@linux.ibm.com> (maintainer:S390 ARCHITECTURE)
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com> (reviewer:S390 ARCHITECTURE)
> Cc: Sven Schnelle <svens@linux.ibm.com> (reviewer:S390 ARCHITECTURE,commit_signer:1/2=50%)
> Cc: S390 ML <linux-s390@vger.kernel.org> (open list:S390 ARCHITECTURE
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
> ---
> Trivial, but uncompiled!!
> ---
>   drivers/s390/char/con3215.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index 56e43d43c713..1519694c48f0 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -35,6 +35,12 @@
>   
>   #include "ctrlchar.h"
>   
> +#define RAW3215_MAJOR		TTY_MAJOR
> +#define RAW3215_MINOR		64
> +#define RAW3215_DRIVER_NAME	"tty3215"
> +#define RAW3215_DEVICE_NAME	"ttyS"
> +#define RAW3215_CONSOLE_NAME	"3215"
> +
>   #define NR_3215		    1
>   #define NR_3215_REQ	    (4*NR_3215)
>   #define RAW3215_BUFFER_SIZE 65536     /* output buffer size */
> @@ -813,7 +819,7 @@ static const struct attribute_group *con3215_drv_attr_groups[] = {
>   
>   static struct ccw_driver raw3215_ccw_driver = {
>   	.driver = {
> -		.name	= "3215",
> +		.name	= RAW3215_CONSOLE_NAME,
>   		.groups = con3215_drv_attr_groups,
>   		.owner	= THIS_MODULE,
>   	},
> @@ -887,7 +893,7 @@ static struct notifier_block on_reboot_nb = {
>    *  The console structure for the 3215 console
>    */
>   static struct console con3215 = {
> -	.name	 = "ttyS",
> +	.name	 = RAW3215_DEVICE_NAME,
>   	.write	 = con3215_write,
>   	.device	 = con3215_device,
>   	.flags	 = CON_PRINTBUFFER,
> @@ -1168,10 +1174,10 @@ static int __init tty3215_init(void)
>   	 * proc_entry, set_termios, flush_buffer, set_ldisc, write_proc
>   	 */
>   
> -	driver->driver_name = "tty3215";
> -	driver->name = "ttyS";
> -	driver->major = TTY_MAJOR;
> -	driver->minor_start = 64;
> +	driver->driver_name = RAW3215_DRIVER_NAME;
> +	driver->name = RAW3215_DEVICE_NAME;
> +	driver->major = RAW3215_MAJOR;
> +	driver->minor_start = RAW3215_MINOR;
>   	driver->type = TTY_DRIVER_TYPE_SYSTEM;
>   	driver->subtype = SYSTEM_TYPE_TTY;
>   	driver->init_termios = tty_std_termios;

