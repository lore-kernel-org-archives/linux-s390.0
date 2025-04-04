Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A91EB1B8
	for <linux-s390@vger.kernel.org>; Fri,  4 Apr 2025 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774536; cv=none; b=CgWBnlcZ1geU4ItdVnevBMDvy/hIoCCyWTSToemh+dnbcFTKT/Qb76/GSMokjWUYRC/lfcWYq7+gmiXila3IXZ4G9cOLdHGR/5L2L413gF2JEli+9vjmf4G3zEvZQMeTHaM2CS4uEHuX8bjbiGgMng1y15XH5ug2+y0fs6/Tmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774536; c=relaxed/simple;
	bh=/LoNyuqZkNHlaGAsryiCLwoc4jmD6q9kXkjXuLH92HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsSr++sPsc8myuNLlU0Tg3WpAB+3sdoerq4Spxy6PGiJQTWnDX3MJiVB/TbKtxb5WC2kvjWl/rl/8x5zagFj70AeHbY9RXbl9Y1vEtHvL5+FufSBPglREE5MIHzwnw7JEzSdbDjMEjNfajc3EZdXRuidi+4ZZeFLMEI2Wm0ZTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQa0zimK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQa0zimK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743774533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aIFufL6GeNlo+jVuLlnkG+OJQ7hMrZuqqKT+ehHwkXo=;
	b=IQa0zimK6dyfFudAgopQ/q7kJ1K6tmFNgO5lR9TqDz7NDIN2oEjgZDGfn4M0yfHUiqRhhz
	prCMcMf6GlIckwVHt73TAbWokbkSoQQc9rti60az1+cy6+VCXtFZJgnF4qqTB8Cm6U5cVD
	15urB0/xgY0YrpCFFb+5luWtd9/MNjQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-6shlzN_yNWKVdTG0g0pFBg-1; Fri, 04 Apr 2025 09:48:52 -0400
X-MC-Unique: 6shlzN_yNWKVdTG0g0pFBg-1
X-Mimecast-MFC-AGG-ID: 6shlzN_yNWKVdTG0g0pFBg_1743774531
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912fe32a30so975493f8f.1
        for <linux-s390@vger.kernel.org>; Fri, 04 Apr 2025 06:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743774531; x=1744379331;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aIFufL6GeNlo+jVuLlnkG+OJQ7hMrZuqqKT+ehHwkXo=;
        b=WI1goGI/O+ebrRBGmxis2tNNHwX5QAKTZZBcdu46oiL0SJmstqJvyWCgypfcunS9Nm
         5xtwDqSKYe3uCRTTlHNj25YEVj9B8kQUGDT39FbtX30aRqxG77yo0RRjBFqz1Qz7pxYv
         X2B56lFqqHV033poGZTvvJlxknDLDwxufsQKlTKXaxOA9E3wd0bu/Al9vrcC6z7OXUI0
         zh3dpXFf+JWO5AHkv2pdqqvcmKTkBXPiMZPXDpDRJTcIMp1+e2IyInI6z/dcMPd/fO2g
         0bf8+15lQnzJY5oIXuSETeyc/ULAy8QV7cWTAG/jAZiXpa5w4IjBSPmsW0FN8S8PieEH
         J52g==
X-Forwarded-Encrypted: i=1; AJvYcCWEsGkc75CikW9eawjEZIaXJJ2qzaKr2xkE0gxYI/3yIckbrw6Ha0VEA+YL/cKcreNlGv8hLaOPT6ub@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/CP2J+0Lnf/mj28cFIrHgsFf5apMWrE8JyTx7gfQhsFrDBed
	UFGUNRzgREG+WfjlNLiIls8kCvEa8mbhZr52jOecieBwoUOGaAwHWJnhGqYELkeBTWVcDDAagb1
	nqCMlZwbC6GNrCZ8IEw492TbfV3z4V9/lEfGvMfve6bgJ53kFzEwBTA9/QOA=
