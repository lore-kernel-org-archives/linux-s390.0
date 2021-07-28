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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA7C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 10:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6DF760C3F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 10:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhG1Kgp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 06:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232514AbhG1Kgo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 06:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627468603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5E+mRYTtCZ4PA0EOVCSF1LV9sJDASpy6oSHxKe9/wo=;
        b=IJRzkjRgZYfKY5feNnAHOZ3ebvWlGHXWqGF10HjRDV8LsxLPGfAPuzQnyxnvJBU2Pq49PX
        QI7+m8cqTEfbJA4WUjHaTJpkHRAZX8V/fHRFc9um1AoiPVf6UWTW+Bthpf9jr+59V6xRZm
        zWlMWfz5tMGkpV6dbZhyK/vfvDe2HQ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-TMEkOpgfPsSpb-LnrKAP7w-1; Wed, 28 Jul 2021 06:36:41 -0400
X-MC-Unique: TMEkOpgfPsSpb-LnrKAP7w-1
Received: by mail-wr1-f71.google.com with SMTP id l7-20020a5d48070000b0290153b1557952so770151wrq.16
        for <linux-s390@vger.kernel.org>; Wed, 28 Jul 2021 03:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K5E+mRYTtCZ4PA0EOVCSF1LV9sJDASpy6oSHxKe9/wo=;
        b=WxgcnZC0aRu3z6M1nbYaCvAaTkNPKRWdZCixONcTBDcIXAUNePO1j6lckoSCXezCZw
         jVrxqSOl3hZTBRM/WUVzdGtCFAB1ks5N63BoEZ6hKl8GcVb5L+YEkIVOP4Q1SSkZVQkS
         Q+XTmj4SxU2MjpQMhBdWvvgn/BkYp0npyQbAphpDfBym8qSOWpHbBh7EmiTr34wV8NZ9
         227vaUmgh/+HK0nhfKMDRe/W9XBR6pA61AFNmWNqjEfwZupV+KSVGK5bL7FzGpjnnjPX
         c946Gzc1xB+2pmxZBHg2evBykNkQFEiDsVXgyzmkJw3lrDCPkZ7JFsBGROCLCx6yUWMn
         1gbw==
X-Gm-Message-State: AOAM530U+i5TXMVD2Dyge6MvDokKwtyuuwaT68nrD/73Uquu8EXxGljA
        JS0a+urmrX/mxna9yGczuc569IZOfAB+nsBBEFM+1dV84wrdFFo3Dto1a+UHMXwxRSziIHCPd3Y
        LzzXaXoGOWAwLIV/7pPSEJg==
X-Received: by 2002:adf:c803:: with SMTP id d3mr29892729wrh.345.1627468600385;
        Wed, 28 Jul 2021 03:36:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKpYiIngNIrO9iIW+3eUICC+4NU5UgG19LqyY41jjO+pAVTmwHURy0Od/7oixw3MPNVjS4qg==
X-Received: by 2002:adf:c803:: with SMTP id d3mr29892712wrh.345.1627468600250;
        Wed, 28 Jul 2021 03:36:40 -0700 (PDT)
Received: from thuth.remote.csb (p5791d475.dip0.t-ipconnect.de. [87.145.212.117])
        by smtp.gmail.com with ESMTPSA id f2sm5982427wrq.69.2021.07.28.03.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:36:39 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 1/3] s390x: Add SPDX and header comments
 for s390x/* and lib/s390x/*
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com,
        cohuck@redhat.com
References: <20210728101328.51646-1-frankja@linux.ibm.com>
 <20210728101328.51646-2-frankja@linux.ibm.com>
 <20210728123221.7ca90b35@p-imbrenda>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <d5c31cc5-0645-aa91-374e-c668b37e1150@redhat.com>
Date:   Wed, 28 Jul 2021 12:36:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728123221.7ca90b35@p-imbrenda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28/07/2021 12.32, Claudio Imbrenda wrote:
> On Wed, 28 Jul 2021 10:13:26 +0000
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> Seems like I missed adding them.
>>
>> The s390x/sieve.c one is a bit of a head scratcher since it came with
>> the first commit but I assume it's lpgl2-only since that's what the
>> COPYRIGHT file said then.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   lib/s390x/uv.c   |  9 +++++++++
>>   s390x/mvpg-sie.c |  9 +++++++++
>>   s390x/sie.c      | 10 ++++++++++
>>   x86/sieve.c      |  5 +++++
>>   4 files changed, 33 insertions(+)
[...]
>> diff --git a/x86/sieve.c b/x86/sieve.c
>> index 8150f2d9..b89d5f80 100644
>> --- a/x86/sieve.c
>> +++ b/x86/sieve.c
>> @@ -1,3 +1,8 @@
>> +/* SPDX-License-Identifier: LGPL-2.0-only */
> 
> do you really need to fix something in the x86 directory? (even though
> it is also used on other archs)

I just realized that s390x/sieve.c is just a symlink, not a copy of the file :-)

> maybe you can split out this as a separate patch, so s390x stuff is
> more self contained, and others can then discuss the sieve.c patch
> separately if needed?

That might make sense, indeed.

  Thomas

