Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2867C433ED
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 13:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A11D60C40
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 13:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhETNiQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 20 May 2021 09:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232754AbhETNiP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 May 2021 09:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621517812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jDqb0WbNRWfVzDXzZndrXkYjxKSiX/oojU5U/u7mGHY=;
        b=bwjjaISmcOczzr3Yrd7fvIyIwSuXma2eKN52IhrNBQoAwwPtt5HihxHL5HHef+VDGxr6N3
        DZ5ZCDJYYtvG2GjZlPweqr6Aqjs1qf9QVTodYbow4plD38fifQchfgWmibdvXAj0/91JhZ
        1BUuNrUto/Dwp+SCuvNn7fyMijJYmzM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-13QNV190PNiaLpkNYoOpzQ-1; Thu, 20 May 2021 09:36:50 -0400
X-MC-Unique: 13QNV190PNiaLpkNYoOpzQ-1
Received: by mail-wr1-f70.google.com with SMTP id 22-20020adf82960000b02901115ae2f734so8645817wrc.5
        for <linux-s390@vger.kernel.org>; Thu, 20 May 2021 06:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jDqb0WbNRWfVzDXzZndrXkYjxKSiX/oojU5U/u7mGHY=;
        b=pl6L9Q1wJPv2MKPJWFbClZzsteWbEddZhJM1ZzAl4LRkKRsXpvM1FEbPEYSA5iUZkQ
         S1yYtcF8+4nqQGALCSaDhB21L3SvFocj/u9o5gC3DWBiw4Hjl/mYbclXV/KgzhCpEpsZ
         9GdXCviP2560w/uz/uP7KCmrplzh7KheESwQ/rLKttVbV0G8OvkIAVLoZaX8aZW8KLoR
         HJ5fOF3JiA/Rgmzup1wLplDpUkYJIBWBzLqcKXYhfM4GhCleFRJBwHWl+VJ120a4R6Y6
         OrZjCvLgEUVOnz4eoHMsKJGzqLGgg5nHT7iCZTe4tPqYvGSJ+N+5ghKD2ppjBcA2BNNG
         rx5A==
X-Gm-Message-State: AOAM5304oI534Iso5ZK6UeJ76c3NI5QWkiUPpXN9gv8jUtJ0LXnCAtmK
        f6uVqs/BzEtV+QTTBt1cYhoy+xjZdivV/JVQvzbOykNSeVC9/EzmLzLke4gh5CaJDKHKBdZwGkx
        n+h4wGVT7WA8qEBs91nT+vA==
X-Received: by 2002:a5d:500b:: with SMTP id e11mr4383046wrt.209.1621517809072;
        Thu, 20 May 2021 06:36:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaorDOozd3/iekfxe00tdpJtoWykCK/Q6hRKJwhMQfLXUiMcAmy0IfmqDRNBhc87uSKFjmXg==
X-Received: by 2002:a5d:500b:: with SMTP id e11mr4383010wrt.209.1621517808685;
        Thu, 20 May 2021 06:36:48 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6315.dip0.t-ipconnect.de. [91.12.99.21])
        by smtp.gmail.com with ESMTPSA id y20sm9770638wmi.0.2021.05.20.06.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 06:36:48 -0700 (PDT)
Subject: Re: [kvm-unit-tests RFC 0/2] s390x: Add snippet support
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com, cohuck@redhat.com
References: <20210520094730.55759-1-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7c17d790-5a3c-d4ea-8d78-7148dbc6ca60@redhat.com>
Date:   Thu, 20 May 2021 15:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520094730.55759-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20.05.21 11:47, Janosch Frank wrote:
> The SIE support allows us to run guests and test the hypervisor's
> (V)SIE implementation. However it requires that the guest instructions
> are binary which limits the complexity of the guest code.
> 
> The snippet support provides a way to write guest code as ASM or C and
> simply memcpy it into guest memory. Some of the KVM-unit-test library
> can be re-used which further speeds up guest code development.
> 
> The included mvpg-sie test helped us to deliver the KVM mvpg fixes
> which Claudio posted a short while ago. In the future I'll post Secure
> Execution snippet support patches which was my initial goal with this
> series anyway.
> 
> I heard you liked tests so I put tests inside tests so you can test
> while you test.

The idea sounds sane to me.

-- 
Thanks,

David / dhildenb

