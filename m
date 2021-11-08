Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BC3C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  8 Nov 2021 08:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4A861029
	for <linux-s390@archiver.kernel.org>; Mon,  8 Nov 2021 08:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbhKHJAX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 8 Nov 2021 04:00:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238226AbhKHJAT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Nov 2021 04:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636361853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1QVy2jF6V4BA7K1wLjdWcKPNmRSWOeaRFj3XjWQfgo=;
        b=EoJfXuPshYt6QaiEgXyaCoLmo5ltKl5yNmeK9YyY7XeC8LJoX6wGMsc6X40WltgnezCJxY
        D+i3RwU4KqqXWlGnSpFvki6g875V4x3UXCu0gWsMnuNjoJTj7L1ni7W3XI2beldU+P6FX7
        6O7xn+mJ22wWwMnnIVM3q/qcLqnVpBY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-zSoSz-ODOROnbZ9oeSBKwg-1; Mon, 08 Nov 2021 03:57:32 -0500
X-MC-Unique: zSoSz-ODOROnbZ9oeSBKwg-1
Received: by mail-wr1-f71.google.com with SMTP id d7-20020a5d6447000000b00186a113463dso3817582wrw.10
        for <linux-s390@vger.kernel.org>; Mon, 08 Nov 2021 00:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=g1QVy2jF6V4BA7K1wLjdWcKPNmRSWOeaRFj3XjWQfgo=;
        b=SbiIsT6oVulpp/mO/bXao8FN6wjrYjbcnPKYXys2hiiisDx3ICZx+Gt+5LlbLLo4if
         1thcLxVGy6UfBkrpKsnQa8Ey08UMVnFKE+ZvHPi/EtTNcGspAeLTBjiQc0E/oM5IYWQf
         27PZQ7xlji7oJVghusdlKfrxCSPkfBj7eWEXPn9CJ8d5D1FlkARmp9FHVdlz2lkpKhas
         BG+dIY+Ef3bWKoOyr5zBKuKkPyLP1rVcLwQJSh9gck9SFqjrejjooJ63pNlFUWR8AC7v
         tB2OQaSz0m1dan+kUROLO4n8Il5hrJzw9dkvtFXXJ4E59v5FK3Fy052MDo42iPsGw2kF
         Ta7g==
X-Gm-Message-State: AOAM531P4qs6G1Df/En9pHJouxOQz1aypFyXm/wy0QW1RO2yCJ6MubNc
        FUtlMGAFSY146TiUOaieIdV6FboRC9Thc6jIbi6zJkH1YEWMheyeTQwQ+2DfiYXFQ2LORphZcng
        Y3ykAYece3/8xJrCE4w4RuA==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr49698082wmh.193.1636361851479;
        Mon, 08 Nov 2021 00:57:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJye+8D16l/504GIRn0ryj2rM/g2LAWDU8pggMBrRVe+L2Ngt3A/rSkPXhqOCx2C3Pr1d5AuJQ==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr49698067wmh.193.1636361851289;
        Mon, 08 Nov 2021 00:57:31 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6108.dip0.t-ipconnect.de. [91.12.97.8])
        by smtp.gmail.com with ESMTPSA id n15sm20024708wmq.38.2021.11.08.00.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 00:57:30 -0800 (PST)
Message-ID: <fb4e14c2-aa95-fc8c-5252-5a3a43381d95@redhat.com>
Date:   Mon, 8 Nov 2021 09:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20211102194652.2685098-1-farman@linux.ibm.com>
 <20211102194652.2685098-3-farman@linux.ibm.com>
 <7e98f659-32ac-9b4e-0ddd-958086732c8d@redhat.com>
 <2ad9bef6b39a5a6c9b634cab7d70d110064d8f04.camel@linux.ibm.com>
 <655b3473-ccbd-f198-6566-c23a0ec20940@redhat.com>
 <1365cae27512d38a4b405d72b4d0ae2d502ec5d1.camel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v2 2/2] KVM: s390: Extend the USER_SIGP capability
