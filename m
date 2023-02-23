Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05409C636D6
	for <linux-s390@archiver.kernel.org>; Thu, 23 Feb 2023 19:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjBWTTD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjBWTTC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Feb 2023 14:19:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3451826CC2
        for <linux-s390@vger.kernel.org>; Thu, 23 Feb 2023 11:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677179802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KU3Ox2Ew/Jsk/EiHqSrTUkdmsrVL1tultoFc9/FEnc=;
        b=LX3zs5H4JOmBKVuXhj+jYxTd9gp067GWYvoRDuh0XqEykMwPvLeK41l0ElXrIRHKUEGD8D
        7y9+g61fCt0vOISBhqsbHQcmDCO4SgCLyM6ZTI7qvTpjirt6v8RwrjOVF1OnAg0Oi9C1kj
        LYvusSZ3KzxC0Hn4PUJKnyq9ORx+l1Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-_yQGyG7lN4aBJSi3rJEEWw-1; Thu, 23 Feb 2023 14:16:40 -0500
X-MC-Unique: _yQGyG7lN4aBJSi3rJEEWw-1
Received: by mail-wm1-f72.google.com with SMTP id f14-20020a7bcc0e000000b003dd41ad974bso89337wmh.3
        for <linux-s390@vger.kernel.org>; Thu, 23 Feb 2023 11:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KU3Ox2Ew/Jsk/EiHqSrTUkdmsrVL1tultoFc9/FEnc=;
        b=Eqki7/c26EszmtObytwwS+8bCr77iWVMFQobmL4hBCCls6+JHs71MVzMERLoYLd6R6
         YePDAUMeNzZPYO9VcX8/kfpn4E1QZ3x2PIG8J0ldHv95YHKm1Jy/9sNtoU0bCbWI92h0
         hjDtDhNR8ojEur8k3Fjb60TQeS4qd9ZgtdqhqgQBT3pxsF6IyMfUqFv9rnlZZ8vM3MXC
         21tKHqqPgzL9cK1WPHJ37fvREqEZgDLin3B+dn+EO9ok8UoGXwR4gJ4SaY17TG84GnBH
         poKoEJUYD3U2sSp1OxEJJIu53sdX2Y8Gn9IXc4pHKucX+B8yYyH1wLNe4fzBFkBMi7GU
         5hOQ==
X-Gm-Message-State: AO0yUKV0hY+gY7kfNrjs+kSH+YoD9HYYopepZLsGgCw2YI9+Gav+RQot
        6hLhyvACe+lI9rX1SM9aCdf0LC/J/PqaQToEhAS6qBzO5ZVBY8E5+b04NsJC/ox9KbAJ74+aePA
        aakF/RkXv/ztpOv7y4fkG5Q==
X-Received: by 2002:a05:600c:1da5:b0:3e2:1dac:b071 with SMTP id p37-20020a05600c1da500b003e21dacb071mr11790412wms.13.1677179799896;
        Thu, 23 Feb 2023 11:16:39 -0800 (PST)
X-Google-Smtp-Source: AK7set9+rCcRcA2Owu9q2As55Ch182UG72EUT9DZuObj8BilvSgnJCjNXKMZATz95zng1AvEyGI2Jw==
X-Received: by 2002:a05:600c:1da5:b0:3e2:1dac:b071 with SMTP id p37-20020a05600c1da500b003e21dacb071mr11790403wms.13.1677179799635;
        Thu, 23 Feb 2023 11:16:39 -0800 (PST)
Received: from [192.168.8.104] (tmo-100-40.customers.d1-online.com. [80.187.100.40])
        by smtp.gmail.com with ESMTPSA id t4-20020adff044000000b002c5694aef92sm10903913wro.21.2023.02.23.11.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:16:38 -0800 (PST)
Message-ID: <8ddf067b-4c0e-7c4c-6820-c76e874400ba@redhat.com>
Date:   Thu, 23 Feb 2023 20:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [kvm-unit-tests PATCH v1] s390x: Add tests for execute-type
 instructions
Content-Language: en-US
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20230222114742.1208584-1-nsg@linux.ibm.com>
 <167713875438.6442.2406479682969262260@t14-nrb.local>
 <e8d21eb5afde7fd9114e225692222fa8902c4e7a.camel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <e8d21eb5afde7fd9114e225692222fa8902c4e7a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23/02/2023 10.50, Nina Schoetterl-Glausch wrote:
> On Thu, 2023-02-23 at 08:52 +0100, Nico Boehr wrote:
>> Quoting Nina Schoetterl-Glausch (2023-02-22 12:47:42)
>>> Test the instruction address used by targets of an execute instruction.
>>> When the target instruction calculates a relative address, the result is
>>> relative to the target instruction, not the execute instruction.
>>>
>>> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> [...]
>>> diff --git a/s390x/Makefile b/s390x/Makefile
>>> index 97a61611..6cf8018b 100644
>>> --- a/s390x/Makefile
>>> +++ b/s390x/Makefile
>>> @@ -39,6 +39,7 @@ tests += $(TEST_DIR)/panic-loop-extint.elf
>>>   tests += $(TEST_DIR)/panic-loop-pgm.elf
>>>   tests += $(TEST_DIR)/migration-sck.elf
>>>   tests += $(TEST_DIR)/exittime.elf
>>> +tests += $(TEST_DIR)/ex.elf
>>
>> You didn't add your new test to unittests.cfg, is this intentional?
> 
> Nope, I just forgot.
> 
> @Thomas, I guess I should also add it to s390x-kvm in .gitlab-ci.yml,
> since the test passes on KVM?

Yes, please (unless your test requires the latest and greatest shiny 
upstream kernel - we don't have that on the machine available yet).

  Thomas

