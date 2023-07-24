Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15037C001DF
	for <linux-s390@archiver.kernel.org>; Mon, 24 Jul 2023 08:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjGXI6O (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGXI6J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Jul 2023 04:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E8B10CE
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690189026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hiUzn4GoHzYmJRywXbeyp47r5LbOlgKk94EnRsD7j9E=;
        b=Td20KQhgX9EDx03ny7gYU/xJuqlJQeAi5b4tlWpMGVt/N12hcDjOSVuecePB1GIBdr9XtT
        aN1o7O1YeF1ib92hGssBUoteRGC/Kbo4VivBAjaxdGDddMTr80kzP02D5nC+HxoKZMB7Lt
        0Gkfj+RszWvGJ44w4/52zw5PPrDwlUo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-ISxaxcs7OiieL6HSzu4eqw-1; Mon, 24 Jul 2023 04:56:59 -0400
X-MC-Unique: ISxaxcs7OiieL6HSzu4eqw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbb34f7224so25570495e9.2
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 01:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189018; x=1690793818;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiUzn4GoHzYmJRywXbeyp47r5LbOlgKk94EnRsD7j9E=;
        b=fE8naijsOq7ZPeyTQJmbgchzeahIchICqWMMpknoS5pVh3yO4uklvKUto7oFpIuh8c
         5ylXT7XYrJMvC3C4/SlYzlanccP1rkPC6uf3c1OxMBggm5bQxaebSNU9lk4BmJsG7x8g
         WjcITTOgi7XfnHKyCmTW+XulyuGSouCV0Vx0GpUPV2nYa6JKlDTk+C+ZegmHqcLfbwcf
         +18p3IJiN48TN3hLBcy4ssr2ZEXjHp/4z1koj9S+6r44F7QrpqDMVkMyQu4eIJbEqLd9
         54WKcI02f8B2bngrEt8Jpqx0VWGedR25UJECPN4MyarbMa9Do6dkJ5iRQeRw0iZXUVOq
         iIkw==
X-Gm-Message-State: ABy/qLYjWJ538USRSqRQgmlSovOezHgcLcEHM80cEwqPrj0bKcJIkjXh
        UjUD974ZcORszbuY54YSLfrAp2kbdNaFyJOXNJvKBGHGyt23JwZZXHiY01Y56XJYAOcXhn4l4jX
        VaWFcHKrmpAJ57Wf4O2wmJg==
X-Received: by 2002:a1c:ed0f:0:b0:3f8:fc96:6bfd with SMTP id l15-20020a1ced0f000000b003f8fc966bfdmr6849520wmh.17.1690189018753;
        Mon, 24 Jul 2023 01:56:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpERLNNdkBQgqeLMFfxb+yLknb1i7c/nG0TK8neSKVVTW7S2Zgzvd3sYLdo7tRcyc7R9bJOQ==
X-Received: by 2002:a1c:ed0f:0:b0:3f8:fc96:6bfd with SMTP id l15-20020a1ced0f000000b003f8fc966bfdmr6849505wmh.17.1690189018429;
        Mon, 24 Jul 2023 01:56:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:d000:62f2:4df0:704a:e859? (p200300d82f45d00062f24df0704ae859.dip0.t-ipconnect.de. [2003:d8:2f45:d000:62f2:4df0:704a:e859])
        by smtp.gmail.com with ESMTPSA id p25-20020a1c7419000000b003fbb0c01d4bsm9753501wmc.16.2023.07.24.01.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:56:57 -0700 (PDT)
Message-ID: <dba4395d-400a-7bea-5eba-a44cab80ce0e@redhat.com>
Date:   Mon, 24 Jul 2023 10:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/6] KVM: s390: interrupt: Fix single-stepping into
 interrupt handlers
Content-Language: en-US
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Freimann <jfreimann@redhat.com>
References: <20230721120046.2262291-1-iii@linux.ibm.com>
 <20230721120046.2262291-2-iii@linux.ibm.com>
 <af7be3a9-816c-95dc-22a7-cf62fe245e24@redhat.com>
 <5394773f1d872f086625439cc515c50d2374a161.camel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <5394773f1d872f086625439cc515c50d2374a161.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 24.07.23 10:42, Ilya Leoshkevich wrote:
> On Mon, 2023-07-24 at 10:22 +0200, David Hildenbrand wrote:
>> On 21.07.23 13:57, Ilya Leoshkevich wrote:
>>> After single-stepping an instruction that generates an interrupt,
>>> GDB
>>> ends up on the second instruction of the respective interrupt
>>> handler.
>>>
>>> The reason is that vcpu_pre_run() manually delivers the interrupt,
>>> and
>>> then __vcpu_run() runs the first handler instruction using the
>>> CPUSTAT_P flag. This causes a KVM_SINGLESTEP exit on the second
>>> handler
>>> instruction.
>>>
>>> Fix by delaying the KVM_SINGLESTEP exit until after the manual
>>> interrupt delivery.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    arch/s390/kvm/interrupt.c | 10 ++++++++++
>>>    arch/s390/kvm/kvm-s390.c  |  4 ++--
>>>    2 files changed, 12 insertions(+), 2 deletions(-)
> 
> [...]
>>
> 
>> Can we add a comment like
>>
>> /*
>>    * We delivered at least one interrupt and modified the PC. Force a
>>    * singlestep event now.
>>    */
> 
> Ok, will do.
> 
>>> +       if (delivered && guestdbg_sstep_enabled(vcpu)) {
>>> +               struct kvm_debug_exit_arch *debug_exit = &vcpu-
>>>> run->debug.arch;
>>> +
>>> +               debug_exit->addr = vcpu->arch.sie_block->gpsw.addr;
>>> +               debug_exit->type = KVM_SINGLESTEP;
>>> +               vcpu->guest_debug |= KVM_GUESTDBG_EXIT_PENDING;
>>>          }
>>
>> I do wonder if we, instead, want to do this whenever we modify the
>> PSW.
>>
>> That way we could catch any PC changes and only have to add checks
>> for
>> guestdbg_exit_pending().
> 
> Wouldn't this break a corner case where the first instruction of the
> interrupt handler causes the same interrupt?

Could be, there are many possible corner cases (PGM interrupt at the 
first instruction of PGM interrupt handler -- our PSW address might not 
even change)

-- 
Cheers,

David / dhildenb

