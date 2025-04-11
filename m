Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7A27CCD0;
	Fri, 11 Apr 2025 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353636; cv=none; b=nYTvhr7APzla40O7Y8mG1a+4CFFSAeWFKUbjZqNCWgJjpD6I7B5mgzUARYpOHzmuSD5KTrgIhMH7PCnPqKQS7+/m8XFmXpyygIlvVb30T2vPH/5pWHwfl5YLwAma2Bo942IEW+whTmkXtvkIeAZWjKIPK10q9BmmZAolwwkg1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353636; c=relaxed/simple;
	bh=pgIERK+mFu597JGdwOKpnZyhatoi5tPncw/8irfmZQs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bQQ8Nrq949m5e76YkmGx6eWTDms9HhWtwZv2xBOFjVIaxeDnjupYjvRibv95v1kQnxyb8XaKkiFWG2NWFZSOFjk05y+z8VQgErYTJ8pkH0U6h/aXSqZXQX7ArFo/ZtcqsGZQWU6rNmtAsj4kY3qYGu4BYWF+tVschQ6C7xBObzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTcDsyXW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTcDsyXW"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736b350a22cso1376118b3a.1;
        Thu, 10 Apr 2025 23:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744353634; x=1744958434; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFEK5BUAzhnm7Ls0LSYKvyunOzyOHTaf9tKVCyYIPn0=;
        b=BTcDsyXWYAqrmVfD/7mTqHkX7E7/M9IMe+Mc7YtQnBNMzidpTtxdMztD6Gnnswdklv
         CAtpq20at1qn3EAAQKELZbEs5NghiVFoHZttUoSQ8Pwg+s6y5ioybYoiexXkGthNyhM7
         83+AKWCbQzLGhu32Wljy9CFeqWvxJSX+jEZoM2xysdqXz9Y/Siag0sjrT6FtbjiJglnO
         7YtSmXASysfbfq9JkYeMTl9xjyU25UoIQvSeyKyXDeUqp8Fntptsbcfyyl1m907bpdQG
         xh+aUf20uQVaqfDVn0SWcLTqy20LQYdqDjQYExxFO5zw2kdqovAuBhMFiyh/42aAyNHo
         EFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744353634; x=1744958434;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFEK5BUAzhnm7Ls0LSYKvyunOzyOHTaf9tKVCyYIPn0=;
        b=kKb8cY7kbU5u/PDRc/PKaNd5YVfhabuz96plUCyyk9y5dULIiUv2y8YqfPaaffp+4j
         YRXyX2CnWx1Cl2WoNbOjjdJwHhhqODLse2QHpiWa+EXHmNcS2c8s48b5eY5to71mdu5i
         +pFwRht/VnZVbYF1fJ1f2fX4zviusGdwm7WpSW0eqSNfD+kSHCzwIuA91JfsTbOlQQlH
         auUJRsAOL6yTImnGOfY4DSFqbWMNGU2ZJEA5maMbyJlLCEeXygQwD/LOL/fDd1vZsu3c
         SZQVDvrXgWmcytj/mUIgPMG08XAVd0Y7+zD6s1689jaYGxfka03kMQrX6CSpxRR+gYfk
         i8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV7sqTVhATy9XbfLxGc0voRdde7r27mFSFVIusX4COBeoLcHj9IuSDl2N0cRS6lWjhodbFGXPz8715lSQ==@vger.kernel.org, AJvYcCVBGfjvNyi0N/qmrijYLdr06x17diJ3Cu9poQu3WNAJwF0+r3vux2MySI6kZ6vIJFKpu0zwfJUir1wEmQ==@vger.kernel.org, AJvYcCWeDZVrIeE8EtYR4kWsOMfxvThT+sGBj/wpKMWBVNvRvTrQiwOc1YyZ91VnhfefvJLmpVdK6TAzJ2suLVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKzm62q66kEOpap+/gI06pk99lyoiZNIskVHfroeV3ByJNzzy
	d4VEQWNA4BXkf7nLV4AMeDzx7LI891wsQoSA8UJKHJN9vXtQHjM1
