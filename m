Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A517C210
	for <linux-s390@vger.kernel.org>; Thu, 21 Nov 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203451; cv=none; b=EqAsk7UArKO93GAAKrBTWVCtgJSVu8jmbVRv9OhQBVibAnnznHm4cfw/zTWAygvoti1S+Yfj19Vs0/CcCdwIri8dGYi+nwuB2yXMIXxF7uc2rWa2AhSWD385N96RbyjJzDdgxdevU/sPSfGjw48UdKOGcrl6rpDzz+Sq/B7ip60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203451; c=relaxed/simple;
	bh=eckblXHkSvhd8BGyR9du0j4hp1Pb4lGIxwfEguEklLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7oHSUuxSlxjQS7MtPTieIU0hoVlJME8KY1x9BIQYVmT+oqdYitH4zveCtU6hOS1UkMx2H/m5JT4Cc3gWwM4Ddn8yYz9QAar9Ox4RquQVDalZeEB+r88ldZoqN2o9bL1FWoK/GzBJjuYitNLTNeIzEUwXARQHF7i1FkfyUQkork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0d5vox/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0d5vox/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732203449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eS7bGCy5YRnQF1VVX3hqmSIuG3NddVnWmPFA2i7JUNM=;
	b=G0d5vox/YZvI4HoyhYRlGw5JFjVU8p/iiFKFG+LN4+CkSkNYDUIK29YDqJz6CRRuvhHEB+
	pW5qrwTOKFaMQNzM2rsLjXldVjVFzAcvMt64hW8tqlP7G/bc4Exp894XgDQGweSXWpioKt
	z1CqnYTkbxfolnnyinzyUeIk6CBqTwU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248--SRvmL5INgqG9ngr1UJvgQ-1; Thu, 21 Nov 2024 10:37:27 -0500
X-MC-Unique: -SRvmL5INgqG9ngr1UJvgQ-1
X-Mimecast-MFC-AGG-ID: -SRvmL5INgqG9ngr1UJvgQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso9284575e9.2
        for <linux-s390@vger.kernel.org>; Thu, 21 Nov 2024 07:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203445; x=1732808245;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eS7bGCy5YRnQF1VVX3hqmSIuG3NddVnWmPFA2i7JUNM=;
        b=eQb3lnZk92Y77LM5cydC30WXAXmzLUssD3h2ICehGq8RykTnCxzrrJezwUSIQWDN7F
         C9mTR45uQiu39owuh5oc1Zkf8+uT8WJ8YDw08j4C3U1EyFxXNYBlL2HU/AyiIzY1E9FH
         1pSQGssa6y1dMLmyC9JowF7mYDd6N9bb6PDswNu9EWGadFx86qvjTLAkjWJrLPQohHdr
         1OzrcU25aVVwKcfFdaUh6eMc7p7YuXzrmiCtgFrjgEs2T4s/N4BbApSp2O3h+AzwtADj
         cIt3ftSjQwN0aKEWgY9MDphaaN3UcANLOGpZcUPCxC16/+z9HzqoAWqc+LY/MrLSAkGa
         n1Fw==
X-Forwarded-Encrypted: i=1; AJvYcCX55Fxk7IoI2vQgWwBP5lJ+KyOKA512IEOyZYggvGIWQ3KTQ6fo/9Cyj5Ua3te2ZITXmer86geQyBbd@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDwoYagp7FGiPQ8etCq8obgXOJQpG0x/1zo0Wa9G0Kdgr7c2N
	YCQfuDXh06km/BefPhFcFPIuil2P59+77tN0kpyKJdNcC7tg8ONmMRXqCeFo88ms1Qu0DQvrDmh
	DsDS1J8SaHWUfbcQ3dHk5VKHhHdTQ6We2/wfHUuyX5tBoSmGZl+/ceOCnDSY=
X-Gm-Gg: ASbGncsAHSPrS3qYSi27lbPQ0PmVzd1E+jzYQCHxzIv4lPkEELvep0f4b//rR+GSEGx
	gthL0o2kPJE90OO+MPylItKzIlnHkabxp/BX+R+l1NxaMHOTZIw1jVYLaUQwA8wk09Dc6+OQI4u
	WdASiMjbQrnUh0DVVYukI9Ck8cDBGAXumSBQ6tQyxSEDYmW5bqqY8FMu5XMXpPmrabYVbj63h94
	QeShCGI0Lajsf+lcegtdgCEh1aTsvJ1ESd523n9FKl20SeYdG7wwG5QI41r+ERTU3q6hI1YNyJc
	hT6QRu3Q0XVVrHr9bcXQN/AEx5SLJb3leoNeJNC2XVayKMJ1w1GjqSRHW4rZL39JiM7wgWHQICs
	=
X-Received: by 2002:a05:600c:1d93:b0:42b:ac3d:3abc with SMTP id 5b1f17b1804b1-4334f01548dmr68139815e9.24.1732203445509;
        Thu, 21 Nov 2024 07:37:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcWfaRMIf30Hgg52d+hIlcLWUuMutdNfVmMqgbxuJi7boGn2lsfYZzyLLvkfHTbZQW2nzANQ==
X-Received: by 2002:a05:600c:1d93:b0:42b:ac3d:3abc with SMTP id 5b1f17b1804b1-4334f01548dmr68139385e9.24.1732203445201;
        Thu, 21 Nov 2024 07:37:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:de00:1200:8636:b63b:f43? (p200300cbc70cde0012008636b63b0f43.dip0.t-ipconnect.de. [2003:cb:c70c:de00:1200:8636:b63b:f43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d16f8sm58469525e9.2.2024.11.21.07.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 07:37:24 -0800 (PST)
Message-ID: <b778d6d2-729b-4416-bc12-78a2e85b08f3@redhat.com>
Date: Thu, 21 Nov 2024 16:37:23 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] fs/proc/vmcore: move vmcore definitions from
 kcore.h to crash_dump.h
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-5-david@redhat.com> <ZzcYEQwLuLnGQM1y@MiWiFi-R3L-srv>
 <ca0dd4a7-e007-4092-8f46-446fba26c672@redhat.com>
 <Zz2u+2abswlwVcer@MiWiFi-R3L-srv>
 <120bc3d9-2993-47eb-a532-eb3a5f6c4116@redhat.com>
 <Zz64efFyFstyDdN8@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zz64efFyFstyDdN8@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>> If there are strong feelings I can use a different name, but
>>>
>>> Yes, I would suggest we better keep the old name or take a more
>>> appropriate one if have to change.
>>
>> In light of patch #5 and #6, really only something like "vmcore_mem_node"
>> makes sense. Alternatively "vmcore_range" or "vmcore_mem_range".
>>
>> Leaving it as "struct vmcore" would mean that we had to do in #5 and #6:
>>
>> * vmcore_alloc_add_mem_node() -> vmcore_alloc_add()
>> * vmcore_free_mem_nodes() -> vmcore_free()
>>
>> Which would *really* be misleading, because we are not "freeing" the vmcore.
>>
>> Would "vmcore_range" work for you? Then we could do:
>>
>> * vmcore_alloc_add_mem_node() -> vmcore_alloc_add_range()
>> * vmcore_free_mem_nodes() -> vmcore_free_ranges()
> 
> Yeah, vmcore_range is better, which won't cause misunderstanding.
> Thanks.
> 

Thanks, I'll use that and adjust patch #5 and #6, keeping your ACKs.

-- 
Cheers,

David / dhildenb

