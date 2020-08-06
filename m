Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727006AbgHFLPl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Aug 2020 07:15:41 -0400
Date: Thu, 6 Aug 2020 13:00:09 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390/Kconfig: add missing ZCRYPT dependency to VFIO_AP
Message-ID: <20200806110009.GA68234@osiris>
References: <20200805155053.3739-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805155053.3739-1-krzk@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 05:50:53PM +0200, Krzysztof Kozlowski wrote:
> The VFIO_AP uses ap_driver_register() (and deregister) functions
> implemented in ap_bus.c (compiled into ap.o).  However the ap.o will be
> built only if CONFIG_ZCRYPT is selected.
> 
> This was not visible before commit e93a1695d7fb ("iommu: Enable compile
> testing for some of drivers") because the CONFIG_VFIO_AP depends on
> CONFIG_S390_AP_IOMMU which depends on the missing CONFIG_ZCRYPT.  After
> adding COMPILE_TEST, it is possible to select a configuration with
> VFIO_AP and S390_AP_IOMMU but without the ZCRYPT.
> 
> Add proper dependency to the VFIO_AP to fix build errors:
> 
> ERROR: modpost: "ap_driver_register" [drivers/s390/crypto/vfio_ap.ko] undefined!
> ERROR: modpost: "ap_driver_unregister" [drivers/s390/crypto/vfio_ap.ko] undefined!
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: e93a1695d7fb ("iommu: Enable compile testing for some of drivers")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/s390/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
