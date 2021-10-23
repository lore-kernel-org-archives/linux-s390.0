Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4046AC433F5
	for <linux-s390@archiver.kernel.org>; Sat, 23 Oct 2021 01:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D1660EE2
	for <linux-s390@archiver.kernel.org>; Sat, 23 Oct 2021 01:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhJWBj6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 22 Oct 2021 21:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhJWBjz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 Oct 2021 21:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634953056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VMIfEUdyS7S9YycGnN8abTq0K/b0QBW0FaCGofvAkWQ=;
        b=UNXBFTHbzZlA/82GUAjSGeFRNRQpMy24hfm0ERQ+hG6wnqKf2UIFxa3NQ5DiihQZ3qdcwa
        m1pjUTDbaPdlcHKRBGzyNp4/tapwk6nXYmlZmsEf9SE0EWBFP0v5SIFN97bOAuPjdem7Df
        PaRrCEyoxsXDWx3z2IHVjrC+N2Cjl1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-dGKLLbnsONGXIqdLVyqF3w-1; Fri, 22 Oct 2021 21:37:31 -0400
X-MC-Unique: dGKLLbnsONGXIqdLVyqF3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89FC5362F8;
        Sat, 23 Oct 2021 01:37:27 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.16.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E1F817CEE;
        Sat, 23 Oct 2021 01:37:23 +0000 (UTC)
Subject: Re: [PATCH] locking: remove spin_lock_flags() etc
To:     Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
References: <20211022120058.1031690-1-arnd@kernel.org>
From:   Waiman Long <longman@redhat.com>
Message-ID: <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
Date:   Fri, 22 Oct 2021 21:37:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022120058.1031690-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/22/21 7:59 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> parisc, ia64 and powerpc32 are the only remaining architectures that
> provide custom arch_{spin,read,write}_lock_flags() functions, which are
> meant to re-enable interrupts while waiting for a spinlock.
>
> However, none of these can actually run into this codepath, because
> it is only called on architectures without CONFIG_GENERIC_LOCKBREAK,
> or when CONFIG_DEBUG_LOCK_ALLOC is set without CONFIG_LOCKDEP, and none
> of those combinations are possible on the three architectures.
>
> Going back in the git history, it appears that arch/mn10300 may have
> been able to run into this code path, but there is a good chance that
> it never worked. On the architectures that still exist, it was
> already impossible to hit back in 2008 after the introduction of
> CONFIG_GENERIC_LOCKBREAK, and possibly earlier.
>
> As this is all dead code, just remove it and the helper functions built
> around it. For arch/ia64, the inline asm could be cleaned up, but
> it seems safer to leave it untouched.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Does that mean we can also remove the GENERIC_LOCKBREAK config option 
from the Kconfig files as well?

Cheers,
Longman


