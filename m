Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727207AbgKRRFY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 12:05:24 -0500
Received: by mail-ed1-f70.google.com with SMTP id x15so1061237edr.10
        for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2020 09:05:20 -0800 (PST)
Subject: Re: [GIT PULL 0/2] KVM: s390: Fix for destroy page ultravisor call
References: <20201118170116.8239-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e6ed560-9e75-e596-174b-8f10a078c761@redhat.com>
Date: Wed, 18 Nov 2020 18:05:16 +0100
MIME-Version: 1.0
In-Reply-To: <20201118170116.8239-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>

On 18/11/20 18:01, Christian Borntraeger wrote:
> Paolo,
> 
> one more fix for 5.10 in addition with an update of the MAINTAINERS
> file. The uv.c file is mostly used by KVM and Heiko asked that we take
> care of this patch.
> 
> The following changes since commit 6cbf1e960fa52e4c63a6dfa4cda8736375b34ccc:
> 
>    KVM: s390: remove diag318 reset code (2020-11-11 09:31:52 +0100)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.10-2
> 
> for you to fetch changes up to 735931f9a51ab09cf795721b37696b420484625f:
> 
>    MAINTAINERS: add uv.c also to KVM/s390 (2020-11-18 13:09:21 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: Fix for destroy page ultravisor call
> 
> - handle response code from older firmware
> - add uv.c to KVM: s390/s390 maintainer list
> 
> ----------------------------------------------------------------
> Christian Borntraeger (2):
>        s390/uv: handle destroy page legacy interface
>        MAINTAINERS: add uv.c also to KVM/s390
> 
>   MAINTAINERS           | 1 +
>   arch/s390/kernel/uv.c | 9 ++++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 

Pulled, thanks.

Paolo
