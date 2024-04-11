Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAE148855
	for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839707; cv=none; b=RAXHGkIaLa0OzsAF3unYKXAIiYWwuWtH/IgX+YU9f5qsaBUj1qdIGk2OMyf1cfc48AXZt05R/FwWe5+a5eaPmiCbB8ShlIQsXpyWl15+sILE5UheL1UunRIDCRz+4fsjLYIoCxhjMyHhZ2u24Ev05uXbIZWrlRaqxEwF7dFdj+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839707; c=relaxed/simple;
	bh=WdDOMX9tnc1tmWwRoL7QOvCRxUbQx0s/YjWcKqoMOXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWWcOVx04lFhh6OrMlX4zi22wqSaxy2mSmZIRF+7zo4YokZzNuIIzK7HJyMJJ2ih0mvRL9gWTuP9+1lTzZmu6SHPbzTzzcRXLxaZRMA30m9Eem1s3G77WvtoL2+kdG4l/k+LKcUVLWaEzxiMUxF3NunJkjm1LyyXQ8SMXxZTmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbU0hoag; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbU0hoag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712839704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YGv0oxILWFs0mMfSSjVAs+Z0hudt/O6Xh0nJxcnvIcY=;
	b=PbU0hoagDybfxRGKROP0nnsZxGi8NpPeQpFfnjNqK+vTUvw5k40WlcOawBHyGOjBLLApDd
	cH302QLGEHyLi0bMHAs3nS5J7apVHS6ekrKq2e1lfm79ljEGjmG+JMfE+RPXVfVP/2A8td
	r4c73KHFMPDC9jrKU+TQrlOmBslZFgo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-7AiBnIH0Ocir7-uCO6x5eQ-1; Thu, 11 Apr 2024 08:48:23 -0400
X-MC-Unique: 7AiBnIH0Ocir7-uCO6x5eQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-346b8ef7e10so393751f8f.3
        for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 05:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712839702; x=1713444502;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YGv0oxILWFs0mMfSSjVAs+Z0hudt/O6Xh0nJxcnvIcY=;
        b=JowtgQorvfcHGXeSZ9x74Ihh+MoSBUY9sgw7DEiTjK7cOnYNn/VEyZzScJSRNlqKat
         i5BppYfDDYcIw8DV3Xg/Dr1hHKY32u6f3v+sg/T1WyptvPGPU8qWNtPP4YPEcwVtxgzS
         73N4UfqoJFTAgCFT+x4wWePVetye7TvMcf+zPa4e/Brreh5m/SV9POfV6ljmSkmUJK5B
         qwpQkU8wCGqRkA5S52GwwAuSfZN9KueHmf4AAH/kvgurhjMlu2o3ke0j0HIAfqEoJkF5
         0XjSFosavpeA5ptOt2MctxxX22j7Vwz/A29TUUfcUerG/YLaZR0TWbQcIfl/n0Ay5nmA
         CSGw==
X-Forwarded-Encrypted: i=1; AJvYcCXVbPh7p2Qvi8+FcOuJjzMMxdptLVn1Nj5mUSPfkVADqxSZQFx9NwFa5XpoxC20KbHeDIYnFOazh+671QBuQdRwPakpcZDxe1OgIA==
X-Gm-Message-State: AOJu0Yw+q3zEnzx511LYSomBeyWUOY4iFPOrmiDBnlqLpjzdIbkEX5bi
	d9H7rBPE9gTVcWJ1bROMUUuZ3bep69S1yD8NRskJMecHDZh1sT23UoBW8cw28cMtlCzusOac9O5
	pzOxLxna6hzdRXH76IxlL6kVLybw1oduyGrwh7QHWrpd9lTHq5ZiwqEJUEWA=
X-Received: by 2002:adf:e259:0:b0:33e:cc16:387 with SMTP id bl25-20020adfe259000000b0033ecc160387mr3810155wrb.54.1712839701836;
        Thu, 11 Apr 2024 05:48:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHI7e7R7IE4IicBalLusII+MbmDxKJG2iEJMqCJIjaUxwJC11oCyxgblPO8jFK/XF2/CifNA==
X-Received: by 2002:adf:e259:0:b0:33e:cc16:387 with SMTP id bl25-20020adfe259000000b0033ecc160387mr3810136wrb.54.1712839701399;
        Thu, 11 Apr 2024 05:48:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id gb32-20020a05600045a000b003462b54bc8asm1691536wrb.109.2024.04.11.05.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 05:48:20 -0700 (PDT)
Message-ID: <329758ca-c795-43a3-9788-d83c09247dce@redhat.com>
Date: Thu, 11 Apr 2024 14:48:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] s390/mm: re-enable the shared zeropage for !PV and
 !skeys KVM guests
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20240327171737.919590-1-david@redhat.com>
 <20240327171737.919590-3-david@redhat.com>
 <ZhfYrVERxUijQbAL@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZhfYrVERxUijQbAL@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.04.24 14:33, Alexander Gordeev wrote:
> On Wed, Mar 27, 2024 at 06:17:37PM +0100, David Hildenbrand wrote:
>> index 60950e7a25f5..1a71cb19c089 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -566,10 +566,19 @@ static inline pud_t set_pud_bit(pud_t pud, pgprot_t prot)
>>   }
>>   
>>   /*
>> - * In the case that a guest uses storage keys
>> - * faults should no longer be backed by zero pages
>> + * As soon as the guest uses storage keys or enables PV, we deduplicate all
>> + * mapped shared zeropages and prevent new shared zeropages from getting
>> + * mapped.
>>    */
>> -#define mm_forbids_zeropage mm_has_pgste
> 
> Should it be the below insted?
> 
> #define mm_forbids_zeropage mm_forbids_zeropage
> 
> Once I add it, it fails to compile, due to the issue in patch #1.

I guess yes. So we tested the unsharing part (why I was seeing unsharing 
triggering), but would have allowed zeropages afterwards. Sight.

Let me retest and resend. Thanks!

-- 
Cheers,

David / dhildenb

