Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBC27D791;
	Fri, 11 Apr 2025 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354474; cv=none; b=M8jG7ILCHS3ygl5QZz8+5hs1L1DLqWzd6mRiJ6/RHtlC15/ACqX4XON9kNS+DDmk0TmPxQ4WPnE4EEuMiMrlE1CIH9NXdK5Q/xtdhbvPRuPTFaLuTXLpZA5h9G5LPT671Anm2F5a5ieJ+rXleYJvHErRglNdAhaw/NKChYWCaYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354474; c=relaxed/simple;
	bh=AD4eyDZxuR/f6Z+QbrfpNlGENoSPYRxphAgwFhEw03M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dS1pSKVOIWZxG93CCV1hjUn5LKnT9WHNi4FTgJWDZEzxTrMX5ShVsqLO2kxqYmXeQiQNqqQjtQWjI+LTfDH7vfgDkDamSFy2LwlMYCljHaG8qszJyln16G2rafuGTQWqQKsvOj0Pa5pGXYeF+rxZ6gvkGYowgFnTkr980yIWQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj5w2QV+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj5w2QV+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22928d629faso16678915ad.3;
        Thu, 10 Apr 2025 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744354472; x=1744959272; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMrPec0FtWGKoKqlWKZKVYlPugkOpwSx2KisPfbkQKU=;
        b=Zj5w2QV+Yg0TzuHGoRod60Ej3kuo4oYG+P7Gfm6yDk4UFfUpdwaBb7i/jnUCc6qe85
         5EsFHylsDKp79HmpmA9xOHFRqV40xEI7aE5mURUUtlq4LQ+1r2VgQKELAi+w9mvBdunV
         zkQ+b9ef0hpGHHibVXFSb2UUgjzcguQSCMTBByovkarf4vkMJuMvwjQwjjFxSOxq6FBQ
         KOBJFrXmIuATVNybQQ+/K3NN4VsVgjmDGJJ0KPoZKUA0G38VMj9TOpNlPhWut4Zd/X0L
         xBWzH7dz3nfPfXP71HLJscBVDEsyjrLYYEef5w6IEyH2GzOfiKmOg9vKwRwKAy+YhZ6O
         LMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744354472; x=1744959272;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EMrPec0FtWGKoKqlWKZKVYlPugkOpwSx2KisPfbkQKU=;
        b=KTCkTDoTBeDXqC2wACG8giYkgDLybwRwWxLgt0sruh4bCh6jBrrjoQnOA2F6fwnmjd
         eJtMc+wuGwe2rJGQkfMhJlUthc642XD901pfjENaH5VPeiLljnsepVRM4eKxzQP0IhWx
         DewA8/Fs+3JjLG9SS/1uWrDWdIKfYCyrXwERIkZd7DlSkEdgGX+8M+eVIE+AA1I3jT+U
         joQCjG0AtODpuGOmTqq8FbOnBykf1RBSxIvOrQFxRUgACn0HNdiD6vX23Pi0Lu1bQdeH
         +/J9D9cZH8VbIWkhlb36af7nJSWxOaZCf2KzNY4H9cw0C7itYmHmWylJTdp7p+rWKnem
         OsTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5afdzyYNr1G2tiS2TLPV77rpWJEEfo4bmYkRAtw73JX1vyrVBnCHt/j+QNfE96W2HpS22dOMv0ciELQ==@vger.kernel.org, AJvYcCVQmjxVRaxjVWXc2mKUurLkGObTjAVU1zthlS6Yoi+KKE68ccjkdrnhEIQEgDv/ocX4EXxJObokKP4S96o=@vger.kernel.org, AJvYcCXzgWijLxnxwuyVShGZ3A6j/j0JR8M2rG23UaGSidmEgTIOfXYJwzHQbUQOsd7Oz/2MAiSt8vn0SwGiSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjGlDYRkHrV7V0TH62aYWrS/R/Eb4l4+fQk+hbORrJOZ3JYwIr
	0ALVKlGStrebc8ckYuio74/iDC6EL+dK1ArtzQBeTvPaxhhIENKC
X-Gm-Gg: ASbGncvcIFybe0/Z8P/5Neq/6/FuFMFU59lfSa7tzXVKTVEgVvqiQ1vKvAVumBBMkJr
	dcfcMcQuwjp/+UGi3nFsHiR6SN6tmtXqpR51lXxJ55dDUpMOfLuMtuZW2SUBAuerkTNEvxDxXbK
	w7x0dFM5/gGNH0IGDz3oTT7HEvda+kX/oC4rRUru63Qc7ERQyY5oTO+mYEWQELbrwfU0PyZIIdi
	l6/O+SiGIoimQeR/4hmNi9aZBLKRY0/ng9Y4fU/ZmSSu3VY5XqQd33FlsEhKLEAN+xMqSScWdKc
	PisuF/pGaQUsHvg2Qa8pDLbY7ZFm5ZsPFA==
X-Google-Smtp-Source: AGHT+IGSH0OgLf53VF7UhNZNnJ/VcLJp7S3R1+Mq4jeyNCKlAufgShNsDG1jyYvvXL3wLn/jNMdw9A==
X-Received: by 2002:a17:902:ce8a:b0:224:191d:8a87 with SMTP id d9443c01a7336-22bea4bc62emr24301425ad.26.1744354472347;
        Thu, 10 Apr 2025 23:54:32 -0700 (PDT)
Received: from localhost ([220.253.99.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd23342ddsm728537b3a.164.2025.04.10.23.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 16:54:25 +1000
Message-Id: <D93M1ULKMFVB.FY9I2463RQ68@gmail.com>
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

Oh of course you can't make it GFP_KERNEL after the
patch to take ptl even for archs that don't use lazy
mmu.

Thanks,
Nick
