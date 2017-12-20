From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 5/5] kvm_config: add CONFIG_S390_GUEST
Date: Wed, 20 Dec 2017 17:44:14 +0100
Message-ID: <20171220174414.0fd8804d.cohuck@redhat.com>
References: <20171220155300.102321-1-borntraeger@de.ibm.com>
        <20171220155300.102321-6-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171220155300.102321-6-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 20 Dec 2017 16:53:00 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> make kvmconfig currently does not select CONFIG_S390_GUEST. Since
> the virtio-ccw transport depends on CONFIG_S390_GUEST, we want
> to add CONFIG_S390_GUEST to kvmconfig.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  kernel/configs/kvm_guest.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/configs/kvm_guest.config b/kernel/configs/kvm_guest.config
> index 8d9643767142..108fecc20fc1 100644
> --- a/kernel/configs/kvm_guest.config
> +++ b/kernel/configs/kvm_guest.config
> @@ -18,6 +18,7 @@ CONFIG_VIRTUALIZATION=y
>  CONFIG_HYPERVISOR_GUEST=y
>  CONFIG_PARAVIRT=y
>  CONFIG_KVM_GUEST=y
> +CONFIG_S390_GUEST=y
>  CONFIG_VIRTIO=y
>  CONFIG_VIRTIO_PCI=y
>  CONFIG_VIRTIO_BLK=y

Acked-by: Cornelia Huck <cohuck@redhat.com>
