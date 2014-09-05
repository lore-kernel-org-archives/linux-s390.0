From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC][patch 4/6] KVM: s390: Add PCI pass-through support
Date: Fri, 05 Sep 2014 10:37:23 +0200
Message-ID: <54097643.30507@suse.de>
References: <20140904105223.336503578@de.ibm.com> <20140904105337.202077766@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140904105337.202077766@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: frank.blaschka@de.ibm.com, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>



On 04.09.14 12:52, frank.blaschka@de.ibm.com wrote:
> From: Frank Blaschka <frank.blaschka@de.ibm.com>
> 
> This patch implemets PCI pass-through kernel support for s390.
> Design approach is very similar to the x86 device assignment.
> User space executes the KVM_ASSIGN_PCI_DEVICE ioctl to create
> a proxy instance in the kernel KVM and connect this instance to the
> host pci device. s390 pci instructions are intercepted in kernel and
> operations are passed directly to the assigned pci device.
> To take advantage of all system z specific virtualization features
> we need to access the SIE control block residing in KVM. Also we have to
> enable z pci devices with special configuration information coming
> form the SIE block as well.
> 
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |    1 
>  arch/s390/kvm/Makefile           |    2 
>  arch/s390/kvm/intercept.c        |    1 
>  arch/s390/kvm/kvm-s390.c         |   33 
>  arch/s390/kvm/kvm-s390.h         |   17 
>  arch/s390/kvm/pci.c              | 2130 +++++++++++++++++++++++++++++++++++++++
>  arch/s390/kvm/priv.c             |   21 
>  7 files changed, 2202 insertions(+), 3 deletions(-)


I would love to review this patch, but in its current form it's
impossible to do. I can't possibly keep > 2000 lines of code in my head.


Alex
