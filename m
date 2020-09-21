Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbgIUJit (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 05:38:49 -0400
Subject: Re: [PATCH 2/4] s390/pci: track whether util_str is valid in the
 zpci_dev
References: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
 <1600529318-8996-3-git-send-email-mjrosato@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <72aa9ba3-cb88-c8ab-4cfe-dcd54e7a1426@de.ibm.com>
Date: Mon, 21 Sep 2020 11:38:41 +0200
MIME-Version: 1.0
In-Reply-To: <1600529318-8996-3-git-send-email-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>, alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org



On 19.09.20 17:28, Matthew Rosato wrote:
> We'll need to keep track of whether or not the byte string in util_str is
> valid and thus needs to be passed to a vfio-pci passthrough device.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

If this goes via the vfio tree, 

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

(please wait for an ack from Niklas Schnelle as well)
> ---
>  arch/s390/include/asm/pci.h | 3 ++-
>  arch/s390/pci/pci_clp.c     | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 882e233..32eb975 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -132,7 +132,8 @@ struct zpci_dev {
>  	u8		rid_available	: 1;
>  	u8		has_hp_slot	: 1;
>  	u8		is_physfn	: 1;
> -	u8		reserved	: 5;
> +	u8		util_avail	: 1;
> +	u8		reserved	: 4;
>  	unsigned int	devfn;		/* DEVFN part of the RID*/
>  
>  	struct mutex lock;
> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
> index 48bf316..d011134 100644
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
> @@ -168,6 +168,7 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
>  	if (response->util_str_avail) {
>  		memcpy(zdev->util_str, response->util_str,
>  		       sizeof(zdev->util_str));
> +		zdev->util_avail = 1;
>  	}
>  	zdev->mio_capable = response->mio_addr_avail;
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> 
