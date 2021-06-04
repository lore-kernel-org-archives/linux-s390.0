Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38864C07E94
	for <linux-s390@archiver.kernel.org>; Fri,  4 Jun 2021 07:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD9261415
	for <linux-s390@archiver.kernel.org>; Fri,  4 Jun 2021 07:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFDHTj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 4 Jun 2021 03:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhFDHTi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Jun 2021 03:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622791072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYiGBrwOVwQzTkg4cxNvQnAUyjlM8dxbSVyQ8B6K+H0=;
        b=WKYjw6DZGss2e7ZfYX7/9cRExmJoSMrz340iRvQ4rWTeS8aMde8sFIDe5U8vxmtlB+LjK9
        nqxo17YV3+Vi1lTQHBO9BLyKSV9aQ6f5hic5ddfyGZbSvDDFn60vq8Ut1hVfGRoJ3whaJk
        +CnEmJ/yI+kZIe0W3Ot6DY6HAT8RMBs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-6Y4Lj-2lMAe6xQZSd_xypg-1; Fri, 04 Jun 2021 03:17:50 -0400
X-MC-Unique: 6Y4Lj-2lMAe6xQZSd_xypg-1
Received: by mail-ej1-f72.google.com with SMTP id j16-20020a1709062a10b02903ba544485d0so3046109eje.3
        for <linux-s390@vger.kernel.org>; Fri, 04 Jun 2021 00:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oYiGBrwOVwQzTkg4cxNvQnAUyjlM8dxbSVyQ8B6K+H0=;
        b=icpAfWXjIQgXWbfJvTQJIYK5/UbiQVqnMVSeFeYGNuBeq8zEDmnjC90XXpuFRySLhL
         xxTue2xlFSdLEoVqAMGlAomM8XST3PbE2jZm8qvWnsX2KotUKSAyr/eyrMvkIaPMJ5UU
         aK5wVm/b+aBtyGsHUkI74HefxnvRaZhtTdsTkH4mzfGwaqVSc3YlROgSiqYZ+KhHYj7b
         /BYVD5X6D4uzkKI2bQ4Qi9gpS6JbWCxrzgvPVDIiaxho7MZAGBcafv0YtXOoRqyc93Ki
         EHfI1r12iwFsv5CTIAxzHQgp8KhY6fctYPFM3jGIM3NeUMVekw+5oakDpWd2loC5nYIN
         g+8w==
X-Gm-Message-State: AOAM530TDItAtJ7RwYUUbf+lfO+hJhhySJMTgr1a0wdQCyX0o1WNGqpQ
        9kPffSIQND3u7wXIgSw5UNpCCJ60GUtVdXOKCXiRfGQUpsk97kkjW4rDHkumR2jySsPxV0RYkid
        i1n9tQ4vk3iadcwBXADXrL6C6pTCT55FrlzZCror48crpdFhc9FrJId18IrSM3+02TGDDv3U5GA
        ==
X-Received: by 2002:a17:906:1982:: with SMTP id g2mr2940231ejd.184.1622791069159;
        Fri, 04 Jun 2021 00:17:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNA+cR803OKErcII3/XiBGdUlseY07tlmT5T9SKrsahaFVgc/V2SdsxWbxXtho/hDOs9RuiA==
X-Received: by 2002:a17:906:1982:: with SMTP id g2mr2940199ejd.184.1622791068902;
        Fri, 04 Jun 2021 00:17:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id um5sm2430354ejb.109.2021.06.04.00.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 00:17:48 -0700 (PDT)
Subject: Re: [RFC][PATCH] kvm: add suspend pm-notifier
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210603164315.682994-1-senozhatsky@chromium.org>
 <YLkRB3qxjrXB99He@hirez.programming.kicks-ass.net>
 <YLl2QeoziEVHvRAO@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a460c63-89d6-b7ae-657b-2c4b841c9562@redhat.com>
Date:   Fri, 4 Jun 2021 09:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YLl2QeoziEVHvRAO@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/06/21 02:39, Sergey Senozhatsky wrote:
>>>   
>>> +void kvm_arch_pm_notifier(struct kvm *kvm)
>>> +{
>>> +}
>>> +
>>>   long kvm_arch_vm_ioctl(struct file *filp,
>>>   		       unsigned int ioctl, unsigned long arg)
>>>   {
>> What looks like you wants a __weak function.
> True. Thanks for the suggestion.
> 
> I thought about it, but I recalled that tglx had  __strong opinions
> on __weak functions.
> 

Alternatively, you can add a Kconfig symbol to virt/kvm/Kconfig and 
select it from arch/x86/kvm.

Paolo

