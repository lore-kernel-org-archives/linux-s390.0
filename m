Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07C4C4338F
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 07:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA89D61104
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 07:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243471AbhHFHKs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242848AbhHFHKs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Aug 2021 03:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628233832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OdiX91xZyqhCMWTD+e1a7203Hh2iiQFW1H/jHSgMREc=;
        b=ZEJwu9F+5NmCWWBljAV343h9V/i7WvsbM1jOZG7QNw3xB4KplhPvdd6tjz/gJHmcA0ixmS
        Jj4Bqr7J2WmVTcYFMdiAHPoQDEZnP67eGIQgnEqSIi/Ds1m7d4ZIJ26/anyD9zbN1H+pST
        wHM/GI8p278Ld3bAvjzAZhlVS6XdppE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-UGkWzHJNOHSWmETDoPsZbQ-1; Fri, 06 Aug 2021 03:10:30 -0400
X-MC-Unique: UGkWzHJNOHSWmETDoPsZbQ-1
Received: by mail-wm1-f71.google.com with SMTP id 21-20020a05600c0255b02902571fa93802so2712465wmj.1
        for <linux-s390@vger.kernel.org>; Fri, 06 Aug 2021 00:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OdiX91xZyqhCMWTD+e1a7203Hh2iiQFW1H/jHSgMREc=;
        b=PtXyvmD2N+q37EmGEhTYeSlZNbrZYrDbI65B1eqx+okrcRUtImkBJAqvo0zEzE5kLb
         coBg7PVqS8v7WZTP57CrhJXNB9er+BTFkYDpNZ+TaHm4ySqXOCm1xf2/Ro5j6zzXG3Gg
         ZWuXWcpJ4ooZ+j7EVYkfjOPB6OohQaErkMrU031sUWmTF/q+9QGTJMffbR3UDa/V5L/g
         7GG6/Ji5NzRzmMtsZwh45+p4i9SaM52Ttk8ognbBpdpU75hAO/0RB/pxp8AhAGcf93Cm
         DDWS1p5raHG/csBMxiX66BWCQ9boL9PzM80iB233ecd88vpvgdMFcMbdyI0Id1Zbthi0
         5UUg==
X-Gm-Message-State: AOAM533TvmiIeWi4DWRvWUEEBtvgqrifEQ/T81eFDQ0CHHcPDTuk0ukX
        A3EOk0ZF7C+d9QKThokBVXY7k8UyXMW/ttmDtPszI8KrYsl0CEFWIciIAGd5XDp5ly9+Urq8Qab
        7YhBr43mhcGrt7He8RFSa5A==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr18778764wmc.111.1628233829596;
        Fri, 06 Aug 2021 00:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3kCeiOWbbw8vg7aEBTtCpQMHk0XWodUURxQdsSZuiFQC4PLQm2T8HYcAlaq/7xcBafZ8pIw==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr18778739wmc.111.1628233829376;
        Fri, 06 Aug 2021 00:10:29 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6104.dip0.t-ipconnect.de. [91.12.97.4])
        by smtp.gmail.com with ESMTPSA id a2sm8564992wrn.95.2021.08.06.00.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 00:10:29 -0700 (PDT)
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulrich.Weigand@de.ibm.com,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>
References: <20210804154046.88552-1-imbrenda@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 00/14] KVM: s390: pv: implement lazy destroy
Message-ID: <86b114ef-41ea-04b6-327c-4a036f784fad@redhat.com>
Date:   Fri, 6 Aug 2021 09:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804154046.88552-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04.08.21 17:40, Claudio Imbrenda wrote:
> Previously, when a protected VM was rebooted or when it was shut down,
> its memory was made unprotected, and then the protected VM itself was
> destroyed. Looping over the whole address space can take some time,
> considering the overhead of the various Ultravisor Calls (UVCs). This
> means that a reboot or a shutdown would take a potentially long amount
> of time, depending on the amount of used memory.
> 
> This patchseries implements a deferred destroy mechanism for protected
> guests. When a protected guest is destroyed, its memory is cleared in
> background, allowing the guest to restart or terminate significantly
> faster than before.
> 
> There are 2 possibilities when a protected VM is torn down:
> * it still has an address space associated (reboot case)
> * it does not have an address space anymore (shutdown case)
> 
> For the reboot case, the reference count of the mm is increased, and
> then a background thread is started to clean up. Once the thread went
> through the whole address space, the protected VM is actually
> destroyed.

That doesn't sound too hacky to me, and actually sounds like a good 
idea, doing what the guest would do either way but speeding it up 
asynchronously, but ...

> 
> For the shutdown case, a list of pages to be destroyed is formed when
> the mm is torn down. Instead of just unmapping the pages when the
> address space is being torn down, they are also set aside. Later when
> KVM cleans up the VM, a thread is started to clean up the pages from
> the list.

... this ...

> 
> This means that the same address space can have memory belonging to
> more than one protected guest, although only one will be running, the
> others will in fact not even have any CPUs.

... this ...
> 
> When a guest is destroyed, its memory still counts towards its memory
> control group until it's actually freed (I tested this experimentally)
> 
> When the system runs out of memory, if a guest has terminated and its
> memory is being cleaned asynchronously, the OOM killer will wait a
> little and then see if memory has been freed. This has the practical
> effect of slowing down memory allocations when the system is out of
> memory to give the cleanup thread time to cleanup and free memory, and
> avoid an actual OOM situation.

... and this sound like the kind of arch MM hacks that will bite us in 
the long run. Of course, I might be wrong, but already doing excessive 
GFP_ATOMIC allocations or messing with the OOM killer that way for a 
pure (shutdown) optimization is an alarm signal. Of course, I might be 
wrong.

You should at least CC linux-mm. I'll do that right now and also CC 
Michal. He might have time to have a quick glimpse at patch #11 and #13.

https://lkml.kernel.org/r/20210804154046.88552-12-imbrenda@linux.ibm.com
https://lkml.kernel.org/r/20210804154046.88552-14-imbrenda@linux.ibm.com

IMHO, we should proceed with patch 1-10, as they solve a really 
important problem ("slow reboots") in a nice way, whereby patch 11 
handles a case that can be worked around comparatively easily by 
management tools -- my 2 cents.

-- 
Thanks,

David / dhildenb

