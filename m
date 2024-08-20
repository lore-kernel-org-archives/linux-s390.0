Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872B178376
	for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150710; cv=none; b=My4sn8/mOINwqx5mRxUu7yQvFz+4s94j8Zfgt+B8MqgV6aBHQ8YxRjYRH9Il7hRw9AufsXXtgSxgOCUj29MJyYuC3LDzUx/pAhy3kP0CVClbPL/CdmPRiRru+dw6g4SwLYRBkACiVDxjrmUaX1vvcAcaqUIUbCwiC1jDJb02txM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150710; c=relaxed/simple;
	bh=sFVfJBKE5ac/TDph1oBNvCoOGF/b+CejLCy2FTFfdW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpXWKlqqrsEgO1HwHFnayGtIFb+psE6RprDgtwfAGWX2YJfB68YEA1+b0MygUvyrksJfpLyw0nZxlzaUwEd3b+eG5DIXl1lMESU55BB7ppJQj3GuNKVH4RIH71ifUfsCyHLdahX9NagNkJsgte53ZBdvaZjdLrKXc13fXJFIRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNY5nV7L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNY5nV7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724150705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGfup/GIC5d/0ml/A8/AQVsp8wsdLNzZ4+eJ30JsWZ4=;
	b=cNY5nV7LfpysZXBUL6Sy/fhkeF88DsVbuipduUUzj9JliaNI0hCpwbKz7jFYQE4a5RxMbS
	6KwO7GWuW9TgMnNF9pvB+fsflm+yTiDglK5htptEs39YVVw0A0jd4RRPMRpLF+NzB0BcD0
	7I93T+IiQeR+wbFz14w17imwGh2QBDo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-BSOtIT1sM3STa3SoHz4SIA-1; Tue, 20 Aug 2024 06:45:04 -0400
X-MC-Unique: BSOtIT1sM3STa3SoHz4SIA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42808f5d32aso9827825e9.2
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2024 03:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724150703; x=1724755503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGfup/GIC5d/0ml/A8/AQVsp8wsdLNzZ4+eJ30JsWZ4=;
        b=PeTmPd8MulZs72s2COi/fL3j3HeJQcq22b/vHILnGjjRdYQgwJSmzsJux/fsdvKwWs
         l6pmRK+lAVK0cv3TxLFgvOupHrWjbW2GxomkaIk0mVUUtGPS7ncyjKneqbYaqubPMCjC
         L6XXTD470hgaPsDzX88WhWMtwEJ+jKa+uj/6Zavp94upGFJYNld5LIdXPavbPf+NRvKq
         Uf+XPv5QHND/4A97dHEPG/CCV1d7mvNdyFGtfyz2qcP/tLm7V8Sp8wztp7ht4KV8L302
         6tuKAE2H7Y76b4ZG6VK+hCJ5zzBrE20aQ0sLJvHjiRWM2CYzDfuvv0c3TcTSpBnOJn5x
         JBFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8LB70jRwz2iqRUchAd8RwBeR1swqNDxjWd85aCabJKfNOsfmHyqOv0Ibpl+2fKQTY3RqaRZv3o6SA9tX3xOlXrM1I7pqXqhTfgg==
X-Gm-Message-State: AOJu0YwpEzEYBQHT9Pg14fFXXPu1G6mclneEo+UqLAqGZY9BYroOrv3x
	FxovpBVhenZyBSct//Mtrkybtjib+5aeHtKgFdUvV8pTtistm92aQ7cgF6UenmitDWFRg0LCdfx
	m2HBGNj/8Ph0b7Al79WC64eoYEgZ7zVG+aRdvu7+WrPpksUMe2u5Ig1XsYV8=
X-Received: by 2002:a05:600c:1d12:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-429ed7fdbe1mr57450265e9.5.1724150703482;
        Tue, 20 Aug 2024 03:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8cTXnqRWYqqm0XpVAVQ8pCeuWaYsky+/icxWWxftsJM5lZe26M/fHr1QH1BCVYmmEycldNA==
X-Received: by 2002:a05:600c:1d12:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-429ed7fdbe1mr57450055e9.5.1724150703020;
        Tue, 20 Aug 2024 03:45:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a31csm12842627f8f.17.2024.08.20.03.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 03:45:02 -0700 (PDT)
Message-ID: <e0f35083-7604-4766-990a-f77554e0202f@redhat.com>
Date: Tue, 20 Aug 2024 12:45:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v5,2/2] net/smc: modify smc_sock structure
To: Jeongjun Park <aha310510@gmail.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dust.li@linux.alibaba.com, ubraun@linux.vnet.ibm.com, utz.bacher@de.ibm.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240815043714.38772-1-aha310510@gmail.com>
 <20240815043904.38959-1-aha310510@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240815043904.38959-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/15/24 06:39, Jeongjun Park wrote:
> Since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> point to the same address, when smc_create_clcsk() stores the newly
> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> into clcsock. This causes NULL pointer dereference and various other
> memory corruptions.
> 
> To solve this, we need to modify the smc_sock structure.
> 
> Fixes: ac7138746e14 ("smc: establish new socket family")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>   net/smc/smc.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 34b781e463c4..0d67a02a6ab1 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -283,7 +283,10 @@ struct smc_connection {
>   };
>   
>   struct smc_sock {				/* smc sock container */
> -	struct sock		sk;
> +	union {
> +		struct sock		sk;
> +		struct inet_sock	inet;
> +	};
>   	struct socket		*clcsock;	/* internal tcp socket */
>   	void			(*clcsk_state_change)(struct sock *sk);
>   						/* original stat_change fct. */

As per the running discussion here:

https://lore.kernel.org/all/5ad4de6f-48d4-4d1b-b062-e1cd2e8b3600@linux.ibm.com/#t

you should include at least a add a comment to the union, describing 
which one is used in which case.

My personal preference would be directly replacing 'struct sk' with
'struct inet_sock inet;' and adjust all the smc->sk access accordingly, 
likely via a new helper.

I understand that would be much more invasive, but would align with 
other AF.

Thanks,

Paolo

