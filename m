Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9871C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 18 Jan 2022 11:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbiARLoS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240921AbiARLoQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Jan 2022 06:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642506255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8U3jGh8wUjHRYKJpJBPp8vZAQ/5jxuWNA7E7/BWluDg=;
        b=WnEc6rPKrnXBmdh6mt26i/gnR50ucrNyfZjKWduhJOW7jSdVxeFumuWNoNCpgXOBf7sNKV
        zZT5Be1GkGQ4qPRj7AgycEoJiIsMyUf7DYA8zQMsUDi9t0cqOpui1dp4DlfT3QLTfJiWf5
        PeVW8G6c7c1zm0WR6Z6P1JY+H7QezSE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-BHtq54XKMT2SOiOJkRRJfQ-1; Tue, 18 Jan 2022 06:44:14 -0500
X-MC-Unique: BHtq54XKMT2SOiOJkRRJfQ-1
Received: by mail-wm1-f70.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso1884640wmb.9
        for <linux-s390@vger.kernel.org>; Tue, 18 Jan 2022 03:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8U3jGh8wUjHRYKJpJBPp8vZAQ/5jxuWNA7E7/BWluDg=;
        b=oQSOihKJVKjhzxAaNbhUNVvXPOsN0EIqxnmJelf3MVPx799meZyTY/j2u4SCpJDiQC
         FHFae+3iBuYPvLCFUehgg/GYlNhVoS1BCbJtqZAKiryVwHy7Eu4z6OgCu9sfzXmLGxwP
         d2bx+Q/e3Hg/maP5Ha0DXHVN0ulZudqk8uK2QgDnPcSsa+cWzNYYZlhJFaWVZ2dChO8a
         ZW9Dy5OiUQbu/xtZJnfhJtndYZOie39B6rTaxn4YP4nn0Jc/hiTAv5peccObrqI9sA1i
         Hx1aaikLpCyC9sFPfY2E4aaI3+dHf6olRCwa8aPy7mRglooDPXQKeKTZSMcQuj6qxkQ5
         jF6g==
X-Gm-Message-State: AOAM533ULyHS5HZyjgg0Bde+0YBlS6erRg1lte0oly7VjnUMj5nO0ka6
        SYpB3E8AUGfBAjNxd5mIf7nAv55LCgO1OcJxyihyRBsvcQWsWXqpQl37zgh29Vr2TFUFt0gwlvY
        7frWqpyI4m3YuC2WhizAVeA==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr31261625wmz.61.1642506252863;
        Tue, 18 Jan 2022 03:44:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyD4snZ3GPjXyCXaZbanPrNUOhbLbnXgN4NvXzdfnk1YTr19HNCsUmm/J3AjYWPohJ93Xh+QA==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr31261606wmz.61.1642506252638;
        Tue, 18 Jan 2022 03:44:12 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id m20sm2390928wms.4.2022.01.18.03.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 03:44:12 -0800 (PST)
Message-ID: <073cdc28-6dbb-a2d1-ee1b-f3b53d5b7c81@redhat.com>
Date:   Tue, 18 Jan 2022 12:44:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: avoid warning on s390 in mark_page_dirty
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        dwmw2@infradead.org
Cc:     butterflyhuangxx@gmail.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanjc@google.com,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <e9e5521d-21e5-8f6f-902c-17b0516b9839@redhat.com>
 <20220113122924.740496-1-borntraeger@linux.ibm.com>
 <eda019b1-8e1d-5d2b-4be4-2725e5814b23@linux.ibm.com>
 <14380a1b-669f-8f0f-139b-7c89fabd4276@redhat.com>
 <d39d9a13-e797-b7d3-6240-db3957b6ff53@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <d39d9a13-e797-b7d3-6240-db3957b6ff53@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 1/18/22 09:53, Christian Borntraeger wrote:
>>>
>>> Paolo, are you going to pick this for next for the time being?
>>>
>>
>> Yep, done now.
>>
>> Paolo
> 
> Thanks. I just realized that Davids patch meanwhile landed in Linus 
> tree. So better
> take this via master and not next.

Yeah, I understood what you meant. :)  In fact, "master" right now is 
still on 5.16 (for patches that are destined to stable, but have 
conflicts merge window changes; those are pushed to master and merged 
from there into next).  There will be another pull request this week and 
it will have this patch.

> Maybe also add
> Fixes: 2efd61a608b0 ("KVM: Warn if mark_page_dirty() is called without 
> an active vCPU")
> in case the patch is picked for stable

Ok, will do.

Paolo

