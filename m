Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC221E503C
	for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2024 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571339; cv=none; b=dIGtoY+vzJJGgtLyd5Zf7iiovSCnB5E6HvDEnTxmnxNQf+6+6E2CEKI7LElPPn/3He72gpDc12NcDVW+2iH6AuCKnbSLw53WNFqWhef0KaAXJOL9lxoM6HOMNPbWT5DzKVKdepXjJ5Bys62N/jBi1K4Z6C5CBTRea0+RJG9Khmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571339; c=relaxed/simple;
	bh=rfEJIwZQTeIzctV/eId0rTDdf0FCGFJXfiZqY/Pq/tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MC2DAQ7B45dyw1xpozKrLjad8gqWurMH4kvjjUTtdXNHBJ/L3dBGqN0yqfNE80eS9UABFIPEgl6jPzgFhegpkfY76UEoIp6hIn8gEnnrpXiJeOjB/j8kRVKNj4ligvNmMD87WSZbHpETfMXOCT25yZ8Sh6yzkbXLfgYeeLlE7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4Of80Lm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4Of80Lm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728571335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Czt6sk8OPzgHm4T3VRqN/X5z331h/b5UeNHggjRMYxs=;
	b=U4Of80LmpA0M0n+tyQ62gRoOE7/tHvARzIK5V0Z3xpBQ4eymTtw5/FE27VzWWCEqWcpoHk
	RxLAMn+RgU/fu+dy4+myBK+qIvY/m0+xpebBHh25b3OCZvjGeQ7h2IA5ixpXEpQquwZ804
	YJCkLl1HilWgTahsPShClwBnlnOMrZE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-AjOxWhhpOmKymYlkWmzpKA-1; Thu, 10 Oct 2024 10:42:14 -0400
X-MC-Unique: AjOxWhhpOmKymYlkWmzpKA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4a211177so427187f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2024 07:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728571333; x=1729176133;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Czt6sk8OPzgHm4T3VRqN/X5z331h/b5UeNHggjRMYxs=;
        b=YG65L42hOgiYsZ9wDp4MxP2FbD7RGEWaV7r8WRmlTzyfF0Ai7Rp6tS+BKe0e8h2ZZh
         qjZ1sKkA9kMMHKb4aqHMFZbBU90NFrUDTNLzkkXl/4/p8/LoRTTeqby5mtc+5wh1LCCR
         eHd78C7LCakCNzXr6N0r5VtP2/YMDdC1UcOA+rWFANIzez0eQG+W704zh4Bu0+A0wt+K
         l0gfGnC0Q7j9nLcBUasKXXkpLJadXijqU6LSoKLTzdka6VLTKPB0AVgBEs2t0AgOwgVL
         Qo2cOP+qdWzzeBVC0xgDrkt/6jiwQWwzvwiVPoyqmlTqpm2oiYfLnJELn36hp1Tqumlb
         MeWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvu61J9VEGRm+ne30fYtQlXBJ4mCNTq2tfLS1STviNPpnEJsiYYU7rCb+EHTwgka2Xda+1LYlmZWIk@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQYWCr8zpvVexu7nklE+e4sJJkv7gH9qa9B1UYeuATptDeKf9
	xtDz9Klme4F/NN8xb55h0nYxhve1xIKyEMg8cPqQgJTIkJrJUoDlKaLkI7c7xFLm/GCrNhuJH6Z
	Z/Npx6gvyvZjcwsiuz1IBgWtHGjMO7kvyBA4t7sTJ6qsWM+oirT5eJubZFfA=
X-Received: by 2002:a5d:568a:0:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-37d3a9b4eb7mr4288607f8f.5.1728571332578;
        Thu, 10 Oct 2024 07:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/81/uKOPt502sNJ3M72XD00/fsiaHkAnXd068rYKZyOx9zqAd2zdPti07Npc/PGQX87VvJA==
X-Received: by 2002:a5d:568a:0:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-37d3a9b4eb7mr4288579f8f.5.1728571332162;
        Thu, 10 Oct 2024 07:42:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:9200:eb2e:74f9:6f5c:3040? (p200300cbc7429200eb2e74f96f5c3040.dip0.t-ipconnect.de. [2003:cb:c742:9200:eb2e:74f9:6f5c:3040])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd127sm1726028f8f.36.2024.10.10.07.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 07:42:11 -0700 (PDT)
Message-ID: <46a253f5-f04f-4c68-962d-9bd446d83dfa@redhat.com>
Date: Thu, 10 Oct 2024 16:42:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] virtio-mem: s390x support
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Mario Casquero <mcasquer@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-s390@vger.kernel.org,
 virtualization@lists.linux.dev, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20240910191541.2179655-1-david@redhat.com>
 <CAMXpfWvRy_fpNUXeVO_-0O9WXDYY8f+cBEQQvsqZD2g2043LaA@mail.gmail.com>
 <e0e13b95-bc9a-4f4b-a721-379676725525@redhat.com>
 <20241010144101.15346-C-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241010144101.15346-C-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.10.24 16:41, Heiko Carstens wrote:
> On Thu, Oct 10, 2024 at 02:31:31PM +0200, David Hildenbrand wrote:
>> On 10.10.24 10:41, Mario Casquero wrote:
>>> This series has been successfully tested along with the QEMU's series.
>>> Virtio-mem devices could be resized, plugged and unplugged seamlessly.
>>> The memory information displayed is correct and reboot doesn't cause
>>> any issue.
>>>
>>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>>
>> Thanks a bunch for testing!
>>
>> If there are no more comments, I'll add the in-tree kernel update for the
>> new diag500 subcall and resend.
> 
> Sorry that you haven't seen any review from here yet, but... :)
> 
> Please also change all usages of "s390x" to "s390" before you resend.
> Within the kernel usage of s390x is not common and there shouldn't be
> anything like this added.

Makes sense, thanks!

-- 
Cheers,

David / dhildenb

