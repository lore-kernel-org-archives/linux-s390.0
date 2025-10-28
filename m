Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2334CFC8
	for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686091; cv=none; b=rsaZDeK6gd+8E73O8PX7n+6sm7M/yqc+2EfbS6yjB9v96qdR2xg/TJoKIDrlE7Fk07LIVboRso3rFE0hgnp+brHWF7Wz67iXsdRkvr+pZSGBmMoMKQ6j0PLrwtLp1Q+zAjVhzSZL6bZZt0FY3LE6w1XG1akQRip1Y8wodhwLs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686091; c=relaxed/simple;
	bh=TSJqQiqcuIrrLHU2HBL8/BtxE2AmDhEy6dzxtsABhr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFrSX+mM2ieHL5f/DkeXTW1pSJhkYrCDGPVgx7ry+QWASbEi4mEnlzs8+ZWDaknmM2e0HlXphR8EhZvz4eEdc9AlyZ/ccRV9upVQzWLlmZX3MBkvZe2yZ1g9PHkLB85AIgF2SBVktu2rs0vAmtYjTOfgE91t33ArjjxGIoCGI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgJOnC0K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgJOnC0K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761686088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HrvyEcRFoneqk86qrnzAoo3f6d+zdXeHYtZ1JCa9Ps=;
	b=XgJOnC0Kccwh49pjFXs1bjCbH9h1gYn+aPAvQPBaLA4zk4JG2xU8xyWREbq7pZ8WV0/6tG
	7NvhrFY6zNCB3ioBp0pOGtqQl67TPnpLIIt1nLO4+XvLyypn2h+E8fzn7hVM0S3ko2cxLq
	oi9gS23Qp+Ac8V1tVXwp6dRYWGjB9qI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-bY2sT6g0P9Sikdln8nvAkw-1; Tue, 28 Oct 2025 17:14:47 -0400
X-MC-Unique: bY2sT6g0P9Sikdln8nvAkw-1
X-Mimecast-MFC-AGG-ID: bY2sT6g0P9Sikdln8nvAkw_1761686087
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88fec61f826so1731600085a.1
        for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 14:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686087; x=1762290887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HrvyEcRFoneqk86qrnzAoo3f6d+zdXeHYtZ1JCa9Ps=;
        b=Tcpn1AmPAhMDL5kVT8HHHPS6TjE7KL6ckVGmUtlCZqW3mGM8PUezbiv6fHF7+CNV+g
         t7ZWwRzdIdTXL0F/NpIait/PMiiLli7GyzKZFvTiPIN7SBu3k3E8FDK8Wi/Blkh+dUJl
         KYZUfiqpXV3xE9nZNCCMRKOOWv5Vgy9NC0GlXwFcqR0J7ao+0+MMLZomgNDal3xFRDQ9
         FURevRZ3NjyBVJUiePWlWOQNpIY98mgGdsdK5FLpNh+DrcYBSvcKdV1j25z7kTTJ8+SM
         Y5feqGgK9gEMbXo7kGLQIhka6Kac1kkktFUfel+4Od38oqrz48K64kRDSCZ/1Fb4HZ+j
         o4tA==
X-Forwarded-Encrypted: i=1; AJvYcCUn+PCVzQlUTBTCdkYuGlA75pZ3P/Fd2xzDwb97nABhWKpPBIqk8peViEm9g0LB+CfzRewWGjOMamQ0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xqWpIJD41G/+7M5nhkVyJOU9NA+eNsM9E27YS25gzXuNkBS0
	FhJMzQU58f2MBLc4yR4jeyIUniV60DM0wCAX2L4ALHLic5t9pS/w2CIR4bsXyg3WH9J0ynnJpoX
	BK3Kgf3W4QG9eJZOQ6Ebdh3i2K0yMbct3USjW0Re2vXh2OJ6VKwSGy22NsbwNGeo=
