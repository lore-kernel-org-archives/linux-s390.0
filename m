Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3223BE7B61B
	for <linux-s390@archiver.kernel.org>; Wed,  4 Oct 2023 14:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbjJDOEl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 4 Oct 2023 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbjJDOEl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Oct 2023 10:04:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39318BD
        for <linux-s390@vger.kernel.org>; Wed,  4 Oct 2023 07:04:38 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79fc0068cb5so30653639f.1
        for <linux-s390@vger.kernel.org>; Wed, 04 Oct 2023 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696428277; x=1697033077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBObCAvl415IgunarYXCD03xBaTPmaQ6oUuz6W/Tybg=;
        b=TnqJuTOO+YwYKVrjq2p/0uGzs00NIk/3axvbmN8HegLCrRbP7E8At5o3ga66Z8x8c/
         yeRcUirLjLRTgooW+/2hZOrjNfRa4pOO6hknLprMKzMvopJTY4rZWvKLpDLtlnSzghtH
         XnwIAv39qAWLGcEub7icbV19OFqJ8/dhJg2K/jzpvCdk+LxdvQH2OHRnMiAwg02SD5wZ
         DgTK0sivBH6JzRiHFQiRiTRH8L7WaBjWJPKcliM9FJ7ccOYDdAOmPdEV2n2ImX8UNHzp
         mARx47UaGLENnF9UEWPrcwaOjHMZGkhHXXvt4CefCq3jqz+cci/usoKhzyXQqm0Yulz3
         QTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696428277; x=1697033077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBObCAvl415IgunarYXCD03xBaTPmaQ6oUuz6W/Tybg=;
        b=wEx0F7vhXHo2Vx4WJJvTMgBhbah4abojQCuesoJflTA38k6kQ3vgKnUkwSDXXfEPBV
         i2zHIEHo6A1+mzNRcQNgNkeEe6UMa8CYSs6hp/M2wFC04iUzpCvyXHlUrYgAut2+FkFh
         BV6uWZmIGggbGVzdVmvR3Be4s4WVQBnaomwhJDEJAMHH1r9xyWPWZXR5ju/imSCBHxC0
         XQuU3ARpSeymXU6rD7s4KxlwqmDyyyvyS7TGKOTPmtExSD8VcqVtRDxXkqh/3Ojhspqn
         cSTCt6EMaToIvrIoo/03tpIKDIgG3xiDCLtx0HXjdoNFLczzHdoDECq9/ZpWmQiKr+ti
         +lPg==
X-Gm-Message-State: AOJu0YyYOQ+AgwOyOTNQGs4J+yOrvQljT+Wc0p9axCZlEgw0pl2dRxIB
        +Z4WNpa5WF+aA/3fI/k6X6rP7w==
X-Google-Smtp-Source: AGHT+IGz+avlAZn3aF+d8+W++7Sn7IX1/L6/9TWK1stHBzWIQs+nuR7jKT2TzB8EzoN1Nx+0Vje5RA==
X-Received: by 2002:a05:6602:2e84:b0:79f:8cd3:fd0e with SMTP id m4-20020a0566022e8400b0079f8cd3fd0emr2834750iow.1.1696428277148;
        Wed, 04 Oct 2023 07:04:37 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g7-20020a05663811c700b0043cb3818dffsm979897jas.3.2023.10.04.07.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 07:04:36 -0700 (PDT)
Message-ID: <e19c6352-a54d-4ae3-b70a-ec1529107583@kernel.dk>
Date:   Wed, 4 Oct 2023 08:04:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] partitions/ibm: Replace strncpy() and cleanups
Content-Language: en-US
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Justin Stitt <justinstitt@google.com>
References: <20230915131001.697070-1-sth@linux.ibm.com>
 <c9c468df-e67a-4cb8-ef26-12c380fd55e2@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c9c468df-e67a-4cb8-ef26-12c380fd55e2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/4/23 3:59 AM, Stefan Haberland wrote:
> Am 15.09.23 um 15:09 schrieb Stefan Haberland:
>> Hi Jens,
>>
>> please apply the following patches for the next merge window that remove
>> strncpy() from DASD partition detection. This includes some cleanups that
>> should increase readability of the code.
>>
>> This is based on the discussion started with the patches by Justin Stitt:
>> https://lore.kernel.org/linux-s390/20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com/
>> https://lore.kernel.org/linux-s390/20230823-strncpy-block-partitions-cmdline-ibm-v2-1-40c77f7182fc@google.com/
>>
>> Thanks.
>>
>> Jan H?ppner (3):
>>    partitions/ibm: Remove unnecessary memset
>>    partitions/ibm: Replace strncpy() and improve readability
>>    partitions/ibm: Introduce defines for magic string length values
>>
>>   block/partitions/ibm.c | 98 +++++++++++++++++++++++++++++-------------
>>   1 file changed, 68 insertions(+), 30 deletions(-)
>>
> 
> Hi Jens,
> 
> polite ping.
> Any objections against the patches?

Nope, just had some travel and it got lost in the inbox. Now applied.

-- 
Jens Axboe

