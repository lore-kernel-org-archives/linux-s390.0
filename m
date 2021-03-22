Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B676AC433C1
	for <linux-s390@archiver.kernel.org>; Mon, 22 Mar 2021 11:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891E56199F
	for <linux-s390@archiver.kernel.org>; Mon, 22 Mar 2021 11:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhCVLRF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230192AbhCVLQz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Mar 2021 07:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616411814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWEFybr+IaJN8OOZQO/MBfevyb+n5hnb9KMLfpdHKIg=;
        b=Gw9/vn5TAYBsDK618a2e683Gnap4DLdyJ2odXWAJN939XXJ1rPqVai41MSbYiKnzgn0EXK
        TQh8G1OdL28yFgdJFN2tRqXib1heeY3ar29J6ykh58qq/dQJIRw5Af4E9blJa/GKdNq9Yf
        KmOXLpLZkzigbuKfxhNmX69q2ZHB3VQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-VrV3kUaENmGrlw0NErUbWA-1; Mon, 22 Mar 2021 07:16:53 -0400
X-MC-Unique: VrV3kUaENmGrlw0NErUbWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8417E108BD0A;
        Mon, 22 Mar 2021 11:16:51 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30DC619C78;
        Mon, 22 Mar 2021 11:16:48 +0000 (UTC)
Subject: Re: [PATCH v1 1/2] s390/kvm: split kvm_s390_real_to_abs
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, cohuck@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
References: <20210319193354.399587-1-imbrenda@linux.ibm.com>
 <20210319193354.399587-2-imbrenda@linux.ibm.com>
 <fa583ab0-36ac-47a7-7fa3-4ce88c518488@redhat.com>
 <f76f770c-908e-4f4f-f060-15f4d30652d8@redhat.com> <YFh7nGfVZRD15Cbp@osiris>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c394c3ce-2d13-b3d1-c886-22478fee7dcb@redhat.com>
Date:   Mon, 22 Mar 2021 12:16:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFh7nGfVZRD15Cbp@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22.03.21 12:12, Heiko Carstens wrote:
> On Mon, Mar 22, 2021 at 10:53:46AM +0100, David Hildenbrand wrote:
>>>> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
>>>> index daba10f76936..7c72a5e3449f 100644
>>>> --- a/arch/s390/kvm/gaccess.h
>>>> +++ b/arch/s390/kvm/gaccess.h
>>>> @@ -18,17 +18,14 @@
>>>>     /**
>>>>      * kvm_s390_real_to_abs - convert guest real address to guest absolute address
>>>> - * @vcpu - guest virtual cpu
>>>> + * @prefix - guest prefix
>>>>      * @gra - guest real address
>>>>      *
>>>>      * Returns the guest absolute address that corresponds to the passed guest real
>>>> - * address @gra of a virtual guest cpu by applying its prefix.
>>>> + * address @gra of by applying the given prefix.
>>>>      */
>>>> -static inline unsigned long kvm_s390_real_to_abs(struct kvm_vcpu *vcpu,
>>>> -						 unsigned long gra)
>>>> +static inline unsigned long _kvm_s390_real_to_abs(u32 prefix, unsigned long gra)
>>>
>>> <bikeshedding>
>>> Just a matter of taste, but maybe this could be named differently?
>>> kvm_s390_real2abs_prefix() ? kvm_s390_prefix_real_to_abs()?
>>> </bikeshedding>
>>
>> +1, I also dislike these "_.*" style functions here.
> 
> Yes, let's bikeshed then :)
> 
> Could you then please try to rename page_to* and everything that looks
> similar to page2* please? I'm wondering what the response will be..

Oh, we're bikeshedding about anything now? Cool.

-- 
Thanks,

David / dhildenb

