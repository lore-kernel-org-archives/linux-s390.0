Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB3FC433F5
	for <linux-s390@archiver.kernel.org>; Thu,  2 Dec 2021 12:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhLBM2L (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Dec 2021 07:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhLBM2K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Dec 2021 07:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638447887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C83xi4fA5c9VsOduJ5B6diglBp8tOL6i14NDXgQQbrc=;
        b=jIkazDCnKzru/CMW8+Fq6mmKWE2NdgElrfrujoTn4SYbCShn6oiz0vh2Z3skl8gXVbNmao
        BaF5TiIESo4LeLd/zyiaFeAxVG0JJxQ2tHZKPwAL4BJlXVv1hBYYPB2SM2jIxl+0qntzaV
        S3Ljny86V2jvmGVOgnqwf9D/nNMlbcU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-fF7ynxpePdi8Rihz8ai1UA-1; Thu, 02 Dec 2021 07:24:46 -0500
X-MC-Unique: fF7ynxpePdi8Rihz8ai1UA-1
Received: by mail-wm1-f69.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so2425201wmb.4
        for <linux-s390@vger.kernel.org>; Thu, 02 Dec 2021 04:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=C83xi4fA5c9VsOduJ5B6diglBp8tOL6i14NDXgQQbrc=;
        b=DvDCwt4AlkJ8nIKxYkGMBOiBDf/kL23cCDbGTBJDqT1BUjhlIjunWkUNeLl8JDYpzo
         8p2sX0V8bx8YRSGeGFlgO2vg4BENt+YkOj4OZQE8m9jVynIHTQeRFBtBeUUYi+9jmRb4
         X5rKfmSVjWIzD1ZF+wqvKV9KGAvYxK+FIQSfhYzWiBLJxBgNjwsoDI/PLRvtYpiw6cYh
         rAD9fiTJJsdfxhhCDRqP7DOj2WT3ogwG5TdAp5JxGAdA1gk8GrJUOXO/w2/BmrEjkIeu
         rcQJZRbMwkftZE08+TFUBOWFsMd+xSosgijpCdbBJUDV/dXljRUtInsmgkU6CqJwfdSb
         oiag==
X-Gm-Message-State: AOAM533BRDoThgARBZYNG6+G1OrhAHjT0MqNy5yw6Uf8noF2IZ2ojn9j
        WPJVafEfKSiSPtIDkTw221sgo60gHlmhS8uU1/JJsQwzFFrzAUPfcUs6HvZhaXzusMyskaCI8MV
        BFgcUwe6sI4Xn6Bg4CMwLrg==
X-Received: by 2002:a05:6000:18ac:: with SMTP id b12mr14502085wri.355.1638447885531;
        Thu, 02 Dec 2021 04:24:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0ATnccPs1quG6qncUu/rpRiNBrxbpTwki4yRfNM7Ghe63iAYViItB1swDuehAYUx/iGg+XQ==
X-Received: by 2002:a05:6000:18ac:: with SMTP id b12mr14502057wri.355.1638447885273;
        Thu, 02 Dec 2021 04:24:45 -0800 (PST)
Received: from ?IPV6:2003:d8:2f44:9200:3344:447e:353c:bf0b? (p200300d82f4492003344447e353cbf0b.dip0.t-ipconnect.de. [2003:d8:2f44:9200:3344:447e:353c:bf0b])
        by smtp.gmail.com with ESMTPSA id i7sm1267178wro.58.2021.12.02.04.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 04:24:44 -0800 (PST)
Message-ID: <0a708f46-d1fe-9a76-c1c7-76cd0ed74776@redhat.com>
Date:   Thu, 2 Dec 2021 13:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Mitterle <smitterl@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20211202095843.41162-1-david@redhat.com>
 <20211202095843.41162-3-david@redhat.com>
 <20211202120113.2dd279a8@p-imbrenda>
 <95160439-2aa9-765f-9f06-16952e42a495@redhat.com>
 <20211202130728.72570680@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [kvm-unit-tests PATCH v1 2/2] s390x: firq: floating interrupt
 test
In-Reply-To: <20211202130728.72570680@p-imbrenda>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 02.12.21 13:07, Claudio Imbrenda wrote:
> On Thu, 2 Dec 2021 12:13:08 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>>>> +static void wait_for_sclp_int(void)
>>>> +{
>>>> +	/* Enable SCLP interrupts on this CPU only. */
>>>> +	ctl_set_bit(0, CTL0_SERVICE_SIGNAL);
>>>> +
>>>> +	set_flag(1);  
>>>
>>> why not just WRITE_ONCE/READ_ONCE?  
>>
>> Because I shamelessly copied that from s390x/smp.c ;)
>>
>>>> +	set_flag(0);
>>>> +
>>>> +	/* Start CPU #1 and let it wait for the interrupt. */
>>>> +	psw.mask = extract_psw_mask();
>>>> +	psw.addr = (unsigned long)wait_for_sclp_int;
>>>> +	ret = smp_cpu_setup(1, psw);
>>>> +	if (ret) {
>>>> +		report_skip("cpu #1 not found");  
>>>
>>> ...which means that this will hang, and so will all the other report*
>>> functions. maybe you should manually unset the flag before calling the
>>> various report* functions.  
>>
>> Good point, thanks!
>>
>>>   
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	/* Wait until the CPU #1 at least enabled SCLP interrupts. */
>>>> +	wait_for_flag();
>>>> +
>>>> +	/*
>>>> +	 * We'd have to jump trough some hoops to sense e.g., via SIGP
>>>> +	 * CONDITIONAL EMERGENCY SIGNAL if CPU #1 is already in the
>>>> +	 * wait state.
>>>> +	 *
>>>> +	 * Although not completely reliable, use SIGP SENSE RUNNING STATUS
>>>> +	 * until not reported as running -- after all, our SCLP processing
>>>> +	 * will take some time as well and make races very rare.
>>>> +	 */
>>>> +	while(smp_sense_running_status(1));
> 
> if you wait here for CPU1 to be in wait state, then why did you need to
> wait until it has set the flag earlier? can't you just wait here and not
> use the whole wait_for_flag logic? smp_cpu_setup only returns after the
> new CPU has started running.

I use the flag right now as a mechanism to make the race window as short
as possible. But you're right, we might not need the flag logic as
knowing that we processed the setup part and will jump/jumped to the
target code might be good enough.

Thanks!

-- 
Thanks,

David / dhildenb

