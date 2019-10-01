Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:39112 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfJADtd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Sep 2019 23:49:33 -0400
Subject: Re: [PATCH] zfcp: fix reaction on bit error theshold notification with adapter close
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190924160616.15301-1-maier@linux.ibm.com>
Date: Mon, 30 Sep 2019 23:49:26 -0400
In-Reply-To: <20190924160616.15301-1-maier@linux.ibm.com> (Steffen Maier's
        message of "Tue, 24 Sep 2019 18:06:16 +0200")
Message-ID: <yq1d0fhw2ex.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, stable@vger.kernel.org


Steffen,

> Kernel message explanation:
>
>  * Description:
>  * The FCP channel reported that its bit error threshold has been exceeded.
>  * These errors might result from a problem with the physical components
>  * of the local fibre link into the FCP channel.
>  * The problem might be damage or malfunction of the cable or
>  * cable connection between the FCP channel and
>  * the adjacent fabric switch port or the point-to-point peer.
>  * Find details about the errors in the HBA trace for the FCP device.
>  * The zfcp device driver closed down the FCP device
>  * to limit the performance impact from possible I/O command timeouts.
>  * User action:
>  * Check for problems on the local fibre link, ensure that fibre optics are
>  * clean and functional, and all cables are properly plugged.
>  * After the repair action, you can manually recover the FCP device by
>  * writing "0" into its "failed" sysfs attribute.
>  * If recovery through sysfs is not possible, set the CHPID of the device
>  * offline and back online on the service element.

This commentary does not read like a patch description. It makes no
mention of the actual kernel changes and the introduced module
parameter.

> +static bool ber_stop = true;
> +module_param(ber_stop, bool, 0600);
> +MODULE_PARM_DESC(ber_stop,
> +		 "Shuts down FCP devices for FCP channels that report a bit-error count in excess of its threshold (default on)");
> +

-- 
Martin K. Petersen	Oracle Linux Engineering
