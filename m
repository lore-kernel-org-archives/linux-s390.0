Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33453 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727926AbgFSMtK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 Jun 2020 08:49:10 -0400
Subject: Re: [PATCH RFC 1/2] s390/zcore: traverse resources instead of
 memblocks
References: <20200417150151.17239-1-david@redhat.com>
 <20200417150151.17239-2-david@redhat.com> <20200610114523.GA5943@osiris>
 <20200619144723.01fc99e8@laptop2-ibm.local>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8f37e793-dd55-0614-92b8-f33379a7fe63@redhat.com>
Date: Fri, 19 Jun 2020 14:49:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200619144723.01fc99e8@laptop2-ibm.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Philipp Rudo <prudo@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Kirill Smelkov <kirr@nexedi.com>, Alexander Egorenkov <egorenar@linux.vnet.ibm.com>

On 19.06.20 14:47, Philipp Rudo wrote:
> Hi David,
> 
> zcore/memmap is no longer needed and Alexander is preparing a patch to remove
> it. You can drop this patch.

Awesome, once that's done, can you consider patch #2? Thanks!

-- 
Thanks,

David / dhildenb
