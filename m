Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5AD1E7C13
	for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513170; cv=none; b=jznUVorNEh51MWkAA+sjQL4lfpn8jxFYVdGqhKoHUKSKtmK864pEwumC9sHjI/bIP2AmY2HiUFZGKzoFiUb5PNn/UVccxnr0uhPmZ93GGEDppotjS9G2LT8FMsYtz97nIlJadhj1fLWhAFnlqOscwXpRDD/m9bUE+ZcsOtd/GS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513170; c=relaxed/simple;
	bh=85dwOBqgxabEtu7DlXSK3j+X36k6w41TKJHAAtHgg2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHKSWjXz4YJ542EONvnf2EE2hmuhhR8M+7DVz/t1fp1XRfZGPJ5WqdIrizUgUeO0bHiNFr1SnwdK9i/AWoNPE/oWsu1J2Uo9fUZErF2w6gS6F+n0RQx6d3fzw40CMPpR7sYrFnNPl1Uj7xGDzLewUa4knnsLJjY/pmKoJCih9Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itBqERyJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itBqERyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729513167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SSNANQOGj1r9ayrCBzVvFmFj/ChOB3ieC2hxuoZm3o=;
	b=itBqERyJZx0C2HdogBZrG1iHhbTD+RVGYjGo8WQyOwltnzNBy58AqH6ro8TNzpLRkxKfWp
	Ghvv3brzegyNpke9jO2nji55JSLzY5N46YCYOlXaLUHP98x3wvsr2abHHaXYNmm06pJFJe
	jmt/atFFhosb9d41FV9VbifIoXhVQHI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-JBnaO3nFORunbXZtrxsdYA-1; Mon, 21 Oct 2024 08:19:26 -0400
X-MC-Unique: JBnaO3nFORunbXZtrxsdYA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315d98a75fso29986995e9.2
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2024 05:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513165; x=1730117965;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SSNANQOGj1r9ayrCBzVvFmFj/ChOB3ieC2hxuoZm3o=;
        b=AI7nRwCoNCXXwnDUf5yzIMcZ90gRolfHAH41r922nO9zGxFbIueFjssHo/Lu8fnhFX
         XFtvH2e1s2OQoRilFre1odE1xqsdHMRapw1kKTcB2NhAhFHqZ+8XDFaak1WTvcXwF34G
         R9ZRbP2I2IOqpsX1Qx54WRpFNt2JVrWJSwwQKlgEffhHv+i0F+9GfpDrmfbZWvUdvFPV
         3B3vWm0fSdRtdezxUKEvPmPNStq1y0SYJAT2Sib3nRQDfDlygYwFXZ5pzbmD0GdL2xgu
         te10EXQtQXCAjGetX8wsYSKndACW6neRYKZ7mNbHB9G8eLKlKZkwp/kE1TW/ViV7sCZV
         q9fw==
X-Forwarded-Encrypted: i=1; AJvYcCVgYQfFtxlrDIdG3PEKrKaiXbwX5DASqKrjUkOiv0T5wZpCDqnofzD+XzY5XFzlLuqUtnJnBVgXm3Ec@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6m6xOCdnEFGjlMp1wskarKsTcTpYPDHNhLpapEVuF49nT1rhQ
	NWJ9G3j6o2qkByiMBb7GZDs5J9gH3v49AFRCMQjpp8lCzXQb6FfhGCmhCoXndhAkpmN5HKcEs/L
	U0Jb2cTlHeyN8D5eJDm6e2Ool4SVk8w+7sJdvGe5Zz7ECnPDd0UIdytEKfAQ=
X-Received: by 2002:a05:600c:4e12:b0:431:1d97:2b0a with SMTP id 5b1f17b1804b1-43161641793mr95707985e9.15.1729513164987;
        Mon, 21 Oct 2024 05:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL+4zTIZRaHCwKu0OkK2nf7jN/ima55H0fGeAQpNI8aBlBlaAzYq2yIrtU/CEO+/V54e4DoQ==
X-Received: by 2002:a05:600c:4e12:b0:431:1d97:2b0a with SMTP id 5b1f17b1804b1-43161641793mr95707665e9.15.1729513164570;
        Mon, 21 Oct 2024 05:19:24 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:36d3:2b96:a142:a05b? ([2a09:80c0:192:0:36d3:2b96:a142:a05b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fa4fsm56089275e9.16.2024.10.21.05.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 05:19:24 -0700 (PDT)
Message-ID: <213b6a6a-3594-4bc5-ae6d-930bbaf3616d@redhat.com>
Date: Mon, 21 Oct 2024 14:19:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] virtio-mem: s390 support
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Mario Casquero <mcasquer@redhat.com>
References: <20241014144622.876731-1-david@redhat.com>
 <20241014144622.876731-6-david@redhat.com>
 <20241014184824.10447-F-hca@linux.ibm.com>
 <ebce486f-71a0-4196-b52a-a61d0403e384@redhat.com>
 <20241015083750.7641-D-hca@linux.ibm.com>
 <fbee219a-cc88-414b-8f5f-2cb3b4c9f470@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <fbee219a-cc88-414b-8f5f-2cb3b4c9f470@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 21.10.24 um 08:33 schrieb Christian Borntraeger:
> 
> 
> Am 15.10.24 um 10:37 schrieb Heiko Carstens:
>> On Mon, Oct 14, 2024 at 09:16:45PM +0200, David Hildenbrand wrote:
>>> On 14.10.24 20:48, Heiko Carstens wrote:
>>>
>>> The cover letter is clearer on that: "One remaining work item is kdump
>>> support for virtio-mem memory. This will be sent out separately once initial
>>> support landed."
>>>
>>> I had a prototype, but need to spend some time to clean it up -- or find
>>> someone to hand it over to clean it up.
>>>
>>> I have to chose wisely what I work on nowadays, and cannot spend that time
>>> if the basic support won't get ACKed.
>>>
>>>
>>> For many production use cases it certainly needs to exist.
>>>
>>> But note that virtio-mem can be used with ZONE_MOVABLE, in which case mostly
>>> only user data (e.g., pagecache,anon) ends up on hotplugged memory, that
>>> would get excluded from makedumpfile in the default configs either way.
>>>
>>> It's not uncommon to let kdump support be added later (e.g., AMD SNP
>>> variants).
>>
>> I'll leave it up to kvm folks to decide if we need kdump support from
>> the beginning or if we are good with the current implementation.
> 
> If David confirms that he has a plan for this, I am fine with a staged approach
> for upstream.

I do have a plan and a even a semi-working prototype that I am currently 
improving. In summary, the virtio-mem driver in kdump mode can report ranges 
with plugged memory to the core so we can include them in the elfcore hdr. That 
is the easy part.

The "challenge" is when the virtio-mem driver is built as a module and gets 
loaded after building/allocating the elfcore hdr (which happens when creating 
/proc/vmcore). We have to defer detecting+adding the ranges to the time 
/proc/vmcore gets opened. Not super complicated, but needs some thought to get 
it done in a clean way / with minimal churn.

-- 
Cheers,

David / dhildenb

