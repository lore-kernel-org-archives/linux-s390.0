From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 3/5] s390: Add new channel I/O based virtio
	transport.
Date: Thu, 9 Aug 2012 12:34:04 +0100
Message-ID: <CAJSP0QX+tv46xjqFAhQ6XZcF6OkqSs+9EbyF2wktq-rquBBNVA@mail.gmail.com>
References: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351173-2716-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1344351173-2716-4-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 7, 2012 at 3:52 PM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> Add a new virtio transport that uses channel commands to perform
> virtio operations.
>
> Add a new machine type s390-ccw that uses this virtio-ccw transport
> and make it the default machine for s390.
>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/qdev-monitor.c      |   5 +
>  hw/s390-virtio.c       | 268 ++++++++++----
>  hw/s390x/Makefile.objs |   1 +
>  hw/s390x/virtio-ccw.c  | 962 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/virtio-ccw.h  |  77 ++++
>  vl.c                   |   1 +
>  6 files changed, 1243 insertions(+), 71 deletions(-)
>  create mode 100644 hw/s390x/virtio-ccw.c
>  create mode 100644 hw/s390x/virtio-ccw.h

Is the virtqueue still using vring and assuming the hypervisor reaches
into guest memory?

Can existing ccw device types access memory directly (for some reason
I assumed ccw always copies or send messages)?

Stefan
