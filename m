Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406387AbfIYN5d (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 09:57:33 -0400
Subject: Re: [kvm-unit-tests PATCH 0/2] s390x: Quick fixes
References: <20190925135623.9740-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <65acf839-3dc6-4ff3-fb83-51434b86f025@redhat.com>
Date: Wed, 25 Sep 2019 15:57:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190925135623.9740-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 25.09.19 15:56, Janosch Frank wrote:
> Missing free and missing import.
> 
> Janosch Frank (2):
>   s390x: Add missing include in smp.h
>   s390x: Free allocated page in iep test
> 
>  lib/s390x/smp.h | 2 ++
>  s390x/iep.c     | 1 +
>  2 files changed, 3 insertions(+)
> 

To both

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
