Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D34EEB8FA5
	for <linux-s390@archiver.kernel.org>; Wed,  6 Sep 2023 07:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjIFHiZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Sep 2023 03:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjIFHiY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Sep 2023 03:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBD9CE
        for <linux-s390@vger.kernel.org>; Wed,  6 Sep 2023 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693985855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u+G7SCEl+RQAMOAXPLnGsTEkk0k/teSfrbOvDIMaHxM=;
        b=ZGmciYEvVCbcWNAkES65bC2EcLjgsQ2ljZpJnmWQjGDB0ZPcFiNF7xbH4oI6c7m4gLGP34
        i+3DbCrJTEDYWTC4LVRxDtWcDAD+ipiM07RujKtPWYMuFxDWuc5DgNC0bZBeBd9MplQB+o
        hadsYRvnuv56dlqXMMmaTgoHpAey7Lc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Is6QcgWWNkytDYIjTFvVTg-1; Wed, 06 Sep 2023 03:37:31 -0400
X-MC-Unique: Is6QcgWWNkytDYIjTFvVTg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31c5c55fd70so261545f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 06 Sep 2023 00:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985850; x=1694590650;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+G7SCEl+RQAMOAXPLnGsTEkk0k/teSfrbOvDIMaHxM=;
        b=ZmtEoaOqaVvVPeNKU0dmeT79BkFZqomXavCYNQrxFiw+xVVgo/5K/lz9JuGhGhm+w4
         x8j0GZOzxgeR63z0DNqfagLddrmn660WaMjLESoVBugHGkLiT0N/nnrz65n7BRE9Ovuq
         u3NnpgmAUFnrVrPfQ99CvLsnlO2BCinaRYs8kNXnTIr9dTEqwO+vZqLJmSo1dXdl9Q8j
         u4lFk90Pe/B0k/0uexMt1Osh2aqU8ug01pe0AsJM5n4N/VHuu2v49PLovD32r2OrSMR4
         2O4MojlxAsIQeCxN8g2o1MGDccrNEwAzPlZrt/zS+8H1LqCTIan0lEBGvIT+0RmrORHH
         IU7Q==
X-Gm-Message-State: AOJu0YxgLZbR/u9e0Qo9ggfPCZzcUkXZ2VtZoihT/asmLifPCA4s2ngb
        tMM2UfuJs3FVXc0iSSIfwNbda5RV/m0yQn1dO4iYY1YJlAY4XrOxTinc8ZPnXGObJySdqr3uABL
        Du3YTUY1NNz878yWnj0fDS+junIG+2w==
X-Received: by 2002:a05:6000:3c5:b0:31f:651f:f84d with SMTP id b5-20020a05600003c500b0031f651ff84dmr696719wrg.12.1693985850720;
        Wed, 06 Sep 2023 00:37:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1DSLXnwgNrv0EcncvQZhdHSbHRQqVhH+cXARLZ7z4S+sxICbZle9GKSg+Vg9thxtE+EUG8g==
X-Received: by 2002:a05:6000:3c5:b0:31f:651f:f84d with SMTP id b5-20020a05600003c500b0031f651ff84dmr696701wrg.12.1693985850322;
        Wed, 06 Sep 2023 00:37:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853? (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de. [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d56c3000000b0031762e89f94sm19274463wrw.117.2023.09.06.00.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:37:29 -0700 (PDT)
Message-ID: <411a4c35-4f65-c166-0eb0-994b8e39f9c6@redhat.com>
Date:   Wed, 6 Sep 2023 09:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/2] KVM: s390: add counters for vsie performance
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230904130140.22006-1-nrb@linux.ibm.com>
 <a41f6fc29032d345b3c2f24e19f32282dd627e5c.camel@linux.ibm.com>
 <169390280362.97137.14761686200997364254@t14-nrb>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <169390280362.97137.14761686200997364254@t14-nrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05.09.23 10:33, Nico Boehr wrote:
> Quoting Niklas Schnelle (2023-09-05 09:53:40)
>> On Mon, 2023-09-04 at 15:01 +0200, Nico Boehr wrote:
>>> v3:
>>> ---
>>> * rename te -> entry (David)
>>> * add counters for gmap reuse and gmap create (David)
>>>
>>> v2:
>>> ---
>>> * also count shadowing of pages (Janosch)
>>> * fix naming of counters (Janosch)
>>> * mention shadowing of multiple levels is counted in each level (Claudio)
>>> * fix inaccuate commit description regarding gmap notifier (Claudio)
>>>
>>> When running a guest-3 via VSIE, guest-1 needs to shadow the page table
>>> structures of guest-2.
>>>
>>> To reflect changes of the guest-2 in the _shadowed_ page table structures,
>>> the _shadowing_ sturctures sometimes need to be rebuilt. Since this is a
>>> costly operation, it should be avoided whenever possible.
>>>
>>> This series adds kvm stat counters to count the number of shadow gmaps
>>> created and a tracepoint whenever something is unshadowed. This is a first
>>> step to try and improve VSIE performance.
>>>
>>> Please note that "KVM: s390: add tracepoint in gmap notifier" has some
>>> checkpatch --strict findings. I did not fix these since the tracepoint
>>> definition would then look completely different from all the other
>>> tracepoints in arch/s390/kvm/trace-s390.h. If you want me to fix that,
>>> please let me know.
>>>
>>> While developing this, a question regarding the stat counters came up:
>>> there's usually no locking involved when the stat counters are incremented.
>>> On s390, GCC accidentally seems to do the right thing(TM) most of the time
>>> by generating a agsi instruction (which should be atomic given proper
>>> alignment). However, it's not guaranteed, so would we rather want to go
>>> with an atomic for the stat counters to avoid losing events? Or do we just
>>> accept the fact that we might loose events sometimes? Is there anything
>>> that speaks against having an atomic in kvm_stat?
>>>
>>
>> FWIW the PCI counters (/sys/kernel/debug/pci/<dev>/statistics) use
>> atomic64_add(). Also, s390's memory model is strong enough that these
>> are actually just normal loads/stores/adds (see
>> arch/s390/include/asm/atomic_ops.h) with the generic atomic64_xx()
>> adding debug instrumentation.
> 
> In KVM I am mostly concerned about the compiler since we just do counter++
> - right now this always seems to result in an agsi instruction, but that's
> of course not guaranteed.

Right, the compiler can do what it wants with that. The question is if 
we care about a slight imprecision, though.

Probably not worth the trouble for something that never happens and is 
only used for debugging purposes.

Using atomics would be cleaner, though.

-- 
Cheers,

David / dhildenb

