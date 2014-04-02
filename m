From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 0/5] cmma and lazy sske
Date: Wed, 2 Apr 2014 16:31:23 +0200
Message-ID: <20140402163123.6b24e85f@mschwide>
References: <1396430688-53629-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1396430688-53629-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  2 Apr 2014 11:24:43 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> shall we send out patch 1 via your tree or kvm? Should be still in for 3.15
> 
> Can you ACK patches 2-5?
> 
> 
> Dominik Dingel (5):
>   KVM: s390: make cmma usage conditionally
>   KVM: s390: Adding skey bit to mmu context
>   KVM: s390: Clear storage keys
>   KVM: s390: Allow skeys to be enabled for the current process
>   KVM: s390: Don't enable skeys by default
> 
>  arch/s390/include/asm/kvm_host.h    |  4 ++
>  arch/s390/include/asm/mmu.h         |  2 +
>  arch/s390/include/asm/mmu_context.h |  1 +
>  arch/s390/include/asm/pgalloc.h     |  3 +-
>  arch/s390/include/asm/pgtable.h     | 42 +++++++++++------
>  arch/s390/kvm/diag.c                |  6 ---
>  arch/s390/kvm/kvm-s390.c            | 61 +++++++++++++++---------
>  arch/s390/kvm/kvm-s390.h            |  6 ++-
>  arch/s390/kvm/priv.c                | 94 +++++++++++++++++++++----------------
>  arch/s390/kvm/trace.h               | 14 ++++++
>  arch/s390/mm/pgtable.c              | 61 +++++++++++++++++++-----
>  11 files changed, 199 insertions(+), 95 deletions(-)
 
This is all related to kvm and the majority of changes are for files
in the kvm directory. The changes in the mm headers only affect the
code for CONFIG_PGSTE=y. I think this should go over the kvm tree.

And "Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>" for the
patches 2-5.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
