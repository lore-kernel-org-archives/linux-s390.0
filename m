Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794382814;
	b=3GCrBKo4/E2It9dqlWgSSXif4imhMBbJRTEDRVpntKJ9bg1VCOfRCgrnmmxYp1t9ODAs
	 l30qctGz8DbgukpGVYQrwmWrylNoHBZgYNix4W9dwsIe+R5Lzj2uLd8SAb1og9h/5FarV
	 qvEbfLRRXDPZWcJVTHAs0LMqKqM9Ixw8sMhBWP2dY8HCzJcucWcNhLcC+DJYEc9Gq4xV2
	 jr6Rjnl+ZDxIUYOQ0MMVu6uGfcxrfUWk2GbXr6cQUHAUIb7zx1DC1+CbUUaBiwx1dGla8
	 0AUcbck6kBfgd6yjsw6BRKz/J7T6DT5rB51ADDBF5d3LhTNCGT9uZ2m9g9/uVvheXRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UE+ZO+LDbUQkJMK6amSVRY89ivr6MWd0ox+os4xr0eo=;
	b=wpWwfQgUH3jNPg5VxWgN1d/lOWUK1X8K/VZTCn/kI9HfFJKaG/6DfbVCjIJQnABmbGkY
	 G+ORlJRoIZNhKd55JJuz/JpNW/nwRNE3ODeFt3bswvlQjzRMW3htmKf5hVK2LO3wWyvWN
	 q+dcrTcGeUligv92y1Oa3rUivVwpkUy/UXaw6RvTPI/7zahsBX70pgtufFtW1XeN2ViT/
	 tFfgFJqBFcNwlSZuQHDRUx54/Yz+puS0Cbjl+DV4xqp7QsK7rrpmfJYoWZTKopDZGrpFm
	 sEUypZZRKDbzSyrQuDAmRzKMKuRQFHftZ14DHIoZVIUdcRjyX4Y2pbQhqn4L5FvJLdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VCD6QF64;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB64606A32E
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 07:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB64606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VCD6QF64
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b581b6b0e9so1724745a12.2
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 23:40:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794382812; cv=none;
        d=google.com; s=arc-20260327;
        b=GieqUtZ76eri3PquMteGMEEPoX9b0UWwU2YBy+Z3c0XaVgIDYk6tp5gvCotGW/3feu
         sWio15GVRGhap8b0nN1tYASO+nQo7uVgTkDrQVmNo6DFtMWgGZkSuwc8ScMs6NbpwJnK
         az2P1lEyqwEEB/uX4oaZJuXNRqvltB3RJmWv5YGLwHoswHLuddZCeGQdNejt1nd+NEko
         tTQGHMk42Amzrv8CkRu6cxnqGAzP6Kw+/t8s8UE7rqpFbfrkpc/CmnUKgLADQZK9y1fv
         WASkuAh1LwG5DnIwWZbpUxYimSaPNb9jZUJgU5ikMJ79ieI/EAO/fvUa0yOFJ4BHNFUR
         ZAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UE+ZO+LDbUQkJMK6amSVRY89ivr6MWd0ox+os4xr0eo=;
        fh=c4xA4mvBF0va5ZqUbBfGDIW+t+2mBz0HYpT5uTGkRMY=;
        b=hGwzsjnwJcbqTJlJ37GLCl8XE6slNsnQk09phNCACszp5AUMwDHYQqkUFB3jfn/Mnl
         n9pT1VaL4bVSIjZ+zpv5KvVRby1scK6RyYw8rowR4VhhlktQkWxP5yNLRQ0Gnuzzi569
         i6jePUiV7cYTF28kqYGDflWuMH6crqbfS1LM/9B/cxJs8UyRPZKUi8mjV7O6Jcn+Eoo/
         rCQ4qD39LU1IFULQBx+3drwFTpLh5fTpN18L0cFLScdEslW9L2va37Kd21AQV8j9r0on
         tsAiFf4eOvaboxQJnhODiRk5dNHfy3etEnbXVRDPL9xQvZMq5OMCJPn0hYOmRJ/9vh6Y
         Gshw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794382812; x=1794987612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UE+ZO+LDbUQkJMK6amSVRY89ivr6MWd0ox+os4xr0eo=;
        b=VCD6QF64cq+6EajKVeH2KGvi/U5cBgOq2QaZUPujN9TUpScC8tW0bSWQt0oDUSy4JW
         S6Z8D6nWlIJvYo0C12W4DfrOkGdol86fJwYUUTyy4O1KRs5ZZZUMVLH5TcN2PkElzTMC
         CDPcO/9EjC2evHTSCepGDSbwuoSelf7KCGcOupsWhHmqIXstiHNkS+oNFTvRiDsE9USX
         LiWsrb9RYjjdGp3t/FMvX1MXOCXDbkNCM98PDcj50ceTD5evbGSrKBzvVmJsknTflsiz
         goYBb6lxDQzfivXfrbKsifTYJfLVgLYCutTWcyI9Jo7kHyPrf094IrOod562TSGGHij3
         JFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794382812; x=1794987612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UE+ZO+LDbUQkJMK6amSVRY89ivr6MWd0ox+os4xr0eo=;
        b=Mgc6EzIl69udi5BeqEhgsw8LYEOiEMDrqy0Vf3vdhRFWlM5Ppzp+0c0TCHCbRQk8S6
         nQbOV+ygDOQ17+QPFqiITTccJO12oBLe5VD+KNRtZP3WMZdFICHfNE/OjCmsvloxJrzE
         XfRH6LA25F46Dbj6Zes5AmgwYgVXr3eZqNwtyHntfMKCzLcgzgQJEDR8a2vXlDBmq2Nb
         2DxemTsIwn/b8u3HDqf0wOqHiu5wuoqyxc80RESOmXUc5Ewter87LYYhKm7WCZa8F9mn
         ppPfJswPpcsFX50wfCKlbeVN+6r/S5ZQbT8IeDmt8635oOScbP+h1ZW+uHLEIZed97wu
         CnyA==
