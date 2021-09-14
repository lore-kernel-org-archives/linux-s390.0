Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862F2C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 17:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C41260F6C
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 17:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhINRY7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhINRY6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Sep 2021 13:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631640220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqDXjCZcBn29nal+6qOuwi7JZU8wFISffsSfwR+3L3E=;
        b=SZy8xrWi359oDh9qw537B21NtuGb7iI71OeNnXvfG/LKE1y/lBIEdd5a5eaodaWkdEZn+H
        o61h96Z6g8XLAsW0wF4WecsQDyWN6bv6hDeQgia3wlNgmN0piF5M9UKS3vcmyQ+pV2ocnm
        yh77niGKhL/v7wgjtD820hwW/aQv+/A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-1eSV6FVkNSyihom5oncyIg-1; Tue, 14 Sep 2021 13:23:39 -0400
X-MC-Unique: 1eSV6FVkNSyihom5oncyIg-1
Received: by mail-wm1-f71.google.com with SMTP id g13-20020a1c200d000000b00308ecd761e8so60189wmg.2
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 10:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MqDXjCZcBn29nal+6qOuwi7JZU8wFISffsSfwR+3L3E=;
        b=VtqdCBYDENrD2BsoSsWY/wKaMRVnoz5DXA7jjwi+lljwHmX7KGI8kZfWJosy2xQT0/
         f82FIt0vW7FP1JR5D/CaJVbeLB/qnoL6obyhTFtfL2JIckbuNVZ8nEwGlXMJi7GWhvox
         PJf3qepfkDyD0IlawEE0Pn270vnIhU4mytfGTNTSPa1m2OpqLUQi4NBMasfhnOs4hpZQ
         Bdic6c6gbvUeBaEXR/x769eBsizalJU9yraYNIDKyg0iqJQfLf190T0oFAI3dPXXeraT
         Z807D+sQtZ4ZMpS3eaXn3jg/xSGyJjlSjAp946dmzSRRqESJhzonJWrN0cF7uz4tT8jJ
         bIOg==
X-Gm-Message-State: AOAM53253oLIegObvTIkQjWQOGIl1llpWIFf4lut/2Jq6raQBD5gMV/6
        TWMrWnbHjOYJHdUSuakY2wxUXc6goLbgBXZADCt04fjhsoaYkpIJvp6kmHhDz5GOji4UEJvbgU2
        7OYICgRuweWppsnh4w6osOQ==
X-Received: by 2002:a5d:61c1:: with SMTP id q1mr334682wrv.154.1631640218350;
        Tue, 14 Sep 2021 10:23:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3k1jrCY2l0TCreFxkhzeZFt/sEfOOcGitXD1qc1Q6O8TBKNKTnPnTU/9Pcn8mkICg9BGFjg==
X-Received: by 2002:a5d:61c1:: with SMTP id q1mr334653wrv.154.1631640218126;
        Tue, 14 Sep 2021 10:23:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6041.dip0.t-ipconnect.de. [91.12.96.65])
        by smtp.gmail.com with ESMTPSA id 61sm4080214wrl.94.2021.09.14.10.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 10:23:37 -0700 (PDT)
Subject: Re: [PATCH resend RFC 7/9] s390/mm: no need for pte_alloc_map_lock()
 if we know the pmd is present
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
References: <20210909162248.14969-1-david@redhat.com>
 <20210909162248.14969-8-david@redhat.com>
 <20210914185449.42d7d5ca@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <5a572489-a6d6-aaf4-098a-a8059f9b12f0@redhat.com>
Date:   Tue, 14 Sep 2021 19:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914185449.42d7d5ca@p-imbrenda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14.09.21 18:54, Claudio Imbrenda wrote:
> On Thu,  9 Sep 2021 18:22:46 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> pte_map_lock() is sufficient.
> 
> Can you explain the difference and why it is enough?

I didn't repeat the $subject:

"No need for pte_alloc_map_lock() if we know the pmd is present; 
pte_map_lock() is sufficient, because there isn't anything to allocate."

> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/s390/mm/pgtable.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
>> index 5fb409ff7842..4e77b8ebdcc5 100644
>> --- a/arch/s390/mm/pgtable.c
>> +++ b/arch/s390/mm/pgtable.c
>> @@ -814,10 +814,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
>>   	}
>>   	spin_unlock(ptl);
>>   
>> -	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
>> -	if (unlikely(!ptep))
>> -		return -EFAULT;
>> -
>> +	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>   	new = old = pgste_get_lock(ptep);
>>   	pgste_val(new) &= ~(PGSTE_GR_BIT | PGSTE_GC_BIT |
>>   			    PGSTE_ACC_BITS | PGSTE_FP_BIT);
>> @@ -912,10 +909,7 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
>>   	}
>>   	spin_unlock(ptl);
>>   
>> -	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
>> -	if (unlikely(!ptep))
>> -		return -EFAULT;
>> -
>> +	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>   	new = old = pgste_get_lock(ptep);
>>   	/* Reset guest reference bit only */
>>   	pgste_val(new) &= ~PGSTE_GR_BIT;
>> @@ -977,10 +971,7 @@ int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
>>   	}
>>   	spin_unlock(ptl);
>>   
>> -	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
>> -	if (unlikely(!ptep))
>> -		return -EFAULT;
>> -
>> +	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>   	pgste = pgste_get_lock(ptep);
>>   	*key = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
>>   	paddr = pte_val(*ptep) & PAGE_MASK;
> 


-- 
Thanks,

David / dhildenb

