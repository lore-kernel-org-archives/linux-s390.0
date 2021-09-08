Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42569C433EF
	for <linux-s390@archiver.kernel.org>; Wed,  8 Sep 2021 15:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4816113C
	for <linux-s390@archiver.kernel.org>; Wed,  8 Sep 2021 15:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352180AbhIHQAz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349777AbhIHQAy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Sep 2021 12:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631116786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNGQxhgl92hWe/3FtCW1Csy9gPO2VqfXKxGZzqH+8fM=;
        b=SwP5RoLM1shtTU4HSgZQsYkY2N0VGaXBZeJzY4wZMczDQBg5NRN+bOu4BzULQ1ISL4wPyZ
        q2n1lwuR7OxnGUvKqygHAhVLrYnIsFf8y9/JYhkLFqb1shETAH2mCKAd+Duq56VJzmXmNX
        kkCguYstJyPoNjxix+g4Z0b+I5yKONk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-hQLoTZZgPhGYXuAjYv9BQQ-1; Wed, 08 Sep 2021 11:59:45 -0400
X-MC-Unique: hQLoTZZgPhGYXuAjYv9BQQ-1
Received: by mail-wm1-f69.google.com with SMTP id y188-20020a1c7dc5000000b002e80e0b2f87so1278502wmc.1
        for <linux-s390@vger.kernel.org>; Wed, 08 Sep 2021 08:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nNGQxhgl92hWe/3FtCW1Csy9gPO2VqfXKxGZzqH+8fM=;
        b=lztOp7l3i0N/5yrHBhv1hLex+lDBp3NO5vhMvnaXs/gwg9Ik3FqIs0Cd5qms+ABAIx
         nLhqCtgIhahRD1+vn59oxrcm+E1v0qaLCXzwarou7vT3bL7aQLcpBzpmWmQxHKHI3oOY
         Hv4nXGE5xnTPKWzf3KboaVNJi7amHKNeySO1hGmHcUPi/k7tRVaMd6hBip3YBtCbdHSh
         CethHgOOKxzyzDhqIncoVkfIGfTWze4PdJRoH4r2pbfd6aYg3NSvApqk0DzwglpbKu54
         /fefnFOtV7t20sLA1tatj2QSs8vCEIv8Alp1cgduVVKLU/DMj0ke6+y5Y2FOmBgXnPMS
         L5rA==
X-Gm-Message-State: AOAM531FkmKbZYAQshZiv//nQMQzb0y7u3gp3YecwA9G7koDq3EEwVQy
        U9NFZH3fqN+TArguvAV1aaRTV0PXH5cH7INrHqYbfty048oJTj6i/8uFF2RXhix7N7eEc2AW6e6
        tTtEgpNdSDW40OP/8R/ncwg==
X-Received: by 2002:a5d:5241:: with SMTP id k1mr5057150wrc.14.1631116784251;
        Wed, 08 Sep 2021 08:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbV4MVn6sYe3duHRKvKFgkXf7OfAeyy0HcyFVucgkBnamnZJUt5EmSeR3LM818BjuO31ao5Q==
X-Received: by 2002:a5d:5241:: with SMTP id k1mr5057132wrc.14.1631116784080;
        Wed, 08 Sep 2021 08:59:44 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6125.dip0.t-ipconnect.de. [91.12.97.37])
        by smtp.gmail.com with ESMTPSA id g1sm2745480wrc.65.2021.09.08.08.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 08:59:43 -0700 (PDT)
Subject: Re: [PATCH v1] hugetlbfs: s390 is always 64bit
To:     linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20210908154506.20764-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3f9d1394-600b-5851-670d-71f1ab13a88a@redhat.com>
Date:   Wed, 8 Sep 2021 17:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908154506.20764-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08.09.21 17:45, David Hildenbrand wrote:
> No need to check for 64BIT. While at it, let's just select
> ARCH_SUPPORTS_HUGETLBFS from arch/s390x/Kconfig.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-mm@vger.kernel.org

^ wishful thinking, lol

Cc: linux-mm@kvack.org


-- 
Thanks,

David / dhildenb

