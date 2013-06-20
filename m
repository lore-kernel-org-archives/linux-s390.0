From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/7] KVM: s390: further fixes for -next
Date: Thu, 20 Jun 2013 23:33:07 +0200
Message-ID: <51C37513.6000404@redhat.com>
References: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 20/06/2013 17:21, Cornelia Huck ha scritto:
> Hi,
> 
> some more fixes for kvm-next, bringing our handling of intercepted
> instructions more into line with what is actually architectured.
> 
> Please apply.
> 
> Thomas Huth (7):
>   KVM: s390: Renamed PGM_PRIVILEGED_OPERATION
>   KVM: s390: Privileged operation check for TPROT
>   KVM: s390: Privileged operation checks moved to instruction handlers
>   KVM: s390: Check for PSTATE when handling DIAGNOSE
>   KVM: s390: Check for access exceptions during TPI
>   KVM: s390: Reworked LCTL and LCTLG instructions
>   KVM: s390: Fixed priority of execution in STSI
> 
>  arch/s390/include/asm/kvm_host.h |   2 +-
>  arch/s390/kvm/diag.c             |   3 +
>  arch/s390/kvm/intercept.c        |  85 +-----------------
>  arch/s390/kvm/kvm-s390.h         |   3 +-
>  arch/s390/kvm/priv.c             | 184 ++++++++++++++++++++++++++++++---------
>  arch/s390/kvm/sigp.c             |   3 +-
>  6 files changed, 152 insertions(+), 128 deletions(-)
> 

Applied to next, thanks.

Paolo
