Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0DB25E443
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197148; cv=none; b=nMiI75FXpZ2x6ncDdDTczrnM6kFb0Q2hH7PoA2rWMsuGg/o+iOrcDdlF/HmKqJiewAkN5dFYehuGyQTq8qIgMzShM/dCPTlo2uUIn5LHbSj3ZsakAoVnjXgieSCDlNjSQTdxQubrrDu2bcrzrQxGVG3zpIscj80hTnMiHS1J/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197148; c=relaxed/simple;
	bh=AAGrQNtBuN1ihWdkerk8c2neW/iHPIvIRrwJh+j8YW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6bd1RCwMuNzdFzFQwlMeucDf6iARQVxi3svxxIJhsmADcRJnN6nnVZrjfWSgm8nZnkpBdf7Oy35CNArtMIU/HksrXHzIEUdLYZgwiR5lfXe4UFrc2uBzP2MsNWdXC5cKfEEL3timtbwNutcV5twZD7r3LeAtgD5IsBuecVOgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3gJYrqQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3gJYrqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744197146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9nMsTneqx3jgd8j4ujUAwXpeFm7NDC75tljzqi5ciEg=;
	b=e3gJYrqQW9WpR5qRp3j8L/4+bTJB7BD57KUE6UBlGXRKd4S4IiBOQvLFUvrQftDdUZC1xf
	GsK+VvGqY/+upelrt+pGfSFTJi6Ecx8Ihs6UbTCIjbxOIZxiv2PDjYrCEVz861srdrhdrn
	3gGbPb33BhlWHjmbN4IEsDoNQTlmJMY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-y-Ki3phGNJGVnnwLaeBt6Q-1; Wed, 09 Apr 2025 07:12:22 -0400
X-MC-Unique: y-Ki3phGNJGVnnwLaeBt6Q-1
X-Mimecast-MFC-AGG-ID: y-Ki3phGNJGVnnwLaeBt6Q_1744197142
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso43202045e9.0
        for <linux-s390@vger.kernel.org>; Wed, 09 Apr 2025 04:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744197141; x=1744801941;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9nMsTneqx3jgd8j4ujUAwXpeFm7NDC75tljzqi5ciEg=;
        b=XrBpuoKezFc+D0V15BBAQnKTX3S3gpKFzG/39QWJGc8Y0vAEoJKwAEgTFpqcuET2Es
         HWb4rIX5telDfSK7CW7GfKQYK7GBOo3EevQQgXSpMGN7iDPFauzc2lpsNq5wEPxrd2MQ
         n3tBvc6+2Aq7Pg5RZhiipHIJO7hmcNkEkSBJ5IcrkU6rfhRQEh/7uOlbBSNlNuU5aPkm
         jNzowTLkWp2F7+1yxPUdMDqBe5Ets9J5A9urRzOPTE1nr+e1owLIX2qJG9CFpvAXq3kk
         uuYYqRWSPahb9U1vDwr+dCPfYBGnSDX9PVB3z8UibcgDSC9wFDsK4I0mSiP4LGfmRkyD
         dkLg==
X-Forwarded-Encrypted: i=1; AJvYcCUe1Dzoktt9EdprN7mrMrKFn7dLUWdXeDCQn5hQGYv5puF4ILRu6Sm5BwEEBt4weRQrQCf7zuS+EZuq@vger.kernel.org
X-Gm-Message-State: AOJu0YyANpO3HgsbfDdOD8yE6JtIH63nUwec6DKuOLX4NlehlRk+KT5u
	5Qp7refY7tefrlj4c2u6juNY2+B2lVxXKnwNuhJJJJHJzTXVVrbK8DCaz1U0yE2Eia+ddDbxqoU
	N9nzY77xUZzQheX9OULMfUGrGFYImc3Xy6ivP9O5/WdF3OLhnnW1kHyK+1zQ=
X-Gm-Gg: ASbGncvHlmL4FKOC6ynwLU908AH2gOKJHiivAPg5S3RFuSvxo+ZtKLVAvr0eBXnN54c
	kGGJg02yDAv6R2cl+4lCHJie2icK3Rei7EvY2bboznM19l8IQMWt9PGd+YboWWZFvaQC1KiOfrX
	tMi3P7atYlNbhaqnYZmmG9cj0+BwHj3tXN8X2wEXpkb9hWNREIGrpmS86Fr9zcSPan47uQsUmq8
	rzKlhW614zx5h+DjFpHnr2OrTtseOriK31xZ5zUu/6061Yki5c3ZYbgODFw04DXX6TQpJH6rK57
	nB+8GIUxNT7P2dQV2Gu69HkAFX6OysspQClVU0re8g2voyryKOYfWXWEDUQyLrhoxI93ZZ+Fl91
	2AxZHQXVUZqKJP/YBazbZUiREs+ZCOysmuw==