In-Reply-To: <1365cae27512d38a4b405d72b4d0ae2d502ec5d1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04.11.21 16:54, Eric Farman wrote:
> On Thu, 2021-11-04 at 15:59 +0100, David Hildenbrand wrote:
>>>> For example, we don't care about concurrent SIGP SENSE. We only
>>>> care
>>>> about "lightweight" SIGP orders with concurrent "heavy weight"
>>>> SIGP
>>>> orders.
>>>
>>> I very much care about concurrent SIGP SENSE (a "lightweight" order
>>> handled in-kernel) and how that interacts with the "heavy weight"
>>> SIGP
>>> orders (handled in userspace). SIGP SENSE might return CC0
>>> (accepted)
>>> if a vcpu is operating normally, or CC1 (status stored) with status
>>> bits indicating an external call is pending and/or the vcpu is
>>> stopped.
>>> This means that the actual response will depend on whether
>>> userspace
>>> has picked up the sigp order and processed it or not. Giving CC0
>>> when
>>> userspace is actively processing a SIGP STOP/STOP AND STORE STATUS
>>> would be misleading for the SIGP SENSE. (Did the STOP order get
>>> lost?
>>> Failed? Not yet dispatched? Blocked?)
>>
>> But that would only visible when concurrently SIGP STOP'ing from one
>> VCPU and SIGP SENSE'ing from another VCPU. But in that case, there
>> are
>> already no guarantees, because it's inherently racy:
>>
>> VCPU #2: SIGP STOP #3
>> VCPU #1: SIGP SENSE #3
>>
> 
> Is it inherently racy? QEMU has a global "one SIGP at a time,
> regardless of vcpu count" mechanism, so that it gets serialized at that
> level. POPS says an order is rejected (BUSY) if the "access path to a
> cpu is processing another order", and I would imagine that KVM is
> acting as that access path to the vcpu. The deliniation between
> kernelspace and userspace should be uninteresting on whether parallel
> orders are serialized (in QEMU via USER_SIGP) or not (!USER_SIGP or
> "lightweight" orders).

There is no real way for a guest to enforce the execution order of

VCPU #2: SIGP STOP #3
VCPU #1: SIGP SENSE #3

or

VCPU #1: SIGP SENSE #3
VCPU #2: SIGP STOP #3

without additional synchronization.

There could be random delays in the instruction execution at any point
in time. So the SENSE on #2 might observe "stopped" "not stopped" or
"busy" randomly, because it's inherently racy.


Of course, one could implement some synchronization on top:

VCPU #2: SIGP STOP #3
# VCPU #2 instructs #1 to SIGP SENSE #2
VCPU #1: SIGP SENSE #3
# VCPU #2 waits for SIGP SENSE #2 result from #1
VCPU #2: SIGP SENSE #3

Then, we have to make sure that it cannot happen that #1 observes "not
busy" and #2 observes "busy". But, to implement something like that, #2
has to execute additional instructions to perform the synchronization.

So after SIGP STOP returns on #2 and #2 was able to execute new
instructions, we have to make sure that SIGP SENSE of #3 returns "busy"
on all VCPUs until #3 finished the SIGP STOP.

> 
>> There is no guarantee who ends up first
>> a) In the kernel
>> b) On the final destination (SENSE -> kernel; STOP -> QEMU)
>>
>> They could be rescheduled/delayed in various ways.
>>
>>
>> The important part is that orders from the *same* CPU are properly
>> handled, right?
>>
>> VCPU #1: SIGP STOP #3
>> VCPU #1: SIGP SENSE #3
>>
>> SENSE must return BUSY in case the STOP was not successful yet,
>> correct?
> 
> It's not a matter of whether STOP is/not successful. If the vcpu is

Right, I meant "accepted but not fully processed yet".

> actively processing a STOP, then the SENSE gets a BUSY. But there's no
> code today to do that for the SENSE, which is of course why I'm here.
> :)

Right, and the only problematic SIGP orders are really SIGP STOP*,
because these are the only ones that will get processed asynchronously
-- the sending VCPU can return and execute new instructions without the
SIGP STOP order being fully processed.


-- 
Thanks,

David / dhildenb

