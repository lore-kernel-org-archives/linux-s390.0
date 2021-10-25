Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ED9C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 25 Oct 2021 18:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED86160E0B
	for <linux-s390@archiver.kernel.org>; Mon, 25 Oct 2021 18:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhJYS2P (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233217AbhJYS2I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 Oct 2021 14:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635186345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmLX7TLtZ9IDJ1JQ+2m7C+nUTKDcem4HGFPTzsvzRlk=;
        b=Wv+Bn4dxhZd55LviAVyViBWcPOU0Rp9ilELfxoHmfPRFMsMTnWyr1KV+vnUb7HxdBQFDfC
        8u0icaeLpBJuKsHO4IauhD6FqbM2usvJnAy9dRHnG8kAyJQ3OJOmAhBHBf4caR9CwOQhVl
        MPkAtyhKscX5eicRiWleuN3BY3eHf84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-pXULrgXMNu2BFbQqJnWKPA-1; Mon, 25 Oct 2021 14:25:40 -0400
X-MC-Unique: pXULrgXMNu2BFbQqJnWKPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3722410B3959;
        Mon, 25 Oct 2021 18:25:37 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.18.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28C21100763D;
        Mon, 25 Oct 2021 18:25:33 +0000 (UTC)
Subject: Re: [PATCH] locking: remove spin_lock_flags() etc
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20211022120058.1031690-1-arnd@kernel.org>
 <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
 <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
 <YXZ/iLB7BvZtzDMp@hirez.programming.kicks-ass.net>
 <CAK8P3a2Luz7sd5cM1OdZhYCs_UPzo+2qVQYSZPfR2QN+0DkyRg@mail.gmail.com>
 <2413f412-a390-bbc0-e848-e2a77d1f0ab3@redhat.com>
 <CAK8P3a3JEBF-dEg0iVThMMRNK3CDxY+mRtTeStMusycnethO_g@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Message-ID: <d7af2422-3264-b9bb-b515-da4351743448@redhat.com>
Date:   Mon, 25 Oct 2021 14:25:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3JEBF-dEg0iVThMMRNK3CDxY+mRtTeStMusycnethO_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/25/21 11:44 AM, Arnd Bergmann wrote:
> On Mon, Oct 25, 2021 at 5:28 PM Waiman Long <longman@redhat.com> wrote:
>> On 10/25/21 9:06 AM, Arnd Bergmann wrote:
>>> On s390, we pick between the cmpxchg() based directed-yield when
>>> running on virtualized CPUs, and a normal qspinlock when running on a
>>> dedicated CPU.
>> I am not aware that s390 is using qspinlocks at all as I don't see
>> ARCH_USE_QUEUED_SPINLOCKS being set anywhere under arch/s390. I only see
>> that it uses a cmpxchg based spinlock.
> Sorry, I should not have said "normal" here. See arch/s390/lib/spinlock.c
> for their custom queued spinlocks as implemented in arch_spin_lock_queued().
> I don't know if that code actually does the same thing as the generic qspinlock,
> but it seems at least similar.

Yes, you are right. Their queued lock code looks like a custom version 
of the pvqspinlock code.

Cheers,
Longman

