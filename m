Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D88C4743C
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028076115B
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFGJ7h (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230194AbhFGJ7h (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 05:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623059866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7awUZSmtwE73YaPk78D/jTjtxkiUtYiFGv2HHuxraCI=;
        b=c3CDToi3Jjx1MF7xeLRSUIt+9gg38lAKjsx7/WwiR9A5zTnWT51kPV2oP6xWy0t4gxfwsh
        ITrCst9Ixxmt9bJV8m9MK1nC5LABlIePfFT87Cm8JujUEBmiZd6aiCtWem2+1gvj/On16j
        yhgxtYtEYFXx8HTi7DHNxkSbBYbgI8U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-wTkknI1KNBmAMaFA44FJFw-1; Mon, 07 Jun 2021 05:57:44 -0400
X-MC-Unique: wTkknI1KNBmAMaFA44FJFw-1
Received: by mail-wm1-f70.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so3904421wmh.9
        for <linux-s390@vger.kernel.org>; Mon, 07 Jun 2021 02:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7awUZSmtwE73YaPk78D/jTjtxkiUtYiFGv2HHuxraCI=;
        b=ZWA7+oPtRY1YivhV3VcfwBcGd6vWzyzbTgljxGhAVoA5QkGbavhQv8RK4NHDR86oSE
         gqdjWAE9VwyXtIYmn2Dx81IVqVduOMrhoXw+RTZ673KfqqGk2Q2mhCrFDZHLOzGjz8Kr
         qBDt1umJaO+yotCmCmC/cnJ0H+s+Ivlrk4aFWjD54ErM5ozGhYYrzvuzlLiqmcwmzZ7z
         KTtNjZ66lmxLetG1e7B2bE9AcIuusNzBdy5uoHnzBVwo1M2955WbTB5l1t1MOyOz1vZh
         AIPNeyp+Q+nXgAn4MAZPlydbCn9OwFoMoNLo4idQWE/qB/mAB8cbdtv95jg74nznwhzr
         +Urw==
X-Gm-Message-State: AOAM532TASY2uid9PQjecoieFDdaHOq4PmjHY0JX9Y2V9vVSC8FFiNKn
        FBOLau0eFwB54e1GtT6AMliSa8ilA7R9aZQRT18gBT/Q41GWkm1bEJGP/wdVpONd+5wAZe8LTvT
        aP8j6IfMXmC9Z1ipgW7KFjAVe78TuO7glYi6g/kRHDND174fZdTYZPNLlLRyZuk39k+73/w==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr15684200wrm.177.1623059863532;
        Mon, 07 Jun 2021 02:57:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy2JnuXPJlE8N8A5u5bpZ8cxRMhkZNB+GZy39rztvdiscVnZi0dfP0L8nuFzQIscu15FLhTw==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr15684181wrm.177.1623059863324;
        Mon, 07 Jun 2021 02:57:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6188.dip0.t-ipconnect.de. [91.12.97.136])
        by smtp.gmail.com with ESMTPSA id l2sm15023010wrp.21.2021.06.07.02.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 02:57:43 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: run: Skip PV tests when tcg is
 the accelerator
To:     Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, linux-s390@vger.kernel.org
References: <20210318125015.45502-1-frankja@linux.ibm.com>
 <20210318125015.45502-4-frankja@linux.ibm.com>
 <92be69b9-227a-d01c-6877-738a4482b8c6@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <656f9301-70ec-a1e1-2d24-48ede0b07aca@redhat.com>
Date:   Mon, 7 Jun 2021 11:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <92be69b9-227a-d01c-6877-738a4482b8c6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07.06.21 11:54, Thomas Huth wrote:
> On 18/03/2021 13.50, Janosch Frank wrote:
>> TCG doesn't support PV.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>    s390x/run | 5 +++++
>>    1 file changed, 5 insertions(+)
>>
>> diff --git a/s390x/run b/s390x/run
>> index df7ef5ca..82922701 100755
>> --- a/s390x/run
>> +++ b/s390x/run
>> @@ -19,6 +19,11 @@ else
>>        ACCEL=$DEF_ACCEL
>>    fi
>>    
>> +if [ "${1: -7}" == ".pv.bin" ] || [ "${TESTNAME: -3}" == "_PV" ] && [ $ACCEL == "tcg" ]; then
> 
> Put $ACCEL in quotes?
> 
> With that nit fixed:
> 

Should these "==" be "=" ? Bash string comparisons always mess with my mind.


-- 
Thanks,

David / dhildenb

