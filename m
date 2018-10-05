From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 2/2] s390: vfio-ap: setup APCB mask using KVM
 dedicated function
Date: Fri, 5 Oct 2018 11:31:35 +0200
Message-ID: <20181005113135.71e5b33f.cohuck@redhat.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
        <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
        <1538728270-10340-3-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538728270-10340-3-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 Oct 2018 10:31:10 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We replace the vfio_ap_mdev_copy_masks() by the new
> kvm_arch_crypto_set_masks() to be able to use the standard
> KVM tracing system.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 33 +++------------------------------
>  1 file changed, 3 insertions(+), 30 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
