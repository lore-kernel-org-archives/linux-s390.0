Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E5BC4338F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 08:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCD56108F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 08:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhHRIpO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238582AbhHRIpN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 04:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629276277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9LtWbaLwq6kJjM9ZOZwycFMBsFtGptd3p5wovzjNweE=;
        b=ZJu2BdqGbedwRHvFmmE18mwqLjNTJtjiMXwo0V4E5cYRAA1qOIsDS+oyvGTQriGjrNUmuv
        G2kPzAa5GSeHJsiFaSbnJzoBvT7kMErpAvn89ewvtKqD4ZqHTMNkkUWE2cA1yZIy3IWZJp
        EWmaVuP+NSp9Sy2yYiVbMR9p8cJvoR8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-v3C5Tx0lMwCFOxR3GJjAMQ-1; Wed, 18 Aug 2021 04:44:36 -0400
X-MC-Unique: v3C5Tx0lMwCFOxR3GJjAMQ-1
Received: by mail-wr1-f71.google.com with SMTP id l1-20020adff481000000b00156e670a09dso361803wro.1
        for <linux-s390@vger.kernel.org>; Wed, 18 Aug 2021 01:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9LtWbaLwq6kJjM9ZOZwycFMBsFtGptd3p5wovzjNweE=;
        b=o0j1ZrHIRo8bp/7NlmWPORKRk+ux04LMezVpJzgg5RtqRWcQzg++mjCme9/kQIaVsk
         JSk1U+X+ziCXJvh2ZTQuXokGRLWlVKCJbgtDzwGC9D6DUpgayXQb36VDaCfNd48xO8Tl
         u648pH9DPjT4kKWGSjMFJxHv00IjchKI9ELf/DVRztdryao7uqnnbK7R3tRNVwzHrsi5
         oRNDye9VilR8eBs2R+LMoafRhsYEPpSdzfJJGkJSqSy+WsAV2jfp0QgvRDinfUEjD9d8
         rf+AVCHP8yaRKxWA4E5GXa4TMeyF3IhfCHjlnsT7PvfKOj50O2jOyD9APDiKzrE4O2fj
         3bsA==
X-Gm-Message-State: AOAM5309k54VxSURZNRmxtWSVDlaAwMRuDNi7oXY1460jDDH31lJ+zHs
        gYvBpYVmARtMv69fLeZnOK6kSsvg9q141JvSpNFon0RJtGUNpojeCcQiBG2HpmQBFai918nSxG/
        TnanhTR2hH+7uzsfD1krpNA==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr9712624wrr.198.1629276275493;
        Wed, 18 Aug 2021 01:44:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/D+WUy8PsPz3S65vrEk1dvRI5wYhxcrZuVh6VwHswDCxOH96ASRcWtuHLW1Yfs9Ecc7X0nA==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr9712609wrr.198.1629276275340;
        Wed, 18 Aug 2021 01:44:35 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6417.dip0.t-ipconnect.de. [91.12.100.23])
        by smtp.gmail.com with ESMTPSA id n188sm3452655wmn.48.2021.08.18.01.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:44:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: s390: gaccess: Cleanup access to guest frames
To:     Janosch Frank <frankja@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        kvm@vger.kernel.org, borntraeger@de.ibm.com,
        imbrenda@linux.ibm.com, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     cohuck@redhat.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210816150718.3063877-1-scgl@linux.ibm.com>
 <20210816150718.3063877-2-scgl@linux.ibm.com>
 <d11128bb-18f6-5210-6f42-74a89d8edcf7@redhat.com>
 <584ca757-4eb4-491e-a4cd-7bc60fb04b61@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0c800ed3-cc60-9c13-c0a7-8ba302365ccb@redhat.com>
Date:   Wed, 18 Aug 2021 10:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <584ca757-4eb4-491e-a4cd-7bc60fb04b61@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.08.21 10:06, Janosch Frank wrote:
> On 8/18/21 9:54 AM, David Hildenbrand wrote:
>> On 16.08.21 17:07, Janis Schoetterl-Glausch wrote:
>>> Introduce a helper function for guest frame access.
>>> Rewrite the calculation of the gpa and the length of the segment
>>> to be more readable.
>>>
>>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> [...]
>>> -	unsigned long _len, gpa;
>>> +	unsigned long gpa;
>>> +	unsigned int seg;
>>>    	int rc = 0;
>>>    
>>>    	while (len && !rc) {
>>>    		gpa = kvm_s390_real_to_abs(vcpu, gra);
>>> -		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
>>> -		if (mode)
>>> -			rc = write_guest_abs(vcpu, gpa, data, _len);
>>> -		else
>>> -			rc = read_guest_abs(vcpu, gpa, data, _len);
>>> -		len -= _len;
>>> -		gra += _len;
>>> -		data += _len;
>>> +		seg = min(PAGE_SIZE - offset_in_page(gpa), len);
>>
>> What does "seg" mean? I certainly know when "len" means -- which is also
>> what the function eats.
> 
> What does "_len" mean especially in contrast to "len"?
> 
> "seg" is used in the common kvm guest access functions so it's at least
> consistent although I share the sentiment that it's not a great name for
> the length we access inside the page.
> 
> Originally I suggested "len_in_page" if you have a better name I'd
> expect we'll both be happy to discuss it :-)

Similar code I encountered in other places uses "len" vs "cur_len" or 
"total_len" vs. "cur_len". I agree that everything is better than "len" 
vs. "_len".

I just cannot come up with a proper word for "seg" that would make 
sense. "Segment" ? Maybe my uneducated mind is missing some important 
English words that just fit perfectly here.

Anyhow, just my 2 cents, you maintain this code :)

-- 
Thanks,

David / dhildenb

