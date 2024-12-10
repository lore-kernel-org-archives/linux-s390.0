Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536878F47
	for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828733; cv=none; b=ROnkj6yXyoqaEA5fxReDBEqMAlMyLCn8wNepRiBCRk4bNB/wlnLIlZz7Mv+E2MrCTFT0LrRtYC2q+ozuvY4zMDl+tv1IaPjJCyhs57uVpjQwQVUiBHTSrOnXG2/ha1ej3ySEz7QpLiqFlW6RtimzZp68yUTcxY3puX4RAZ7UVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828733; c=relaxed/simple;
	bh=uA/N6Wn5xabsbCvqy7kd7JKyi5RRQzrR8OPXV/sLFRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFB2Y+G11nDK/aNUDFw3cewRGH2BpgQKPt+K5MgAs+UBJJGRkacH9QHtQBGFkkl1ZzDl5KP2uyx4TiQrN/8L8PfAawXp/82PStF3lv/P+RUoiUcfXxNr1pOF32UeWGtbsw2KpweVSai5gfPF5bLseNmdfTRutgvnTonLVd3pBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1jAJcKU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1jAJcKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733828730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fZcVe/5zuZ/V5Y6RxXliwxtDw1Xl/IijHe7b33hj10Q=;
	b=I1jAJcKUDC4gKMsucPPeBAjNhbWtIZHdThhwUYLgDE6D4ICbHGdBOO41KbfMyqQWEBlgCV
	QKGGKMu31IyiLUUpSVpC8VejgDAoM5a3F0xNhel8o9oC6HhtB21fwM8jvLHk5/lnraqXyB
	BF47hjHDKVzSOeFglLlorm7MUxbiWvc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-uYlrie07Pvei8XFsA2432Q-1; Tue, 10 Dec 2024 06:05:29 -0500
X-MC-Unique: uYlrie07Pvei8XFsA2432Q-1
X-Mimecast-MFC-AGG-ID: uYlrie07Pvei8XFsA2432Q
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f3fcc891so19845375e9.1
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 03:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828728; x=1734433528;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZcVe/5zuZ/V5Y6RxXliwxtDw1Xl/IijHe7b33hj10Q=;
        b=RqyM/pivWonrRKoRKMoPky0ltDWBWCd2AzHiRdU4KhUhdFohMFFjvA/xiX3Mr39//u
         c8VLWmL8//nJheUK6QJ49aatJd2B7Yn/MwxN1JXD9PsyeHSF/X2Gifc3OSXiAD+7huVi
         aQpojtK9Rl3/VP2bh3PL8F5AoDBxUGiCYWDTPI/m1zchd/2IpIRkD14JVNU1Wt8l3mO9
         xGLxOYhPGgzIjQMKXRQPn/u5TxvajC6wT3WSaDzAuph0xiq6Gqti5kLhYnomSTxsuvlH
         iTper2jnaek43I49J4Wx0qpkzUsAF5Q1Fz92IU8yCWWdt7hPKEweiA13lOMTpsQt4sCq
         aLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO8I1+ZuuO/o1+DkOrQvMBnhevpjKkV1M2ecsTNl/RdRcdPja/d+t+K6fDd2YzP1UGiP/hp3XGqPAb@vger.kernel.org
X-Gm-Message-State: AOJu0YxhW0P9oE+wyig49xRK6Hva6LP00PU3xudDgceRrOaRF0O4vehV
	sar2x+XORDPyvcrsf17Ey0cdXCxMwNGEHclEYK2+BEyyWqBOO7ltOwIPuypDDWHCf4LglWuVRZ4
	Mwk/ITQQx01zeyV/qZwDOeNWVerOv3IZJv8Q1MqNimIiezPA5PHD30Kh9p64=