X-Forwarded-Encrypted: i=1; AL+hErHZOjqBgLONztM9GulhjXUO4L25yXdIjBDT2z95iZWA5/Y9HpjTy+b07Wb6KpxgYXmrVmTdCRqQaaCt@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ej12Iy5EFbT/k+1suVc7PvzuUKcHuaRHYYmPWlcOv4B1feqRu
	84zO9l3sTwFt6G95opbz9M+CQcsD42j+bg56cD3BmADPlXQb9MP6fNmZHmdfP7Gyc08r9STAhKt
	3FL5BqK5MRA/+IkI3kQ7+TFN2i/Amj+s=
X-Gm-Gg: AYBFou3ljqFDnKnBEFAQ+M+JxoryDbFPERpVMjib9ZajlQ3dz5InazRsZHHQV+1TSIK
	zgBb6HCOAXPaa93SkPNCbX9yVQyg0hXUOZRgV7Mk0M3ybw8lJTxnjzVdCfqa3RNg1dxveFPfCmS
	KUQ+jf6iF0SL5g2JGJSk3oqXuoaw3PmOUsZnU76JyK9SjtYZJh9Ld3wNncX3+JbcC6w4JfkxYg1
	9rldynV252L/W1S/1ayTgKtAxr9dAW/a7wtLw/yLGPsLuBc2oe0W/8m0JBWfdW4b7r8XPdxF4ul
	PdshDbU5X3+szFZetwMcu/IudJSGsNFfERq8aAZJfPX1Gh/pP+LqkMrueFeXmJGH91JKbwmwxZG
	zh8IQ8Bu86tkT80pYkjcnIF4zSlNbgujFrNV48EZm8jKRq0bC3YrULMDoCvEGK2QqKfJc0g==
X-Received: by 2002:a05:6402:a614:b0:6b4:2aa6:2bf7 with SMTP id
 4fb4d7f45d1cf-6b7773fba00mr814626a12.17.1794382812113; Tue, 10 Nov 2026
 23:40:12 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com> <20261105-tonyk-syscall_table-v9-10-8d1275885d9c@igalia.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-10-8d1275885d9c@igalia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 11 Nov 2026 08:40:00 +0100
X-Gm-Features: AclHuK-efo-IN8C0PeBM3H51GRM-qrC5WxHB8slQK0l-tYnt6GeST1OC-lb_0Yw
Message-ID: <CA+=Fv5RNznnVyh4AM_ZTdwyK4iv-8TEO5Ejx0_81sf5CTeoGgw@mail.gmail.com>
Subject: Re: [PATCH v9 10/15] alpha: Define entry point for
 set_mempolicy_home_node syscall
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-alpha@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	soc@lists.linux.dev, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9

On Thu, Nov 5, 2026 at 9:06=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> Instead of explicitly defining set_mempolicy_home_node as sys_ni_sycall i=
n
> the syscall table, define it as the real syscall entry point,
> sys_set_mempolicy_home_node. As per commit fdb7d9b7acd0 ("alpha: remove
> DISCONTIGMEM and NUMA"), alpha doesn't have NUMA support, so none of the
> mempolicy sycalls will ever be compiled for alpha, resulting in the
> COND_SYSCALL() fallback being used to result in the sys_ni_syscall.
>
> There's no function change here, but this step helps to unify the syscall
> tables and create a common table to rule them all.
>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 52e3538cc7df..8fc4701a6328 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -489,7 +489,7 @@
>  # 557 reserved for memfd_secret
>  558    common  process_mrelease                sys_process_mrelease
>  559    common  futex_waitv                     sys_futex_waitv
> -560    common  set_mempolicy_home_node         sys_ni_syscall
> +560    common  set_mempolicy_home_node         sys_set_mempolicy_home_no=
de
>  561    common  cachestat                       sys_cachestat
>  562    common  fchmodat2                       sys_fchmodat2
>  563    common  map_shadow_stack                sys_map_shadow_stack
>
> --
> 2.56.0
>

My Acked-by already in this patch still stands.

I tested the series against my Alpha for-next, with the integration
adjustments described in my replies to patches 11 and 12. Full GENERIC
SMP and DP264 UP builds passed.

The generated dispatch table changes syscall 560 to
sys_set_mempolicy_home_node as intended. Alpha has no NUMA support,
so this still resolves to the sys_ni_syscall fallback.

Thanks,
Magnus
