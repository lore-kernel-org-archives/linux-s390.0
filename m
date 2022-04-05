Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67473C46467
	for <linux-s390@archiver.kernel.org>; Tue,  5 Apr 2022 10:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353999AbiDEKKb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350331AbiDEJ5Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Apr 2022 05:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49B644D9F5
        for <linux-s390@vger.kernel.org>; Tue,  5 Apr 2022 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649152262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMzcoQmo6xN0J9pUpc+raser+ONnMhNzrSVqI16lM6g=;
        b=TiaZNoEPGGDeOAx5AReViC5zRgIsx3COob3RSRBvuG4NCsQyhpWi7FmydXarSqQueB9oC/
        5gVupTpJAFHvZohsji78W5QI8xTgO5z1op48ob9v8h+r6/nP7RbdwLkLGY7cr79HLYeVif
        /1rKwxLAyLmKj3OBMO9W4d4SPhsrVrY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-yajYlqEYMnqEgLapA1Y4rA-1; Tue, 05 Apr 2022 05:51:01 -0400
X-MC-Unique: yajYlqEYMnqEgLapA1Y4rA-1
Received: by mail-wm1-f69.google.com with SMTP id j6-20020a05600c1c0600b0038e7d07ebcaso743476wms.0
        for <linux-s390@vger.kernel.org>; Tue, 05 Apr 2022 02:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IMzcoQmo6xN0J9pUpc+raser+ONnMhNzrSVqI16lM6g=;
        b=dpPJs6rVx+jM/vgxqkULunf53tLpuehNw88jwxAZ1rayawT2VNm1X5IljZyuvrhNWO
         BNisInZHCguwSiCZIDrgcXF5UJIuw6W+DonE9Kg4Eos7AJY3mfjBYn8q7kTnSvMyNFH1
         yPXS0uWLd1c9mHbFYv0DZuLDaEMF2d+7ZBmdZHdwUljSOd0tZ92Cr7lAs8EcgTxSMyq2
         ileoSXb5qhuNDoc9q2p+snRkVj2s8WtyR/8fQW2wCdRNszYppQtguGfUxLQAj6TJ65hD
         hdaIp6D5wPuV+B/jCpYDr7gRQ/uareQwqmdwpxkhgNOrOLCAuFYDOIYa/aLuy50Ezgy9
         kxxw==
X-Gm-Message-State: AOAM533585DLSfLa0Yr5HMbKIsS44jXJpC/LqDlLeyH6uxfa2GdDuK8t
        uRinp8LZtHhALCxlh5ckplUMc3NNG3pOR43r4A397w2BlmIjRjLOrceVmOPWP6Fc/DsSYmdZwCt
        bxtYal7hH05FBIhayLAQuJQ==
X-Received: by 2002:adf:d1c4:0:b0:204:b9d:a840 with SMTP id b4-20020adfd1c4000000b002040b9da840mr1996695wrd.285.1649152259741;
        Tue, 05 Apr 2022 02:50:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjxlVd/K2JIJTQYk3riHkTGazRfuCQYkxTp5hsMujWCq0rU1M9ujSPmv0UpkfiVfSy4nMSew==
X-Received: by 2002:adf:d1c4:0:b0:204:b9d:a840 with SMTP id b4-20020adfd1c4000000b002040b9da840mr1996667wrd.285.1649152259489;
        Tue, 05 Apr 2022 02:50:59 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id y2-20020adffa42000000b002060d53dbe0sm9026825wrr.9.2022.04.05.02.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 02:50:58 -0700 (PDT)
Message-ID: <9f0a91ce-3a2f-4149-7237-c5f963c0cba0@redhat.com>
Date:   Tue, 5 Apr 2022 11:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH 2/8] s390x: diag308: Only test subcode 2
 under QEMU
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, nrb@linux.ibm.com, seiden@linux.ibm.com
References: <20220405075225.15903-1-frankja@linux.ibm.com>
 <20220405075225.15903-3-frankja@linux.ibm.com>
 <16c254ac-c3ed-6174-5eef-5f309e7a7585@redhat.com>
 <68646d2c-0793-e395-4719-d1526983de6b@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <68646d2c-0793-e395-4719-d1526983de6b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/04/2022 11.33, Janosch Frank wrote:
> On 4/5/22 11:18, Thomas Huth wrote:
>> On 05/04/2022 09.52, Janosch Frank wrote:
>>> Other hypervisors might implement it and therefore not send a
>>> specification exception.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>    s390x/diag308.c | 15 ++++++++++++++-
>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/s390x/diag308.c b/s390x/diag308.c
>>> index c9d6c499..9614f9a9 100644
>>> --- a/s390x/diag308.c
>>> +++ b/s390x/diag308.c
>>> @@ -8,6 +8,7 @@
>>>    #include <libcflat.h>
>>>    #include <asm/asm-offsets.h>
>>>    #include <asm/interrupt.h>
>>> +#include <hardware.h>
>>>    /* The diagnose calls should be blocked in problem state */
>>>    static void test_priv(void)
>>> @@ -75,7 +76,7 @@ static void test_subcode6(void)
>>>    /* Unsupported subcodes should generate a specification exception */
>>>    static void test_unsupported_subcode(void)
>>>    {
>>> -    int subcodes[] = { 2, 0x101, 0xffff, 0x10001, -1 };
>>> +    int subcodes[] = { 0x101, 0xffff, 0x10001, -1 };
>>>        int idx;
>>>        for (idx = 0; idx < ARRAY_SIZE(subcodes); idx++) {
>>> @@ -85,6 +86,18 @@ static void test_unsupported_subcode(void)
>>>            check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>>>            report_prefix_pop();
>>>        }
>>> +
>>> +    /*
>>> +     * Subcode 2 is not available under QEMU but might be on other
>>> +     * hypervisors.
>>> +     */
>>> +    if (detect_host() != HOST_IS_TCG && detect_host() != HOST_IS_KVM) {
>>
>> Shouldn't this be rather the other way round instead?
>>
>>     if (detect_host() == HOST_IS_TCG || detect_host() == HOST_IS_KVM)
>>
>> ?
> 
> The css if checks if we are under QEMU, this one checks if we're not under 
> QEMU.

but ...

>>
>>> +        expect_pgm_int();
>>> +        asm volatile ("diag %0,%1,0x308" :: "d"(0), "d"(2));
>>> +        check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);

... don't we want to check here whether the diag causes a spec exception if 
we are *under* QEMU here?
/me feels confused now.

  Thomas

