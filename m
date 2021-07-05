Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A71C07E99
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 10:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9912D613C8
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 10:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhGEKIU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230367AbhGEKIU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Jul 2021 06:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625479543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ff8XIbVqW5sBPga2YwlaIM//lfIqxbfy//y/L7/taAU=;
        b=Zqv5LKvydaKeEXs924kVk5NJq9TWzbZMsw7lJ4Lqa+UqNZS/HVZW7bU8Dgop8kFF84n6nJ
        X5kyqOzTrQq5SNnrjZCcBAEYSHeaRM8UrTd/hBc3YVuZHSrQxwJep6fqZbjFBlMoVMqzYi
        c8VPjQhd9EwCgvCz1aSf1ElEoKKO9R0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-He2ktF8YPtOUH7IImaiZvg-1; Mon, 05 Jul 2021 06:05:41 -0400
X-MC-Unique: He2ktF8YPtOUH7IImaiZvg-1
Received: by mail-wm1-f71.google.com with SMTP id t82-20020a1cc3550000b02901ee1ed24f94so9662139wmf.9
        for <linux-s390@vger.kernel.org>; Mon, 05 Jul 2021 03:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ff8XIbVqW5sBPga2YwlaIM//lfIqxbfy//y/L7/taAU=;
        b=DnlC+1+5K+uO51y4Vy+vBdVXKLKQdhHwSuoAOgwK87myLvj71zABjlzEkLc+3LuYrY
         qkd994uGIiCwUb+dDI/jrL6OdrEkuwm1VaATbtAWMOXbu8Dd7HAVWm7nqL1+4cxcqXU1
         I8bWtLidL5f2j1qPzV6dllrqeQOMBOcrTfsqBCtbC45PqbcxaE2kShPkVN8KgR6AuHDN
         yNH0vhVukptBH96MUDWUgfe5Hxl+22uggsCN4cpS141Bk26xdKl7XyKrD5Rb2V0G8ziw
         e+jE6DbswpW1j+JtDQFT8NDWMyeCT7j+h+lA0dUamoRZa/7h1qKmw+esDG4ymgpO13w1
         OU1A==
X-Gm-Message-State: AOAM530rWVwVeBaxptXljYRxcg8nBIlMxSIAtrllwppbHzDjfKrU0+zi
        uMkWxpfpRxijEv0sbL1pmqBsuEXQ1BCJs1KGegicM+mEm27jX9swzswt4kvsAoLYygAzBsx3dLu
        y6XASyt0J5Z9wvI15WYscvg==
X-Received: by 2002:a7b:c154:: with SMTP id z20mr14162789wmi.155.1625479540606;
        Mon, 05 Jul 2021 03:05:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBGyNDrD3/JomaqPn/DbrMfBpeHatHiVf83bxivnT9MDNZLNqNq+LmOrqs8IvAXmxi7ol0NQ==
X-Received: by 2002:a7b:c154:: with SMTP id z20mr14162775wmi.155.1625479540434;
        Mon, 05 Jul 2021 03:05:40 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id k6sm11410419wrx.41.2021.07.05.03.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 03:05:40 -0700 (PDT)
Subject: Re: [PATCH/RFC] KVM: selftests: introduce P44V64 for z196 and EC12
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20210701153853.33063-1-borntraeger@de.ibm.com>
 <bc025447-db53-5472-76b0-0cfa2c3ae996@redhat.com>
 <390803e9-a713-c9e7-cda8-ee822e5c1c40@de.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <fb2cfee2-b9bd-3e3c-a98c-a0ed7a28462f@redhat.com>
Date:   Mon, 5 Jul 2021 12:05:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <390803e9-a713-c9e7-cda8-ee822e5c1c40@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05.07.21 11:59, Christian Borntraeger wrote:
> 
> 
> On 05.07.21 11:53, David Hildenbrand wrote:
>> On 01.07.21 17:38, Christian Borntraeger wrote:
>>> Older machines likes z196 and zEC12 do only support 44 bits of physical
>>> addresses. Make this the default and check via IBC if we are on a later
>>> machine. We then add P47V64 as an additional model.
>>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Fixes: 1bc603af73dd ("KVM: selftests: introduce P47V64 for s390x")
>>
>> [...]
>>
>>> +#ifdef __s390x__
>>> +    {
>>> +        int kvm_fd, vm_fd;
>>> +        struct kvm_s390_vm_cpu_processor info;
>>> +
>>> +        kvm_fd = open_kvm_dev_path_or_exit();
>>> +        vm_fd = ioctl(kvm_fd, KVM_CREATE_VM, 0);
>>> +        kvm_device_access(vm_fd, KVM_S390_VM_CPU_MODEL,
>>> +                  KVM_S390_VM_CPU_PROCESSOR, &info, false);
>>
>> Can we always assume to run on a kernel where this won't fail?
> 
> As far as I can tell, the selftests are bundled with a given kernel (and
> there it should not fail). I guess most selftests will fail with a 3.x
> kernel and we do not care?

Fair enough

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

