From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 2/4] KVM: Introduce KVM_CSS_BUS.
Date: Sun, 24 Feb 2013 11:57:25 +0200
Message-ID: <20130224095725.GF25269@redhat.com>
References: <1361534989-38884-1-git-send-email-cornelia.huck@de.ibm.com>
 <1361534989-38884-3-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1361534989-38884-3-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 22, 2013 at 01:09:47PM +0100, Cornelia Huck wrote:
> Add a new bus type for s390 css kvm io devices.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  include/linux/kvm_host.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3b768ef..59be516 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -148,6 +148,7 @@ struct kvm_io_bus {
>  enum kvm_bus {
>  	KVM_MMIO_BUS,
>  	KVM_PIO_BUS,
> +	KVM_CSS_BUS,

so maybe KVM_S390_VIRTIO_CCW_NOTIFY_BUS

to make the fact it's s390 and virtio specific, explicit?

>  	KVM_NR_BUSES
>  };
>  
> -- 
> 1.7.12.4
