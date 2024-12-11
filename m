Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E5239BC5
	for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914667; cv=none; b=ZNG49KDPMD9eHkNsZfd9D7rDP0qZqFXycG4JdyWnFd2c64pwuKsJhpAtYQiVk5rLmrY0PTkwtTodrZaP49icKO21t3vySIqMbEv1AufieBozpJqTaYM30YJ4DoipSE6VTxyDGmSkYrtSjovGUTAtERsU5o7aVWeQsoWZBZAwlww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914667; c=relaxed/simple;
	bh=l1HLbP5ajn2JJUN6VZxVichs3X9TNt8jAkd+61qbcRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIK38sgltI9f6iQrRuoCbtQfOXOkn5hzrWT/pchDnfnaMS1KVbWQpTak16JaOWnYQeuIoSLoqYpVpi+xuYgsJmDi7JG3kLHPYJgIZX7XVb/417085vWgKBy35Uv8N8OEThd9WFMhUBQocJz0/UDUofSCo0Ps4ZTIEMtAMdhCCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPxbfwby; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPxbfwby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733914664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f+GQ8tsyGKgJFkU/B8nsOzseW/lELPWkUJqO5s1w+2A=;
	b=CPxbfwby5bQc4/heuok0JIhqw8FMvvrFoKrDhomdOwAHb61s+yBs8keK3HvjGXzLIO+Dv9
	FZrd9lbvZVo/QzKzgMtdeVAE2YgpGRhdSbNcoJn48q9LIAm3HLG53L2jEqVF4/oSPnPero
	g0pSVmGiR9kzZHWpu9tuNXakIzjNEYQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-U1syztzpOV6tTfweaup5Fg-1; Wed, 11 Dec 2024 05:57:42 -0500
X-MC-Unique: U1syztzpOV6tTfweaup5Fg-1
X-Mimecast-MFC-AGG-ID: U1syztzpOV6tTfweaup5Fg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862f3ccf4fso2224646f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2024 02:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914661; x=1734519461;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+GQ8tsyGKgJFkU/B8nsOzseW/lELPWkUJqO5s1w+2A=;
        b=iWkKzGti4EeTNot8aDwkBx/+6FigF7POuiSFje/+5EctJkhT0rfAOrm5Rv2wjp59wP
         HXYc+OInKReU/yI9JAx+ypvmaZsdZyZoz58dERhM8BY7fBTuHCGtAZs/iC9UF3aWWrMu
         cJaY+HLZlEI+BLnFprkkQCVwTOOOrRJNYBpBCPPOzJDeZvqawT1h1hbRqVxwiJ25DLUs
         Kw4irrKBYZ8GDbC+Oma/+AoGwBtB2x/Lvn9jAB4JDfB2LE2Ow2t5EwbzAFLgnFP96huG
         7jIKx4CeDJ61YaoEzvDsiye+bafc9/HL/qAVo3KjwpI2/dewBmRlx94uabKWPVJGqsiL
         K4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVoXJVK7pWpX7hMFGAW6FVxbWEKijk+vvn2cvOJbBJ8GjIBASIiAUTydP1IvmOvW4tiHdrKi4zBiuoE@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPfcckV2iJlGFtLyF34JIBAadAsFEJPZsjW1u19M8O6TumpoQ
	abkKEZyorAU7CQAExMcl+KwjujhH3wSjVbr+d4okIpPgv3O6fWd2OLoh+i8/CnglxwSDRYNzhJT
	AE0RfwDqJBOy/xiUol6w/spJW3BkbV15vSNyY5ZhZ0M3dAuqILm9z34N5Urw=
X-Gm-Gg: ASbGncuPKTgdi7WXGmJtzGt3ML4iLiZwyEADIwt3UvyGGLzN/FD0T94/Hnz4CU3D1Xi
	iaXRkC43rR3IRi8ZN3h9plkHS4cqXKGL2SqpnEg6TZf/j541BszhoXoNN0nSpbCsS55Def+eiwG
	dBX/qmOLKlown+DzwpkPPdKWsw4votZDoOuWU3HwgMyB+7rhYx4GYR6mA22HgNP21BW4TPtNuDb
	HA9+yyApLrElBlCHkAncwL7Wt1mh38JdGbQHu0dFmDigXv7ZzJfQHzDXK6bQOqYxqN1/cq8HKhO
	FjiISvI=
X-Received: by 2002:a05:6000:4009:b0:386:459e:e138 with SMTP id ffacd0b85a97d-3864cea3bd3mr1804835f8f.36.1733914661581;
        Wed, 11 Dec 2024 02:57:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUKg9H6oaYQkfGXXxli6E1+9isNZKdHb45oDqLX0mj0ZRLj88hfOhbB/b7Op8n69nDqmj22w==
X-Received: by 2002:a05:6000:4009:b0:386:459e:e138 with SMTP id ffacd0b85a97d-3864cea3bd3mr1804821f8f.36.1733914661209;
        Wed, 11 Dec 2024 02:57:41 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2b08972sm125280215e9.27.2024.12.11.02.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 02:57:40 -0800 (PST)
Message-ID: <ba7d8da0-dcc3-40b8-ad99-50ec17a74573@redhat.com>
Date: Wed, 11 Dec 2024 11:57:38 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] iommu/s390: add basic routines for region 1st and 2nd
 tables
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, gerald.schaefer@linux.ibm.com,
 schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20241209192549.107226-1-mjrosato@linux.ibm.com>
 <20241209192549.107226-4-mjrosato@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241209192549.107226-4-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/12/2024 20.25, Matthew Rosato wrote:
> Add common routines for region first and region second tables, similar
> to what already exists for region third tables.  Routines added are
> for determining an index value based on address, getting and setting
> origin flags, and validating entries.
> These routines are not yet used, but will be in subsequent commits.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   arch/s390/include/asm/pci_dma.h |  2 ++
>   drivers/iommu/s390-iommu.c      | 56 +++++++++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
> index 42d7cc4262ca..8d8962e4fd58 100644
> --- a/arch/s390/include/asm/pci_dma.h
> +++ b/arch/s390/include/asm/pci_dma.h
> @@ -55,6 +55,8 @@ enum zpci_ioat_dtype {
>   #define ZPCI_PT_BITS			8
>   #define ZPCI_ST_SHIFT			(ZPCI_PT_BITS + PAGE_SHIFT)
>   #define ZPCI_RT_SHIFT			(ZPCI_ST_SHIFT + ZPCI_TABLE_BITS)
> +#define ZPCI_RS_SHIFT			(ZPCI_RT_SHIFT + ZPCI_TABLE_BITS)
> +#define ZPCI_RF_SHIFT			(ZPCI_RS_SHIFT + ZPCI_TABLE_BITS)
>   
>   #define ZPCI_RTE_FLAG_MASK		0x3fffUL
>   #define ZPCI_RTE_ADDR_MASK		(~ZPCI_RTE_FLAG_MASK)
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index f6c27b6ab4c6..fcebc7415fb3 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -36,6 +36,16 @@ struct s390_domain {
>   
>   static struct iommu_domain blocking_domain;
>   
> +static inline unsigned int calc_rfx(dma_addr_t ptr)
> +{
> +	return ((unsigned long)ptr >> ZPCI_RF_SHIFT) & ZPCI_INDEX_MASK;
> +}

  Hi Matthew!

Correct me if I'm wrong, but IIRC Clang will barf at you when you declare a 
"static inline" function in a .c file without using it? So this might break 
bisection later when using Clang and -Werror ... maybe it's better to 
introduce the functions just when they are also used?

  Thomas

