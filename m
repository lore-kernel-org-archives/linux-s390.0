From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 0/9] KVM: s390: some patches for kvm-next
Date: Thu, 28 Nov 2013 15:31:19 +0100
Message-ID: <529753B7.6020108@redhat.com>
References: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Il 28/11/2013 15:06, Cornelia Huck ha scritto:
> Gleb, Paolo,
> 
> here's a pull request for some fixes/cleanups that have accumulated
> on our side. As this is my first pull request via kernel.org, feel
> free to tell me whether I messed up :)
> 
> 
> The following changes since commit 0a00a775d2a49d16efba721c786859844184599c:
> 
>   KVM: Change maintainer email address (2013-11-27 17:56:36 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-20131128
> 
> for you to fetch changes up to 36daca9bb36f0395755817d1b0c45ab6fbf0441b:
> 
>   KVM: s390: Removed kvm_s390_inject_sigp_stop() (2013-11-28 11:08:17 +0100)
> 
> ----------------------------------------------------------------
> Several fixes for kvm-next.
> 
> The diagnose decoding and the missing store status are more major (can
> cause the host to execute different things than the guest wanted resp.
> produce unusable dumps when something breaks). The other patches contain
> more minor fixes and cleanups.
> 
> ----------------------------------------------------------------
> Heiko Carstens (1):
>   KVM: s390: fix diagnose code extraction
> 
> Thomas Huth (8):
>   KVM: s390: Removed SIE_INTERCEPT_UCONTROL
>   KVM: s390: Removed VIRTIODESCSPACE
>   KVM: s390: Fix access to CR6 in TPI handler
>   KVM: s390: Do not set CC3 for EQBS and SQBS
>   KVM: s390: Always store status during SIGP STOP_AND_STORE_STATUS
>   KVM: s390: Fix clock comparator field for STORE STATUS
>   KVM: s390: Add SIGP store-status-at-address order
>   KVM: s390: Removed kvm_s390_inject_sigp_stop()
> 
>  arch/s390/kvm/diag.c     |    2 +-
>  arch/s390/kvm/kvm-s390.c |   53 ++++++++++++++++++++-----------------------
>  arch/s390/kvm/kvm-s390.h |   10 ++-------
>  arch/s390/kvm/priv.c     |    4 +---
>  arch/s390/kvm/sigp.c     |   56 ++++++++++++++++++++++++++++++++++++++++------
>  arch/s390/kvm/trace.h    |    1 +
>  6 files changed, 78 insertions(+), 48 deletions(-)
> 

Pulled, thanks.

Paolo
