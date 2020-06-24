Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31192 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389227AbgFXGpO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jun 2020 02:45:14 -0400
Received: by mail-wr1-f69.google.com with SMTP id o25so2032942wro.16
        for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2020 23:45:10 -0700 (PDT)
Subject: Re: [GIT PULL 0/1] KVM: s390: Fix for 5.8
References: <20200623092341.10348-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c3afcb4-5671-f8d6-2a89-8ed69cff5e1f@redhat.com>
Date: Wed, 24 Jun 2020 08:45:06 +0200
MIME-Version: 1.0
In-Reply-To: <20200623092341.10348-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

On 23/06/20 11:23, Janosch Frank wrote:
> Hi Paolo,
> 
> please pull this fix reducing the number of (currently unused) iopins
> for kvm/master.
> 
> 
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-5.8-3
> 
> for you to fetch changes up to 774911290c589e98e3638e73b24b0a4d4530e97c:
> 
>   KVM: s390: reduce number of IO pins to 1 (2020-06-18 09:48:19 +0200)
> 
> ----------------------------------------------------------------
> The current number of KVM_IRQCHIP_NUM_PINS results in an order 3
> allocation (32kb) for each guest start/restart which can result in OOM
> killer activity when kernel memory is fragmented enough.
> 
> This fix reduces the number of iopins as s390 doesn't use them, hence
> reducing the memory footprint.
> 
> ----------------------------------------------------------------
> 
> Christian Borntraeger (1):
>   KVM: s390: reduce number of IO pins to 1
> 
>  arch/s390/include/asm/kvm_host.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Pulled, thanks.  Unfortunately this missed my 5.8-rc3 pull request by a
day, but at least it's safe and sound in kvm/master.

Paolo
