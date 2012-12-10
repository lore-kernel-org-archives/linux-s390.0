From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH v4 0/8] s390: channel I/O support in qemu.
Date: Mon, 10 Dec 2012 09:02:51 +0100
Message-ID: <019BF2A3-BDA8-493F-815D-246C54989501@suse.de>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, fred.konrad@greensocs.com
List-ID: <linux-s390.vger.kernel.org>


On 07.12.2012, at 13:50, Cornelia Huck wrote:

> Hi,
> 
> just a quick dump of my qemu patch series for channel I/O.
> 
> I've managed to chop the virtual css patch into some smaller
> chunks (patches 2-6), which are hopefully easier to review.
> 
> The virtio-ccw patch is still based upon the current virtio
> infrastructure; I'll try to rebase it upon the virtio refactoring
> once that has most of the infrastructure in place.

I wouldn't want to hold this feature back only for some virtio refactoring. Let's try to get it into shape for now and worry about the refactor work when that's closer to merging.


Alex

> 
> Cornelia Huck (8):
>  Update linux headers.
>  s390: Channel I/O basic defintions.
>  s390: I/O interrupt and machine check injection.
>  s390: Add channel I/O instructions.
>  s390: Virtual channel subsystem support.
>  s390: Wire up channel I/O in kvm.
>  s390-virtio: Factor out some initialization code.
>  s390: Add new channel I/O based virtio transport.
> 
> hw/s390-virtio.c                     |  281 +++++---
> hw/s390x/Makefile.objs               |    2 +
> hw/s390x/css.c                       | 1195 ++++++++++++++++++++++++++++++++++
> hw/s390x/css.h                       |   92 +++
> hw/s390x/virtio-ccw.c                |  909 ++++++++++++++++++++++++++
> hw/s390x/virtio-ccw.h                |   81 +++
> linux-headers/asm-generic/kvm_para.h |    4 +
> linux-headers/asm-powerpc/kvm.h      |   59 ++
> linux-headers/asm-powerpc/kvm_para.h |    7 +-
> linux-headers/linux/kvm.h            |   36 +-
> target-s390x/Makefile.objs           |    2 +-
> target-s390x/cpu.h                   |  230 +++++++
> target-s390x/helper.c                |  145 +++++
> target-s390x/ioinst.c                |  726 +++++++++++++++++++++
> target-s390x/ioinst.h                |  223 +++++++
> target-s390x/kvm.c                   |  246 ++++++-
> trace-events                         |   18 +
> 17 files changed, 4161 insertions(+), 95 deletions(-)
> create mode 100644 hw/s390x/css.c
> create mode 100644 hw/s390x/css.h
> create mode 100644 hw/s390x/virtio-ccw.c
> create mode 100644 hw/s390x/virtio-ccw.h
> create mode 100644 linux-headers/asm-generic/kvm_para.h
> create mode 100644 target-s390x/ioinst.c
> create mode 100644 target-s390x/ioinst.h
> 
> -- 
> 1.7.12.4
> 
