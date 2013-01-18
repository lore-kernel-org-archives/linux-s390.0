From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v5 00/12] s390: channel I/O support in qemu.
Date: Fri, 18 Jan 2013 17:49:48 +0100
Message-ID: <B5F2156A-48BA-4BEC-A72A-E36364A986E2@suse.de>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 17.01.2013, at 15:23, Cornelia Huck wrote:

> Hi,
> 
> here's the latest incarnation of my channel I/O and virtio-ccw
> patchset for qemu, containing various changes over the last one.

Which tree are you working against? This set doesn't apply on s390-next.


Alex

> 
> (Note that "s390: Add a hypercall registration interface." has
> already been posted: http://marc.info/?l=qemu-devel&m=135834160607372&w=2)
> 
> Changes include:
> - Add various defines for magic constants.
> - Introduce helpers for various mapping stuff and use them.
> - Adapt virtio-ccw to QOM conventions.
> - Move the new s390-ccw-virtio machine into an extra file (and an
>  extra patch).
> - Improve cpu handling during machine init (don't pass around env).
> 
> Cornelia Huck (12):
>  s390: Add a hypercall registration interface.
>  s390: Lowcore mapping helper.
>  s390: Add mapping helper functions.
>  Update linux headers.
>  s390: Channel I/O basic defintions.
>  s390: I/O interrupt and machine check injection.
>  s390: Add channel I/O instructions.
>  s390: Virtual channel subsystem support.
>  s390: Wire up channel I/O in kvm.
>  s390: Add new channel I/O based virtio transport.
>  s390-virtio: Factor out some initialization code.
>  s390: Add s390-ccw-virtio machine.
> 
> hw/s390-virtio.c                     |  240 ++++----
> hw/s390-virtio.h                     |   28 +
> hw/s390x/Makefile.objs               |    4 +
> hw/s390x/css.c                       | 1131 ++++++++++++++++++++++++++++++++++
> hw/s390x/css.h                       |   92 +++
> hw/s390x/s390-virtio-ccw.c           |  141 +++++
> hw/s390x/s390-virtio-hcall.c         |   36 ++
> hw/s390x/virtio-ccw.c                |  906 +++++++++++++++++++++++++++
> hw/s390x/virtio-ccw.h                |   79 +++
> linux-headers/asm-generic/kvm_para.h |    4 +
> linux-headers/asm-powerpc/kvm_para.h |    2 +-
> linux-headers/linux/kvm.h            |   21 +
> target-s390x/Makefile.objs           |    2 +-
> target-s390x/cpu.h                   |  257 +++++++-
> target-s390x/helper.c                |  200 +++++-
> target-s390x/ioinst.c                |  709 +++++++++++++++++++++
> target-s390x/ioinst.h                |  223 +++++++
> target-s390x/kvm.c                   |  254 +++++++-
> target-s390x/misc_helper.c           |    2 +-
> trace-events                         |   18 +
> 20 files changed, 4215 insertions(+), 134 deletions(-)
> create mode 100644 hw/s390-virtio.h
> create mode 100644 hw/s390x/css.c
> create mode 100644 hw/s390x/css.h
> create mode 100644 hw/s390x/s390-virtio-ccw.c
> create mode 100644 hw/s390x/s390-virtio-hcall.c
> create mode 100644 hw/s390x/virtio-ccw.c
> create mode 100644 hw/s390x/virtio-ccw.h
> create mode 100644 linux-headers/asm-generic/kvm_para.h
> create mode 100644 target-s390x/ioinst.c
> create mode 100644 target-s390x/ioinst.h
> 
> -- 
> 1.7.12.4
> 
