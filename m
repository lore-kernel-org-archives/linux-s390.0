Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34644 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgBJKDp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 05:03:45 -0500
Subject: Re: [PATCH 15/35] KVM: s390: protvirt: Implement interruption
 injection
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-16-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f25f7092-3410-bdcd-8b4a-994b84d37efa@redhat.com>
Date: Mon, 10 Feb 2020 11:03:34 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-16-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 07/02/2020 12.39, Christian Borntraeger wrote:
> From: Michael Mueller <mimu@linux.ibm.com>
> 
> The patch implements interruption injection for the following
> list of interruption types:
> 
>    - I/O (uses inject io interruption)
>      __deliver_io
> 
>    - External (uses inject external interruption)
>      __deliver_cpu_timer
>      __deliver_ckc
>      __deliver_emergency_signal
>      __deliver_external_call
> 
>    - cpu restart (uses inject restart interruption)
>      __deliver_restart
> 
>    - machine checks (uses mcic, failing address and external damage)
>      __write_machine_check
> 
> Please note that posted interrupts (GISA) are not used for protected
> guests as of today.
> 
> The service interrupt is handled in a followup patch.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |   6 ++
>  arch/s390/kvm/interrupt.c        | 106 +++++++++++++++++++++++--------
>  2 files changed, 86 insertions(+), 26 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
