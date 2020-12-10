Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730504AbgLJKfF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 05:35:05 -0500
Date: Thu, 10 Dec 2020 11:33:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 1/4] s390/pci: track alignment/length strictness for
 zpci_dev
Message-ID: <20201210113318.136636e2.cohuck@redhat.com>
In-Reply-To: <1607545670-1557-2-git-send-email-mjrosato@linux.ibm.com>
References: <1607545670-1557-1-git-send-email-mjrosato@linux.ibm.com>
        <1607545670-1557-2-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  9 Dec 2020 15:27:47 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Some zpci device types (e.g., ISM) follow different rules for length
> and alignment of pci instructions.  Recognize this and keep track of
> it in the zpci_dev.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h     | 3 ++-
>  arch/s390/include/asm/pci_clp.h | 4 +++-
>  arch/s390/pci/pci_clp.c         | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 2126289..f16ffba 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -133,7 +133,8 @@ struct zpci_dev {
>  	u8		has_hp_slot	: 1;
>  	u8		is_physfn	: 1;
>  	u8		util_str_avail	: 1;
> -	u8		reserved	: 4;
> +	u8		relaxed_align	: 1;
> +	u8		reserved	: 3;
>  	unsigned int	devfn;		/* DEVFN part of the RID*/
>  
>  	struct mutex lock;
> diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
> index 1f4b666..9fb7cbf 100644
> --- a/arch/s390/include/asm/pci_clp.h
> +++ b/arch/s390/include/asm/pci_clp.h
> @@ -150,7 +150,9 @@ struct clp_rsp_query_pci_grp {
>  	u16			:  4;
>  	u16 noi			: 12;	/* number of interrupts */
>  	u8 version;
> -	u8			:  6;
> +	u8			:  4;
> +	u8 relaxed_align	:  1;	/* Relax length and alignment rules */
> +	u8			:  1;
>  	u8 frame		:  1;
>  	u8 refresh		:  1;	/* TLB refresh mode */
>  	u16 reserved2;
> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
> index 153720d..630f8fc 100644
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
> @@ -103,6 +103,7 @@ static void clp_store_query_pci_fngrp(struct zpci_dev *zdev,
>  	zdev->max_msi = response->noi;
>  	zdev->fmb_update = response->mui;
>  	zdev->version = response->version;
> +	zdev->relaxed_align = response->relaxed_align;
>  
>  	switch (response->version) {
>  	case 1:

Hm, what does that 'relaxed alignment' imply? Is that something that
can apply to emulated devices as well?
