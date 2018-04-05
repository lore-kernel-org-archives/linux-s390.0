From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 01/14] KVM: s390: refactor crypto initialization
Date: Thu, 5 Apr 2018 12:42:42 +0200
Message-ID: <49eaa40e-12d7-7ba9-d48f-e72c06e74c8f@de.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-2-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521051954-25715-2-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 03/14/2018 07:25 PM, Tony Krowiak wrote:
> This patch refactors the code that initializes the crypto
> configuration for a guest. The crypto configuration is contained in
> a crypto control block (CRYCB) which is a satellite control block to
> our main hardware virtualization control block. The CRYCB is
> attached to the main virtualization control block via a CRYCB
> designation (CRYCBD) designation field containing the address of
> the CRYCB as well as its format.
> 
> Prior to the introduction of AP device virtualization, there was
> no need to provide access to or specify the format of the CRYCB for
> a guest unless the MSA extension 3 (MSAX3) facility was installed
> on the host system. With the introduction of AP device virtualization,
> the CRYCB and its format must be made accessible to the guest
> regardless of the presence of the MSAX3 facility.
> 
> The crypto initialization code is restructured as follows:
> 
> * A new compilation unit is introduced to contain all interfaces
>   and data structures related to configuring a guest's CRYCB for
>   both the refactoring of crypto initialization as well as all
>   subsequent patches introducing AP virtualization support.
> 
> * Currently, the asm code for querying the AP configuration is
>   duplicated in the AP bus as well as in KVM. Since the KVM
>   code was introduced, the AP bus has externalized the interface
>   for querying the AP configuration. The KVM interface will be
>   replaced with a call to the AP bus interface. Of course, this
>   will be moved to the new compilation unit mentioned above.
> 
> * An interface to format the CRYCBD field will be provided via
>   the new compilation unit and called from the KVM vm
>   initialization.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  MAINTAINERS                      |   10 ++++++
>  arch/s390/include/asm/kvm-ap.h   |   16 ++++++++++
>  arch/s390/include/asm/kvm_host.h |    1 +
>  arch/s390/kvm/Kconfig            |    1 +
>  arch/s390/kvm/Makefile           |    2 +-
>  arch/s390/kvm/kvm-ap.c           |   48 +++++++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c         |   61 ++++---------------------------------
>  7 files changed, 84 insertions(+), 55 deletions(-)
>  create mode 100644 arch/s390/include/asm/kvm-ap.h
>  create mode 100644 arch/s390/kvm/kvm-ap.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0ec5881..72742d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11875,6 +11875,16 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
>  S:	Supported
>  F:	drivers/s390/crypto/
> 
> +S390 VFIO AP DRIVER
> +M:	Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> +M:	Christian Borntraeger <borntraeger@de.ibm.com>
> +M:	Martin Schwidefsky <schwidefsky@de.ibm.com>
> +L:	linux-s390@vger.kernel.org
> +W:	http://www.ibm.com/developerworks/linux/linux390/
> +S:	Supported
> +F:	arch/s390/include/asm/kvm/kvm-ap.h
> +F:	arch/s390/kvm/kvm-ap.c
> +
>  S390 ZFCP DRIVER
>  M:	Steffen Maier <maier@linux.vnet.ibm.com>
>  M:	Benjamin Block <bblock@linux.vnet.ibm.com>


The Maintainers update belongs into a different patch (e.g. when you introduce 
drivers/s390/crypto/vfio_ap_drv.c )
