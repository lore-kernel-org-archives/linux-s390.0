Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfIIJIR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 9 Sep 2019 05:08:17 -0400
Subject: Re: [kvm-unit-tests PATCH v2 1/6] s390x: Use interrupts in SCLP and
 add locking
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b9beae7f-798f-a97e-dc1b-50ad4f6fee82@redhat.com>
Date: Mon, 9 Sep 2019 11:08:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190905103951.36522-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 05/09/2019 12.39, Janosch Frank wrote:
> We need to properly implement interrupt handling for SCLP, because on
> z/VM and LPAR SCLP calls are not synchronous!
> 
> Also with smp CPUs have to compete for sclp. Let's add some locking,
> so they execute sclp calls in an orderly fashion and don't compete for
> the data buffer.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/interrupt.h |  2 ++
>  lib/s390x/interrupt.c     | 12 +++++++--
>  lib/s390x/sclp-console.c  |  2 ++
>  lib/s390x/sclp.c          | 55 +++++++++++++++++++++++++++++++++++++--
>  lib/s390x/sclp.h          |  3 +++
>  5 files changed, 70 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
