From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v5 0/3] s390: Guest support for virtio-ccw.
Date: Mon, 17 Dec 2012 16:00:20 +0100
Message-ID: <7613CB93-4C0D-4B68-B473-05DF99FE1EE9@suse.de>
References: <1355500938-35344-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1355500938-35344-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 14.12.2012, at 17:02, Cornelia Huck wrote:

> Hi,
> 
> here's the virtio-ccw guest support for kvm/next again.
> 
> The not-kvm specific patches have made their way upstream via the
> s390 tree in the meantime. Patch 2 fixes an inconsistency there.
> 
> Patch 3 lost the now unneeded schid.h include; otherwise, the patches
> are unchanged from v4.

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex

> 
> Cornelia Huck (3):
>  KVM: s390: Handle hosts not supporting s390-virtio.
>  s390/ccwdev: Include asm/schid.h.
>  KVM: s390: Add a channel I/O based virtio transport driver.
> 
> arch/s390/include/asm/ccwdev.h |   4 +-
> arch/s390/include/asm/irq.h    |   1 +
> arch/s390/kernel/irq.c         |   1 +
> drivers/s390/kvm/Makefile      |   2 +-
> drivers/s390/kvm/kvm_virtio.c  |  38 +-
> drivers/s390/kvm/virtio_ccw.c  | 853 +++++++++++++++++++++++++++++++++++++++++
> 6 files changed, 887 insertions(+), 12 deletions(-)
> create mode 100644 drivers/s390/kvm/virtio_ccw.c
> 
> -- 
> 1.7.12.4
> 
