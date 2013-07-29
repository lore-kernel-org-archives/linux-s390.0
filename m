From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/8] KVM: s390: fixes and cleanup
Date: Mon, 29 Jul 2013 09:05:36 +0200
Message-ID: <51F61440.3040704@redhat.com>
References: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 26/07/2013 15:03, Christian Borntraeger ha scritto:
> Gleb, Paolo,
> 
> here are some fixes and cleanups for KVM/s390.
> 
> The first two patches
> "KVM: s390: move kvm_guest_enter,exit closer to sie"
> and
> "KVM: s390: fix pfmf non-quiescing control handling"
> 
> should go into 3.11. Everything else looks more like 3.12.
> Please apply.
> 
> Christian
> 
> 
> Dominik Dingel (2):
>   KVM: s390: move kvm_guest_enter,exit closer to sie
>   KVM: s390: Make KVM_HVA_ERR_BAD usable on s390
> 
> Heiko Carstens (1):
>   KVM: s390: fix pfmf non-quiescing control handling
> 
> Martin Schwidefsky (2):
>   KVM: s390: allow sie enablement for multi-threaded programs
>   KVM: s390: fix task size check
> 
> Michael Mueller (1):
>   KVM: s390: declare virtual HW facilities
> 
> Thomas Huth (2):
>   KVM: s390: Fix sparse warnings in priv.c
>   KVM: s390: Add helper function for setting condition code
> 
>  arch/s390/include/asm/kvm_host.h    |   8 ++
>  arch/s390/include/asm/mmu.h         |   2 -
>  arch/s390/include/asm/mmu_context.h |  19 +---
>  arch/s390/include/asm/pgtable.h     |  11 +++
>  arch/s390/include/asm/processor.h   |   2 +
>  arch/s390/kvm/kvm-s390.c            |  44 ++++++---
>  arch/s390/kvm/kvm-s390.h            |  10 ++
>  arch/s390/kvm/priv.c                |  36 +++----
>  arch/s390/mm/pgtable.c              | 183 +++++++++++++++++++++++-------------
>  include/linux/kvm_host.h            |   8 ++
>  10 files changed, 202 insertions(+), 121 deletions(-)
> 

Applied all (1-2 to master, 3-8 to next/queue), thanks.

Paolo
