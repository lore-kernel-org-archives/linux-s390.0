From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 1/4] s390/kvm: Handle hosts not supporting
	s390-virtio.
Date: Thu, 09 Aug 2012 13:03:57 +0300
Message-ID: <50238B0D.2060604@redhat.com>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351168-2568-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1344351168-2568-2-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 08/07/2012 05:52 PM, Cornelia Huck wrote:
> Running under a kvm host does not necessarily imply the presence of
> a page mapped above the main memory with the virtio information;
> however, the code includes a hard coded access to that page.
> 
> Instead, check for the presence of the page and exit gracefully
> before we hit an addressing exception if it does not exist.
> 
>  /*
>   * Init function for virtio
>   * devices are in a single page above top of "normal" mem
> @@ -443,6 +458,12 @@ static int __init kvm_devices_init(void)
>  	}
>  
>  	kvm_devices = (void *) real_memory_size;
> +	if (test_devices_support() < 0) {
> +		vmem_remove_mapping(real_memory_size, PAGE_SIZE);
> +		root_device_unregister(kvm_root);
> +		/* No error. */
> +		return 0;
> +	}
>  

Cleaner to defer root_device_register() until after the mapping has been
verified.


-- 
error compiling committee.c: too many arguments to function