X-Gm-Gg: ASbGnctg84XEkhkbQ7nB2DHhKdOwpEojuMCYqQQPz7HkNMMwPkRx9jsyc5XVGjoki0z
	9EIx7eqUAT0qmUykOUkmUQUOKZ8yFq6nGGevMw2+tZhu4rgVKka1ChrvnBEdel4uLQ1H9IaDzOl
	3wnNlPqTYa/eZT/2IvopQ2l2zKtY/o/qC0iXMlJo7EqWAOWxW9hipQJPUPY0rBvXuVFu0kKcXdc
	D5IvqbYZ+i1dXINEr1Th+NVUOaRpFXNs5IMdOTzfTgJnv+yDIL6VxULj0eINI5LjNREmTTdqp4O
	P0YxoJMqPvKOZlfNQhUQpMxUqLyI+3hbQvKW8Lr8gclN5ZqLTXltBfBGy4TgyIbeb6YBGZrIKZj
	zoaIpyrE49+abVOVyjlgq074pRaY6cb7wh/NbKSix6u4=
X-Received: by 2002:a05:6000:248a:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-39cba93245dmr2879740f8f.25.1743774531193;
        Fri, 04 Apr 2025 06:48:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhlPl7enqIiLMXYl6+JR/5GXEO9+RAt+ekX6lCH13CQz2tU1h487SfdpVFZg/GMaC+rM6XGA==
X-Received: by 2002:a05:6000:248a:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-39cba93245dmr2879713f8f.25.1743774530824;
        Fri, 04 Apr 2025 06:48:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm4439713f8f.72.2025.04.04.06.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 06:48:50 -0700 (PDT)
Message-ID: <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
Date: Fri, 4 Apr 2025 15:48:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 Chandra Merla <cmerla@redhat.com>, Stable@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250404153620.04d2df05.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.25 15:36, Halil Pasic wrote:
> On Fri, 4 Apr 2025 12:55:09 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> For virito-balloon, we should probably do the following:
>>
>>   From 38e340c2bb53c2a7cc7c675f5dfdd44ecf7701d9 Mon Sep 17 00:00:00 2001
>> From: David Hildenbrand <david@redhat.com>
>> Date: Fri, 4 Apr 2025 12:53:16 +0200
>> Subject: [PATCH] virtio-balloon: Fix queue index assignment for
>>    non-existing queues
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    device-types/balloon/description.tex | 22 ++++++++++++++++------
>>    1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/device-types/balloon/description.tex b/device-types/balloon/description.tex
>> index a1d9603..a7396ff 100644
>> --- a/device-types/balloon/description.tex
>> +++ b/device-types/balloon/description.tex
>> @@ -16,6 +16,21 @@ \subsection{Device ID}\label{sec:Device Types / Memory Balloon Device / Device I
>>      5
>>    
>>    \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtqueues}
>> +
>> +\begin{description}
>> +\item[inflateq] Exists unconditionally.
>> +\item[deflateq] Exists unconditionally.
>> +\item[statsq] Only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
>> +\item[free_page_vq] Only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
>> +\item[reporting_vq] Only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> 
> s/is set/is negotiated/?
> 
> I think we should stick to "feature is offered" and "feature is
> negotiated".
> 
>> +\end{description}
>> +
>> +\begin{note}
>> +Virtqueue indexes are assigned sequentially for existing queues, starting
>> +with index 0; consequently, if a virtqueue does not exist, it does not get
>> +an index assigned. Assuming all virtqueues exist for a device, the indexes
>> +are:
>> +
>>    \begin{description}
>>    \item[0] inflateq
>>    \item[1] deflateq
>> @@ -23,12 +38,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
>>    \item[3] free_page_vq
>>    \item[4] reporting_vq
>>    \end{description}
>> -
>> -  statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
>> -
>> -  free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
>> -
>> -  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
>> +\end{note}
>>    
>>    \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
>>    \begin{description}
> 
> Sounds good to me! But I'm still a little confused by the "holes". What
> confuses me is that i can think of at least 2 distinct types of "holes":
> 1) Holes that can be filled later. The queue conceptually exists, but
>     there is no need to back it with any resources for now because it is
>     dormant (it can be seen a hole in comparison to queues that need to
>    materialize -- vring, notifiers, ...)
> 2) Holes that can not be filled without resetting the device: i.e. if
>     certain features are not negotiated, then a queue X does not exist,
>     but subsequent queues retain their index.

I think it is not about "negotiated", that might be the wrong terminology.

E.g., in QEMU virtio_balloon_device_realize() we define the virtqueues 
(virtio_add_queue()) if virtio_has_feature(s->host_features).

That is, it's independent of a feature negotiation (IIUC), it's static 
for the device --  "host_features"


Is that really "negotiated" or is it "the device offers the feature X" ?

-- 
Cheers,

David / dhildenb