X-Gm-Gg: ASbGncuGMUEHZPpayzyAkUNuPkKcDU9hE7lTHi2jMpyIHRKs2tL8xYfa2/hU2SyTAfS
	ez9kQ93jWJs+B27mSEOSBeLiOeyijbTT+JDbUH2NneQjyJGO/7vuk1nw7llInmtK+90QRm7QtJt
	0PquAf1ZxoKDUMR9Q/7FESspqetMT6ZGinQRrgyjyqu9Hq6QgbLhhHesF8RS3JY9Vu4EE+xNzp1
	R3mMAR2ksqbVWndH8ZUMKKoL2A0LbMb56KpnC0sXZFl30TyJwT5qFQYXk24sjWAnu3LhbjLrfGO
	iiKfH4Ksy/c6Noe+z5Bj4wzeTmK7YxmG9g==
X-Google-Smtp-Source: AGHT+IGxv2OdTwUHRm9UMQ0BxuItHKpv+vDYxaqSXEB9Rf30X+vmBhY4lLT/tgRpdLMgX439EpkNdA==
X-Received: by 2002:a05:6a00:13a1:b0:730:927c:d451 with SMTP id d2e1a72fcca58-73bd12a9926mr2119650b3a.20.1744353633666;
        Thu, 10 Apr 2025 23:40:33 -0700 (PDT)
Received: from localhost ([220.253.99.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b029dff3b64sm4083209a12.0.2025.04.10.23.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 16:40:25 +1000
Message-Id: <D93LR52FZ2QR.399C9CFVNU658@gmail.com>
Cc: "Hugh Dickins" <hughd@google.com>, "Guenter Roeck" <linux@roeck-us.net>,
 "Juergen Gross" <jgross@suse.com>, "Jeremy Fitzhardinge" <jeremy@goop.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <kasan-dev@googlegroups.com>, <sparclinux@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] kasan: Avoid sleepable page allocation from
 atomic context
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>
X-Mailer: aerc 0.19.0
References: <cover.1744037648.git.agordeev@linux.ibm.com>
 <ad1b313b6e3e1a84d2df6f686680ad78ae99710c.1744037648.git.agordeev@linux.ibm.com>
In-Reply-To: <ad1b313b6e3e1a84d2df6f686680ad78ae99710c.1744037648.git.agordeev@linux.ibm.com>

On Tue Apr 8, 2025 at 1:11 AM AEST, Alexander Gordeev wrote:
> apply_to_page_range() enters lazy MMU mode and then invokes
> kasan_populate_vmalloc_pte() callback on each page table walk
> iteration. The lazy MMU mode may only be entered only under
> protection of the page table lock. However, the callback can
> go into sleep when trying to allocate a single page.
>
> Change __get_free_page() allocation mode from GFP_KERNEL to
> GFP_ATOMIC to avoid scheduling out while in atomic context.

It's a bit unfortunate to make this use atomic allocs for
archs that don't need it.

Could you make it depend on __HAVE_ARCH_ENTER_LAZY_MMU_MODE
or is that overkill?

I wanted to remove ppc64's per-CPU page array and replace it
with on stack or dynaimc alloc array in the thread... but
cost/benefit of working on ppc64 hash MMU code is not
high :(

Fix itself for ppc64's requirement at least looks right to me
so for that,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  mm/kasan/shadow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 88d1c9dcb507..edfa77959474 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -301,7 +301,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, un=
signed long addr,
>  	if (likely(!pte_none(ptep_get(ptep))))
>  		return 0;
> =20
> -	page =3D __get_free_page(GFP_KERNEL);
> +	page =3D __get_free_page(GFP_ATOMIC);
>  	if (!page)
>  		return -ENOMEM;
> =20

