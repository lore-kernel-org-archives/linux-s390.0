Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5979C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 15 Sep 2021 14:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEDE61164
	for <linux-s390@archiver.kernel.org>; Wed, 15 Sep 2021 14:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhIOOJp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Sep 2021 10:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhIOOJo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Sep 2021 10:09:44 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB63C061574;
        Wed, 15 Sep 2021 07:08:25 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so3663615otg.11;
        Wed, 15 Sep 2021 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I2A31vkH1KuWdXSd5ju0bH7L4mFuHVmLMgvk3FgHJY0=;
        b=NRdaicJWp7ayqH9jsDFb73Gz8Cf3R628eZgQGNYYYw73nlRDwX0MhDq3KweoJDhTJT
         GbxOItv3OOUX8L6g6LLw54GEZtCbyUbRDJreqRfzf2kQ8+ZBCa8lt7i4hA/D3w+b7J2H
         wtIcXm/k2Y7EJx6QRC43Tt790k2irXPm+bEBOiLhnMjNuCig1kv00lMutBWUUMGqlhAR
         zWFwosOLm5A+i4su+fgeaWORBHdDvNj1IC8X2pHlSWR5+qMfJzc+Ph80lhUZNCxml7gm
         9roMymlF1nIpeN4Wgqc4sQUWQYe2isgncBD/xw6u3wE1W54GJ0aJneuYsgYJrBw/zyx5
         tWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2A31vkH1KuWdXSd5ju0bH7L4mFuHVmLMgvk3FgHJY0=;
        b=LjqWHg+LYMtJ0SQ5DsfD/yIlqSu9l5AcyWB7zfpMEiHvj15YiS3HBDdLU61c2I3nta
         lJDNeizp7gElqeGtYQDkx0K4gzz6Va7mGWYzuZXqlye7/Eg3zC3DGffa2uJDTfh+l5e6
         4WJl06Eb2UH74wBX0AC2cvt/dSRq9eSFUtuHs+DgAZy3oN0iY6YB19N+EC0cbaDTkmWc
         DGR43WzH9sbWQRPaT4U4OnxE51VjiCScFoxJKCCzI9SbFo0vBx3wN2zuqstYFjUqLItv
         vif2UB/kfL+3KXJrWuzwrElWpPfBw5CNElGvT6aL/LDulF3AcJzDxtaEs3C+keWdvNlW
         SU9w==
X-Gm-Message-State: AOAM5323gLFyU1umpH9pofWphM9sfUBB50FQltXK+fReCyJ0fGqxyJz1
        QruX2z44+L4Ifqpkeu325R5Is+Ahofw=
X-Google-Smtp-Source: ABdhPJyGVejKG/0QIjX/U07XHlCiHcZBAD5y4wapWvmWPwTsE14wGhKTrxx2aD6uEomzXj+nR2CUgQ==
X-Received: by 2002:a9d:4589:: with SMTP id x9mr111337ote.52.1631714904722;
        Wed, 15 Sep 2021 07:08:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v5sm20358oos.17.2021.09.15.07.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 07:08:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] s390: Add WARN_DYNAMIC_STACK dependencies
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210915044010.640499-1-linux@roeck-us.net>
 <80b7dbc9-0c09-197f-0f40-ab92d2e3fe3c@de.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <84949d48-435a-e76b-9977-d072f7359d91@roeck-us.net>
Date:   Wed, 15 Sep 2021 07:08:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <80b7dbc9-0c09-197f-0f40-ab92d2e3fe3c@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 9/15/21 2:02 AM, Christian Borntraeger wrote:
> 
> 
> On 15.09.21 06:40, Guenter Roeck wrote:
>> s390:allmodconfig fails to build with the following errors.
>>
>> arch/s390/kernel/syscall.c: In function '__do_syscall':
>> arch/s390/kernel/syscall.c:168:1: error:
>>     '__do_syscall' uses dynamic stack allocation
>>
>> lib/test_kasan.c: In function 'kasan_alloca_oob_right':
>> lib/test_kasan.c:782:1: error:
>>     'kasan_alloca_oob_right' uses dynamic stack allocation
>>
>> lib/test_kasan.c: In function 'kasan_alloca_oob_left':
>> lib/test_kasan.c:767:1: error:
>>     'kasan_alloca_oob_left' uses dynamic stack allocation
>>
>> The first error is seen if RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>> WARN_DYNAMIC_STACK, and WERROR are enabled. The other problems
>> are seen if KASAN_KUNIT_TEST, WARN_DYNAMIC_STACK, and WERROR
>> are enabled.
>>
>> It does not make sense to abort a build in that situation.
>> If either RANDOMIZE_KSTACK_OFFSET_DEFAULT or KASAN_KUNIT_TEST
>> is enabled, dynamic stack allocation is on purpose and should
>> not fail the build. Add dependencies to reflect that situation.
>>
> 
> Thanks for the patch. I think Heiko (on vacation) has a patch to
> get rid  of this config alltogether, which is probably the better
> solution.
> 

I did consider that, but concluded that this would be something a maintainer
should do and went with what I thought was the least invasive method.
I did check the various mailing lists for other patches, but I did not
find anything there. Sorry if I missed it.

Guenter
