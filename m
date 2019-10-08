Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728866AbfJHJLP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Oct 2019 05:11:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9897Pb3031461
        for <linux-s390@vger.kernel.org>; Tue, 8 Oct 2019 05:11:10 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vgp7nb8cc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 08 Oct 2019 05:11:10 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Tue, 8 Oct 2019 10:11:08 +0100
Subject: Re: [dm-devel] [RESEND TRIVIAL 1/3] treewide: drivers: Fix Kconfig
 indentation
References: <20191004145544.5066-1-krzk@kernel.org>
From: Steffen Maier <maier@linux.ibm.com>
Date: Tue, 8 Oct 2019 11:11:03 +0200
MIME-Version: 1.0
In-Reply-To: <20191004145544.5066-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0ba5549e-6f6f-571c-47b9-018d5200c88a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Block <bblock@linux.ibm.com>

adding s390 list and zfcp maintainers

On 10/4/19 4:55 PM, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>      $ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

>   drivers/scsi/Kconfig                          | 22 ++---

>   92 files changed, 631 insertions(+), 631 deletions(-)
> 

> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 1b92f3c19ff3..23678311b51c 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -1166,8 +1166,8 @@ config SCSI_LPFC
>   	depends on NVME_FC || NVME_FC=n
>   	select CRC_T10DIF
>   	---help---
> -          This lpfc driver supports the Emulex LightPulse
> -          Family of Fibre Channel PCI host adapters.
> +	  This lpfc driver supports the Emulex LightPulse
> +	  Family of Fibre Channel PCI host adapters.
> 
>   config SCSI_LPFC_DEBUG_FS
>   	bool "Emulex LightPulse Fibre Channel debugfs Support"
> @@ -1480,14 +1480,14 @@ config ZFCP
>   	depends on S390 && QDIO && SCSI
>   	depends on SCSI_FC_ATTRS
>   	help
> -          If you want to access SCSI devices attached to your IBM eServer
> -          zSeries by means of Fibre Channel interfaces say Y.
> -          For details please refer to the documentation provided by IBM at
> -          <http://oss.software.ibm.com/developerworks/opensource/linux390>
> +	  If you want to access SCSI devices attached to your IBM eServer
> +	  zSeries by means of Fibre Channel interfaces say Y.
> +	  For details please refer to the documentation provided by IBM at
> +	  <http://oss.software.ibm.com/developerworks/opensource/linux390>
> 
> -          This driver is also available as a module. This module will be
> -          called zfcp. If you want to compile it as a module, say M here
> -          and read <file:Documentation/kbuild/modules.rst>.
> +	  This driver is also available as a module. This module will be
> +	  called zfcp. If you want to compile it as a module, say M here
> +	  and read <file:Documentation/kbuild/modules.rst>.
> 
>   config SCSI_PMCRAID
>   	tristate "PMC SIERRA Linux MaxRAID adapter support"
> @@ -1518,8 +1518,8 @@ config SCSI_VIRTIO
>   	tristate "virtio-scsi support"
>   	depends on VIRTIO
>   	help
> -          This is the virtual HBA driver for virtio.  If the kernel will
> -          be used in a virtual machine, say Y or M.
> +	  This is the virtual HBA driver for virtio.  If the kernel will
> +	  be used in a virtual machine, say Y or M.
> 
>   source "drivers/scsi/csiostor/Kconfig"
> 



-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
