Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F34503B
	for <linux-s390@vger.kernel.org>; Thu, 10 Apr 2025 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310201; cv=none; b=r+1OPvz1hBSaC0UaWfRX8voqHWEeG3Txkh5k3bQWk+eT9KV0pEce0dcjArSbMfaEEQSxHYMjzcmYiH2CxIHfwJIjqZh+wTl1TLqNkepFJIE8k5cOD5R4QlZ6b3wl7lmIlixgh+0eWYN3B/vT+dHx14T3oD9KfCjwl0rQsjVAB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310201; c=relaxed/simple;
	bh=gTNXq37akgqk6z+58rhQWAsjkG2V+MCF+5rA1Q6dX5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eG7jcmgSFOxtpqzs6lkNSDqxkPdnBiTK9nxXOLnx6MsEdWNtaghciO2WWCphScSPvPepBE4dL++CFPx5wOokyoYf4a5Z0OoGPKoor/XSsXwFnq4A+vgqrf6kxcwOqzcuF3h7da17KxaiPVxqqB53JRbz/6PITQUjPaxcRgV6YmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dd/JwoEH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dd/JwoEH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744310199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zr+Ng4jJFOHIi/H/AZxmASCM4Qn5ASJYm7koFScbolg=;
	b=Dd/JwoEHuR+EIcvaDoyFPJinGUVSJ10H3d2ZAB2i8/iEUZrzKy2GYXZ7JSb8V2Gm0K6Op+
	braEldHURCzc7zcLBEGQtxx2A5Li7dGWoxCMCIQoFRfN8Xe7MUzPqIkhzodxHlSOPxhZxr
	MfNkjCIQx1vbH8EHYky7zmHk6XjY6pQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-qyNY_04RMhmHgrW_Z6OfoQ-1; Thu, 10 Apr 2025 14:36:37 -0400
X-MC-Unique: qyNY_04RMhmHgrW_Z6OfoQ-1
X-Mimecast-MFC-AGG-ID: qyNY_04RMhmHgrW_Z6OfoQ_1744310197
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b19so8445185e9.2
        for <linux-s390@vger.kernel.org>; Thu, 10 Apr 2025 11:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744310196; x=1744914996;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zr+Ng4jJFOHIi/H/AZxmASCM4Qn5ASJYm7koFScbolg=;
        b=GrA1f6GamRrCP/j+z1i8pOo+dsgLU04HU2+87h7qwOdNmdCe97RIvoePulaGQu80yJ
         X7x0fNDYBY96g9oNskE1raOI1JjaenIdrUQF4qcY7/0dtlfLLfwv6kLdvbZgwgeMo0rH
         Yn6suEBXLbEAeQi2vDx47I79hg0ztfmIvievdqFTaY+gie82ZL2C2kAUp2pwVqFDNnTA
         Ls7GBS9o9KLVFlTR3u8R1DGvGTMPTDtnKTZEhKThdzp0OPJuxbdL0/72ljd7dV8qIMMT
         XoaKgNqL/xt4Y2kXbOB3WEnF2vA9D8r7rMjvv5DbKnePb5P52+jsZiT5xomq++5prB2u
         DbZw==
X-Forwarded-Encrypted: i=1; AJvYcCXDQ9aaLirQfuO92JonYmAanD8YhTXeOWA7GwQbinpblRrxBFfmcz632x9R9OzVf+AbTPiP0faNxTTq@vger.kernel.org
X-Gm-Message-State: AOJu0YzkvESOQZxsP+Y10FknEvFVXDQxhYI3EQ9MZ0eFNfZGxiV488nq
	60jy8ZraBEIZ09IjSwmN5FotAHTgz3vT+lSUPqPPeLMJvyQM5kR/hK1MeM8i3s7v7QMx6hBJt7I
	X8BD9HjIsCx8/T3cY2N+sxSQsy/Cc9JY9+D1cqL/Z1wS/GUXUHYDwaHMkyCs=
X-Gm-Gg: ASbGnctGyvaMzKjs1zcGMgR2ymfZNGWjiM+AhGFxTgKbiaI2s3FSWdhmmT3F2blWqG8
	2SmdtwyK3mUVaFutjVswic00iQZUchbLb2rgei90O/b34wGNvv/tx0DBmor8n+hr+F/SaiyeAKO
	NFcmdwEpnPKwOjIgo9a6hY4bSEqtdqepawoTA4l9/vJqxjA1CLF6kwjJvOUiLLys9SI1B/Yqgd9
	OVPrqmZcfZporAvshUD5AwR33N/8Zc76sYACXsY3Qe4/S6k556Z1jRiS+7RLrkMCBCk95s9752T
	WZ9Cwhcped08JWm2diSYaT2hbILJNM1JQDv7buhlrg==
X-Received: by 2002:a05:6000:40c7:b0:391:487f:27e7 with SMTP id ffacd0b85a97d-39d8f4ea82amr3475364f8f.55.1744310196632;
        Thu, 10 Apr 2025 11:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVaFm+41IJ7zizfBFTSY/K1PgcFhHzilk0IMx8IpDGRbcrJzSKoZ7cYNY7rCyvPExpXJUHnA==
X-Received: by 2002:a05:6000:40c7:b0:391:487f:27e7 with SMTP id ffacd0b85a97d-39d8f4ea82amr3475347f8f.55.1744310196268;
        Thu, 10 Apr 2025 11:36:36 -0700 (PDT)
Received: from [192.168.3.141] (p4ff232c1.dip0.t-ipconnect.de. [79.242.50.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89362fcbsm5439717f8f.5.2025.04.10.11.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 11:36:35 -0700 (PDT)
Message-ID: <83e8b1b3-fc73-4a49-9f6c-36489c3f39d6@redhat.com>
Date: Thu, 10 Apr 2025 20:36:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Introduce free_folio_and_swap_cache() to replace
 free_page_and_swap_cache()
To: Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
Cc: nifan.cxl@gmail.com, mcgrof@kernel.org, a.manzanares@samsung.com,
 dave@stgolabs.net, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, will@kernel.org, aneesh.kumar@kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, linux-s390@vger.kernel.org,
 Fan Ni <fan.ni@samsung.com>
References: <20250410180254.164118-1-nifan.cxl@gmail.com>
 <C40778F7-6A22-4A0E-9566-9D3ACC697EA7@nvidia.com>
 <Z_gNBRY_1UVe2-ax@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z_gNBRY_1UVe2-ax@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.04.25 20:25, Matthew Wilcox wrote:
> On Thu, Apr 10, 2025 at 02:16:09PM -0400, Zi Yan wrote:
>>> @@ -49,7 +49,7 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>>>   {
>>>   	VM_WARN_ON_ONCE(delay_rmap);
>>>
>>> -	free_page_and_swap_cache(page);
>>> +	free_folio_and_swap_cache(page_folio(page));
>>>   	return false;
>>>   }
>>
>> __tlb_remove_page_size() is ruining the fun of the conversion. But it will be
>> converted to use folio eventually.
> 
> Well, hm, I'm not sure.  I haven't looked into this in detail.
> We have a __tlb_remove_folio_pages() which removes N pages but they must
> all be within the same folio:
> 
>          VM_WARN_ON_ONCE(page_folio(page) != page_folio(page + nr_pages - 1));
> 
> but would we be better off just passing in the folio which contains the
> page and always flush all pages in the folio? 

The delay_rmap needs the precise pages, so we cannot easily switch to 
folio + nr_refs.

Once the per-page mapcounts are gone for good, we might no longer need 
page+nr_pages but folio+nr_refs would work.

-- 
Cheers,

David / dhildenb

