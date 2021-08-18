Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2948DC4338F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 08:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F366B60295
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 08:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbhHRIUz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239727AbhHRIUw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 04:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629274817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwTwlNl/ChVG4Exw19xpoyut/CU/s2jMFLukh6oulq0=;
        b=ib6ax3mOuSnlu6LfOJbyNAgjXKnMxphV1H8XnRsaPR/Dulp1q2zn++FjVY2F9uU+z2KWsi
        OTFyehgS+rvNH4i9pTTcNTGeL+snP++jSVgRQ3hX1q4gSGtTlUWN/ti6UVlUDUxX5XznR/
        UG0BLyBcNBxKZx+G6HvrMZLEBK/Awpk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-FE2yl9lWMFavSe4IUb7sFw-1; Wed, 18 Aug 2021 04:20:16 -0400
X-MC-Unique: FE2yl9lWMFavSe4IUb7sFw-1
Received: by mail-ed1-f71.google.com with SMTP id u4-20020a50eac40000b02903bddc52675eso657136edp.4
        for <linux-s390@vger.kernel.org>; Wed, 18 Aug 2021 01:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vwTwlNl/ChVG4Exw19xpoyut/CU/s2jMFLukh6oulq0=;
        b=rNXOELP5ZnpMxeReOXSMTNEALJKu+S2MsTK+Y2qoybGNnA+eg2PuQatZlzmJi9/dLY
         FeYBzEUJNBqoBXUi/jG/wROcSOvekj69lwB6SNvc4EzaGdjHzt+Wl9FXIj4DBIpTqSpT
         Q0YxceLsunnz6P50TBrph0L8eI884SkL1nLK3o/3H4QpuKJ23KFIDEmmPV8DuB0Ik6nb
         oe7xtIM4h1ICh9rFNImIUGL3k6/boLI9GUk1mGxOzwrtMxEAceOtUbWi4wmFTLoUt38+
         wawILZwMQM0x36RLiG+fIStG44lYcFw7WPEKB9rHnIrd4IAEf2iOO2y4zesWCUYwTub9
         YYkQ==
X-Gm-Message-State: AOAM531kDoxjU4cV6DhMAh97d/lqL8Wkkjhaqt5NNuM0J0l0Yky4IPdj
        XWQXHjkTrWt/iBJn3VG+y8u8XKoHeqISjCRk4l+mlv4jnlLnvlnDsZS1Y0mGdaAygwp5UhQqZVK
        PzfIInudgesQDqRb3q0RUFQ==
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr8379457ejr.435.1629274815127;
        Wed, 18 Aug 2021 01:20:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQqDP2X2CVEYrBUvv3EWAA21MgH0S7mkn8oKJ0O51LTNGOJB/WUoqj+/ljUyB6Jr88QCr5cQ==
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr8379448ejr.435.1629274814969;
        Wed, 18 Aug 2021 01:20:14 -0700 (PDT)
Received: from thuth.remote.csb (pd9e83070.dip0.t-ipconnect.de. [217.232.48.112])
        by smtp.gmail.com with ESMTPSA id be23sm2203200edb.68.2021.08.18.01.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:20:14 -0700 (PDT)
To:     Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com,
        cohuck@redhat.com
References: <20210813073615.32837-1-frankja@linux.ibm.com>
 <20210813073615.32837-2-frankja@linux.ibm.com>
 <20210813103240.33710ea6@p-imbrenda>
 <e0bcb199-7254-01bb-baee-7de83b62495a@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 1/8] s390x: lib: Extend bitops
Message-ID: <de5b6d16-9ec1-5d77-00ac-61305d90851a@redhat.com>
Date:   Wed, 18 Aug 2021 10:20:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e0bcb199-7254-01bb-baee-7de83b62495a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 13/08/2021 13.31, Janosch Frank wrote:
> On 8/13/21 10:32 AM, Claudio Imbrenda wrote:
>> On Fri, 13 Aug 2021 07:36:08 +0000
>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>
>>> Bit setting and clearing is never bad to have.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>   lib/s390x/asm/bitops.h | 102
>>> +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 102
>>> insertions(+)
>>>
>>> diff --git a/lib/s390x/asm/bitops.h b/lib/s390x/asm/bitops.h
>>> index 792881ec..f5612855 100644
>>> --- a/lib/s390x/asm/bitops.h
>>> +++ b/lib/s390x/asm/bitops.h
>>> @@ -17,6 +17,78 @@
>>>   
>>>   #define BITS_PER_LONG	64
>>>   
>>> +static inline unsigned long *bitops_word(unsigned long nr,
>>> +					 const volatile unsigned
>>> long *ptr) +{
>>> +	unsigned long addr;
>>> +
>>> +	addr = (unsigned long)ptr + ((nr ^ (nr & (BITS_PER_LONG -
>>> 1))) >> 3);
>>> +	return (unsigned long *)addr;
>>
>> why not just
>>
>> return ptr + (nr / BITS_PER_LONG);
>>
>>> +}
>>> +
>>> +static inline unsigned long bitops_mask(unsigned long nr)
>>> +{
>>> +	return 1UL << (nr & (BITS_PER_LONG - 1));
>>> +}
>>> +
>>> +static inline uint64_t laog(volatile unsigned long *ptr, uint64_t
>>> mask) +{
>>> +	uint64_t old;
>>> +
>>> +	/* load and or 64bit concurrent and interlocked */
>>> +	asm volatile(
>>> +		"	laog	%[old],%[mask],%[ptr]\n"
>>> +		: [old] "=d" (old), [ptr] "+Q" (*ptr)
>>> +		: [mask] "d" (mask)
>>> +		: "memory", "cc" );
>>> +	return old;
>>> +}
>>
>> do we really need the artillery (asm) here?
>> is there a reason why we can't do this in C?
> 
> Those are the interlocked/atomic instructions and even though we don't
> exactly need them right now I wanted to add them for completeness.

I think I agree with Claudio - unless we really need them, we should not 
clog the sources with arbitrary inline assembly functions.

> We might be able to achieve the same via compiler functionality but this
> is not my expertise. Maybe Thomas or David have a few pointers for me?

I'm not an expert with atomic builtins either, but what's the point of this 
at all? Loading a value and OR-ing something into the value in one go? 
What's that good for?

  Thomas

