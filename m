Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237969AbhA0Mb3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Jan 2021 07:31:29 -0500
Date: Wed, 27 Jan 2021 13:30:29 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] Fix "ordering" comment typos
Message-ID: <your-ad-here.call-01611750629-ext-5157@work.hours>
References: <20210126195042.2909405-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126195042.2909405-1-helgaas@kernel.org>
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Luca Coelho <luciano.coelho@intel.com>, Kalle Valo <kvalo@codeaurora.org>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>

On Tue, Jan 26, 2021 at 01:50:42PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix comment typos in "ordering".
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/s390/include/asm/facility.h             | 2 +-
>  drivers/gpu/drm/qxl/qxl_drv.c                | 2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/file.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> Unless somebody objects, I'll just merge these typo fixes via the PCI tree.
> 
> 
> diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
> index 68c476b20b57..91b5d714d28f 100644
> --- a/arch/s390/include/asm/facility.h
> +++ b/arch/s390/include/asm/facility.h
> @@ -44,7 +44,7 @@ static inline int __test_facility(unsigned long nr, void *facilities)
>  }
>  
>  /*
> - * The test_facility function uses the bit odering where the MSB is bit 0.
> + * The test_facility function uses the bit ordering where the MSB is bit 0.
>   * That makes it easier to query facility bits with the bit number as
>   * documented in the Principles of Operation.
>   */

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
