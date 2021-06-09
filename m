Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAF4C48BD1
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 15:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5EC60FEB
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 15:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhFIPvZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236453AbhFIPvX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Jun 2021 11:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623253768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1Rsw4qjtQzXYC5CUL44PJl6CJVfU6O96i1OlLTor14=;
        b=JYu2zOcnZWtHU4mRvsubdli+L06W4s6maiCRMrF2SRWifhhtSY8PbDxYHkhqmo12mibrhZ
        kIqKCpwUKsS5cwqFjrw8p3gTL0nAjaekoH+GxDXDN5W9G3yw4os4xQdWTGZkid/Ivkqyjw
        4Cz/lYdTHl7qyrWqc/IZHxrNUZQT9Hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-IjLxG5MGPm2Bo2kpGKrE2g-1; Wed, 09 Jun 2021 11:49:25 -0400
X-MC-Unique: IjLxG5MGPm2Bo2kpGKrE2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13D7C100C609;
        Wed,  9 Jun 2021 15:49:24 +0000 (UTC)
Received: from [10.36.112.148] (ovpn-112-148.ams2.redhat.com [10.36.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F6915D6AD;
        Wed,  9 Jun 2021 15:49:18 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 2/7] lib: unify header guards
To:     Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210609143712.60933-1-cohuck@redhat.com>
 <20210609143712.60933-3-cohuck@redhat.com>
 <f20b32d0-9272-66d5-e106-a0af4340b95a@redhat.com> <877dj3122a.fsf@redhat.com>
From:   Laurent Vivier <lvivier@redhat.com>
Message-ID: <cf6d1548-0137-902a-4537-cc4d02aee887@redhat.com>
Date:   Wed, 9 Jun 2021 17:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <877dj3122a.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 09/06/2021 17:37, Cornelia Huck wrote:
> On Wed, Jun 09 2021, Laurent Vivier <lvivier@redhat.com> wrote:
> 
>> On 09/06/2021 16:37, Cornelia Huck wrote:
>>> Standardize header guards to _LIB_HEADER_H_.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  lib/alloc_page.h       | 4 ++--
>>>  lib/libcflat.h         | 4 ++--
>>>  lib/list.h             | 4 ++--
>>>  lib/pci-edu.h          | 4 ++--
>>>  lib/pci-host-generic.h | 4 ++--
>>>  lib/setjmp.h           | 4 ++--
>>>  lib/string.h           | 6 +++---
>>>  lib/vmalloc.h          | 4 ++--
>>>  8 files changed, 17 insertions(+), 17 deletions(-)
>>
>> What about lib/argv.h and lib/pci.h?
> 
> argv.h does not have a header guard yet (it probably should?)

I think if we want to standardize header guards we should add them where they are not.

But no real strong opinion on that...

Thanks,
Laurent

