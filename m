From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH v3 0/5] s390: Host support for channel
	I/O.
Date: Tue, 13 Nov 2012 20:25:49 -0200
Message-ID: <20121113222549.GB1803@amt.cnet>
References: <1351700678-41969-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <1351700678-41969-1-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 31, 2012 at 05:24:33PM +0100, Cornelia Huck wrote:
> Hi,
> 
> here's the latest incarnation of my host patches to support channel
> I/O on s390.
> 
> Most patches have only seen minor fixes, but patch 5 is completely
> different since the kvm <-> user space interface has been reworked.
> 
> We now handle only interrupt-related operations in kvm. This
> includes two channel I/O instructions that can dequeue pending I/O
> interrupts: tpi and tsch (not the part actually interacting with
> the subchannel). This makes the interface less complex (only one
> new exit for tsch handling) and avoids duplicating code from qemu.
> 
> Cornelia Huck (5):
>   KVM: s390: Support for I/O interrupts.
>   KVM: s390: Add support for machine checks.
>   KVM: s390: In-kernel handling of I/O instructions.
>   KVM: s390: Base infrastructure for enabling capabilities.
>   KVM: s390: Add support for channel I/O instructions.
> 
>  Documentation/virtual/kvm/api.txt |  40 +++++-
>  arch/s390/include/asm/kvm_host.h  |  11 ++
>  arch/s390/kvm/intercept.c         |  22 ++-
>  arch/s390/kvm/interrupt.c         | 264 +++++++++++++++++++++++++++++++++++-
>  arch/s390/kvm/kvm-s390.c          |  38 ++++++
>  arch/s390/kvm/kvm-s390.h          |   6 +
>  arch/s390/kvm/priv.c              | 275 +++++++++++++++++++++++++++++++++++---
>  arch/s390/kvm/trace-s390.h        |  26 +++-
>  include/linux/kvm.h               |  18 +++
>  include/trace/events/kvm.h        |   2 +-
>  10 files changed, 673 insertions(+), 29 deletions(-)
> 
> -- 
> 1.7.12.4

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
