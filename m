Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51907 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2O4K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 10:56:10 -0400
Subject: Re: [PATCH RFC 0/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
References: <20200417150151.17239-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4444ceef-14c7-0975-673f-6fdeefdc4dc0@redhat.com>
Date: Wed, 29 Apr 2020 16:55:55 +0200
MIME-Version: 1.0
In-Reply-To: <20200417150151.17239-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kirill Smelkov <kirr@nexedi.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 17.04.20 17:01, David Hildenbrand wrote:
> Looking into why we still create memblocks for hotplugged memory (via
> add_memory()), I discovered that we might not need ARCH_KEEP_MEMBLOCK on
> s390x after all.
> 
> After [1] we will no longer create memblocks for hotplugged memory in
> case of !CONFIG_ARCH_KEEP_MEMBLOCK. With this series, the same will apply
> to standby memory on s390x, added via add_memory().
> 
> [1] https://lkml.kernel.org/r/20200416104707.20219-1-david@redhat.com
> 
> David Hildenbrand (2):
>   s390/zcore: traverse resources instead of memblocks
>   s390/mm: don't set ARCH_KEEP_MEMBLOCK
> 
>  arch/s390/Kconfig         |  1 -
>  drivers/s390/char/zcore.c | 61 ++++++++++++++++++++++++++++++---------
>  2 files changed, 48 insertions(+), 14 deletions(-)
> 

Ping.

-- 
Thanks,

David / dhildenb
