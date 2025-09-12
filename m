Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99512874F1
	for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669787; cv=none; b=ijO4VG30KXwNCMXHq4a6NhRrGcMJiAlhVpfmA3fF0KH60NzYGhfTSlaMgzev8kyFGdLoft4q9nb63l44ah+qdHAHBTgwF2T2m/sIL0DjJzYmhvsy0KJdHkSTegTnzvYDKcCD2UA7LFC/vWt7t3FN1Rdf6suyaLQXO8l6KQIIPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669787; c=relaxed/simple;
	bh=YVpEMtUPBfI0kSglK1+tG/cRaueTcLeBcBexxPbUDjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lk22tz+imIDdyusdreW50qFrjCUzqr8+zQnTY/kxPLZj2zSxsoxrcwnfsLmyJI5xrDt4oPJ7mRzyPw5Fu3HIB5IlBPKor4P0kqqedL+LMrYKYL2ZfAAG6IH/lTkhQJVquTxHhNUKoFPtQz5h8047Bnf9bdbf48paopJtIZj0AAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fc6H2ELT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fc6H2ELT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757669783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B4KJZdY1MD+iAN7yxyMGS4DtOSEdOr2LuczyAdAae4g=;
	b=fc6H2ELTBqR148rwBjG46HbmYFgFL7BQViM/3+t+//1rcaGRqT4Ma8JviNNzIugGKUHM/r
	cRx70yVM6V1gxZV4jHyg7FxI5DjCDdWNRHwAbANv7S+mmyKqak1HFZemJ7WNV3QU1O0Wz8
	qYVS5YhCH8YIuI/AH9MwErsYZ7fLiTg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-vRo5kJnqOkmE5_V8YgYywQ-1; Fri, 12 Sep 2025 05:36:20 -0400
X-MC-Unique: vRo5kJnqOkmE5_V8YgYywQ-1
X-Mimecast-MFC-AGG-ID: vRo5kJnqOkmE5_V8YgYywQ_1757669780
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e2055ce8b7so795077f8f.0
        for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 02:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669780; x=1758274580;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4KJZdY1MD+iAN7yxyMGS4DtOSEdOr2LuczyAdAae4g=;
        b=TWdQBzLlchqeYhN9zWiFmb+5ysVbYIJ+U2HAZiwwaRqulaDa44i+zcWT+3xFjhEgpg
         x+a40Jyk1UjTAXjeNTKq6SoXG7YCXVnteG/5AzT/O2HxZZm4r00ptXOkYRHrV+WlOXYt
         6J9zesHGZMNxZ6FM9WMn60oxRsweP9X9ltct2ntstyUbygg0jNU9KLulyKkG9bN1wybU
         fvU/pObb03vUjjZURIz859PKQyxjXwYCJ0yCBF1Db04iEURku7bhSc9AK03uO8qj9haI
         jDAnX0MlcLnTHbxfx6OoyiZvtrCcmJpm/GAjbCcQ6V8mUAETzBXiIas/T/mfud+PSWUO
         1YWg==
X-Forwarded-Encrypted: i=1; AJvYcCXtVr1B3ArKaOAft8hTgGENltCm08ZA8KEgJSFL6NRSUK1Q9t1QUR1lh6qIrmzX6yamMpD7ANX0ADeg@vger.kernel.org
X-Gm-Message-State: AOJu0YwRE+HesKyMEXYBemyp0OSY5CTNEis0CoePsmdp0pb3bHvpy7Pz
	GhLn9p0ZyI727t2QTWSs1cmm1E77SE14jH0lb+lms+hgVG2u5neOflz3DS8W7vEV48yX9Vr06Qk
	Jgi343a0K0id7DsfzcHEcQwFraWAFDYHKEpV3V4CSm+Jq0Wl24noxKKjnU8gV49U=
X-Gm-Gg: ASbGnctd7HoWpEwMsLF4YYS7QuleQzRr5G/cAqEH1DH+MbxSJwdsQO36UOd1MtJcN2v
	le5BDO6JRmGFbSQfHYzHI3XmLx1I1yeMDQRCpI7KCPYndJ8Zh+MkABkILV6kmr9ryzMEjMB5fON
	ya9g8IpRoQveGbDJiHryHNqzu7wzRdlScdIAbIkOAb+lR80UsHIf1HTvt/gcemb06N9PnIUxx+S
	24sNqcM3GnqfpHDJ3puqEQYW+Sbn9Gl2CDBJTC2+87kc8S1bBX/WnADmHuA31Skz+//ZlLxUg6z
	BojjLhFl4xU3ypnK3e8cg8sVpXhFDy2cj4789VSSUsbidMudYbu3K/xO5+k8a8Z6PjLWGm1x8QS
	z7LaJXyiC6PS9mMFHdzqSElna9Cai6kP6hn3JNcy7FjSwW/Ydq/HplxMPBMl1eU6I+HE=
