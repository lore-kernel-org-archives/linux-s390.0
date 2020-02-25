Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33010 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729048AbgBYMMA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Feb 2020 07:12:00 -0500
Date: Tue, 25 Feb 2020 13:11:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 15/36] KVM: s390: protvirt: Add SCLP interrupt
 handling
Message-ID: <20200225131146.686f0fe0.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-16-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-16-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 24 Feb 2020 06:40:46 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> The sclp interrupt is kind of special. The ultravisor polices that we
> do not inject an sclp interrupt with payload if no sccb is outstanding.
> On the other hand we have "asynchronous" event interrupts, e.g. for
> console input.
> We separate both variants into sclp interrupt and sclp event interrupt.
> The sclp interrupt is masked until a previous servc instruction has
> finished (sie exit 108).
> 
> [frankja@linux.ibm.com: factoring out write_sclp]
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  6 +-
>  arch/s390/kvm/intercept.c        | 27 +++++++++
>  arch/s390/kvm/interrupt.c        | 95 ++++++++++++++++++++++++++------
>  arch/s390/kvm/kvm-s390.c         |  6 ++
>  4 files changed, 115 insertions(+), 19 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
