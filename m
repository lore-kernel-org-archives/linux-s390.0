Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6DAC433B4
	for <linux-s390@archiver.kernel.org>; Tue, 20 Apr 2021 08:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104C861027
	for <linux-s390@archiver.kernel.org>; Tue, 20 Apr 2021 08:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhDTItl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Apr 2021 04:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230395AbhDTItj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Apr 2021 04:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618908548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZA0IgpkK5lKQiQvJYvOTvC79S+chjNwgYw2X48pCbAM=;
        b=jFDGe8IPa8s/AJMAQ/kz0MmdQ/Za9N1rpSaFM73rvguBA1LRAmM/QyutYrzLB6PO6mkufp
        Eyzqxt/6hcQMymXJPvbowsOluH871KNRMN4fBQ5BBeaQ/3suHFaqO95ePtuJkbJrVfvTx2
        oIOhu5FIP+MfiuEsIiOaVke4ksa6GGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-Iub2NJ9BMuesrXC-lmgd6w-1; Tue, 20 Apr 2021 04:48:55 -0400
X-MC-Unique: Iub2NJ9BMuesrXC-lmgd6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3B6B84B9BB;
        Tue, 20 Apr 2021 08:48:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-70.ams2.redhat.com [10.36.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 465D11F04B;
        Tue, 20 Apr 2021 08:48:50 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH 1/6] s390x: uv-guest: Add invalid share
 location test
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, david@redhat.com,
        imbrenda@linux.ibm.com
References: <20210316091654.1646-1-frankja@linux.ibm.com>
 <20210316091654.1646-2-frankja@linux.ibm.com>
 <2c178a2c-d207-e4b8-f159-ecd9e18a2d28@redhat.com>
 <92c5e657-a483-eeb4-5902-651be2cd5356@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <3366db5a-d3ce-85c0-9e0d-a35144b5c6c9@redhat.com>
Date:   Tue, 20 Apr 2021 10:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <92c5e657-a483-eeb4-5902-651be2cd5356@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 19/04/2021 13.45, Janosch Frank wrote:
> On 4/19/21 1:24 PM, Thomas Huth wrote:
>> On 16/03/2021 10.16, Janosch Frank wrote:
>>> Let's also test sharing unavailable memory.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>    s390x/uv-guest.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/s390x/uv-guest.c b/s390x/uv-guest.c
>>> index 99544442..a13669ab 100644
>>> --- a/s390x/uv-guest.c
>>> +++ b/s390x/uv-guest.c
>>> @@ -15,6 +15,7 @@
>>>    #include <asm/interrupt.h>
>>>    #include <asm/facility.h>
>>>    #include <asm/uv.h>
>>> +#include <sclp.h>
>>>    
>>>    static unsigned long page;
>>>    
>>> @@ -99,6 +100,10 @@ static void test_sharing(void)
>>>    	uvcb.header.len = sizeof(uvcb);
>>>    	cc = uv_call(0, (u64)&uvcb);
>>>    	report(cc == 0 && uvcb.header.rc == UVC_RC_EXECUTED, "share");
>>> +	uvcb.paddr = get_ram_size() + PAGE_SIZE;
>>> +	cc = uv_call(0, (u64)&uvcb);
>>> +	report(cc == 1 && uvcb.header.rc == 0x101, "invalid memory");
>>
>> Would it make sense to add a #define for 0x101 ?
>>
> 
> The RCs change meaning with each UV call so we can only re-use a small
> number of constants which wouldn't gain us a lot.

Ok, fair point. A define just for one spot does not make too much sense, indeed.

  Thomas

