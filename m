From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/6] KVM: s390: Patches for kvm-next.
Date: Mon, 17 Jun 2013 17:14:35 +0200
Message-ID: <51BF27DB.5000202@redhat.com>
References: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 12/06/2013 13:54, Cornelia Huck ha scritto:
> Hi,
> 
> here are some patches that have accumulated in our kvm/s390 patch queue.
> 
> There's now support for large pages in the guest, and perf samples can
> be sorted between kvm host or guest. Other than that, some cleanup and
> a bugfix.
> 
> Please apply.
> 
> Christian Borntraeger (3):
>   KVM: s390: Provide function for setting the guest storage key
>   KVM: s390: guest large pages
>   KVM: s390: Use common waitqueue
> 
> Heinz Graalfs (1):
>   KVM: s390,perf: Detect if perf samples belong to KVM host or guest
> 
> Michael Mueller (1):
>   KVM: s390: code cleanup to use common vcpu slab cache
> 
> Thomas Huth (1):
>   KVM: s390: Fix epsw instruction decoding
> 
>  arch/s390/include/asm/kvm_host.h   |  8 +++-
>  arch/s390/include/asm/perf_event.h | 10 +++++
>  arch/s390/include/asm/pgalloc.h    |  3 ++
>  arch/s390/kernel/entry64.S         |  1 +
>  arch/s390/kernel/perf_event.c      | 52 ++++++++++++++++++++++
>  arch/s390/kernel/s390_ksyms.c      |  1 +
>  arch/s390/kvm/interrupt.c          | 18 ++++----
>  arch/s390/kvm/kvm-s390.c           | 15 ++++---
>  arch/s390/kvm/kvm-s390.h           |  6 +++
>  arch/s390/kvm/priv.c               | 89 ++++++++++++++++++++++++++++++++++++--
>  arch/s390/kvm/sigp.c               | 16 +++----
>  arch/s390/mm/pgtable.c             | 48 ++++++++++++++++++++
>  12 files changed, 238 insertions(+), 29 deletions(-)
> 

Applied, thanks.

Paolo
