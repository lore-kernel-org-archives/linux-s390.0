From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 2/3] s390: Virtual channel subsystem
	support.
Date: Mon, 12 Nov 2012 23:17:55 -0200
Message-ID: <20121113011755.GA27831@amt.cnet>
References: <1351700688-42353-1-git-send-email-cornelia.huck@de.ibm.com>
	<1351700688-42353-3-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <1351700688-42353-3-git-send-email-cornelia.huck@de.ibm.com>
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

Hi Cornelia,

On Wed, Oct 31, 2012 at 05:24:47PM +0100, Cornelia Huck wrote:
> Provide a mechanism for qemu to provide fully virtual subchannels to
> the guest. In the KVM case, this relies on the kernel's css support
> for I/O and machine check interrupt handling. The !KVM case handles
> interrupts on its own.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/Makefile.objs     |    1 +
>  hw/s390x/css.c             | 1209 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/css.h             |   90 ++++
>  target-s390x/Makefile.objs |    2 +-
>  target-s390x/cpu.h         |  232 +++++++++
>  target-s390x/helper.c      |  146 ++++++
>  target-s390x/ioinst.c      |  737 +++++++++++++++++++++++++++
>  target-s390x/ioinst.h      |  213 ++++++++
>  target-s390x/kvm.c         |  251 ++++++++-
>  target-s390x/misc_helper.c |    6 +-
>  10 files changed, 2872 insertions(+), 15 deletions(-)
>  create mode 100644 hw/s390x/css.c
>  create mode 100644 hw/s390x/css.h
>  create mode 100644 target-s390x/ioinst.c
>  create mode 100644 target-s390x/ioinst.h

> +void kvm_s390_enable_css_support(CPUS390XState *env)
> +{
> +    struct kvm_enable_cap cap = {};
> +    int r;
> +
> +    /* Activate host kernel channel subsystem support. */
> +    if (kvm_enabled()) {
> +        /* One CPU has to run */
> +        s390_add_running_cpu(env);

Care to explain this?

> +
> +        cap.cap = KVM_CAP_S390_CSS_SUPPORT;
> +        r = kvm_vcpu_ioctl(env, KVM_ENABLE_CAP, &cap);
> +        assert(r == 0);
> +    }
> +}
