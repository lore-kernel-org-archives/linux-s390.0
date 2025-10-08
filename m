Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC02EBDE9
	for <linux-s390@vger.kernel.org>; Wed,  8 Oct 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916594; cv=none; b=BioV2xF97kw5HvSREgaey0J8ohHlbS6wM+qPjF/a3u5+Y6Us/hk84x5Vp5SkBGfEdGmRM6+qpIk6Qof3KdtrqkaRoMK/C1Nmu61I9alXGZmmfy6j1aFpUWaVGhVpLlPVeBTkg6gdKFnAUbD5pv/ExArZV0+BGrDyTRwzSa8L7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916594; c=relaxed/simple;
	bh=EgzJyb14mOG30JZpf3Du1BkGUThOSDWk4PkwBOZ1Jig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSmo2XauXas10pZZ8fWbgp0TQyT6ZHkX99l9YxJxmdhVpIISpb2CqKrMzMuZRSkwGf0RkAHefLXuAJKs3ZGLt1D4DHuIAW8q4pfhODZvYNuT+VWTHGbNCgNQZpgSaoLxsFaQNjehk7q1cnSkX+f66rY60ikpZ7/QJ+lmlNNT2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFyqC6HO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFyqC6HO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759916590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JD/HSn//vajjys6bQcekYCIiWa+gYSHGEuJh3U25KF4=;
	b=LFyqC6HOuzSqXdpVo3/F8tKPhrHOFV6dMU1LhEAv7zN1guM/YEDWV0NVJ0k/2kKn1x3KnO
	X5lXbJ4LkegWKmM0v94XPdlKwKOP3JOcsNc2+oB0Xk+9SO9r93lpC0tmz5HbYcgI+CyxWO
	UA7i7K2v8RjNYRwBT4xY5cTWbGXUKaE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-OB0qIO9CPsGPp54HtLHl5g-1; Wed, 08 Oct 2025 05:43:09 -0400
X-MC-Unique: OB0qIO9CPsGPp54HtLHl5g-1
X-Mimecast-MFC-AGG-ID: OB0qIO9CPsGPp54HtLHl5g_1759916588
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e473e577eso37705045e9.0
        for <linux-s390@vger.kernel.org>; Wed, 08 Oct 2025 02:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759916588; x=1760521388;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JD/HSn//vajjys6bQcekYCIiWa+gYSHGEuJh3U25KF4=;
        b=Fc7pyAboCoQX9D+4x/rfCVkF5skcJo7d77n1jaoxFSvu9v5iOKJaM+64zWXnQwGHuQ
         LgDqTHQPCtZHjjFFy226f2xi/B1e6AStjuZ11yDJzZoaf3w1QnZcu4pjTpv2BY0YVo9G
         b7om8faO1HZBbV5ZOEZ0smZBMX3UwxJbUAUqBuktgfEZzu+JxTSwm2v/ByzMGoZM0qtL
         oSkTnmPxTIIwaOtFcf1/O3nTFRLts7aHgv+qYQzoG66UYwDoMnFHf0RmyEVZppDTBeUj
         ymAPi70NBjKiGgk7AahNbhWPeAZrm2Y+yq/Nd9Rlo2O5kTrEvlcK78rtvwsGC4tx79Dv
         Kxrw==
X-Forwarded-Encrypted: i=1; AJvYcCVthaROGa8F9Jk17gQ7SetU5rj3TjAMVqKgc9pGhuaU8KKSmUb7upM6FdJrfcP+zxd2JZnSJp99E1Zt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZlFNfXhA7DmLDVhWb+jn00P6DOqOxVL94K+AM7wgc/iMp2ln
	nFxqLR7+MlSsxqvy7swNNX8M7vtFpDYKAJxRgKLr590RnMmt6OYYCQEwqwT9V+oXcQQ1OA1j+Km
	FCJ5Io1GrS/ZNEjv+/sroTOMUfVYGDiHorIFlp0jfonwWHNpENv2H0RbNYMTDYds=
X-Gm-Gg: ASbGncssZoRqlCG8uDvbmfRdlSug9P+bzyYdNXVGXB1A/lpRIqQAh27B3GHSbJQ/uvW
	s2OdFvMpr+0kNqwRlT65QUqcqe+HRoGvmDqs20RLuTZ0JF3w3nWln0hI8zHDdiPaB56xDH7aq/K
	MSiswow99IhiP8wRxwxkZmjsenStbhD6T04MfJ24ROEVkmmW6NA1dBKYuoUuGSrPK4VtruDBzMR
	oryntGTcAkwg0enWWJmABr3St/yZrdin7un4s5YZ//21ATdXVIYo+n2QHPE/UpQ1JbmcuCL3Syv
	FgZMYDzDqXfYyG2qGXaeA/Y7+Mnsu03ynkTrqCViXVEE4lYsZrGK0oEfR7tdaAD8sJebnA+AV+K
	Sjm7/T8Mz
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr19134805e9.6.1759916588205;
        Wed, 08 Oct 2025 02:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYzPp9F7S3QX2xHYqfV5S6fHz6gcoGlAerW1ZxI0fAG/Jst1h7y7+sJqtkHP4Cco90/r1u5Q==
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr19134555e9.6.1759916587743;
        Wed, 08 Oct 2025 02:43:07 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf94ddsm30134765e9.2.2025.10.08.02.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:43:07 -0700 (PDT)
Message-ID: <abdd6107-d380-48f5-9a25-22a5f560c78b@redhat.com>
Date: Wed, 8 Oct 2025 11:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Support dynamic (de)configuration of memory
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-s390
 <linux-s390@vger.kernel.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
 <ab366c03-8c78-449d-bfc4-2d155212d9d7@redhat.com>
 <aOVUNmDiWgrDJ1dJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <5e3b16ec-9ef9-483e-b97e-bff0c1915b19@redhat.com>
 <aOX_L1_2S30XhLRA@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1efcb368-fcdf-4bdd-8b94-a705b7806bc2@redhat.com>
 <20251008091226.7407Ba1-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251008091226.7407Ba1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.25 11:12, Heiko Carstens wrote:
> On Wed, Oct 08, 2025 at 10:02:26AM +0200, David Hildenbrand wrote:
>> On 08.10.25 08:05, Sumanth Korikkar wrote:
>>>>> chmem changes would look like:
>>>>> chmem -c 128M -m 1 : configure memory with memmap-on-memory enabled
>>>>> chmem -g 128M : deconfigure memory
>>>>
>>>> I wonder if the above two are really required. I would expect most/all users
>>>> to simply keep using -e / -d.
>>>>
>>>> Sure, there might be some corner cases, but I would assume most people to
>>>> not want to care about memmap-on-memory with the new model.
> 
> ...
> 
>>> 2) If the administrator forgets to configure
>>> memory_hotplug.memmap_on_memory=Y, the following steps can be taken:
>>> Rescue from OOM situations: configure with memmap-on-memory enabled, online it.
>>
>> That's my point: I don't consider either very likely to be used by actual
>> admins.
> 
> But does it really hurt to add those options?

Oh, I don't think so.

I was just a bit surprised to see it in the first version of this, 
because it felt to me like this is something to be added later on top 
quite easily/cleanly.

In particular, patch #2 would get a lot lighter also in terms of 
documentation.

So no strong opinion about adding it, but maybe we can just split it 
into a separate patch and focus on patch #2 on the real magic?

-- 
Cheers

David / dhildenb

