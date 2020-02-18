Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbgBRMRW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 07:17:22 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IC4rSK027009
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 07:17:21 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6dq72qa3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 07:17:21 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 18 Feb 2020 12:17:19 -0000
Date: Tue, 18 Feb 2020 13:17:13 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: Cleanup removed IOSCHED_DEADLINE
References: <20200217165525.5187-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217165525.5187-1-krzk@kernel.org>
Message-Id: <20200218121713.GA3956@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:55:25PM +0100, Krzysztof Kozlowski wrote:
> CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
> remove legacy IO schedulers").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks! I'll leave it up to Stefan and Jan to decide what to do with this.

> ---
>  drivers/s390/block/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
> index a8682f69effc..1f06b19cb290 100644
> --- a/drivers/s390/block/Kconfig
> +++ b/drivers/s390/block/Kconfig
> @@ -26,7 +26,7 @@ config DASD
>  	def_tristate y
>  	prompt "Support for DASD devices"
>  	depends on CCW && BLOCK
> -	select IOSCHED_DEADLINE
> +	select MQ_IOSCHED_DEADLINE
>  	help
>  	  Enable this option if you want to access DASDs directly utilizing
>  	  S/390s channel subsystem commands. This is necessary for running
> -- 
> 2.17.1
> 
