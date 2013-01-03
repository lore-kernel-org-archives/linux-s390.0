From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v5 0/7] s390: Host support for channel I/O.
Date: Thu, 3 Jan 2013 14:30:04 +0100
Message-ID: <C3B12916-61A4-479D-B542-42B067E7B24C@suse.de>
References: <1356013932-23775-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1356013932-23775-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 20.12.2012, at 15:32, Cornelia Huck wrote:

> Hi,
> 
> here's the next iteration of the host patches to support channel
> I/O against kvm/next.
> 
> Changes from v4 are on the style side; mainly using defines instead
> of magic numbers and using helper functions for decoding instructions.
> 
> Patches 1 and 2 are new (and can be applied independently of the
> channel I/O patches); some things Alex pointed out in the patches
> apply to existing code as well.
> 
> Please consider for kvm/next.

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex

> 
> Cornelia Huck (7):
>  KVM: s390: Constify intercept handler tables.
>  KVM: s390: Decoding helper functions.
>  KVM: s390: Support for I/O interrupts.
>  KVM: s390: Add support for machine checks.
>  KVM: s390: In-kernel handling of I/O instructions.
>  KVM: s390: Base infrastructure for enabling capabilities.
>  KVM: s390: Add support for channel I/O instructions.
> 
> Documentation/virtual/kvm/api.txt |  40 ++++-
> arch/s390/include/asm/kvm_host.h  |  11 ++
> arch/s390/kvm/intercept.c         |  45 +++---
> arch/s390/kvm/interrupt.c         | 252 +++++++++++++++++++++++++++++-
> arch/s390/kvm/kvm-s390.c          |  38 +++++
> arch/s390/kvm/kvm-s390.h          |  43 ++++++
> arch/s390/kvm/priv.c              | 316 ++++++++++++++++++++++++++++++++------
> arch/s390/kvm/sigp.c              |   6 +-
> arch/s390/kvm/trace-s390.h        |  26 +++-
> include/trace/events/kvm.h        |   2 +-
> include/uapi/linux/kvm.h          |  21 +++
> 11 files changed, 721 insertions(+), 79 deletions(-)
> 
> -- 
> 1.7.12.4
> 
