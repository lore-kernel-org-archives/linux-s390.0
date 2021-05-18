Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2992C433B4
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 16:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79112611CE
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 16:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350563AbhERQYN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 12:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344626AbhERQYF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 May 2021 12:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621354966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5RJYPLqAYSF7PeEx+nR3RgNKQgQ5XhiMT8l2SDsZYU=;
        b=EI8iLG7gQ7KvpkzYNTLm9uCaHfPTJoQn5dw2b/M8xuS1bLttR+5TYdszDBzSWOQ4T/xz4Z
        mKhOV7QWjR45G0LC/RyeblgJyn2DiLO5XdxaZUek4MJab4vwQXbhqEgy/hdwfybKcuwXzk
        nLWv3hmrAsWW+vKZB5Wjul49TLs7g58=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-GmEIuGpkPGypUM95VLL5WQ-1; Tue, 18 May 2021 12:22:45 -0400
X-MC-Unique: GmEIuGpkPGypUM95VLL5WQ-1
Received: by mail-wr1-f70.google.com with SMTP id 22-20020adf82960000b02901115ae2f734so5807827wrc.5
        for <linux-s390@vger.kernel.org>; Tue, 18 May 2021 09:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=f5RJYPLqAYSF7PeEx+nR3RgNKQgQ5XhiMT8l2SDsZYU=;
        b=nBke4+FHpG6hPF1d4j163ap/av9cOOwjlKwxk+ZMWlFBlj2fe9O3PZDant+JeKvFvD
         sF1vtr3IexPczJa0S6TeF3Yho9Mwxp/tTN8jOCHyzHW3v/O2E545MvCQrRc9w2JS/IZ/
         uibKZaf76b9rimpfhc+9QtKhvNCkzQrJ6iFLvSXt8ob9APJO058chR3s2WslaABX/k6C
         MJx9BwUSKqda2XAWT7m5HrkXnu7ZZ64se1NhUtouVOTCbHieY0y96pjlRHl1OvIl+o1W
         UgsdWNi3jvB9t9c61ZsWkp66NpxT2KA5WO0zz8BA8Aoh9tECfJvbNQt+VIJucubIs20r
         xFJA==
X-Gm-Message-State: AOAM530jIDU6vuFf2I6YYsR4AFw3IKevGDGLLHVlvGskcjHwajLxTBtN
        pUjr8Lre8Gb3fDqVcBCHuSb7DQGcTeMWyiOhcwhj2n08AbDoL9MnqZ+yGEVsLd/rZ/Bw9/ksOSX
        baTxXHqOxIHWjMrtbC5W1Zg==
X-Received: by 2002:a05:6000:1368:: with SMTP id q8mr8169208wrz.342.1621354963255;
        Tue, 18 May 2021 09:22:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJXTyLbbe+j8G/6H/hwqiNFjexjmfC5GXKyFTrPfr1NMUTkplW/NkFtTn2Aiu3BABVg2Cz+Q==
X-Received: by 2002:a05:6000:1368:: with SMTP id q8mr8169190wrz.342.1621354963029;
        Tue, 18 May 2021 09:22:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fd.dip0.t-ipconnect.de. [91.12.100.253])
        by smtp.gmail.com with ESMTPSA id f7sm17857348wmq.30.2021.05.18.09.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 09:22:42 -0700 (PDT)
Subject: Re: [PATCH v1 00/11] KVM: s390: pv: implement lazy destroy
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210517200758.22593-1-imbrenda@linux.ibm.com>
 <20210518170537.58b32ffe.cohuck@redhat.com> <20210518173624.13d043e3@ibm-vm>
 <20210518180411.4abf837d.cohuck@redhat.com> <20210518181922.52d04c61@ibm-vm>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a38192d5-0868-8e07-0a34-c1615e1997fc@redhat.com>
Date:   Tue, 18 May 2021 18:22:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518181922.52d04c61@ibm-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.05.21 18:19, Claudio Imbrenda wrote:
> On Tue, 18 May 2021 18:04:11 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Tue, 18 May 2021 17:36:24 +0200
>> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
>>
>>> On Tue, 18 May 2021 17:05:37 +0200
>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>    
>>>> On Mon, 17 May 2021 22:07:47 +0200
>>>> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
>>
>>>>> This means that the same address space can have memory
>>>>> belonging to more than one protected guest, although only one
>>>>> will be running, the others will in fact not even have any
>>>>> CPUs.
>>>>
>>>> Are those set-aside-but-not-yet-cleaned-up pages still possibly
>>>> accessible in any way? I would assume that they only belong to
>>>> the
>>>
>>> in case of reboot: yes, they are still in the address space of the
>>> guest, and can be swapped if needed
>>>    
>>>> 'zombie' guests, and any new or rebooted guest is a new entity
>>>> that needs to get new pages?
>>>
>>> the rebooted guest (normal or secure) will re-use the same pages of
>>> the old guest (before or after cleanup, which is the reason of
>>> patches 3 and 4)
>>
>> Took a look at those patches, makes sense.
>>
>>>
>>> the KVM guest is not affected in case of reboot, so the userspace
>>> address space is not touched.
>>
>> 'guest' is a bit ambiguous here -- do you mean the vm here, and the
>> actual guest above?
>>
> 
> yes this is tricky, because there is the guest OS, which terminates or
> reboots, then there is the "secure configuration" entity, handled by the
> Ultravisor, and then the KVM VM
> 
> when a secure guest reboots, the "secure configuration" is dismantled
> (in this case, in a deferred way), and the KVM VM (and its memory) is
> not directly affected
> 
> what happened before was that the secure configuration was dismantled
> synchronously, and then re-created.
> 
> now instead, a new secure configuration is created using the same KVM
> VM (and thus the same mm), before the old secure configuration has been
> completely dismantled. hence the same KVM VM can have multiple secure
> configurations associated, sharing the same address space.
> 
> of course, only the newest one is actually running, the other ones are
> "zombies", without CPUs.
> 

Can a guest trigger a DoS?

-- 
Thanks,

David / dhildenb

