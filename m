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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0C3C4743F
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BA86121D
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFGJ6V (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230385AbhFGJ6U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 05:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623059789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0zljjbLQLQDhPin8j5EC2entJjj77TaO87nBv0zfj0=;
        b=Jo+w/CDqv9ROrZzhlqapkyCOSKahS6Gfy4yytRrrkY+h61qbXqjSQKKnkfp6Ue6SGh9YVT
        Wi2aDsKYPReXqvMSf5t3Lhxwk5M+yiAYk4rY/bmtMtK+CycGVEhk+uHdXIBkF/Bg+/Utpr
        GQEHG2OzLehFXt500Od7bttzFASxEuc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-EhcOI-cUP826330NVgFZyg-1; Mon, 07 Jun 2021 05:56:27 -0400
X-MC-Unique: EhcOI-cUP826330NVgFZyg-1
Received: by mail-wm1-f70.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso3928332wmj.0
        for <linux-s390@vger.kernel.org>; Mon, 07 Jun 2021 02:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=O0zljjbLQLQDhPin8j5EC2entJjj77TaO87nBv0zfj0=;
        b=UlLVgF/2hDd0MPsxRzFCc8x6IdO0hLo2r3x4q/QRXZg5CvGfaJoRuYnegJP6qlWAHA
         gNlhQvY/BmkjwoEzHzEm3n0yZM51LwVzNARwmzdNk7yHevCM0GDqAIrFeV+HONJHM8vW
         NH+OVyv84U+l/H6qMi4wNr7PoNgX1NoEwNTUFpUIJ8SuXdUEGR4tqgXRNqeXH8kQ+ZXL
         6EvCKjVCwJht9R23El8cRHP1NgvX9m71x7r6xHti6DTpSSBFOO5upq3pAXH2vrNDOKp+
         LRchZuGxxDrEZljwPicI4vO+5dz5VT1TKPOSUhDBXjLeI3F9EzwNr2gWXlyJF0t4ijFV
         eRGw==
X-Gm-Message-State: AOAM532STrHeL3EhyH3EAokwZZibJ7wpxc3jO15gLncEkAFtPYT7rlkz
        oaVtGj/QiJYzy+ygUBm4bPPltvQIND9iqdBrwKXdFEEIqWuPABIT9q813u9blao5kWoAqK8/s23
        5hfTJMc42sPBhp7Lz1enbnbYMZOCXy1coVlZ+4Kuu//SQoU0Fr+B1wDHRRQ5JDffCufRh9Q==
X-Received: by 2002:a5d:4531:: with SMTP id j17mr15894490wra.303.1623059786761;
        Mon, 07 Jun 2021 02:56:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBC/FjLRsTQq8S2oro9+Zgi/hn9d/OcbVrE1DO5FTvqz05kG7N/Ve64KekD+UGYcOzZoynrQ==
X-Received: by 2002:a5d:4531:: with SMTP id j17mr15894475wra.303.1623059786538;
        Mon, 07 Jun 2021 02:56:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6188.dip0.t-ipconnect.de. [91.12.97.136])
        by smtp.gmail.com with ESMTPSA id n2sm16397310wmb.32.2021.06.07.02.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 02:56:26 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 2/3] configure: s390x: Check if the host
 key document exists
To:     Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, linux-s390@vger.kernel.org
References: <20210318125015.45502-1-frankja@linux.ibm.com>
 <20210318125015.45502-3-frankja@linux.ibm.com>
 <6273f4da-9ce8-965a-dd57-bed917513674@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e159f6bc-0b48-b016-90d6-548a6e927b17@redhat.com>
Date:   Mon, 7 Jun 2021 11:56:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <6273f4da-9ce8-965a-dd57-bed917513674@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07.06.21 11:48, Thomas Huth wrote:
> On 18/03/2021 13.50, Janosch Frank wrote:
>> I'd rather have a readable error message than make failing the build
>> with cryptic errors.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>    configure | 5 +++++
>>    1 file changed, 5 insertions(+)
>>
>> diff --git a/configure b/configure
>> index cdcd34e9..4d4bb646 100755
>> --- a/configure
>> +++ b/configure
>> @@ -121,6 +121,11 @@ while [[ "$1" = -* ]]; do
>>        esac
>>    done
>>    
>> +if [ "$host_key_document" ] && [ ! -f "$host_key_document" ]; then
> 
> Use [ -n "$host_key_document" ] instead of just
>    [ "$host_key_document" ] ?
> 
> With that fixed:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 
>> +    echo "Host key document doesn't exist at the specified location."
>> +    exit 1
>> +fi
>> +
>>    if [ "$erratatxt" ] && [ ! -f "$erratatxt" ]; then
^should we adjust that then as well?


-- 
Thanks,

David / dhildenb

