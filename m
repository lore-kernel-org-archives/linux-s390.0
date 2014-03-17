From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 0/2] KVM: s390: last patches for next
Date: Mon, 17 Mar 2014 12:22:33 +0100
Message-ID: <5326DAF9.5080302@redhat.com>
References: <1395054840-52175-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395054840-52175-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 17/03/2014 12:13, Christian Borntraeger ha scritto:
> Paolo,
>
> here are two patches that are targetted against kvm/next for 3.15.
> One is a bugfix for a performance regression of the ucontrol path,
> but we can handle that via stable. No need to force that into 3.14.0
> The other patch removes some BUG_ONs in inner loops that cant be
> triggered anyway. Patches are against kvm/next
>
> Christian
>
>
> The following changes since commit 8fbb1daf3e8254afc17fc4490b69db00920197ae:
>
>   Merge branch 'kvm-ppc-fix' into HEAD (2014-03-14 16:06:30 +0100)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-20140317
>
> for you to fetch changes up to 2955c83f72801245afd0fe5c560cc75b82bea9aa:
>
>   KVM: s390: Optimize ucontrol path (2014-03-17 11:06:51 +0100)
>
> ----------------------------------------------------------------
> Two patches:
> - one regression fix for reducing the amount of ucontrol userspace exits
> - get rid of BUG_ONs in hot inner loops
>
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390: Optimize ucontrol path
>
> Dominik Dingel (1):
>       KVM: s390: Removing untriggerable BUG_ONs
>
>  arch/s390/kvm/interrupt.c | 2 --
>  arch/s390/kvm/kvm-s390.c  | 5 ++---
>  2 files changed, 2 insertions(+), 5 deletions(-)
>

Applied, thanks!

Paolo
