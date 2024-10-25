Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE531D9A5B
	for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2024 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853533; cv=none; b=dAhAZj7QTDC8PVhgQegXKY6mEOtd9KM6Kn0J0SJF+V/bQpAeDVj//oNRBNe6U8RLcIxFr2mYlPmGUZ2Yq41YDtiYbj9+kTjjIfZpAsbRsAt+Ygy2qK6N19ynFGUvixCId0QeWqaPTmrxz5TXf7E1Dgl85Ct7GidldfhsFOhUb+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853533; c=relaxed/simple;
	bh=kp2DJSQcz5F9ITrB7GXc5frB5yJiuuHNUVJHR6XpcF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJMcXkFEgUlEQZ8+fSZv5JSRFv4T9e6XMbI8whz6FF5qwtHFHTnkWqV3LeaXVJSBNrwVfyxdGimFhOa81iHqn6nN/Pg3kB/8OdVdbaVoyagNAIc89rVCPl5VObGfNZ2x/IzTHpODAzHujPfhTZPj0hO8JG0H1is36eUiFzhlEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+HwVTYD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+HwVTYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729853530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e4r2NzZfPv+Z+xS0CZlcU7ZKIzf4wqWDmUdEIeMKIBk=;
	b=G+HwVTYD3EDgcZCiuq5Dr77QqaXNNeaNQGrG84BC7zlXBDOATRzuFNobwN9fsrL1nEFEM4
	3AnbxXaiUyg5fTfaNQBM9oVjsFo+tE27iTI79RcaL/1mAi4XurKzYO4EoAnLf5Y3Kr77Bd
	5w8F/xv36PwFgOXqF4bFQviqbGAtKaE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-1NqFcvrSOMyHTp4zxtFviw-1; Fri, 25 Oct 2024 06:52:08 -0400
X-MC-Unique: 1NqFcvrSOMyHTp4zxtFviw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2fb4c08c02cso11282221fa.1
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2024 03:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853527; x=1730458327;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e4r2NzZfPv+Z+xS0CZlcU7ZKIzf4wqWDmUdEIeMKIBk=;
        b=TGlNzDWlILcsR2wPDrRmAjtelBe0pJCAtgKZIQJ0elw2+PlNatCD8Aye4jMrf578DI
         p6aG7eZZom3KViE5D+6NTQTKx9VdGcwnqtACRnwIer3roc+aEJ7SMZUBHAs+2c7WyPzg
         DjYYPtX1bJ+ite0FbxOU2ZG3UMY81qemxuTR9qn2P2QwTh9OuRSH4s+ydJ6ldtFo6uMa
         Y3KJ9V95MMJmw7ma7niQwe9agXfanJdG91+/4OspNFuFqflkhXU1cyOU3DKuG0eaBmSb
         9x3u1KiYvpgQgrMNYBOztkIblyUYYuLoqQRs+HanNwEGaE6vlXLTTg1pP1wjpSUJ7kHW
         gMLw==
X-Forwarded-Encrypted: i=1; AJvYcCVhD81kpMPH607tP6gJPdNqYmjzgt6UI6cRfZdQ2oxoRgoUXuTtmypGptPgvc/ExRwn55Dn3INRA1hA@vger.kernel.org
X-Gm-Message-State: AOJu0YztsF2P/Y8XmP8gQztT6jeGMGi+8ebrIIY6ejrEXGeW8QKj+i9i
	fGvn6mjmuvLgTEUOJykE9bXUFosOMc+6wbYDcrEf/9tPjvB7+vkGvh4fZK8wGNc6/7M2yduke5g
	O10sT3gS3uvsFzK009cgjSSS6hns9Qsj0ohUCWN8jSzwIuFp6P0P71Pckyr4=
X-Received: by 2002:a2e:741:0:b0:2fb:5014:8eb9 with SMTP id 38308e7fff4ca-2fc9d2f1a2cmr38426671fa.10.1729853527292;
        Fri, 25 Oct 2024 03:52:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcmLZmu7afPuuZ9o9QyvzZjgc+xVg74UVePptJdhAFYX1KPdNcPvjRw2LvDcGh5gFxxydkeQ==
X-Received: by 2002:a2e:741:0:b0:2fb:5014:8eb9 with SMTP id 38308e7fff4ca-2fc9d2f1a2cmr38426451fa.10.1729853526804;
        Fri, 25 Oct 2024 03:52:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:d800:499c:485a:c734:f290? (p200300cbc70dd800499c485ac734f290.dip0.t-ipconnect.de. [2003:cb:c70d:d800:499c:485a:c734:f290])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5431ecsm45473185e9.5.2024.10.25.03.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 03:52:06 -0700 (PDT)
Message-ID: <e6ca25ae-52dc-40d0-acc6-fd65bd36d00c@redhat.com>
Date: Fri, 25 Oct 2024 12:52:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] s390/physmem_info: query diag500(STORAGE LIMIT) to
 support QEMU/KVM memory devices
To: Heiko Carstens <hca@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
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
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Mario Casquero <mcasquer@redhat.com>
References: <20241014144622.876731-1-david@redhat.com>
 <20241014144622.876731-5-david@redhat.com>
 <20241014184339.10447-E-hca@linux.ibm.com>
 <8131b905c61a7baf4bd09ec4a08e1ace84d36754.camel@linux.ibm.com>
 <20241015152008.7641-P-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241015152008.7641-P-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.24 17:20, Heiko Carstens wrote:
> On Tue, Oct 15, 2024 at 11:01:44AM -0400, Eric Farman wrote:
>> On Mon, 2024-10-14 at 20:43 +0200, Heiko Carstens wrote:
>>> On Mon, Oct 14, 2024 at 04:46:16PM +0200, David Hildenbrand wrote:
> ...
>>> +#define DIAG500_SC_STOR_LIMIT 4
> ...
>> I like the idea of a defined constant here instead of hardcoded, but maybe it should be placed
>> somewhere in include/uapi so that QEMU can pick it up with update-linux-headers.sh and be in sync
>> with the kernel, instead of just an equivalent definition in [1] ?
>>
>> [1] https://lore.kernel.org/qemu-devel/20241008105455.2302628-8-david@redhat.com/
> 
> It is already a mess; we have already subcode 3 defined:
> 
> #define KVM_S390_VIRTIO_CCW_NOTIFY 3
> 
> in
> 
> arch/s390/include/uapi/asm/virtio-ccw.h
> 
> which for some reason is uapi. But it doesn't make sense to put the
> new subcode 4 there too. So what is the end result?
> 
> Another uapi file? I think resolving this would be a project on its own.

Agreed, thanks all!

-- 
Cheers,

David / dhildenb