X-Gm-Gg: ASbGnct4A6ajfamwiST1hHUzVhuaRBG5vfx13ZjMuWk/m9eQO07aZzTy0l/g5PRWqWP
	VzwCO55/W2ZakBDDR6wq0vAmDt7Ky1lnxWRNWTEszxZQHR00WWeT+SCohHONJxdDIeqKKboBSBs
	ECTd7T2NdTk0ZcNrsCY9iOhXucyP2l61gFGXZElWS9+Zjt0ydkLS54T33iVNBwOCv/CHrtFSPZo
	HwrEU87qhcstfQ15XrgOgeaojyfKbp+N3J9Ma3eYXdfFl5vgZ85qxgKqVjvqDFzo/iVt+PPxTO4
	mnAOvKNW6kasgbGcUaBeVhKj+XODTfz8DJZUTw7ZfMSZjHpI46/WSY/j3paWmygAXLQnvB0wZC+
	Fs3F/3w==
X-Received: by 2002:a05:600c:458c:b0:434:9ec0:9e4e with SMTP id 5b1f17b1804b1-434fffba059mr44053845e9.30.1733828727886;
        Tue, 10 Dec 2024 03:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmMiNJbY1TFcSyI+tm1/HJE4vK538VL1akxE/9NqvyW5iMwBw380e0W+Rgkka8ZcfpLKokug==
X-Received: by 2002:a05:600c:458c:b0:434:9ec0:9e4e with SMTP id 5b1f17b1804b1-434fffba059mr44053235e9.30.1733828727234;
        Tue, 10 Dec 2024 03:05:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:b800:9a60:4b46:49f9:87f3? (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190975fsm15434782f8f.68.2024.12.10.03.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:05:26 -0800 (PST)
Message-ID: <023d1c53-783e-4d6d-a5e9-d15b9e068986@redhat.com>
Date: Tue, 10 Dec 2024 12:05:25 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Removing page->index
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org
References: <Z09hOy-UY9KC8WMb@casper.infradead.org>
 <cebb44b2-e258-43ff-80a5-6bd19c8edab8@redhat.com>
 <20241209183611.1f15595f@p-imbrenda>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241209183611.1f15595f@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.12.24 18:36, Claudio Imbrenda wrote:
> On Wed, 4 Dec 2024 16:58:52 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 03.12.24 20:51, Matthew Wilcox wrote:
>>> I've pushed out a new tree to
>>> git://git.infradead.org/users/willy/pagecache.git shrunk-page
>>> aka
>>> http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/shrunk-page
>>>
>>> The observant will notice that it doesn't actually shrink struct page
>>> yet.  However, we're getting close.  What it does do is rename
>>> page->index to page->__folio_index to prevent new users of page->index
>>> from showing up.
>>
>> BTW, I was wondering how often we convert a page to a folio to then
>> access folio->index / folio->mapping and not actually having a folio (in
>> the future).
>>
>> I suspect this will need quite some changes to get it right, and I would
>> count that as "less obvious".
>>
>> Calling PageAnon() on anything mapped into user space page tables might
>> be one such case, for example.
>>
>>>
>>> There are (I believe) three build failures in that tree:
>>>
>>>    - fb_defio
>>>    - fbtft
>>>    - s390's gmap (and vsie?  is that the same thing?)
>>
>> Not completely (vsie (nested VMs) uses shadow gmap, ordinary VMs use
>> ordinary gmap) , but they are very related (-> KVM implementation on s390x).
>>
>> I know that Claudio is working on some changes, but not sure how that
>> would affect gmap's usage of page->index.
> 
> After I'm done, we won't use page->index anymore.
> 
> The changes I'm working on are massive, it's very impractical to push
> everything at once, so I'm refactoring and splitting smaller and more
> manageable (and reviewable) series.
> 
> This means that it will take some time before I'm done (I'm *hoping*
> to be done for 6.15)

Thanks for the information. So for the time being, we could likely 
switch to page->private.

One question may be whether these (not-user-space) page tables should at 
some point deserve a dedicated memdesc. But likely the question is what 
it will all look like after your rework.

-- 
Cheers,

David / dhildenb

