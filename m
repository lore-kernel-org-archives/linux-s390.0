Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BB86337
	for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2024 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627421; cv=none; b=a8VGf1aKz7Z0RPCdO5gBi5Yra9qN073KhWDfsg1vO8+7wk0oqpWxyj6l//hn6uZwb4hluismVHMqI5H4paqGINzZG/8+wMow4nn+ZsjOg8yqLJscbkRgBDOY/zLKNuLRlK1wLdrPTx0CspP7UsoiytASAL37ndX8hLEjJclT5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627421; c=relaxed/simple;
	bh=nL9an/TFvRzhA3x383OlVx6btp5ekODkFvklDicZ538=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnynKa39KZqzEHsgtU4cznoIF0QfxUJ8HZ1Dqp5YwSNsM2iCVC1PxMLDc9izuRq9Mm5hTAuN36bTwY+7QxMn/hf477fqV7OET3P91CfhDU7Rli1HJBWDIJ22yHB5tqyM8XcGHoOS3Mhkn9I5c4mnb+jJVY5tzPTqW9SPnybQ8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlPgg3fg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlPgg3fg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734627419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MRTUn6J+ksVgeDseV7t1yVqVIzAgB4EqVwWAFEnymPo=;
	b=AlPgg3fgI6otV1qRGocdJI8aq8Hg8egcbB7ky1oZsdFfbQm52BZZRtm2BO8rydWjReG4sH
	PISHG2wMyV0GfLCR+fp8xGuEj2q1xYRRKJ1HRiqcl3NKN8TIZi3bXFINPUInA7wh6TwRJ/
	ED1dNB0sIm70iDw5TYj7Y6446jBdkQI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-lBdxfrNiNRuFHv1qPPOYlA-1; Thu, 19 Dec 2024 11:56:57 -0500
X-MC-Unique: lBdxfrNiNRuFHv1qPPOYlA-1
X-Mimecast-MFC-AGG-ID: lBdxfrNiNRuFHv1qPPOYlA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43610eba55bso8294205e9.3
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2024 08:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627417; x=1735232217;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MRTUn6J+ksVgeDseV7t1yVqVIzAgB4EqVwWAFEnymPo=;
        b=KtFIgzogtllZfaAZkLS2nM+qNj4vf42pnQMpEuK8AKshOv+oF0v84OHHFJoEHF9LcU
         wW4LkRRg9+7FAjwBhLSJpphFmTs5AwfeiDaIzxB/EZjZvZA9Fr9s8wYHlxjjg+Pd9vNQ
         d+NfBTCibhW9wpMnzYJKbnDq+vVoRAIbVhYgkxD7AhiC8GuYfWWCg+zaexz2utV9K/Uq
         Op+cpJLRHYvDeInTwJHBDFmc4doCp/6K6ERCRTGI/0po4dn8Us+ZnjbGDOFUQAySZbdR
         kcUpQLCXUkJ56dbfyTr7tXLYkcBeroK5U6tGf81iRUxtbEvcpW7gKEoJbTdrQ4EPlhzF
         AdGA==
X-Forwarded-Encrypted: i=1; AJvYcCWL0xGGQGi0iLnwC1N75HjzWTYKhBGiKbrUYFhmKbo+fb4T0CKtate2I49LvngQ8eWvtwAwxHfBWCm9@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQvSyCybeyzl52gLhfOqVibNT4Kkwxpf5bj16tArgFKWVCFZ0
	O+0V3quGEOUC0xjcVB7UuTdDB1hUeehm61UpZmtXHRgDjrA7ypXcKOdbkXuZaEWeyCTuW1iUOS0
	hmT5vqxPfvq5/JnrcqxvaBXLjLPRs962IsGuLK+ea0yYKl6Y+vLL0rcU0DcM=
X-Gm-Gg: ASbGncvNVdW1uVeznAI9bXbuBKoAb8G2JP2cekMezqOtJotYHPxnjiuB61QCMFQjlRC
	YIje+f9zGk7ZD8kilN8YBrZEXdAOJ6KGxfrAHpaQblGN2AMQJYEkYnyWYpn13/VgUJPXClwfEii
	YXPno1k1K7OBPswaAMSWBlWgLDIL+5xukN2iyXzMxaoXbmCm913azkJYyT8KGNUeLiNxBGVZ5nK
	QpgXgemOv50ynQLVp0NgizyZcJkdrekxkJTBrmhA88GaIyECED/FBJNUustRDoZnLRjqSGIp5dH
	TL0qKz3ajXf0x6JcH7BoBHCrtQ9C0iJNPKXMLUg8JgPSF2onVxS2JZhEYNbvxy4awmhI3mUjjF/
	LQPgwaA==
X-Received: by 2002:a05:600c:198b:b0:436:51bb:7a3b with SMTP id 5b1f17b1804b1-4365534136emr73139675e9.6.1734627416690;
        Thu, 19 Dec 2024 08:56:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF62IFrlRkEIkWipkRYilhy6ALmna4rbwwdgZ2jRLZqlEeXBhmW4aYIR47oRo54qXMtqJa3NA==
X-Received: by 2002:a05:600c:198b:b0:436:51bb:7a3b with SMTP id 5b1f17b1804b1-4365534136emr73139455e9.6.1734627416259;
        Thu, 19 Dec 2024 08:56:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686? (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de. [2003:cb:c749:6600:b73a:466c:e610:686])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a3766dcsm63707265e9.0.2024.12.19.08.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 08:56:55 -0800 (PST)
Message-ID: <5fae8eb9-0639-4b1b-aeac-c5adc4172446@redhat.com>
Date: Thu, 19 Dec 2024 17:56:54 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] s390: Remove uses of page->index
To: Matthew Wilcox <willy@infradead.org>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-mm@kvack.org,
 linux-s390@vger.kernel.org
References: <20241219162252.1025317-1-willy@infradead.org>
 <9d4efc2e-56d9-4786-9ccb-ecd15f34f3e7@redhat.com>
 <Z2RPNBDbWvZ9Vu9D@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z2RPNBDbWvZ9Vu9D@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 17:52, Matthew Wilcox wrote:
> On Thu, Dec 19, 2024 at 05:33:32PM +0100, David Hildenbrand wrote:
>> On 19.12.24 17:22, Matthew Wilcox (Oracle) wrote:
>>> These two patches compile ... I can promise nothing more than that.
>>>
>>> David suggested to me that the gmap code really should be using ptdesc,
>>> and I think I agree with him.  The vsie code looks quite different
>>> and probably shouldn't be using a ptdesc, but we can use page->private
>>> instead of page->index.  It's not yet clear to me if we'll ever manage
>>> to get rid of page->private.
>>
>> Just curious, does that mean that memdesc would always contain these
>> additional 8 bytes?
> 
> Eventually we'll have a choice to make.
> 
> 1. Shrink struct page to 8 bytes, but we'll need to allocate a 32 byte
>     memdesc for all the current users of page->private
> 2. Shrink struct page to 16 bytes
> 
> I genuinely don't know which will be better for the whole system.
> 
> If you're asking because we can defer some of the mapcount
> work by using the 8 bytes of page->private to store mapcount, then
> yes, let's do that.

Yeah, it could give us a bit more time, until we know that we can just 
get rid of it in all kernel configs. But let's see if that is still a 
problem when we're getting closer to removing them.

-- 
Cheers,

David / dhildenb

