Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728247AbgKYJbd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 04:31:33 -0500
Date: Wed, 25 Nov 2020 10:31:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: track synchronous pfault events in kvm_stat
Message-ID: <20201125103121.3d4f154a.cohuck@redhat.com>
In-Reply-To: <20201125090658.38463-1-borntraeger@de.ibm.com>
References: <20201125090658.38463-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>

On Wed, 25 Nov 2020 10:06:58 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Right now we do count pfault (pseudo page faults aka async page faults
> start and completion events). What we do not count is, if an async page
> fault would have been possible by the host, but it was disabled by the
> guest (e.g. interrupts off, pfault disabled, secure execution....).  Let
> us count those as well in the pfault_sync counter.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 1 +
>  arch/s390/kvm/kvm-s390.c         | 2 ++
>  2 files changed, 3 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
