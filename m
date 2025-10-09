Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAEE70830
	for <linux-s390@vger.kernel.org>; Thu,  9 Oct 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037194; cv=none; b=dJAlk43f9BjWlquDlSl30FXRieqUSQDX5IM1Q4jQfZjQBhaWG72MYL84n77sXfcfxUE+9YaKwTJ1kklPVRs2yc/76gOBY4Jtuf3AJC8J1Wjh4nPOsEdXNzAydHYPtEGVtxUSQ/NWZqhekXNLTQQgCPJDerGGeCAQW/IUaMnM8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037194; c=relaxed/simple;
	bh=ENC6amdDkAm4vf7SRoBraXZjYWz3wUySAT+4cMfHVRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8yJqLm8m9WgSdNDn+Nobr7nLKQYmBSMzIHB+LsAKiHjdY5xIV4gSKWGh6W+TiVzJXR67YMzKb2xVSqs/+c0Ne4GD2u4NzsmwLNrtmYsW7Nv+9qKgwqzHES3JIs8plU0eYxTyQ5X+pewTUjLImtjqlgpscE0hDmd6n35EAx2DUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjM+9EED; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjM+9EED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760037192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uMfDHaIXjP5qW70eAEFIPvcXKGAAk4uyl5DbHMEw+mw=;
	b=XjM+9EEDO+yWaSYe23l5uRAVcQrK0fm8W+nv5DS5maTlNEOkv3TFP7rqGxuILlJ0tve9Du
	QG2AZvnBTojAJdhIZeN6yb/z/HzyfTvLdqyapiboSoQWSEatTEOyhdt0Ff+nUA6b2Ktk/o
	rxwBXjAzJVYqMoz6Fs06DrUZLsD16G8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-yYofjqbvOP-n1qfJSh-XGw-1; Thu, 09 Oct 2025 15:13:11 -0400
X-MC-Unique: yYofjqbvOP-n1qfJSh-XGw-1
X-Mimecast-MFC-AGG-ID: yYofjqbvOP-n1qfJSh-XGw_1760037190
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so13026675e9.2
        for <linux-s390@vger.kernel.org>; Thu, 09 Oct 2025 12:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760037190; x=1760641990;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMfDHaIXjP5qW70eAEFIPvcXKGAAk4uyl5DbHMEw+mw=;
        b=Ezm3adfCd0Vc0XdDGhYMiXUl8C9Gk/Xf6+0j4aCRSXfSRDFhiiwkVTjVBJFurVG8sF
         hMG6C8iros1txDCF0hCJnnpOV9OZywW4dReIBHugueKPaW4AuuJaLWyy9nPyvz0wyF1e
         t58qT161+QtZ4rp0Gj7Mc4YVMkFnZ3LfZRQ29mpz7C+FUIgEDjMKmYVWv4ZTpTJVtel9
         XJmtyN4C8HcegrYpVNZq+cnU98Dq2bCSrHGJaoW0naPqXOnpCG3unpdb4dLuBpl0xG3b
         altLGCQOsyTf/5k+q/cY6g0pkrkGPf0ETLBJIKyt+FIltp6qAAGL6cbYEKWhVcqxOgX4
         i/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Gax42logpzFans+frszMsRRE0/KSSaSrXjvGM5w1yVwCLgP5LRKo6TjbUMp+Ol8LDOYsWZxGYxTf@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwrPAEZ8XfVERvjdSneZoe+gEbVY075hfZ/pkGbaMUp5v76pP
	rEtqPmcXW9o24hluM9gj2+ehoPd6qgvrmRb/Ov5rfFvhHqBVKlgsBpPHTelREjWNkejwwrxjcI5
	MSN0KhTzixBfc5pQY0jlcghMRXUc/rYWRX0+/2ZifMbaetKE8c2Vj9orH/+hujGg=
X-Gm-Gg: ASbGnctcK37Aey+gLlua2p7c6/4cLwCwcjoIynO4/Oq87sUPO/jOc2X0eoRoIexUjop
	m6+Gmv0S09qxQA7qWmCTTzPFQnTIbecasq6Qog3UkxEvXBlLqIVD8lm51Hf7xf1Uo2+Ro9b7LXf
	onLQXHxqndRi1ELntwBG7ewADT9t9NTm1HDRLMtPZ3oj/vxGSwe5J6DvwVk3B3DhFQtmnMzZabn
	3pVzkACN0FH+Y7j0E2F9pTG9sJUvFlWlLfI0XbgKHpRPmdAc8lzW42UpQBYfTz2a0NMKOEITISc
	B9HgJwQ/hLQf+7tVzuxfhXOG/4TcS5sCYpwt3H3uMdPDL9GNxARfX3d4+8sAFsJMWzoxtbyjsU/
	bcXKuSLTk