X-Received: by 2002:a05:600c:34c4:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-43f1ed4b457mr20836745e9.23.1744197141489;
        Wed, 09 Apr 2025 04:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHeq+EHpYUUJQTQEveOg8AhmUdTBJBmzjzPv6OgTA7dYxMwOEXTBGbX0Gy/p01wy2MxV6TMQ==
X-Received: by 2002:a05:600c:34c4:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-43f1ed4b457mr20836585e9.23.1744197141076;
        Wed, 09 Apr 2025 04:12:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:8400:ed9b:a3a:88e5:c6a? (p200300cbc70d8400ed9b0a3a88e50c6a.dip0.t-ipconnect.de. [2003:cb:c70d:8400:ed9b:a3a:88e5:c6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893fdf6dsm1343797f8f.90.2025.04.09.04.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 04:12:20 -0700 (PDT)
Message-ID: <4ad4b12e-b474-48bb-a665-6c1dc843cd51@redhat.com>
Date: Wed, 9 Apr 2025 13:12:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>, Halil Pasic
 <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
 Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Wei Wang <wei.w.wang@intel.com>
References: <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
 <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
 <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
 <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
 <20250407170239-mutt-send-email-mst@kernel.org>
 <440de313-e470-4afa-9f8a-59598fe8dc21@redhat.com>
 <20250409065216-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250409065216-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.04.25 12:56, Michael S. Tsirkin wrote:
> On Wed, Apr 09, 2025 at 12:46:41PM +0200, David Hildenbrand wrote:
>> On 07.04.25 23:20, Michael S. Tsirkin wrote:
>>> On Mon, Apr 07, 2025 at 08:47:05PM +0200, David Hildenbrand wrote:
>>>>> In my opinion, it makes the most sense to keep the spec as it is and
>>>>> change QEMU and the kernel to match, but obviously that's not trivial
>>>>> to do in a way that doesn't break existing devices and drivers.
>>>>
>>>> If only it would be limited to QEMU and Linux ... :)
>>>>
>>>> Out of curiosity, assuming we'd make the spec match the current QEMU/Linux
>>>> implementation at least for the 3 involved features only, would there be a
>>>> way to adjust crossvm without any disruption?
>>>>
>>>> I still have the feeling that it will be rather hard to get that all
>>>> implementations match the spec ... For new features+queues it will be easy
>>>> to force the usage of fixed virtqueue numbers, but for free-page-hinting and
>>>> reporting, it's a mess :(
>>>
>>>
>>> Still thinking about a way to fix drivers... We can discuss this
>>> theoretically, maybe?
>>
>> Yes, absolutely. I took the time to do some more digging; regarding drivers
>> only Linux seems to be problematic.
>>
>> virtio-win, FreeBSD, NetBSD and OpenBSD and don't seem to support
>> problematic features (free page hinting, free page reporting) in their
>> virtio-balloon implementations.
>>
>> So from the known drivers, only Linux is applicable.
>>
>> reporting_vq is either at idx 4/3/2
>> free_page_vq is either at idx 3/2
>> statsq is at idx2 (only relevant if the feature is offered)
>>
>> So if we could test for the existence of a virtqueue at an idx easily, we
>> could test from highest-to-smallest idx.
>>
>> But I recall that testing for the existance of a virtqueue on s390x resulted
>> in the problem/deadlock in the first place ...
>>
>> -- 
>> Cheers,
>>
>> David / dhildenb
> 
> So let's talk about a new feature bit?

Are you thinking about a new feature that switches between "fixed queue 
indices" and "compressed queue indices", whereby the latter would be the 
legacy default and we would expect all devices to switch to the new 
fixed-queue-indices layout?

We could make all new features require "fixed-queue-indices".

> 
> Since vqs are probed after feature negotiation, it looks like
> we could have a feature bit trigger sane behaviour, right?

In the Linux driver, yes. In QEMU (devices), we add the queues when 
realizing, so we'd need some mechanism to adjust the queue indices based 
on feature negotiation I guess?

For virtio-balloon it might be doable to simply always create+indicate 
free-page hinting to resolve the issue easily.

For virtio-fs it might not be that easy.

> 
> I kind of dislike it that we have a feature bit for bugs though.
> What would be a minimal new feature to add so it does not
> feel wrong?

Probably as above: fixed vs. compressed virtqueue indices?

-- 
Cheers,

David / dhildenb

