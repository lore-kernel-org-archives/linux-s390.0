Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0E6C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAA260F93
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 11:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhG1L4s (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 07:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234537AbhG1L4s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 07:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627473406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XaRRTboc70MUCyM0TQteUnofxTwGl2oCgNNxgCYL0w=;
        b=HSWbQfPM+oMOgocyMrVHsboKe/KBPgiYgd6eY6+iB0tpd9d14xCOUdCPNUGje0MWyfPvlf
        od5vQIgsecLysMN/zn+Qi4XpNdV+3XZo46ZbCwuPPJk2VrXhn41CuZimB28q5qotCz5/zD
        CPfJZp13YAZIjPr52/OkPhDicV3fdi0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-0pTFrDS6ORuhBvpAtOAJ3w-1; Wed, 28 Jul 2021 07:56:44 -0400
X-MC-Unique: 0pTFrDS6ORuhBvpAtOAJ3w-1
Received: by mail-wr1-f69.google.com with SMTP id d10-20020a056000114ab02901537f048363so854547wrx.8
        for <linux-s390@vger.kernel.org>; Wed, 28 Jul 2021 04:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/XaRRTboc70MUCyM0TQteUnofxTwGl2oCgNNxgCYL0w=;
        b=EwxvK31UbX4nQhdAyf9OKxeLy78tEKXfHUl/FYxE29cbgxEpLCbm9J8lt9Ue3zs4YY
         3L31fsRlrK/xGaou2vr5Po/TL26VPGijADSswt0pHeV9GkJT9rN2HUb7dXJtiJ6HT7Lb
         oJR4i/V97LmCQf2AZ1dIBEeIlRSn+8b69yyxvF/S2ij9RNrGBa4Q3VYCtkST1quayNpm
         98vClnqZ9kwNFnoqwmw+H6/Rp21nh6GmJJtWuGr4VoReyW7Qp39XMQagswPuBZVVTfOg
         P63cK62Sr65Tk0jDwakGKlEeKxJsPCEoulsnHMpZJbjkpuYuovyvwEFCn3Pv0ZjNmKaK
         cLqQ==
X-Gm-Message-State: AOAM531TvwGjuI/EZN29cZMzK+C3Ko0w/H4gtFLQEvzSl10otHZlHM8m
        zeK8VUYiWuLWO2toqvWIHbq8mWe7wDqIBjzbz9xGQG82s61DzNL7U08frxziw7ezEw58F50y78N
        PY8THrDZUN7p1pV/4/Ao7wA==
X-Received: by 2002:a05:600c:88a:: with SMTP id l10mr1874081wmp.78.1627473403538;
        Wed, 28 Jul 2021 04:56:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzorpSuliVsG4NQ0s7BaFDu+gPHUAXbzulsOoPrbAqQKRZIKFJsvzbR5rPxJnHpBC1yStYWg==
X-Received: by 2002:a05:600c:88a:: with SMTP id l10mr1874066wmp.78.1627473403297;
        Wed, 28 Jul 2021 04:56:43 -0700 (PDT)
Received: from thuth.remote.csb (p5791d475.dip0.t-ipconnect.de. [87.145.212.117])
        by smtp.gmail.com with ESMTPSA id q22sm5971323wmc.16.2021.07.28.04.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 04:56:42 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 1/3] s390x: Add SPDX and header comments
 for s390x/* and lib/s390x/*
To:     Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com,
        cohuck@redhat.com
References: <20210728101328.51646-1-frankja@linux.ibm.com>
 <20210728101328.51646-2-frankja@linux.ibm.com>
 <20210728123221.7ca90b35@p-imbrenda>
 <d5c31cc5-0645-aa91-374e-c668b37e1150@redhat.com>
 <2e391a1a-54d4-8713-4a93-104a6b4cfaf1@linux.ibm.com>
 <d1c3e9f0-57c0-e941-3e3f-94a897ace177@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <32e8624e-4dd9-0c39-fe65-87f1ba0a4b24@redhat.com>
Date:   Wed, 28 Jul 2021 13:56:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d1c3e9f0-57c0-e941-3e3f-94a897ace177@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28/07/2021 13.41, Janosch Frank wrote:
> On 7/28/21 1:36 PM, Janosch Frank wrote:
>> On 7/28/21 12:36 PM, Thomas Huth wrote:
>>> On 28/07/2021 12.32, Claudio Imbrenda wrote:
>>>> On Wed, 28 Jul 2021 10:13:26 +0000
>>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>>
>>>>> Seems like I missed adding them.
>>>>>
>>>>> The s390x/sieve.c one is a bit of a head scratcher since it came with
>>>>> the first commit but I assume it's lpgl2-only since that's what the
>>>>> COPYRIGHT file said then.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>    lib/s390x/uv.c   |  9 +++++++++
>>>>>    s390x/mvpg-sie.c |  9 +++++++++
>>>>>    s390x/sie.c      | 10 ++++++++++
>>>>>    x86/sieve.c      |  5 +++++
>>>>>    4 files changed, 33 insertions(+)
>>> [...]
>>>>> diff --git a/x86/sieve.c b/x86/sieve.c
>>>>> index 8150f2d9..b89d5f80 100644
>>>>> --- a/x86/sieve.c
>>>>> +++ b/x86/sieve.c
>>>>> @@ -1,3 +1,8 @@
>>>>> +/* SPDX-License-Identifier: LGPL-2.0-only */
>>>>
>>>> do you really need to fix something in the x86 directory? (even though
>>>> it is also used on other archs)
>>>
>>> I just realized that s390x/sieve.c is just a symlink, not a copy of the file :-)
>>
>> You're not the only one...
>>
>>>
>>>> maybe you can split out this as a separate patch, so s390x stuff is
>>>> more self contained, and others can then discuss the sieve.c patch
>>>> separately if needed?
>>>
>>> That might make sense, indeed.
>>
>> Yup will do
> 
> On second thought I'm just gonna drop that hunk since x86 doesn't really
> have SPDX or header comments for most of their files anyway.

That's fine, too. We can still add them there later.

  Thomas

