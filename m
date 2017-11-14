From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 0/5] guest dedicated crypto adapters: QEMU usage
Date: Tue, 14 Nov 2017 16:23:41 +0100
Message-ID: <20171114162341.4d648e59.cohuck@redhat.com>
References: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Oct 2017 11:54:49 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> I was asked to post this QEMU patch set to the mailing list to illustrate
> how the KVM/kernel counterpart will be used. The KVM/kernel patches can be
> viewed at:
> 
> https://lkml.org/lkml/2017/10/13/706
> 
> The IBM Adjunct Processor (AP) Cryptographic Facility is comprised 
> of three AP instructions and from 1 to 256 PCIe cryptographic adapter cards.
> These AP adapters provide cryptographic functions to all CPUs assigned to a
> linux system running in an IBM Z system LPAR.
> 
> This patch series introduces a new QEMU command line option and QEMU object
> model to obtain direct guest access to one or more AP adapter cards assigned
> to the LPAR in which the host linux system is running. It is predicated 
> on the KVM/kernel model for providing direct guest access to AP adapters. A 
> complete description for dedicating crypto adapters to a linux guest can be 
> found in the docs/ap-matrix.txt file provided with this patch set.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>

+cc qemu-devel@nongnu.org

The interface exposed by the kernel looks fine to me, and I did not
spot really broken things on a quick readthrough. I'd like more
feedback, though.

> 
> Tony Krowiak (5):
>   s390x/ap-matrix: Adjunct Processor (AP) matrix object model
>   s390x/vfio: ap-matrix: Introduce VFIO AP Matrix device
>   s390x/ap-matrix: Configure AP matrix for KVM guest
>   s390x/cpumodel: enable AP facilities for guest
>   s390x/docs: documentation for ap-matrix
> 
>  default-configs/s390x-softmmu.mak |    1 +
>  docs/ap_matrix.txt                |  529 +++++++++++++++++++++++++++++++++++++
>  hw/s390x/Makefile.objs            |    2 +
>  hw/s390x/ap-matrix-device.c       |   33 +++
>  hw/s390x/ap-matrix-device.h       |   53 ++++
>  hw/s390x/s390-ap-matrix.c         |   52 ++++
>  hw/vfio/Makefile.objs             |    1 +
>  hw/vfio/ap-matrix.c               |  224 ++++++++++++++++
>  include/hw/s390x/s390-ap-matrix.h |   39 +++
>  include/hw/vfio/vfio-common.h     |    1 +
>  linux-headers/linux/vfio.h        |   29 ++-
>  target/s390x/cpu_features.c       |    2 +
>  target/s390x/cpu_features_def.h   |    2 +
>  target/s390x/gen-features.c       |    4 +
>  14 files changed, 969 insertions(+), 3 deletions(-)
>  create mode 100644 docs/ap_matrix.txt
>  create mode 100644 hw/s390x/ap-matrix-device.c
>  create mode 100644 hw/s390x/ap-matrix-device.h
>  create mode 100644 hw/s390x/s390-ap-matrix.c
>  create mode 100644 hw/vfio/ap-matrix.c
>  create mode 100644 include/hw/s390x/s390-ap-matrix.h
> 
