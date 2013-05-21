From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH 0/8] s390/kvm fixes
Date: Tue, 21 May 2013 11:56:04 +0300
Message-ID: <20130521085604.GZ4725@redhat.com>
References: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Marcelo Tossati <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 17, 2013 at 02:41:30PM +0200, Christian Borntraeger wrote:
> Gleb, Paolo, Marcelo,
> 
Applied, thanks.

> here are some low level changes to kvm on s390 that we have been
> cooking for a while now.
> 
> Patch "s390/pgtable: fix ipte notify bit" will go via Martins
> tree into 3.10, but is included to reduce the amount of merge
> conflicts. 
> 
> Patch "s390: fix gmap_ipte_notifier vs. software dirty pages"
> will also go via Martins tree into 3.10 and it fixes a hang with
> heavy host paging and KVM. This is optional for merging, but
> makes testing on kvm/next easier.
> 
> This series addresses 2 problems:
> - paging of guest prefix page
> - RCU timeouts
> 
> The first problem is basically that we must not have the host pte
> invalid or r/o for the guest prefix pages. (everything else has fully
> nested paging but the prefix page must not cause host faults).
> It is not enough to pin the page, also the pte has to be r/w all the
> time. Mlocking is not enough due to memory compaction, malicious
> unmapping etc.
> We use the existing callback mechanism of the s390 page table functions
> to kick guests out of SIE and hold them until this is done. We cant 
> use the existing kick functions since we must hold a pgste lock while
> we wait for SIE to exit and IPIs might dead lock.
> 
> The second problem is that with KVM on s390 we have seen very long
> RCU stalls due to SIE not exiting on interrupts. Instead of returning
> to SIE, we now force an exit into the kvm module, which then does the
> guest exit/enter magic, fixing rcu.
> 
> The whole bunch is probably too complex for 3.10, so please queue for
> 3.11
> 
> Christian Borntraeger (5):
>   s390/pgtable: fix ipte notify bit
>   s390/kvm: Mark if a cpu is in SIE
>   s390/kvm: Provide a way to prevent reentering SIE
>   s390/kvm: Kick guests out of sie if prefix page host pte is touched
>   s390: fix gmap_ipte_notifier vs. software dirty pages
> 
> Martin Schwidefsky (3):
>   s390/kvm: fix psw rewinding in handle_skey
>   s390/kvm: rename RCP_xxx defines to PGSTE_xxx
>   s390/kvm: avoid automatic sie reentry
> 
>  arch/s390/include/asm/kvm_host.h |  8 +++-
>  arch/s390/include/asm/pgtable.h  | 83 +++++++++++++++++++---------------------
>  arch/s390/kernel/asm-offsets.c   |  3 ++
>  arch/s390/kernel/entry64.S       | 80 ++++++++++++++++++--------------------
>  arch/s390/kvm/intercept.c        | 39 +------------------
>  arch/s390/kvm/kvm-s390.c         | 81 ++++++++++++++++++++++++++++++++++++++-
>  arch/s390/kvm/kvm-s390.h         |  5 +++
>  arch/s390/kvm/priv.c             |  3 +-
>  arch/s390/mm/pgtable.c           |  5 +--
>  9 files changed, 179 insertions(+), 128 deletions(-)
> 
> -- 
> 1.8.1.4

--
			Gleb.
