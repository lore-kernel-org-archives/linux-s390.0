Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24722 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgBYMIF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 07:08:05 -0500
Date: Tue, 25 Feb 2020 13:07:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 14/36] KVM: s390: protvirt: Implement interrupt
 injection
Message-ID: <20200225130754.06d4c02a.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-15-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-15-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Mon, 24 Feb 2020 06:40:45 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.ibm.com>
> 
> This defines the necessary data structures in the SIE control block to
> inject machine checks,external and I/O interrupts. We first define the
> the interrupt injection control, which defines the next interrupt to
> inject. Then we define the fields that contain the payload for machine
> checks,external and I/O interrupts.
> This is then used to implement interruption injection for the following
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
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  62 +++++++++++++----
>  arch/s390/kvm/interrupt.c        | 115 +++++++++++++++++++++++--------
>  2 files changed, 138 insertions(+), 39 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