X-Received: by 2002:a05:6000:2410:b0:3e4:64b0:a75d with SMTP id ffacd0b85a97d-3e7659db640mr1861327f8f.30.1757669779713;
        Fri, 12 Sep 2025 02:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEffTnkjpwSgdIokrJRdi0r1dJ0It77LZ+hWwe5tws1dme1LH9tLiMm17T34HzdwjxEeiy8uw==
X-Received: by 2002:a05:6000:2410:b0:3e4:64b0:a75d with SMTP id ffacd0b85a97d-3e7659db640mr1861304f8f.30.1757669779279;
        Fri, 12 Sep 2025 02:36:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e2fd7sm5942242f8f.63.2025.09.12.02.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:36:18 -0700 (PDT)
Message-ID: <37816bb5-97f8-4c05-84ed-9a81cfc5c755@redhat.com>
Date: Fri, 12 Sep 2025 11:36:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource: Improve child resource handling in
 release_mem_region_adjustable()
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250911140004.2241566-1-sumanthk@linux.ibm.com>
 <0ab2cb14-ba8e-4436-b03d-9457137f492a@redhat.com>
 <aMPluIk8EnOuIWbi@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aMPluIk8EnOuIWbi@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> 
> Hi David,

Hi!

> 
> I am working on the item related to the last discussion -  dynamic
> runtime (de)configuration of memory on s390:
> https://lore.kernel.org/all/aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com/
> 
> I came across the problem when I tried to offline and remove the memory
> via /sys/firmware/memory interface.

Ah, that makes sense. Sorry that I didn't immediately connect the dots 
when seeing your name.

> 
> I have also modified lsmem (not yet upstream) to list deconfigured
> memory, which currently appears as offline. An additional "configured"
> column is also introduced to show the configuration state, but it is not
> displayed here yet (without --output-all).

Worth mentioning in the patch description, otherwise it's confusing.

> 
>>> 0x0000000150000000-0x0000000157ffffff  128M offline               42
> 
> True, this will not be shown with the master lsmem, since the sysfs
> entry is removed after deconfiguration.
> 
>> Do we need a Fixes: and CC stable?
> 
> It will reference commit 825f787bb496 ("resource: add
> release_mem_region_adjustable()"). Since the commit already states
> "enhance this logic when necessary," I did not add a Fixes tag.

So if this cannot be triggered yet, all good and no need for Fixes:.

I was assuming that maybe this can be triggered with ppc dlpar, so I was 
concerned.

> 
>>> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
>>> ---
>>>    kernel/resource.c | 44 +++++++++++++++++++++++++++++++++++++++-----
>>>    1 file changed, 39 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/resource.c b/kernel/resource.c
>>> index f9bb5481501a..c329b8a4aa2f 100644
>>> --- a/kernel/resource.c
>>> +++ b/kernel/resource.c
>>> @@ -1388,6 +1388,41 @@ void __release_region(struct resource *parent, resource_size_t start,
>>>    EXPORT_SYMBOL(__release_region);
>>>    #ifdef CONFIG_MEMORY_HOTREMOVE
>>> +static void append_child_to_parent(struct resource *new_parent, struct resource *new_child)
>>> +{
>>> +	struct resource *child;
>>> +
>>> +	child = new_parent->child;
>>> +	if (child) {
>>> +		while (child->sibling)
>>> +			child = child->sibling;
>>> +		child->sibling = new_child;
>>
>> Shouldn't we take care of the address ordering here? I guess this works
>> because we process them in left-to-right (lowest-to-highest) address.
> 
> __request_resource() adds the child resources in the increasing order.
> With that, we dont need to check the ordering again here.  True, here we
> process the child resources from lowest to highest address.
> 
>>> +	} else {
>>> +		new_parent->child = new_child;
>>> +	}
>>> +	new_child->parent = new_parent;
>>> +	new_child->sibling = NULL;
>>> +}
>>> +
>>> +static void move_children_to_parent(struct resource *old_parent,
>>> +				    struct resource *new_parent,
>>> +				    resource_size_t split_addr)
>>
>> I'd call this "reparent_child_resources". But actually the function is
>> weird. Because you only reparents some resources from old to now.
>>
>> Two questions:
>>
>> a) Is split_addr really required. Couldn't we derive that from "old_parent"
> 
> old_parent->end points to old end range before the split, so I think it
> doesnt tell where the split boundary is, until __adjust_resource() is
> called. Hence, split_addr was added.

Makes sense, that's also where the sanity checks happen.

Worth throwing in a comment for the function telling that lower was not 
adjusted yet.

-- 
Cheers

David / dhildenb