X-Gm-Gg: ASbGncsPX7DINR2CaLnaq24Hg6/HwJpIwxObpQw+JoT+deDeWTGZMKOry3yBKMGVnvg
	bRCaBkS010Hkh9d8lW47G/zVcCCIa3TGnMoi1smDCzTPIzeP7PGx4KW8Gsue+Q4bLy6fPYXJ6kT
	YwNYymLE5LY7BDzcV2g3UWKjbRsGV9IWZlYmcDRS0vWwzKb4zdnur8Hr01gqoiahSCvfoeCKtND
	pfhzxSOeySV08eYVNEg8ayOEZktSXbFizQTx1MAoytOBWII9Rk5C5qOkPTFm0v4AQkq3nTKYDCR
	raDe86tj6wxqER9IYBbEmdliTipYyUdCt+fd6d3QDl5jXreiL0E6tXc+WnUJt+P4NW0TSTYSI6i
	xhQ==
X-Received: by 2002:a05:620a:192a:b0:7f7:8271:1a77 with SMTP id af79cd13be357-8a8e426cda9mr126340885a.13.1761686087106;
        Tue, 28 Oct 2025 14:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8D9LTgZgrHHdWeOYc+DL8B2sdCN5Uw6C+NWfSsJhoUGyXAHdeOuejLijrW6CXCNixE1Fy2g==
X-Received: by 2002:a05:620a:192a:b0:7f7:8271:1a77 with SMTP id af79cd13be357-8a8e426cda9mr126337685a.13.1761686086724;
        Tue, 28 Oct 2025 14:14:46 -0700 (PDT)
Received: from [192.168.2.110] ([70.49.125.126])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f254a297dsm929505785a.28.2025.10.28.14.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 14:14:46 -0700 (PDT)
Message-ID: <5cc06269-5a6e-4874-bf68-fa4790f22bc2@redhat.com>
Date: Tue, 28 Oct 2025 17:14:35 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: fix HVO crash on s390
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, osalvador@suse.de,
 akpm@linux-foundation.org, david@redhat.com, aneesh.kumar@kernel.org,
 borntraeger@linux.ibm.com, mike.kravetz@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20251028153930.37107-1-luizcap@redhat.com>
 <50d815a1-8384-4eaa-8515-19d6c92425b3@oracle.com>
 <20251028161426.35377Af6-hca@linux.ibm.com>
 <5c72e064-9298-490e-b05a-16be6b5590b7@oracle.com>
 <20251028170251.11688Aa3-hca@linux.ibm.com>
 <4f522b65-1ab8-4725-8da7-3f071e7919c1@redhat.com>
 <20251028193708.7213A7e-hca@linux.ibm.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251028193708.7213A7e-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-28 15:37, Heiko Carstens wrote:
> On Tue, Oct 28, 2025 at 01:15:57PM -0400, Luiz Capitulino wrote:
>>>> flush_tlb_all() however is the *closest* equivalent to this that's behind an
>>>> arch generic API i.e. flushing kernel address space on all CPUs TLBs. IIUC, x86
>>>> when doing flush_tlb_kernel_range with enough pages it switches to flush_tlb_all
>>>> (these days on modern AMDs it's even one instruction solely in the calling CPU).
>>>
>>> Considering that flush_tlb_all() should be mapped to __tlb_flush_global()
>>> and not __tlb_flush_kernel() on s390.
>>
>> You're right.
>>
>>> However if there is only a need to flush tlb entries for the complete(?)
>>> kernel address space, then I'd rather propose a new tlb_flush_kernel()
>>> instead of a big hammer. If I'm not mistaken flush_tlb_kernel_range()
>>> exists for just avoiding that. And if architectures can avoid a global
>>> flush of _all_ tlb entries then that should be made possible.
>>
>> Should we take a v2 doing your suggestion above for now and work on
>> the tlb_flush_kernel() idea as a follow up improvement? At least we
>> go from crashing to flushing more than we should...
> 
> That's of course fine. I guess for stable backports a small fix is the
> best way forward anyway.

Exactly. I'll also see if I can find time to explore your API
improvement suggestion. I'll send v2 shortly.

