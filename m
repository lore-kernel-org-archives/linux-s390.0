Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726341AbgIUMnl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 08:43:41 -0400
Subject: Re: [PATCH v5 3/3] vfio/pci: Decouple PCI_COMMAND_MEMORY bit checks
 from is_virtfn
From: Matthew Rosato <mjrosato@linux.ibm.com>
References: <1599749997-30489-1-git-send-email-mjrosato@linux.ibm.com>
 <1599749997-30489-4-git-send-email-mjrosato@linux.ibm.com>
Message-ID: <08afc6b2-7549-5440-a947-af0b598288c2@linux.ibm.com>
Date: Mon, 21 Sep 2020 08:43:29 -0400
MIME-Version: 1.0
In-Reply-To: <1599749997-30489-4-git-send-email-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, cohuck@redhat.com, kevin.tian@intel.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

On 9/10/20 10:59 AM, Matthew Rosato wrote:
> While it is true that devices with is_virtfn=1 will have a Memory Space
> Enable bit that is hard-wired to 0, this is not the only case where we
> see this behavior -- For example some bare-metal hypervisors lack
> Memory Space Enable bit emulation for devices not setting is_virtfn
> (s390). Fix this by instead checking for the newly-added
> no_command_memory bit which directly denotes the need for
> PCI_COMMAND_MEMORY emulation in vfio.
> 
> Fixes: abafbc551fdd ("vfio-pci: Invalidate mmaps and block MMIO access on disabled memory")
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

Polite ping on this patch as the other 2 have now received maintainer 
ACKs or reviews.  I'm concerned about this popping up in distros as 
abafbc551fdd was a CVE fix.  Related, see question from the cover:

- Restored the fixes tag to patch 3 (but the other 2 patches are
   now pre-reqs -- cc stable 5.8?)

Thanks,
Matt

> ---
>   drivers/vfio/pci/vfio_pci_config.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index d98843f..5076d01 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -406,7 +406,7 @@ bool __vfio_pci_memory_enabled(struct vfio_pci_device *vdev)
>   	 * PF SR-IOV capability, there's therefore no need to trigger
>   	 * faults based on the virtual value.
>   	 */
> -	return pdev->is_virtfn || (cmd & PCI_COMMAND_MEMORY);
> +	return pdev->no_command_memory || (cmd & PCI_COMMAND_MEMORY);
>   }
>   
>   /*
> @@ -520,8 +520,8 @@ static int vfio_basic_config_read(struct vfio_pci_device *vdev, int pos,
>   
>   	count = vfio_default_config_read(vdev, pos, count, perm, offset, val);
>   
> -	/* Mask in virtual memory enable for SR-IOV devices */
> -	if (offset == PCI_COMMAND && vdev->pdev->is_virtfn) {
> +	/* Mask in virtual memory enable */
> +	if (offset == PCI_COMMAND && vdev->pdev->no_command_memory) {
>   		u16 cmd = le16_to_cpu(*(__le16 *)&vdev->vconfig[PCI_COMMAND]);
>   		u32 tmp_val = le32_to_cpu(*val);
>   
> @@ -589,9 +589,11 @@ static int vfio_basic_config_write(struct vfio_pci_device *vdev, int pos,
>   		 * shows it disabled (phys_mem/io, then the device has
>   		 * undergone some kind of backdoor reset and needs to be
>   		 * restored before we allow it to enable the bars.
> -		 * SR-IOV devices will trigger this, but we catch them later
> +		 * SR-IOV devices will trigger this - for mem enable let's
> +		 * catch this now and for io enable it will be caught later
>   		 */
> -		if ((new_mem && virt_mem && !phys_mem) ||
> +		if ((new_mem && virt_mem && !phys_mem &&
> +		     !pdev->no_command_memory) ||
>   		    (new_io && virt_io && !phys_io) ||
>   		    vfio_need_bar_restore(vdev))
>   			vfio_bar_restore(vdev);
> @@ -1734,12 +1736,14 @@ int vfio_config_init(struct vfio_pci_device *vdev)
>   				 vconfig[PCI_INTERRUPT_PIN]);
>   
>   		vconfig[PCI_INTERRUPT_PIN] = 0; /* Gratuitous for good VFs */
> -
> +	}
> +	if (pdev->no_command_memory) {
>   		/*
> -		 * VFs do no implement the memory enable bit of the COMMAND
> -		 * register therefore we'll not have it set in our initial
> -		 * copy of config space after pci_enable_device().  For
> -		 * consistency with PFs, set the virtual enable bit here.
> +		 * VFs and devices that set pdev->no_command_memory do not
> +		 * implement the memory enable bit of the COMMAND register
> +		 * therefore we'll not have it set in our initial copy of
> +		 * config space after pci_enable_device().  For consistency
> +		 * with PFs, set the virtual enable bit here.
>   		 */
>   		*(__le16 *)&vconfig[PCI_COMMAND] |=
>   					cpu_to_le16(PCI_COMMAND_MEMORY);
> 
