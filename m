Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350C81E2303
	for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281337; cv=none; b=hb+WC6TwnQU+AXx7LxTZQ6YJapSO8ItU7Ny8tYt7Pp2TuBpavAJ48ZW4c2MlwnqFRaZH9EHOxXkuqdHzKHZ8wbMeQvdnkFrk+Rs51TOHrXM4NhGa15ixq1fw5SQjwI9D7McB58wIZRK2G61LUMeM/AFG7PC3UZGgWl3BoefSA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281337; c=relaxed/simple;
	bh=OBE34t425vGk5znu7rwupuc8QDXh1LVpRdY9JxTbYm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvCaagP0Om9Cq9vFPqj/sCBbm9CCp35BqakDQZOv+3YLgsO7GYsvlYU3cHtZUrQ+ftOvfcAum7G3jwpF8+WpJvP6qzEStyupLwAdj5K4BGKZhzYhsQToJ1NdEhzDV46Km3xa4c7T6Ycy1vaXxneHZtT+DvAjClV67zyFNNIOe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiPh/9sD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiPh/9sD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730281334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0uqdJX+z9lUnBtJDOnaMtKo6RYm6dF3mSSpNcMlbnlE=;
	b=HiPh/9sDtOx36E3Ui+cZd9j10kRqGEzxuRC4QkKbNG9XDeQBiQGY1GvmNsZ9vqU+Pko1ve
	5WiJiQo9lRFupRpq5eFx29lWj87uRtDIdPvfYXKIZEFXxCkqygM+uzoRIuEUtFarh9bmlW
	lsRNWJy2SXs95qFEh5cc72Cr6zkeum4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-cpehbPG4MVCUbVwMtQbtFQ-1; Wed, 30 Oct 2024 05:42:09 -0400
X-MC-Unique: cpehbPG4MVCUbVwMtQbtFQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d458087c0so450489f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2024 02:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730281328; x=1730886128;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0uqdJX+z9lUnBtJDOnaMtKo6RYm6dF3mSSpNcMlbnlE=;
        b=PH4YAbbKIB9fHqxSRAklOYCc6ly/HqJ3J2/OCdfb2ZrmM/uKZFrufEswEpiatpGNcE
         uPnva9Ap61Hrs8DkVUJUjmW91e31XibKEse21jPPdV7akC3cy2e8FZoa83xk/rMRXb4G
         hsWF27ABbPTgz6cOIn5BQjh5AQvLc64n2rD/2oLf3scetvtNiYiXzzzO2o+3dUAoLBlL
         7rvvE/iEiYFezw29MNttpx3142Rklib1JB077/iRsxwcsNAOHEE/OKItGv0lv2a1cNvc
         uV2hJjHGiV+YKc8Q2nAXVjO1rHaqYOpVB5bnytLN+zJpE7TF8YDFEsAfjO5C8pnwTymP
         K7HA==
X-Forwarded-Encrypted: i=1; AJvYcCVhETozPv+3jvRMkwpPKviUpJbmSPNE0DQv3IOOusWObIC4PUo+aIbBaUMxOXcUP7PNHOwQ6mJlg+Pi@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMjunGo4F0t4lHP/O984yNPVqbtcdPhb/yAwUWJ/nCtAclgcD
	Fcs6unqc7y+Kr9nIaZ6HxqTzqU7BtoabbwKyO+oSDyRc0en6O/qAMp3TWWidm8ie0aEViLHbd4J
	bKRYRCUrDFHiW7Qdd/ZpHq4aKjTJChc4r5FeVuPtm92E5KiLxuyspMAbYY9c=
X-Received: by 2002:a5d:58fc:0:b0:37d:43a8:dee0 with SMTP id ffacd0b85a97d-381b97330efmr1285818f8f.17.1730281328398;
        Wed, 30 Oct 2024 02:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxL9u1OlA5swPpZHfa8LyW94w79Ij4hpyPVFVWsJ96eNXaF2PKD2Gypfd+Ta08lk+6ZRzRXA==
X-Received: by 2002:a5d:58fc:0:b0:37d:43a8:dee0 with SMTP id ffacd0b85a97d-381b97330efmr1285796f8f.17.1730281327957;
        Wed, 30 Oct 2024 02:42:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:7c00:d067:e327:4f99:7546? (p200300cbc7337c00d067e3274f997546.dip0.t-ipconnect.de. [2003:cb:c733:7c00:d067:e327:4f99:7546])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b49d20sm14784530f8f.62.2024.10.30.02.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 02:42:07 -0700 (PDT)
Message-ID: <35fc960b-0013-4264-93d6-6511d54ab474@redhat.com>
Date: Wed, 30 Oct 2024 10:42:05 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] s390/physmem_info: query diag500(STORAGE LIMIT) to
 support QEMU/KVM memory devices
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Mario Casquero <mcasquer@redhat.com>
References: <20241025141453.1210600-1-david@redhat.com>
 <20241025141453.1210600-4-david@redhat.com>
 <20241030092324.6264-E-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241030092324.6264-E-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.24 10:23, Heiko Carstens wrote:
> On Fri, Oct 25, 2024 at 04:14:48PM +0200, David Hildenbrand wrote:
>> To support memory devices under QEMU/KVM, such as virtio-mem,
>> we have to prepare our kernel virtual address space accordingly and
>> have to know the highest possible physical memory address we might see
>> later: the storage limit. The good old SCLP interface is not suitable for
>> this use case.
>>
>> In particular, memory owned by memory devices has no relationship to
>> storage increments, it is always detected using the device driver, and
>> unaware OSes (no driver) must never try making use of that memory.
>> Consequently this memory is located outside of the "maximum storage
>> increment"-indicated memory range.
>>
>> Let's use our new diag500 STORAGE_LIMIT subcode to query this storage
>> limit that can exceed the "maximum storage increment", and use the
>> existing interfaces (i.e., SCLP) to obtain information about the initial
>> memory that is not owned+managed by memory devices.
>>
>> If a hypervisor does not support such memory devices, the address exposed
>> through diag500 STORAGE_LIMIT will correspond to the maximum storage
>> increment exposed through SCLP.
>>
>> To teach kdump on s390 to include memory owned by memory devices, there
>> will be ways to query the relevant memory ranges from the device via a
>> driver running in special kdump mode (like virtio-mem already implements
>> to filter /proc/vmcore access so we don't end up reading from unplugged
>> device blocks).
>>
>> Update setup_ident_map_size(), to clarify that there can be more than
>> just online and standby memory.
>>
>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/s390/boot/physmem_info.c        | 47 +++++++++++++++++++++++++++-
>>   arch/s390/boot/startup.c             |  7 +++--
>>   arch/s390/include/asm/physmem_info.h |  3 ++
>>   3 files changed, 54 insertions(+), 3 deletions(-)
> 
> Looks like I couldn't convince you to implement a query subcode.

Well, you convinced me that it might be useful, but after waiting on 
feedback from the KVM folks ... which didn't happen I moved on. In the 
cover letter I have "No query function for diag500 for now."

My thinking was that if we go for a query subcode, maybe we'd start 
"anew" with a new diag and use "0=query" like all similar instructions I 
am aware of. And that is then a bigger rework ...

... and I am not particularly interested in extra work without a clear 
statement from KVM people what (a) if that work is required and; (b) 
what it should look like.

Thanks for the review Heiko!

-- 
Cheers,

David / dhildenb

