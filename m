Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57797 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727699AbgCZJ6w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Mar 2020 05:58:52 -0400
Received: by mail-wr1-f69.google.com with SMTP id o18so2780302wrx.9
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2020 02:58:48 -0700 (PDT)
Subject: Re: [GIT PULL 0/2] KVM: s390: changes for 5.7 part 2
References: <20200324125030.323689-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6977ffb-e4e5-1f3d-3db2-55742bacaa1d@redhat.com>
Date: Thu, 26 Mar 2020 10:58:46 +0100
MIME-Version: 1.0
In-Reply-To: <20200324125030.323689-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>

On 24/03/20 13:50, Christian Borntraeger wrote:
> Paolo,
> 
> two more patches for 5.7.
> 
> The following changes since commit cc674ef252f4750bdcea1560ff491081bb960954:
> 
>   KVM: s390: introduce module parameter kvm.use_gisa (2020-02-27 19:47:13 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.7-2
> 
> for you to fetch changes up to f3dd18d444c757840920434e62809b6104081b06:
> 
>   KVM: s390: mark sie block as 512 byte aligned (2020-03-23 18:30:33 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: cleanups for 5.7
> 
> - mark sie control block as 512 byte aligned
> - use fallthrough;
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390: mark sie block as 512 byte aligned
> 
> Joe Perches (1):
>       KVM: s390: Use fallthrough;
> 
>  arch/s390/include/asm/kvm_host.h |  2 +-
>  arch/s390/kvm/gaccess.c          | 23 +++++++++++++----------
>  arch/s390/kvm/interrupt.c        |  2 +-
>  arch/s390/kvm/kvm-s390.c         |  4 ++--
>  arch/s390/mm/gmap.c              |  6 +++---
>  5 files changed, 20 insertions(+), 17 deletions(-)
> 

Pulled, thanks.

Paolo
