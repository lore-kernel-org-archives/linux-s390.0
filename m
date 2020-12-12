Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438539AbgLLKBc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 12 Dec 2020 05:01:32 -0500
Received: by mail-ed1-f71.google.com with SMTP id cq17so5180105edb.17
        for <linux-s390@vger.kernel.org>; Sat, 12 Dec 2020 00:58:34 -0800 (PST)
Subject: Re: [GIT PULL 0/4] KVM: s390: features and test for 5.11
References: <20201210142600.6771-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43278089-2579-8a3d-8f13-81b8d3b75836@redhat.com>
Date: Sat, 12 Dec 2020 09:58:31 +0100
MIME-Version: 1.0
In-Reply-To: <20201210142600.6771-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Collin Walling <walling@linux.ibm.com>

On 10/12/20 15:25, Christian Borntraeger wrote:
> Paolo,
> 
> the following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:
> 
>    Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.11-1
> 
> for you to fetch changes up to 50a05be484cb70d9dfb55fa5a6ed57eab193901f:
> 
>    KVM: s390: track synchronous pfault events in kvm_stat (2020-12-10 14:20:26 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: Features and Test for 5.11
> 
> - memcg accouting for s390 specific parts of kvm and gmap
> - selftest for diag318
> - new kvm_stat for when async_pf falls back to sync
> 
> The selftest even triggers a non-critical bug that is unrelated
> to diag318, fix will follow later.
> 
> ----------------------------------------------------------------
> Christian Borntraeger (3):
>        KVM: s390: Add memcg accounting to KVM allocations
>        s390/gmap: make gmap memcg aware
>        KVM: s390: track synchronous pfault events in kvm_stat
> 
> Collin Walling (1):
>        KVM: selftests: sync_regs test for diag318
> 
>   arch/s390/include/asm/kvm_host.h                   |  1 +
>   arch/s390/kvm/guestdbg.c                           |  8 +--
>   arch/s390/kvm/intercept.c                          |  2 +-
>   arch/s390/kvm/interrupt.c                          | 10 +--
>   arch/s390/kvm/kvm-s390.c                           | 22 +++---
>   arch/s390/kvm/priv.c                               |  4 +-
>   arch/s390/kvm/pv.c                                 |  6 +-
>   arch/s390/kvm/vsie.c                               |  4 +-
>   arch/s390/mm/gmap.c                                | 30 ++++----
>   tools/testing/selftests/kvm/Makefile               |  2 +-
>   .../kvm/include/s390x/diag318_test_handler.h       | 13 ++++
>   .../selftests/kvm/lib/s390x/diag318_test_handler.c | 82 ++++++++++++++++++++++
>   tools/testing/selftests/kvm/s390x/sync_regs_test.c | 16 ++++-
>   13 files changed, 156 insertions(+), 44 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/include/s390x/diag318_test_handler.h
>   create mode 100644 tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
> 

Pulled, thanks.

Paolo
