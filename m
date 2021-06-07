Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1E9C47095
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 10:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FCB611C0
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 10:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFGKEs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 06:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230193AbhFGKEr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 06:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623060176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDxOcIV3LOZMskX0TR+s6vQHpg3Tao4QIKopLA2bBSk=;
        b=ghiLA6oS2iFfn7A2ks4eTVastQWlVxjUCrMaQQQPthWYREQsbBm+37uaCfUBIZDD8PnXh7
        /IEEcnE0vbLIs4zAWER+sIVM5t/b23CZtw1qgpp6oiMdNbAcN6YsbsBWa02h8a8Isi8L0S
        pDcvFrxSrAvlbzA4CoaBDsHGwDbXMvk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-vJrdM4aXPeqXJF8yV5JH6w-1; Mon, 07 Jun 2021 06:02:51 -0400
X-MC-Unique: vJrdM4aXPeqXJF8yV5JH6w-1
Received: by mail-wm1-f69.google.com with SMTP id w3-20020a1cf6030000b0290195fd5fd0f2so3923135wmc.4
        for <linux-s390@vger.kernel.org>; Mon, 07 Jun 2021 03:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QDxOcIV3LOZMskX0TR+s6vQHpg3Tao4QIKopLA2bBSk=;
        b=HegotKXSdxm8ckEabKUAOHuEKXwSl08JgC1kECNkQndhb0bIlgL86LVkPjiJ8xoeZI
         RhFcc06I8ZxFo+KVNCv8MZbDVpRcC+mhmo2dRiSb6FrOG3T0p4vENY8+Vm06SoEqBSBN
         Cq9CWQoubeP748IvU5IgUFpAsOwZAOoMe579ClYlUeruux1fWDg8rXYX/8SZ0SYQcoHa
         17HmJwk1R5XvBt9j6/lNi6CtlLtc052QETz06Q4YOkWtTV1WK9pLzAU/9nwLtKGwHdQT
         rCd6Glh4ZpPxOZs8X2+XRNGmESMURAEWRPD0AcijFgBqXWmhFwhUjjZum+rf6CVMwjBk
         ZFvg==
X-Gm-Message-State: AOAM5315Pg515OoY+y8K8mnezByGG6Qdy9dlxPRrD4ZnX65hk28788oO
        pZFRdrezCZJNsWY9IdTYfA8s+61uIMh+9BQXeQC3DykDHd62i0ANPhtfFZ9mx8GGAadBPJqZ1SU
        XDcGGAUNZhr8LHXPvNwORVK7tI9X0oyGOdRrXJuwFaNgYk6eerNwfbH8vhHk9b/0fbEBr1g==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr15962968wri.386.1623060170916;
        Mon, 07 Jun 2021 03:02:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL4k2ErUlnKNJsph+jyfsDApfgauXG26LfkRzqkoYWhTta0sLsvXg3BmjHcbSsGp6qar3B8A==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr15962951wri.386.1623060170708;
        Mon, 07 Jun 2021 03:02:50 -0700 (PDT)
Received: from thuth.remote.csb (pd957536e.dip0.t-ipconnect.de. [217.87.83.110])
        by smtp.gmail.com with ESMTPSA id p187sm14203741wmp.28.2021.06.07.03.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 03:02:50 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: run: Skip PV tests when tcg is
 the accelerator
To:     David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, linux-s390@vger.kernel.org
References: <20210318125015.45502-1-frankja@linux.ibm.com>
 <20210318125015.45502-4-frankja@linux.ibm.com>
 <92be69b9-227a-d01c-6877-738a4482b8c6@redhat.com>
 <656f9301-70ec-a1e1-2d24-48ede0b07aca@redhat.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <9fec70e1-a5a0-9f65-7a79-5106757e38cb@redhat.com>
Date:   Mon, 7 Jun 2021 12:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <656f9301-70ec-a1e1-2d24-48ede0b07aca@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/06/2021 11.57, David Hildenbrand wrote:
> On 07.06.21 11:54, Thomas Huth wrote:
>> On 18/03/2021 13.50, Janosch Frank wrote:
>>> TCG doesn't support PV.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>    s390x/run | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/s390x/run b/s390x/run
>>> index df7ef5ca..82922701 100755
>>> --- a/s390x/run
>>> +++ b/s390x/run
>>> @@ -19,6 +19,11 @@ else
>>>        ACCEL=$DEF_ACCEL
>>>    fi
>>> +if [ "${1: -7}" == ".pv.bin" ] || [ "${TESTNAME: -3}" == "_PV" ] && [ 
>>> $ACCEL == "tcg" ]; then
>>
>> Put $ACCEL in quotes?
>>
>> With that nit fixed:
>>
> 
> Should these "==" be "=" ? Bash string comparisons always mess with my mind.

Oh, right. I also always have to check "man test" to get the right answer, 
but "=" is more portable, indeed. (Well, k-u-t are hard-wired to bash, but 
it's better to write clean shell code anyway)

  Thomas

