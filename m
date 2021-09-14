Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1AAC433F5
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7E6610A2
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 18:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhINSHk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229937AbhINSHj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Sep 2021 14:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631642781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdkTeh35hskFjppx/AtCQ+7sni5H8rOPzWMjSfWm50U=;
        b=V1x/lpqKZrj/nOekKwl9yjJBE979ubRrXkUP/oRc678n8F5WfdI3y+o/Gq6y9rkL3Y4BVK
        k3P8iUwVyjXubW5F4dAbwe/8DqFSDiyR/yJxMhZM3QvWRoDz9gngQFiVhb2EA/U0AAHVmr
        BobHd/o+Oh4Y3BFYv1YsZE9nageGhQ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-sHmbYV0jOSyUyvjHXy8uOg-1; Tue, 14 Sep 2021 14:06:20 -0400
X-MC-Unique: sHmbYV0jOSyUyvjHXy8uOg-1
Received: by mail-wm1-f70.google.com with SMTP id g18-20020a1c4e12000000b002fa970d2d8dso64826wmh.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 11:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WdkTeh35hskFjppx/AtCQ+7sni5H8rOPzWMjSfWm50U=;
        b=5L1w+ASGQbyodV4Glx4UJgVuWtC6jDpSEt64YJypQz+p6onpysyZhcjZVqyjZpMJXP
         /IkLKbeBLk11AFntdtgmviUJ6dOISlloYaoTwhDVtbxvXFakSG0N6pbuaNQgk/dWSjPR
         3m2qSdN+HQSS1QqPFqyvMpntsrUnTcicLqcANDQH+E3px3xfb8ZyCQlTstm6e2trhSbl
         DSooUJNeE2bX04J20bbUXTqbbfAQvkUzfiHEVkMRp1BeWR4mwaU57rska5ESVUUeJTjT
         nikIG+aZCllI/2/Ev+ES53uAqqhFzwnjpjK2+kWCI3dq4E9xKpKzbhYaw2qIejIGAO7Q
         Sp8A==
X-Gm-Message-State: AOAM532l261RJa8MocuvG2wS1bT7PhpDPTqwDy3uD66v05ROgCcZZ3Hu
        eH0EQEek3Y04t+vNEC/ySZ9tVGmMb/57F6R71PwOK3xR33p9noX1M7iOBFWSno2dO8gq78rV5VA
        lw6IF0Ttf7VLlPQXRwdCe9w==
X-Received: by 2002:a1c:c903:: with SMTP id f3mr450202wmb.101.1631642779387;
        Tue, 14 Sep 2021 11:06:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKIqckQty8a8VOzJidD+CVHVc1oyd0LQz0Ukul/JPoVTfeji3ABJKcoR2cUc0zjpzdgVfVPg==
X-Received: by 2002:a1c:c903:: with SMTP id f3mr450166wmb.101.1631642779102;
        Tue, 14 Sep 2021 11:06:19 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6041.dip0.t-ipconnect.de. [91.12.96.65])
        by smtp.gmail.com with ESMTPSA id g143sm1846758wme.16.2021.09.14.11.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 11:06:18 -0700 (PDT)
Subject: Re: [PATCH resend RFC 0/9] s390: fixes, cleanups and optimizations
 for page table walkers
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
 <20210914185033.367020b3@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <858a5f3b-99c0-6da3-6a60-8d01886399c6@redhat.com>
Date:   Tue, 14 Sep 2021 20:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914185033.367020b3@p-imbrenda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14.09.21 18:50, Claudio Imbrenda wrote:
> On Thu,  9 Sep 2021 18:22:39 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Resend because I missed ccing people on the actual patches ...
>>
>> RFC because the patches are essentially untested and I did not actually
>> try to trigger any of the things these patches are supposed to fix. It
> 
> this is an interesting series, and the code makes sense, but I would
> really like to see some regression tests, and maybe even some
> selftests to trigger (at least some of) the issues.

Yep, it most certainly needs regression testing before picking any of 
this. selftests would be great, but I won't find time for it in the 
foreseeable future.

> 
> the follow-up question is: how did we manage to go on so long without
> noticing these issues? :D

Excellent question - I guess we simply weren't aware of the dos and 
don'ts when dealing with process page tables :)

> 
>> merely matches my current understanding (and what other code does :) ). I
>> did compile-test as far as possible.
>>
>> After learning more about the wonderful world of page tables and their
>> interaction with the mmap_sem and VMAs, I spotted some issues in our
>> page table walkers that allow user space to trigger nasty behavior when
>> playing dirty tricks with munmap() or mmap() of hugetlb. While some issues
>> should be hard to trigger, others are fairly easy because we provide
>> conventient interfaces (e.g., KVM_S390_GET_SKEYS and KVM_S390_SET_SKEYS).
>>
>> Future work:
>> - Don't use get_locked_pte() when it's not required to actually allocate
>>    page tables -- similar to how storage keys are now handled. Examples are
>>    get_pgste() and __gmap_zap.
>> - Don't use get_locked_pte() and instead let page fault logic allocate page
>>    tables when we actually do need page tables -- also, similar to how
>>    storage keys are now handled. Examples are set_pgste_bits() and
>>    pgste_perform_essa().
>> - Maybe switch to mm/pagewalk.c to avoid custom page table walkers. For
>>    __gmap_zap() that's very easy.
>>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Janosch Frank <frankja@linux.ibm.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
>> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>> Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>>
>> David Hildenbrand (9):
>>    s390/gmap: validate VMA in __gmap_zap()
>>    s390/gmap: don't unconditionally call pte_unmap_unlock() in
>>      __gmap_zap()
>>    s390/mm: validate VMA in PGSTE manipulation functions
>>    s390/mm: fix VMA and page table handling code in storage key handling
>>      functions
>>    s390/uv: fully validate the VMA before calling follow_page()
>>    s390/pci_mmio: fully validate the VMA before calling follow_pte()
>>    s390/mm: no need for pte_alloc_map_lock() if we know the pmd is
>>      present
>>    s390/mm: optimize set_guest_storage_key()
>>    s390/mm: optimize reset_guest_reference_bit()
>>
>>   arch/s390/kernel/uv.c    |   2 +-
>>   arch/s390/mm/gmap.c      |  11 +++-
>>   arch/s390/mm/pgtable.c   | 109 +++++++++++++++++++++++++++------------
>>   arch/s390/pci/pci_mmio.c |   4 +-
>>   4 files changed, 89 insertions(+), 37 deletions(-)
>>
>>
>> base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
> 


-- 
Thanks,

David / dhildenb

