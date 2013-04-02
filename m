From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH 00/11] KVM: s390: More patches for kvm-next.
Date: Tue, 2 Apr 2013 16:15:15 +0300
Message-ID: <20130402131515.GE3889@redhat.com>
References: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 25, 2013 at 05:22:47PM +0100, Cornelia Huck wrote:
> Hi,
> 
> here are some kvm/s390 patches that have accumulated in our queue.
> 
> Changes include fixes in the lpsw(e) and stsi handlers, proper
> handling of interrupt injection failures and a gmap optimization.
> 
> Also included are patches allowing support for standby memory on
> kvm guests. Standby memory is used for providing hotpluggable
> memory on s390.
> 
> Please consider applying.
> 
Applied, thanks.

> Christian Borntraeger (1):
>   KVM: s390: Dont do a gmap update on minor memslot changes
> 
> Heiko Carstens (7):
>   KVM: s390: fix 24 bit psw handling in lpsw/lpswe handler
>   KVM: s390: fix psw conversion in lpsw handler
>   KVM: s390: fix return code handling in lpsw/lpswe handlers
>   KVM: s390: make if statements in lpsw/lpswe handlers readable
>   KVM: s390: fix and enforce return code handling for irq injections
>   KVM: s390: fix stsi exception handling
>   KVM: s390: fix compile with !CONFIG_COMPAT
> 
> Nick Wang (3):
>   KVM: s390: Change the virtual memory mapping location for virtio
>     devices
>   KVM: s390: Remove the sanity checks for kvm memory slot
>   KVM: s390: Enable KVM_CAP_NR_MEMSLOTS on s390
> 
>  arch/s390/kvm/intercept.c     |  12 +--
>  arch/s390/kvm/kvm-s390.c      |  32 ++++---
>  arch/s390/kvm/kvm-s390.h      |  12 +--
>  arch/s390/kvm/priv.c          | 203 +++++++++++++++---------------------------
>  drivers/s390/kvm/kvm_virtio.c |  11 +--
>  5 files changed, 108 insertions(+), 162 deletions(-)
> 
> -- 
> 1.7.12.4

--
			Gleb.