X-Received: by 2002:a05:600c:1394:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-46fa9a8f090mr59071555e9.3.1760037189450;
        Thu, 09 Oct 2025 12:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBcImDsyxTunmBqgZfkDNrdR7pu/FzopoU++FfWBhFLzzgiDgfzJIo/TDjPU5ArHmmJTRIsA==
X-Received: by 2002:a05:600c:1394:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-46fa9a8f090mr59071425e9.3.1760037189032;
        Thu, 09 Oct 2025 12:13:09 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf6b4sm405958f8f.25.2025.10.09.12.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 12:13:08 -0700 (PDT)
Message-ID: <ed7db8b9-e828-420d-a8b2-3e1b8aa8c95c@redhat.com>
Date: Thu, 9 Oct 2025 21:13:06 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] s390/sclp: Add support for dynamic
 (de)configuration of memory
To: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
 <20251009131839.3739108-3-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251009131839.3739108-3-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Just a couple of nits

> ---
>   drivers/s390/char/sclp_mem.c | 290 +++++++++++++++++++++++++----------
>   1 file changed, 207 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
> index 27f49f5fd358..e1302b1c98ac 100644
> --- a/drivers/s390/char/sclp_mem.c
> +++ b/drivers/s390/char/sclp_mem.c
> @@ -9,9 +9,12 @@
>   #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>   
>   #include <linux/cpufeature.h>
> +#include <linux/container_of.h>
>   #include <linux/err.h>
>   #include <linux/errno.h>
>   #include <linux/init.h>
> +#include <linux/kobject.h>
> +#include <linux/kstrtox.h>
>   #include <linux/memory.h>
>   #include <linux/memory_hotplug.h>
>   #include <linux/mm.h>
> @@ -27,7 +30,6 @@
>   #define SCLP_CMDW_ASSIGN_STORAGE		0x000d0001
>   #define SCLP_CMDW_UNASSIGN_STORAGE		0x000c0001
>   
> -static DEFINE_MUTEX(sclp_mem_mutex);
>   static LIST_HEAD(sclp_mem_list);
>   static u8 sclp_max_storage_id;
>   static DECLARE_BITMAP(sclp_storage_ids, 256);
> @@ -38,6 +40,18 @@ struct memory_increment {
>   	int standby;
>   };
>   
> +struct sclp_mem {
> +	struct kobject kobj;
> +	unsigned int id;
> +	unsigned int memmap_on_memory;
> +	unsigned int config;
> +};
> +
> +struct sclp_mem_arg {
> +	struct sclp_mem *sclp_mems;
> +	struct kset *kset;
> +};

Just one thought: if you keep either as global variable you wouldn't 
need this. (I would just keep both as globals, but whatever you prefer)

Whatever you prefer.

[...]

>   
> -static void __init sclp_add_standby_memory(void)
> +static int __init create_standby_sclp_mems(struct sclp_mem *sclp_mems, struct kset *kset)
>   {
>   	struct memory_increment *incr;
> +	int rc = 0;
>   
>   	list_for_each_entry(incr, &sclp_mem_list, list) {
>   		if (incr->standby)
> -			add_memory_merged(incr->rn);
> +			rc = create_standby_sclp_mems_merged(sclp_mems, kset, incr->rn);
> +		if (rc)
> +			goto out;

Why not "return rc;" to avoid the goto label?

>   	}
> -	add_memory_merged(0);
> +	rc = create_standby_sclp_mems_merged(sclp_mems, kset, 0);
> +out:
> +	return rc;
> +}
> +
> +static int __init init_sclp_mem(void)
> +{
> +	const u64 block_size = memory_block_size_bytes();

Instead of "u64" maybe "unsigned long" like memory_block_size_bytes() 
returns?

> +	const u64 max_sclp_mems = roundup(sclp.rnmax * sclp.rzm, block_size) / block_size;

Instead of u64 maybe "unsigned int" like the ids you store per sclp_mem?

> +	struct sclp_mem *sclp_mems;
> +	struct sclp_mem_arg arg;
> +	struct kset *kset;
> +	int rc;
> +
> +	/* Allocate memory for all blocks ahead of time. */
> +	sclp_mems = kcalloc(max_sclp_mems, sizeof(struct sclp_mem), GFP_KERNEL);
> +	if (!sclp_mems)
> +		return -ENOMEM;
> +
> +	kset = kset_create_and_add("memory", NULL, firmware_kobj);
> +	if (!kset)
> +		return -ENOMEM;

I guess we don't care about freeing sclp_mems in that case? Likely it 
should never ever happen either way.

-- 
Cheers

David / dhildenb

