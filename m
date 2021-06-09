Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EC0C48BD1
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 15:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D696128A
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 15:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhFIPVU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232540AbhFIPVP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Jun 2021 11:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623251960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EPs1wywtpCyKnad9uo0ufdiauhYEOI43/mf6957AL8M=;
        b=MV99I2xObYX/Q2SL4WjDEZ87wvhQeOnqEObCImwqgDxO55efEUXLpUhgIvimVmLWnwxVXN
        NmUzm57Ns6lQtwxnzD9t5KIkhAE2TCKGOdYg43ykLL5NipheLi8db1MzKC3udmT9b3t6zP
        NGumP1BDwUZp2aqUsZKRimfCT+SkFxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-kf6qpB-yPj-dkOTAj5ORMA-1; Wed, 09 Jun 2021 11:19:14 -0400
X-MC-Unique: kf6qpB-yPj-dkOTAj5ORMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A9F0101C8AD;
        Wed,  9 Jun 2021 15:19:12 +0000 (UTC)
Received: from localhost (ovpn-113-134.ams2.redhat.com [10.36.113.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19CFD60853;
        Wed,  9 Jun 2021 15:19:08 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v2 1/7] README.md: add guideline for
 header guards format
In-Reply-To: <4884a501-939e-a343-7cb3-a31d2f59914f@redhat.com>
Organization: Red Hat GmbH
References: <20210609143712.60933-1-cohuck@redhat.com>
 <20210609143712.60933-2-cohuck@redhat.com>
 <4884a501-939e-a343-7cb3-a31d2f59914f@redhat.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Wed, 09 Jun 2021 17:19:06 +0200
Message-ID: <87a6nz12xh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 09 2021, David Hildenbrand <david@redhat.com> wrote:

> On 09.06.21 16:37, Cornelia Huck wrote:
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   README.md | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>> 
>> diff --git a/README.md b/README.md
>> index 24d4bdaaee0d..687ff50d0af1 100644
>> --- a/README.md
>> +++ b/README.md
>> @@ -156,6 +156,15 @@ Exceptions:
>>   
>>     - While the kernel standard requires 80 columns, we allow up to 120.
>>   
>> +Header guards:
>> +
>> +Please try to adhere to adhere to the following patterns when adding
>> +"#ifndef <...> #define <...>" header guards:
>> +    ./lib:             _HEADER_H_
>> +    ./lib/<ARCH>:      _ARCH_HEADER_H_
>> +    ./lib/<ARCH>/asm:  _ASMARCH_HEADER_H_
>
> I'd have used _ARCH_ASM_HEADER_H_

I had that first, but the pattern I ended up using caused way less churn
(this is basically what arm[64] uses.)

>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

