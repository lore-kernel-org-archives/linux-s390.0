Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122AFC4338F
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 11:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE59E60FE7
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 11:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbhHFLj1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238926AbhHFLj1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Aug 2021 07:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628249951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CCTGCsVlejSWa2TDvN4nfZAMgKaHGMDw5CATIJdm6E=;
        b=MYSwsJJGQpbfSg2leZGA4AF/cpFPNysJ6v+NXf7RXuzoMHnTStWatKg5F2i/JfXTccBu/0
        uanVwSioqLHgFQWrkfhwggRNfOA2z2zofzVvauu+2rdVA2haX3GPeKbwqMDMiAcwtJFcGG
        PXSwO7BDPavNY85m8FqrmmZao925ydM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-MtTDi_Z6Ogy2Ea3Il2PeTw-1; Fri, 06 Aug 2021 07:39:10 -0400
X-MC-Unique: MtTDi_Z6Ogy2Ea3Il2PeTw-1
Received: by mail-wm1-f71.google.com with SMTP id l19-20020a05600c4f13b029025b036c91c6so1933198wmq.2
        for <linux-s390@vger.kernel.org>; Fri, 06 Aug 2021 04:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6CCTGCsVlejSWa2TDvN4nfZAMgKaHGMDw5CATIJdm6E=;
        b=omszR190UGDq7hcJAJa13LkMVRkvBMOe3JOqEuWzeUVnw3vD3UJnNer+kWWPlpAQdM
         fgbNo4N1eXrQecGx5AI32uzs+qUFmpK/n70LJd9Cn5/WL/YlLciYwiIVojgExzFXnKps
         Q0e4DjSP9mVf4H5k8bp2cLXLlTxnCbNdTj/z2CH5JgasVFBgGDMsQ66miCwz4m+y3TAf
         Qf0N5nCw+mQk56DVr78+QXFE9UB4GUHfwDIJv2ANb32klUmOkzG48nf9YMh6orYbEALa
         cXl2km+3mlo3EFiOCtKI+igZIHGRZbqAq0uyVX3iXfoaMbaFwcwOO9yYcFV5u1oPAHb0
         VBgg==
X-Gm-Message-State: AOAM531C5lUnLeHgxzCPHuZX36WFdcYJ9fLoX+UF44w/qgPFIxO/TdMa
        ZpNMhVSaoxtturakh8oOOd/NVto2zRh9YACUjWLFRZTUjWHvRkCv67wfIVWsFurhiFGKIFjmZ4h
        cYopY3aP8/HWPJ8J1oIgDjg==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr2807883wmq.101.1628249948973;
        Fri, 06 Aug 2021 04:39:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBopaYdlFz12anxgFBxd76mmz9lAC4I8VKP8fU5XI5T+hbGBeAtWlQNXOP+dSKFRa9bqFXqA==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr2807863wmq.101.1628249948780;
        Fri, 06 Aug 2021 04:39:08 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6104.dip0.t-ipconnect.de. [91.12.97.4])
        by smtp.gmail.com with ESMTPSA id b15sm9184520wrx.73.2021.08.06.04.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 04:39:08 -0700 (PDT)
Subject: Re: [PATCH v3 03/14] KVM: s390: pv: leak the ASCE page when destroy
 fails
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulrich.Weigand@de.ibm.com
References: <20210804154046.88552-1-imbrenda@linux.ibm.com>
 <20210804154046.88552-4-imbrenda@linux.ibm.com>
 <6b75cc71-b996-cf3d-ce57-dbcd475ebc3a@redhat.com>
 <20210806113244.4d0712d2@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f2902086-6c77-eb7d-c4c9-15abb738b214@redhat.com>
Date:   Fri, 6 Aug 2021 13:39:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806113244.4d0712d2@p-imbrenda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06.08.21 11:32, Claudio Imbrenda wrote:
> On Fri, 6 Aug 2021 09:31:54 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 04.08.21 17:40, Claudio Imbrenda wrote:
>>> When a protected VM is created, the topmost level of page tables of
>>> its ASCE is marked by the Ultravisor; any attempt to use that
>>> memory for protected virtualization will result in failure.
>>>
>>> Only a successful Destroy Configuration UVC will remove the marking.
>>>
>>> When the Destroy Configuration UVC fails, the topmost level of page
>>> tables of the VM does not get its marking cleared; to avoid issues
>>> it must not be used again.
>>>
>>> Since the page becomes in practice unusable, we set it aside and
>>> leak it.
>>
>> Instead of leaking, can't we add it to some list and try again later?
>> Or do we only expect permanent errors?
> 
> once the secure VM has been destroyed unsuccessfully, there is nothing
> that can be done, this is a permanent error
> 
>> Also, we really should bail out loud (pr_warn) to tell the admin that
>> something really nasty is going on.
> 
> when a destroy secure VM UVC fails, there are already other warnings
> printed, no need to add one more
> 

Okay, makes sense then to me, thanks! Might be worth adding some of that 
info to the patch description.

-- 
Thanks,

David / dhildenb

