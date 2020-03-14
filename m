Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44978 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726653AbgCODwX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 14 Mar 2020 23:52:23 -0400
Received: by mail-wr1-f72.google.com with SMTP id c6so5796176wrm.18
        for <linux-s390@vger.kernel.org>; Sat, 14 Mar 2020 04:48:04 -0700 (PDT)
Subject: Re: [PATCH 0/5] selftests: KVM: s390: Accumulated fixes and
 extensions
References: <20200310130144.9921-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d09a198-ba35-1591-6a79-57f336e2f1c5@redhat.com>
Date: Sat, 14 Mar 2020 12:48:01 +0100
MIME-Version: 1.0
In-Reply-To: <20200310130144.9921-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Andrew Jones <drjones@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 10/03/20 14:01, Christian Borntraeger wrote:
> - do more and better testing for reset
> - fix fprintf formats (thanks to Andrew Jones)
> 
> Paolo, I would schedule this for next and not for master. ok?
> 
> Christian Borntraeger (5):
>   selftests: KVM: s390: fix early guest crash
>   selftests: KVM: s390: test more register variants for the reset ioctl
>   selftests: KVM: s390: check for registers to NOT change on reset
>   selftests: KVM: s390: fixup fprintf format error in reset.c
>   selftests: KVM: s390: fix format strings for access reg test
> 
>  tools/testing/selftests/kvm/s390x/resets.c    | 132 ++++++++++++++----
>  .../selftests/kvm/s390x/sync_regs_test.c      |  11 +-
>  2 files changed, 116 insertions(+), 27 deletions(-)
> 

Queued, thanks.  I pulled the format strings fixes before -Wformat is
enabled.

Paolo
