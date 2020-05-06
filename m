Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53052 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727777AbgEFMMz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 08:12:55 -0400
Received: by mail-wm1-f71.google.com with SMTP id 14so673671wmo.9
        for <linux-s390@vger.kernel.org>; Wed, 06 May 2020 05:12:52 -0700 (PDT)
Subject: Re: [GIT PULL 0/1] KVM: s390: Fix for running nested under z/VM
References: <20200506115945.13132-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <918fcace-dac6-bc33-6713-19703fc96180@redhat.com>
Date: Wed, 6 May 2020 14:12:48 +0200
MIME-Version: 1.0
In-Reply-To: <20200506115945.13132-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>

On 06/05/20 13:59, Christian Borntraeger wrote:
> Paolo,
> a fix for kvm/master.
> 
> The following changes since commit 2a173ec993baa6a97e7b0fb89240200a88d90746:
> 
>   MAINTAINERS: add a reviewer for KVM/s390 (2020-04-20 11:24:00 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.7-3
> 
> for you to fetch changes up to 5615e74f48dcc982655543e979b6c3f3f877e6f6:
> 
>   KVM: s390: Remove false WARN_ON_ONCE for the PQAP instruction (2020-05-05 11:15:05 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: Fix for running nested uner z/VM
> 
> There are circumstances when running nested under z/VM that would trigger a
> WARN_ON_ONCE. Remove the WARN_ON_ONCE. Long term we certainly want to make this
> code more robust and flexible, but just returning instead of WARNING makes
> guest bootable again.
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390: Remove false WARN_ON_ONCE for the PQAP instruction
> 
>  arch/s390/kvm/priv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Pulled, thanks.

Paolo
