From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 03/15] s390: zcrypt: externalize AP instructions
 available function
Date: Wed, 28 Feb 2018 18:41:55 +0100
Message-ID: <20180228184155.5b397f76.cohuck@redhat.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1519741693-17440-4-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519741693-17440-4-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 27 Feb 2018 09:28:01 -0500
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> If the AP instructions are not available on the linux host, then
> AP devices can not be interpreted by the SIE. The AP bus has a
> function it uses to determine if the AP instructions are
> available. This patch provides a new function that wraps the
> AP bus's function to externalize it for use by KVM.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/ap.h   |    7 +++++++
>  drivers/s390/crypto/ap_bus.c |    6 ++++++
>  2 files changed, 13 insertions(+), 0 deletions(-)

While I don't see anything wrong with this patch as it stands, you need
to be careful to call this only from vfio-ap code (which depends on
CONFIG_ZCRYPT).

Speaking of which: the ap_bus part cannot be a module, but only
built-in, right? So we don't get additional module complications?
