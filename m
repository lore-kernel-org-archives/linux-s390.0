Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FC9C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 25 Jan 2022 16:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392681AbiAYQrN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 Jan 2022 11:47:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232327AbiAYQpB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Jan 2022 11:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643129098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Upt5MAw/ZjqhCnJJv29d0OfiffNC7o1oJ65z/2ur0mg=;
        b=Gft+SgtCNhIoCKCzkZOwfsmhhiiiws66FatcvwN/Zj3EuPlpliXGSBLjltXT3Q8OCVZU26
        W1KeY9yxOeaOQBNAb1KPSwrO8tTrJu5Zms5hPyaN3d4iG4x887Qqp0YV+e0rdUf1XvNz1A
        +nWtM0PvKIRbkAbYdpkWjvX5qNQnZHs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-JSqJM75PODemsBAa7LJhuQ-1; Tue, 25 Jan 2022 11:44:57 -0500
X-MC-Unique: JSqJM75PODemsBAa7LJhuQ-1
Received: by mail-ed1-f69.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso14189789edb.5
        for <linux-s390@vger.kernel.org>; Tue, 25 Jan 2022 08:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Upt5MAw/ZjqhCnJJv29d0OfiffNC7o1oJ65z/2ur0mg=;
        b=3LWwjivu4jWJ1q76ubxZnIGOV4eXhFoshA98KojOTgQMfeT5dzKxugRQ+RjYk33gTK
         Lul0Le0wK2iSS8tUjJPkvgYQXaiSNsuWZbAxhAI/tKYeVJTPZePWuXPQ2UlvEpOszslt
         JHyE7LargAB1eyca2MT3ZfHhDLRZBp+F/8Ev5KTq4DLI64Eab9sXNyZlrrd9aStVckwD
         0ugVDSlN7cS6tCSWg1+V3i8kHJxbEo5aJAPy9usKTF33/nXPcxIGgD07wSSaOkgy0MMv
         u4NUiM9TTjEsn8Ad2rCZVlAywlZuZH8f6rbXxODzz3NIQkK63JUccHsLp3/jnfBMr22R
         UyRg==
X-Gm-Message-State: AOAM532R2AXS9XHfVTkgw4tBc1JMG5SOrPWsoSLggU9qQLM7qyVz+YC/
        6EQ8GZpeTcR/1TZ+5Ifiv3Gl/A7wRsSosX9soTl2G4h4UDsmdPYjAgKaYMWxe3DXDqenccBCTL0
        sAKhgzmDMejlELBUrxtfTDA==
X-Received: by 2002:a05:6402:190f:: with SMTP id e15mr9628535edz.203.1643129095973;
        Tue, 25 Jan 2022 08:44:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrr2yYn4hRfnp+Gb5D+n1nq5IgudwuBat9vtKeCLimEJ8UZF1p+nzdytUmrEYeQwm/mNAgbg==
X-Received: by 2002:a05:6402:190f:: with SMTP id e15mr9628523edz.203.1643129095806;
        Tue, 25 Jan 2022 08:44:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8000:9797:8f:1ed9:7596? (p200300cbc70f80009797008f1ed97596.dip0.t-ipconnect.de. [2003:cb:c70f:8000:9797:8f:1ed9:7596])
        by smtp.gmail.com with ESMTPSA id b30sm8583844edn.16.2022.01.25.08.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 08:44:55 -0800 (PST)
Message-ID: <3c26089c-e4f0-b2a2-39d7-df601740ba76@redhat.com>
Date:   Tue, 25 Jan 2022 17:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH qemu] s390x: sck: load into a temporary not into in1
Content-Language: en-US
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        Nico Boehr <nrb@linux.ibm.com>, qemu-devel@nongnu.org
Cc:     linux-s390@vger.kernel.org, thuth@redhat.com,
        richard.henderson@linaro.org
References: <20220125122914.567599-1-nrb@linux.ibm.com>
 <9a888391-1020-89b0-65ed-5c93f2cc8642@redhat.com>
 <c0b5e6151a330f58f6794ee4fac19e6319810613.camel@linux.ibm.com>
 <daa1cb44-e089-7aa3-b34c-52090076f840@amsat.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <daa1cb44-e089-7aa3-b34c-52090076f840@amsat.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 25.01.22 17:42, Philippe Mathieu-Daudé wrote:
> On 25/1/22 15:54, Nico Boehr wrote:
>> On Tue, 2022-01-25 at 14:13 +0100, David Hildenbrand wrote:
>>> I think you can actually just reuse in2_m2_64a, similar as we handle
>>> SCKC
>>
>> I tried my SCK tests with your patch, it works just as well and seems
>> much cleaner, thanks.
>>
>> Do you want to send this or should I make a v2 and add you as
>> Suggested-by?
> 
> v2 ;)

Yes, v2 please :)


-- 
Thanks,

David / dhildenb

