Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27179C4321E
	for <linux-s390@archiver.kernel.org>; Thu, 24 Nov 2022 10:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKXKrl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 24 Nov 2022 05:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKXKrk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Nov 2022 05:47:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684A21647B5
        for <linux-s390@vger.kernel.org>; Thu, 24 Nov 2022 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669286803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=meOlUg5MwMVHhaGR+idYAm5TqDEXqBJj0zANbpF8wbk=;
        b=SvswAlx1GhLqE1a0gq9TVQKkmYZkJrxG8RttmdB868AwLKR9Ih/ZFMFTTaOOCOC+rstyZV
        /nIqlgpHIgOlTrj1nGfKHcKD9yzZQS/kFQxiFV3F9fAemCRg/vvkst5Y795hXOt5FLZL4j
        lPBBMKkIxIhfN8ovF5aafajRp4hCkC0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-8aIt13OaPLGHqw_b4_-MIQ-1; Thu, 24 Nov 2022 05:46:42 -0500
X-MC-Unique: 8aIt13OaPLGHqw_b4_-MIQ-1
Received: by mail-wm1-f71.google.com with SMTP id c10-20020a7bc84a000000b003cf81c2d3efso476173wml.7
        for <linux-s390@vger.kernel.org>; Thu, 24 Nov 2022 02:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meOlUg5MwMVHhaGR+idYAm5TqDEXqBJj0zANbpF8wbk=;
        b=DVidndKPL4qyqwpB5QcYd0a6X58vRD8egYdV65LXQ3r5GNbwOSae7msHhplrQdIKdy
         vVz5Z4XvOohhQmvcaxnAgMjyZH0mVMePNpVg2hPmJtGguZ/vBLAmRrnhGS5sWDMyvHVC
         GOUiHxDB1JlEuMl6Ohs1dxIupwpHPuFcx//s1vxTj41KXx8LAH+MQFhNU7V/0DPn79dc
         DGgdSQ05zIWFKj1j5hBZ3jvcNi/OI3l0rtdVl6UZtHMDXh31fwAH57O431i5LLxFtnMO
         D4ezy+Wbj3mATx+taIhlVQqgvudOkIz5Q638ibbct1z9gAkuuPwFKQCQV3XZl/3DKda6
         OwtQ==
X-Gm-Message-State: ANoB5pnkIQYYC6KGlKcF9UM6kFKNhP0/VHla16IIa8qCN1Y6yoE48w9x
        ynbZ9RJxpDLld7RDkYwcoFzp5+tjI6VXtylv5Lk5YUUmkk5LBvHrPW716BFxodNQHP0AWaOq49H
        kfkx7TD/gQ1vJqFgWhtg/kg==
X-Received: by 2002:a5d:4ec7:0:b0:241:e27f:840e with SMTP id s7-20020a5d4ec7000000b00241e27f840emr7459986wrv.690.1669286801107;
        Thu, 24 Nov 2022 02:46:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5pwj5K0xvKVmdTQVnmmXoBI1L5Ykv5hwXvwBuBFvXNl68vB2n20Hl/zZh/FDl0FMsQUPjmcQ==
X-Received: by 2002:a5d:4ec7:0:b0:241:e27f:840e with SMTP id s7-20020a5d4ec7000000b00241e27f840emr7459977wrv.690.1669286800876;
        Thu, 24 Nov 2022 02:46:40 -0800 (PST)
Received: from [192.168.0.5] (ip-109-43-177-190.web.vodafone.de. [109.43.177.190])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c4f8800b003cfd64b6be1sm6445455wmq.27.2022.11.24.02.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 02:46:40 -0800 (PST)
Message-ID: <ef6d7ca6-e896-b554-6a30-05113114713d@redhat.com>
Date:   Thu, 24 Nov 2022 11:46:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] KVM: s390: vsie: Fix the initialization of the epoch
 extension (epdx) field
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        "Collin L. Walling" <walling@linux.ibm.com>,
        Jason J Herne <jjherne@linux.ibm.com>
References: <20221123090833.292938-1-thuth@redhat.com>
 <4d46020f-f33a-474c-b791-be11c2ce2aa6@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <4d46020f-f33a-474c-b791-be11c2ce2aa6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 24/11/2022 11.27, Janosch Frank wrote:
> On 11/23/22 10:08, Thomas Huth wrote:
>> We recently experienced some weird huge time jumps in nested guests when
>> rebooting them in certain cases. After adding some debug code to the epoch
>> handling in vsie.c (thanks to David Hildenbrand for the idea!), it was
>> obvious that the "epdx" field (the multi-epoch extension) did not get set
>> to 0xff in case the "epoch" field was negative.
>> Seems like the code misses to copy the value from the epdx field from
>> the guest to the shadow control block. By doing so, the weird time
>> jumps are gone in our scenarios.
>>
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2140899
>> Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Could you please add a test for this to the KVM unit tests?
> I'd guess you might already have some code for it from your debugging sessions.

I don't have some test code for this yet - I was only testing with the 
scenario that is described in the bugzilla ticket. But sure, I can have a 
try to come up with a k-u-t test.

  Thomas

