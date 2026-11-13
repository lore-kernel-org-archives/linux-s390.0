Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587531;
	b=1tyRWGMgy1at20iAuoNn6MUJzsX2tfrOVwK81MkgyExGwNn4ZxEZ54Np9Tpl4U4yibpT
	 TiTDEjbSLNqdEMVDwMfyigRvxrTP872jwP8WAut3LbuW4/4wzeVyEdvIqK+p344reYuMf
	 Lz6E+lU0KM1FPLLR4yVFStKg70SL+Rbq9fzuEfZhoKDiHFmRHopusjPQuZHA2tJT298nF
	 uza2Azdz44WvjqH9UmfAWbAEDnLw37xEtxdbHuG6HvIqrSZyUvSqPCH7pqXe5e6GSWDF6
	 82ucDPY8kGnvTi5i5okyxrad/A5QckdD/hvebqnA7ne5IcXcOa9WxNx2yElOgaRgQ2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587531;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iWl2lmbb+clfVwjlr+LG5LclLFqVdHG2ZMwrLdQMBbQ=;
	b=SR+lXhPRUs5JC161XwIMgQnOKQFRLJU40bLFpuLrdJrdxIZk2ubrBO4+CAIhIYGnYCjN
	 K4p/CaTCKcPaDC7trpMfDRyVHNSQmh10+D6J2ozyQkSa/TNSZrht9VpzywMETyG8M+LVb
	 pdg/OoNdWGi94HdEQulhjWw+CqdtszRzrjXtjYHX+4MxMjjMBGZMjbgGYu702RMLoXefT
	 QlVeM4BNEAbdQEHMNPwrJ/w/uL8vO9fRzHpWWWdD1q92yaNA1q165vVul7CTnkky07izJ
	 MU+EuT/+FAQj31n+S2S4vDy5AzOpEXig5R0iLxIpNAEVmqrbSDUbgfB9aUVL3z7eiKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=psqgLtq5;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6B606A327
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 16:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2B6B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=psqgLtq5
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFi6ZI3646922
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 16:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iWl2lm
	bb+clfVwjlr+LG5LclLFqVdHG2ZMwrLdQMBbQ=; b=psqgLtq5F78w2/TX+zlvHB
	mU7HgNogB570LYsorvgUqd+idO6X1lG2irWBfkmXpSSSkA1atsTbtKY80xuNhGlz
	FFXuxQ5WuG2PoELp8/572bI/IdAbvltovIzp1w5M85ihLxN0s9MWIwRfja1EwQo6
	3UIrXI8/Z4SHDc2/VSTk0ccKHdMGabIOOTiyPqoW5EKpi5O7xi9A7SKejQ8ZPgiT
	kG+6YpQy2A37mzJ10tUbBzWqQzmeEzGULcf+P73KLrb3SxKybbVuUF7iUGCxSlBP
	kK097CRXuA3HtcoGBnyFwT8ScJNy9OwqgZd30/tzm9d+Y1uHSwBlNqZ9qZWBDJYg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6mpw7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 16:32:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFYxWQ1387094
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 16:32:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hx26k90cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 16:32:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADGUZrf27066640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 16:30:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EA6A2004B;
	Fri, 13 Nov 2026 16:30:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 913D820043;
	Fri, 13 Nov 2026 16:30:34 +0000 (GMT)
Received: from [9.111.183.164] (unknown [9.111.183.164])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 16:30:34 +0000 (GMT)
Message-ID: <17fdea79-3081-42d5-ad7f-fac81cab3a91@linux.ibm.com>
Date: Fri, 13 Nov 2026 17:30:34 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH 2/4] dibs: introduce dibs peer device bus driver
To: Julian Ruess <julianr@linux.ibm.com>, schnelle@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
 <20261008-console_server-v1-2-636b11ebf191@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261008-console_server-v1-2-636b11ebf191@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oJxZTo-Dobch3DsGfiH-lgnZ_qiDkNYs
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af73b88 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ckTwqeVPeqK_PmXes5QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oJxZTo-Dobch3DsGfiH-lgnZ_qiDkNYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NSBTYWx0ZWRfXycqFW/1x63t1
 s3mkqbhY0AYKFBYW1HqmLpArHmlxHnConlp3IL/9f+BRSX/kxJ8n6lX4rZc2HsBX8Y5HabfnaIM
 lurFvRX8P2+VzuhgncYGYdNBghnAJCpYbaBGqj3SM1D3/UpoyK05XxWHa83jLCsxQw7spgXZC1F
 0z4w/SK/9OM325w6zzHNgtOdme2gkO4d80N46Q5+tYF9sSa5aGzAUYrU7/Pyt1DibwVlatpIb0M
 8KKAzrq2vlF/HKFJqKXoEcbGIjHOlLHRFbDkReOIM2VUa4pMn1uWNroNm2bGzjX4aIRoukPxXQT
 z0aVow+ueeJKc7GQN5PDTNXObKPYWxOH9NezxyJv7y0NEGqyPdBcL1KbEosHrlDxXRniIJuIc4w
 ULLwI9AwcMKyQ48yNPQ3q+Q6nNI6d08zO3EowDFuCUfdBzbTrpsuN5dIFRav7LKzixfwruhwAe/
 +aIrbR6BxjLe2nK8EPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NSBTYWx0ZWRfX2iNlDmOZJtOr
 fkA5A9rKcr9sOmxXkNp3ApisjqlUETreGFWnCBV2VaO3OB6MrC0EDbNZrcDMcVEjVLp3HteCvTk
 kO3TYv6/impgKop9Vk48dARVGcYSy0g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130065

This is not a complete review, but I think I read about 80% of the patch.
The comments were not written in any specific order.


Title:
s/dibs peer device bus/dibs peer bus/g

On 08.10.26 10:08, Julian Ruess wrote:
> Introduce a dibs peer device bus driver that represents remotely
> emulated dibs peer devices as kernel devices. 

Wording: Does the bus driver represent the devices?
In my mind, dibs peer bus driver is used to access a dibs peer bus to which
dibs peer devices are attached. (is 'dibs peer' the agreed upon wording?
a reference document would help) The dibs peer bus and dibs peer devices
are emulated on top of a remote peer's dibs device.

Is that understanding wrong? Is there no peer bus implementation on the
console server side?

I know the vfio-ism implementation is not really a dibs device, but
conceptually I think the `dibs peer`stuff is accessed via a remote dibs
device (with gid etc..)

(Refer to RFC here?)

The driver handles
> discovery and lifecycle management of remote peer devices and provides

s/remote peer devices/remote peer dibs devices/g

> the foundation for dibs peer device drivers that operate on top of dibs.

What do you mean by 'on top of dibs'?
Are they dibs clients? Is the dibs peer bus driver a dibs client?
I guess so.

I'd like some more words, what device discovery provides here:
Are Linux devices created? where? Is device probing triggered?

> 
> Two such peer device drivers, hvc_dibs and dibsblk, are added in
> follow-up patches.
> 
> Dibs peer devices are provided by vfio user space tooling (Console
> Server) and are discovered by the kernel of a target system.
> 

(target system is mentioned here for the first time without explanation)

I'd rather say: A possible implemetation of dibs bus and dibs devices is
user space tooling on top of vfio-ism.


I'D like to see a bit more about what the dibs peer bus driver provides,
e.g. /sys/bus/dibs_peer,..


> Discovery works by setting e.g. the kernel parameter
> 'dibs.dibs_peer_address=gid:64000da3-78e8-3931-0000-000000000000'. The
> UUID must be the GID used by the console server of the remote system.
> 

Imperative mode. Console server is used here without explanation.
Use same terminology as above: "gid of remote peer's dibs device'

I'd rather describe this wrt to the dibs peer bus driver "Provide 2 ways
to trigger discovery .."


> Disovery can also be triggered manually by writing the GID of the remote
> system to the discover attribute like e.g. 'echo
> gid:04000da5-78e8-3931-0000-000000000000 > /sys/bus/dibs_peer/discover'.

Wording: s/GID of the remote system/gid of the remote peer's dibs device/g

> 
> Connections can be terminated by unbinding an dibs peer device from its
> driver.
> 

What is a connection in this context?


General: I think it is Linux style to not uppercase gid, uuid etc.


General:
The basic concepts should be documented somewhere (h file,
kernel Documentation, commit message, wherever) like:
- The system can use 1 external dibs peer bus = 1 remote endpoint (?)
- The dibs peer bus is identified by the gid of the remote dibs device
it is attached to
- The dibs peer bus driver is a dibs client (but the peer device drivers
are not dibs clients)


I think you once said that the code is prepared to handle more than 1
dibs peer bus in the future, but currently only 1 is implemented.
I don't think that this is a good idea. These preparations cannot be
properly reviewed or tested. I propose to remove them and thus simplify
the code - it is complex enough already.
You can always bring it back in a future extension.





> Co-developed-by: Tobias Schumacher <ts@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> ---
>  arch/s390/configs/debug_defconfig |    1 +
>  arch/s390/configs/defconfig       |    1 +
>  drivers/dibs/Kconfig              |   11 +
>  drivers/dibs/Makefile             |    3 +-
>  drivers/dibs/dibs_main.c          |    7 +
>  drivers/dibs/dibs_peer_bus_drv.c  | 1220 +++++++++++++++++++++++++++++++++++++
>  include/linux/dibs.h              |   72 ++-
>  7 files changed, 1313 insertions(+), 2 deletions(-)
> 

Is there a way to split this up into multiple patches that are more
convenient for the reviewer?


> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index 3dae71474333..23d6c59189cc 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -133,6 +133,7 @@ CONFIG_SMC=m
>  CONFIG_SMC_DIAG=m
>  CONFIG_DIBS=y
>  CONFIG_DIBS_LO=y
> +CONFIG_DIBS_PEER_BUS_DRV=y
>  CONFIG_XDP_SOCKETS=y
>  CONFIG_XDP_SOCKETS_DIAG=m
>  CONFIG_INET=y
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index 6f5722634b4d..3bffcd016be8 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -124,6 +124,7 @@ CONFIG_SMC=m
>  CONFIG_SMC_DIAG=m
>  CONFIG_DIBS=y
>  CONFIG_DIBS_LO=y
> +CONFIG_DIBS_PEER_BUS_DRV=y
>  CONFIG_XDP_SOCKETS=y
>  CONFIG_XDP_SOCKETS_DIAG=m
>  CONFIG_INET=y
> diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
> index 8f41e5622100..98068bc541e5 100644
> --- a/drivers/dibs/Kconfig
> +++ b/drivers/dibs/Kconfig
> @@ -21,3 +21,14 @@ config DIBS_LO
>  	  occurs within the same OS. This helps in convenient testing of
>  	  dibs clients, since dibs loopback is independent of architecture or
>  	  hardware.
> +
> +config DIBS_PEER_BUS_DRV
> +	bool "dibs peer bus driver support"

without 'support' it looks better in menuconfig

> +	depends on DIBS
> +	default n
> +	help
> +	  This dibs peer bus driver allows to enumerate and use virtual dibs
> +	  peer devices emulated on a dibs remote system. This bus driver is the
> +	  foundation for dibs peer device drivers that operate on top of dibs.
> +	  It provides device discovery and lifecycle management for peer
> +	  devices across the dibs fabric.

What is a dibs remote system? What is 'on top of dibs'?

Why do you mention the dibs fabric (VCHID) here? Is that helpful for the
decision wether to select this config option?

Maybe sth like:
'The dibs peer bus driver allows to access a virtual dibs peer bus that
is emulated on top of a remote peer dibs interface. The dibs peer bus
driver allows for discovery and lifecycle management of virtual dibs
peer devices attached to the dibs peer bus.'
(is that so?)


BTW: I'd just want to point out that this is all not depending on S390.
Which I think is correct.


> diff --git a/drivers/dibs/Makefile b/drivers/dibs/Makefile
> index 85805490c77f..b1418f5149c2 100644
> --- a/drivers/dibs/Makefile
> +++ b/drivers/dibs/Makefile
> @@ -5,4 +5,5 @@
>  
>  dibs-y += dibs_main.o
>  obj-$(CONFIG_DIBS) += dibs.o
> -dibs-$(CONFIG_DIBS_LO) += dibs_loopback.o
> \ No newline at end of file
> +dibs-$(CONFIG_DIBS_LO) += dibs_loopback.o
> +dibs-$(CONFIG_DIBS_PEER_BUS_DRV) += dibs_peer_bus_drv.o
> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
> index e3a33bc42fe8..8fa05971912f 100644
> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c
> @@ -746,8 +746,14 @@ static int __init dibs_init(void)
>  	if (rc)
>  		goto err_unregister;
>  
> +	rc = dibs_pbd_init();
> +	if (rc)
> +		goto err_loopback_exit;
> +
>  	return rc;
>  
> +err_loopback_exit:
> +	dibs_loopback_exit();
>  err_unregister:
>  	class_unregister(&dibs_class);
>  err:
> @@ -757,6 +763,7 @@ static int __init dibs_init(void)
>  
>  static void __exit dibs_exit(void)
>  {
> +	dibs_pbd_exit();
>  	dibs_loopback_exit();
>  	class_unregister(&dibs_class);
>  }
> diff --git a/drivers/dibs/dibs_peer_bus_drv.c b/drivers/dibs/dibs_peer_bus_drv.c
> new file mode 100644
> index 000000000000..99eb0a6f8164
> --- /dev/null
> +++ b/drivers/dibs/dibs_peer_bus_drv.c
> @@ -0,0 +1,1220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dibs peer bus driver
> + *
> + * Copyright IBM Corp.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/dibs.h>
> +#include <linux/gfp_types.h>
> +#include <linux/kref.h>
> +#include <linux/mutex.h>
> +#include <linux/string.h>
> +#include <linux/workqueue.h>
> +#include <linux/device/bus.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/uuid.h>
> +#include <linux/utsname.h>
> +#include <asm/sysinfo.h>
> +#include <asm/ebcdic.h>
> +
> +static u8 dibs_pbd_boot_event_sent;
> +
> +static char *dibs_peer_address;
> +module_param(dibs_peer_address, charp, 0000);
> +MODULE_PARM_DESC(dibs_peer_address,
> +		 "specify the address of the remote system that emulates the peer bus");
> +
> +static unsigned int dibs_pbd_max_timeout = 60;
> +module_param(dibs_pbd_max_timeout, uint, 0644);
> +MODULE_PARM_DESC(dibs_pbd_max_timeout,
> +		 "Maximum timeout for dibs peer bus remote in seconds");
> +
> +struct dibs_pbd_dmb_state {
> +	struct dibs_peer_device *peer_dev;
> +	struct dibs_peer_dev_driver *peer_dev_driver;
> +	struct dibs_pbd_remote_endpoint *remote_endpoint;

But there is only 1 remote endpoint. Why do you store it per dmb??

Ah, is it maybe that a dmb EITHER has peer_dev and peer_dev_driver (if
it belongs to a peer_dev) OR it has a remote_endpoint (if it belongs to
the peer_bus_driver)? Would be helpful to state this in a comment.
(or find another clean way like a type field and a union or so)

> +	/*
> +	 * Protects peer_dev_driver and peer_dev pointers in dmb_state array.
> +	 * Synchronizes IRQ handler with driver bind/unbind to prevent races
> +	 * where driver callbacks are invoked on unbound or freed drivers.
> +	 */
> +	spinlock_t dmb_state_lock;
> +};
> +
> +struct dibs_pbd_event_work {
> +	struct work_struct work;
> +	struct dibs_dev *dibs;
> +	struct dibs_event event;
> +};
> +
> +struct dibs_pbd_dibs_dev_state {
> +	struct list_head list;
> +	struct dibs_dev *dibs;
> +	/* index is the dmbno of the parent dibs device */
> +	struct dibs_pbd_dmb_state dmb_state[];
> +};
> +
> +static LIST_HEAD(dibs_pbd_dibs_dev_state_list);
> +/*
> + * List is modified by add_dev/del_dev (called with dibs_dev_list.mutex)
> + * and read by event handlers and sysfs operations.
> + */
> +static DEFINE_MUTEX(dibs_pbd_dibs_dev_state_list_mutex);
> +
> +static LIST_HEAD(dibs_pbd_remote_endpoint_list);
> +/*
> + * Endpoints may be added from sysfs and recovery work items and
> + * removed asynchronously from dev_disabled work items. Readers
> + * traversing the list must hold this mutex to prevent races with
> + * concurrent list_add()/list_del() operations.
> + */
> +static DEFINE_MUTEX(dibs_pbd_remote_endpoint_list_mutex);
> +
> +struct access_token {
> +	struct list_head list;
> +	u128 access_tok;
> +};
> +
> +static LIST_HEAD(dibs_pbd_access_token_list);
> +
> +static DEFINE_MUTEX(dibs_pbd_access_token_list_mutex);
> +
> +enum { DIBS_PBD_HDR_V1 = 1 };
> +enum {
> +	DIBS_PBD_REMOTE_ENDPOINT_ACCESS_TOKEN_MSG = 1,
> +	DIBS_PBD_SYSTEM_INFO_MSG = 2,
> +	DIBS_PBD_DEV_MSG = 3,
> +	DIBS_PBD_PADDING_MSG = 0xff
> +};
> +
> +struct dibs_pbd_remote_endpoint_dev_msg {
> +	u64 dmb_tok;
> +	u8 peer_dev_type;
> +	u8 id;
> +	u128 peer_dev_tok;
> +} __packed;
> +

Some explanations would be nice. e.g. what is the peer_dev_tok? what is id?

> +struct dibs_pbd_re_sysinfo_msg {
> +	u64 dmb_tok;
> +	u8 system_name[16];
> +	u8 uuid[16];
> +	u8 hostname[128];
> +} __packed;
> +
> +struct dibs_pbd_remote_endpoint_access_tok_msg {
> +	u128 access_tok;
> +} __packed;
> +
> +struct dibs_pbd_remote_endpoint_msg {
> +	struct dibs_msg_hdr hdr;
> +	union {
> +		struct dibs_pbd_remote_endpoint_access_tok_msg atmsg;
> +		struct dibs_pbd_remote_endpoint_dev_msg devmsg;
> +		struct dibs_pbd_re_sysinfo_msg simsg;
> +	};
> +};
> +
> +#define DIBS_PBD_RING_SIZE (1024 * 1024)
> +#define DIBS_PBD_MSG_ALIGNMENT 4
> +

Should all these definitions go into a h file?


> +static u32 dibs_pbd_msg_size(struct dibs_msg_hdr *hdr)
> +{
> +	u32 size;
> +
> +	if (check_add_overflow(sizeof(*hdr), READ_ONCE(hdr->datalen), &size))
> +		return 0;
> +	return ALIGN(size, DIBS_PBD_MSG_ALIGNMENT);
> +}
> +
> +/**
> + * dibs_pbd_msg_max_payload() - Calculate maximum payload size for a message
> + * @rb: Ring buffer to check available space
> + *
> + * Calculates the maximum payload size that can be sent in a single message
> + * without having to wrap around.
> + *
> + * Return: Maximum payload size in bytes, or 0 if no space available
> + */
> +size_t dibs_pbd_msg_max_payload(struct dibs_ring_buffer *rb)
> +{
> +	size_t space = dibs_ring_space_to_end(rb);
> +
> +	if (space == 0)
> +		return 0;
> +
> +	if (space == sizeof(struct dibs_msg_hdr)) {
> +		space = dibs_ring_space(rb) - space;
> +		if (space == 0)
> +			return 0;
> +	}
> +
> +	return ALIGN_DOWN(space - sizeof(struct dibs_msg_hdr),
> +			  DIBS_PBD_MSG_ALIGNMENT);
> +}
> +EXPORT_SYMBOL_GPL(dibs_pbd_msg_max_payload);
> +
> +static int dibs_pbd_send_padding_msg(struct dibs_ring_buffer *rb)
> +{
> +	int ret;
> +	struct dibs_msg_hdr padding_hdr;
> +
> +	padding_hdr.version = DIBS_PBD_HDR_V1;
> +	padding_hdr.type = DIBS_PBD_PADDING_MSG;
> +	padding_hdr.datalen =
> +		dibs_ring_space_to_end(rb) - sizeof(struct dibs_msg_hdr);
> +
> +	ret = dibs_ring_send(rb, &padding_hdr, sizeof(padding_hdr), false);
> +	if (ret)
> +		return ret;
> +
> +	return dibs_ring_send_padding(rb, padding_hdr.datalen);
> +}
> +
> +/**
> + * dibs_pbd_msg_send() - Send a message through the ring buffer
> + * @rb: Ring buffer to send message through
> + * @hdr: Message header with payload to send
> + *
> + * Sends a message through the ring buffer, handling alignment and wrapping.
> + * If the message doesn't fit at the end of the ring buffer, a padding message
> + * is sent first to wrap to the beginning.
> + *
> + * Return: 0 on success, -EINVAL if message size overflows, -ENOSPC if
> + *         insufficient space in ring buffer, or error from ring buffer operations
> + */
> +int dibs_pbd_msg_send(struct dibs_ring_buffer *rb, struct dibs_msg_hdr *hdr)
> +{
> +	u32 msg_size = dibs_pbd_msg_size(hdr);
> +	int ret;
> +
> +	if (!msg_size)
> +		return -EINVAL;
> +
> +	if (msg_size > dibs_ring_space(rb))
> +		return -ENOSPC;
> +
> +	if (msg_size > dibs_ring_space_to_end(rb)) {
> +		ret = dibs_pbd_send_padding_msg(rb);
> +		if (ret)
> +			return ret;
> +
> +		if (msg_size > dibs_ring_space(rb))
> +			return -ENOSPC;
> +	}
> +
> +	return dibs_ring_send(rb, hdr, msg_size, true);
> +}
> +EXPORT_SYMBOL_GPL(dibs_pbd_msg_send);
> +
> +/**
> + * dibs_pbd_msg_recv() - Receive a message from the ring buffer
> + * @rb: Ring buffer to receive message from
> + *
> + * Receives the next message from the ring buffer, automatically skipping
> + * any padding messages used for alignment.
> + *
> + * Return: Pointer to received message header, or NULL if no message available
> + *         or error occurred
> + */
> +struct dibs_msg_hdr *dibs_pbd_msg_recv(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_msg_hdr *msg;
> +	u32 msg_size;
> +
> +	while ((msg = dibs_ring_recv(rb))) {
> +		msg_size = dibs_pbd_msg_size(msg);
> +		if (!msg_size || msg_size > dibs_ring_cnt_to_end(rb)) {
> +			pr_warn("%s(%s): discarding message with invalid size\n",
> +				__func__, rb->name);
> +			rb->msg_size = 0;
> +			return NULL;
> +		}
> +
> +		rb->msg_size = msg_size;
> +
> +		if (READ_ONCE(msg->type) != DIBS_PBD_PADDING_MSG)
> +			break;
> +		if (dibs_pbd_msg_ack(rb))
> +			return NULL;
> +	}
> +
> +	return msg;
> +}
> +EXPORT_SYMBOL_GPL(dibs_pbd_msg_recv);
> +
> +/**
> + * dibs_pbd_msg_ack() - Acknowledge a received message
> + * @rb: Ring buffer the message was received from
> + *
> + * Acknowledges the message dibs_pbd_msg_recv() handed out, freeing its space
> + * in the ring buffer for reuse. Must be called after processing each received
> + * message. Uses the size validated by dibs_pbd_msg_recv(), so that the peer
> + * cannot move the tail by rewriting its datalen afterwards.
> + *
> + * Return: 0 on success, -EINVAL if there is no message to acknowledge, or
> + *         error from ring buffer operations
> + */
> +int dibs_pbd_msg_ack(struct dibs_ring_buffer *rb)
> +{
> +	u32 msg_size = rb->msg_size;
> +
> +	if (!msg_size)
> +		return -EINVAL;
> +
> +	rb->msg_size = 0;
> +
> +	return dibs_ring_ack(rb, msg_size);
> +}
> +EXPORT_SYMBOL_GPL(dibs_pbd_msg_ack);
> +
> +struct dibs_pbd_remote_endpoint {
> +	struct dibs_dev *dibs;
> +	struct list_head list;
> +	uuid_t rgid;
> +	bool trusted;
> +	struct dibs_ring_buffer rb;
> +	struct work_struct handle_irq_work;
> +	/*
> +	 * Reference count protects this structure from being freed while
> +	 * IRQ handler or work items are using it. IRQ handler takes reference
> +	 * with kref_get_unless_zero() before scheduling work. Work handler
> +	 * drops reference when done. Initial reference is dropped in
> +	 * handle_event_work for DIBS_DEV_DISABLED events.
> +	 */
> +	struct kref kref;
> +};
> +
> +static int dibs_pbd_match(struct device *dev, const struct device_driver *drv)
> +{
> +	struct dibs_peer_dev_driver *dpdd;
> +	struct dibs_peer_device *dpd;
> +
> +	dpdd = to_dibs_peer_dev_driver(drv);
> +	dpd = to_dibs_peer_device(dev);
> +	if (dpdd->type && dpdd->type == dpd->type)
> +		return 1;
> +	return 0;
> +};
> +
> +static int dibs_pbd_probe(struct device *dev)
> +{
> +	struct dibs_peer_dev_driver *dpdd;
> +	struct dibs_peer_device *dpd;
> +
> +	if (dev->driver) {
> +		dpd = to_dibs_peer_device(dev);
> +		dpdd = to_dibs_peer_dev_driver(dev->driver);
> +		return dpdd->probe(dpd);
> +	}
> +
> +	return 0;
> +}
> +
> +static void dibs_pbd_remove(struct device *dev)
> +{
> +	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
> +	struct dibs_peer_dev_driver *dpdd;
> +
> +	if (dev->driver) {
> +		dpdd = to_dibs_peer_dev_driver(dev->driver);
> +		dpdd->remove(dpd);
> +	}
> +}
> +
> +static int dibs_pbd_uevent(const struct device *dev,
> +			   struct kobj_uevent_env *env)
> +{
> +	struct dibs_peer_device *dpd;
> +
> +	dpd = to_dibs_peer_device(dev);
> +	add_uevent_var(env, "MODALIAS=dibs:peer_dev:%d", dpd->type);
> +
> +	return 0;
> +}
> +
> +static int dibs_pbd_notifier(struct notifier_block *nb, unsigned long action,
> +			     void *data)
> +{
> +	struct dibs_peer_device *dpd = to_dibs_peer_device(data);
> +
> +	switch (action) {
> +	case BUS_NOTIFY_BOUND_DRIVER:
> +		dpd->status = PEER_DEV_CONNECTED;
> +		break;
> +	case BUS_NOTIFY_UNBIND_DRIVER:
> +		dpd->status = PEER_DEV_DISCONNECTED;
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block dibs_pbd_nb = { .notifier_call =
> +						     dibs_pbd_notifier };
> +
> +static int dibs_pbd_s390_get_system_info(struct dibs_system_info *sysinfo)
> +{
> +	struct sysinfo_2_2_2 *info222;
> +	struct sysinfo_3_2_2 *info322;
> +	void *info;
> +	int level;
> +
> +	info = (void *)get_zeroed_page(GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	memset(sysinfo->system_name, 0, sizeof(sysinfo->system_name));
> +
> +	level = stsi(NULL, 0, 0, 0);
> +	if (level >= 2) {

if (level == 2)
otherwise this block is also executed for level 3.

> +		info222 = (struct sysinfo_2_2_2 *)info;

No need to cast a void pointer.

> +		if (stsi(info222, 2, 2, 2) == 0) {
> +			EBCASC(info222->name, sizeof(info222->name));
> +			memcpy(&sysinfo->system_name, info222->name,
> +			       sizeof(sysinfo->system_name));
> +			memcpy(&sysinfo->uuid, info222->uuid.b, UUID_SIZE);
> +		}
> +	}
> +	if (level >= 3) {
> +		info322 = (struct sysinfo_3_2_2 *)info;
> +		if (stsi(info322, 3, 2, 2) == 0) {
> +			EBCASC(info322->vm[0].name,
> +			       sizeof(info322->vm[0].name));
> +			memcpy(&sysinfo->system_name, info322->vm[0].name,
> +			       sizeof(sysinfo->system_name));
> +			memcpy(&sysinfo->uuid, info322->vm[0].uuid.b,
> +			       UUID_SIZE);
> +		}
> +	}
> +
> +	free_page((unsigned long)info);
> +	return 0;
> +}

This will not compile on non-s390.

> +
> +static int dibs_pbd_get_system_info(struct dibs_system_info *sysinfo)
> +{
> +	int ret = 0;
> +
> +	strscpy(sysinfo->hostname, utsname()->nodename);
> +
> +#ifdef CONFIG_S390
> +	ret = dibs_pbd_s390_get_system_info(sysinfo);
> +#endif
> +	return ret;
> +}
> +
> +static void dibs_pbd_re_access_tok_msg(struct dibs_msg_hdr *msg_hdr,
> +				       struct dibs_pbd_remote_endpoint *re)
> +{

Some explanation how the access token mechanism works, would be nice


> +	struct dibs_pbd_remote_endpoint_access_tok_msg atmsg;
> +	struct dibs_pbd_remote_endpoint_msg msg_to_send;
> +	struct dibs_pbd_remote_endpoint_msg *msg;
> +	struct dibs_system_info sysinfo;
> +	struct access_token *at;
> +	int ret;
> +
> +	msg = (struct dibs_pbd_remote_endpoint_msg *)msg_hdr;
> +	atmsg = msg->atmsg;
> +
> +	if (re->trusted) {
> +		at = kzalloc_obj(*at);
> +		if (!at) {
> +			pr_err("%s: failed to allocate access token\n",
> +			       __func__);
> +			return;
> +		}
> +		at->access_tok = atmsg.access_tok;
> +		mutex_lock(&dibs_pbd_access_token_list_mutex);
> +		list_add_tail(&at->list, &dibs_pbd_access_token_list);
> +		mutex_unlock(&dibs_pbd_access_token_list_mutex);
> +	} else {
> +		mutex_lock(&dibs_pbd_access_token_list_mutex);
> +		list_for_each_entry(at, &dibs_pbd_access_token_list, list) {
> +			if (at->access_tok == atmsg.access_tok)
> +				re->trusted = true;
> +		}
> +		mutex_unlock(&dibs_pbd_access_token_list_mutex);
> +	}
> +
> +	if (re->trusted) {
> +		ret = dibs_pbd_get_system_info(&sysinfo);
> +		if (!ret) {
> +			msg_to_send.hdr.version = DIBS_PBD_HDR_V1;
> +			msg_to_send.hdr.type = DIBS_PBD_SYSTEM_INFO_MSG;
> +			msg_to_send.hdr.datalen =
> +				sizeof(struct dibs_pbd_re_sysinfo_msg);
> +			strscpy(msg_to_send.simsg.system_name,
> +				sysinfo.system_name);
> +			memcpy(msg_to_send.simsg.uuid, sysinfo.uuid,
> +			       sizeof(sysinfo.uuid));
> +			strscpy(msg_to_send.simsg.hostname, sysinfo.hostname);
> +
> +			dibs_pbd_msg_send(&re->rb,
> +					  (struct dibs_msg_hdr *)&msg_to_send);
> +		}
> +	}
> +}
> +
> +static int dibs_pbd_peer_dev_match_id(struct device *dev, const void *data)
> +{
> +	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
> +	const u8 *id = data;
> +
> +	if (dpd && dpd->id == *id)
> +		return 1;
> +	return 0;
> +}
> +
> +static void dibs_pbd_peer_dev_release(struct device *dev)
> +{
> +	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
> +
> +	kfree(dpd);
> +}
> +
> +static ssize_t type_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
> +
> +	return sysfs_emit(buf, "%u\n", dpd->type);
> +}
> +static DEVICE_ATTR_RO(type);
> +
> +static ssize_t id_show(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
> +
> +	return sysfs_emit(buf, "%u\n", dpd->id);
> +}
> +static DEVICE_ATTR_RO(id);
> +
> +static ssize_t dmb_tok_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
> +
> +	if (!dpd->rb.dmb.dmb_tok)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%pUb,%llx\n", &dpd->parent->gid,
> +			  dpd->rb.dmb.dmb_tok);
> +}
> +static DEVICE_ATTR_RO(dmb_tok);
> +
> +static ssize_t peer_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
> +
> +	if (uuid_is_null(&dpd->rgid))
> +		return -ENODEV;
> +	return sysfs_emit(buf, "%pUb\n", &dpd->rgid);
> +}
> +static DEVICE_ATTR_RO(peer);
> +
> +static ssize_t state_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct dibs_peer_device *dpd;
> +
> +	dpd = to_dibs_peer_device(dev);
> +	return sysfs_emit(buf, "%u\n", dpd->status);
> +}
> +static DEVICE_ATTR_RO(state);
> +
> +static struct attribute *dibs_peer_dev_attrs[] = {
> +	&dev_attr_dmb_tok.attr, &dev_attr_peer.attr, &dev_attr_state.attr,
> +	&dev_attr_type.attr,	&dev_attr_id.attr,   NULL,
> +};
> +ATTRIBUTE_GROUPS(dibs_peer_dev);
> +
> +static void dibs_pbd_dibs_event_dev_disabled_work(struct work_struct *work)
> +{
> +	struct dibs_peer_dev_driver *dpdd;
> +	struct dibs_peer_device *dpd;
> +
> +	dpd = container_of(work, struct dibs_peer_device,
> +			   event_dev_disabled_work);
> +
> +	device_lock(&dpd->dev);
> +	if (dpd->dev.driver) {
> +		dpdd = to_dibs_peer_dev_driver(dpd->dev.driver);
> +		dpdd->disconnect(dpd);
> +	}
> +	device_unlock(&dpd->dev);
> +
> +	schedule_delayed_work(&dpd->timeout_work, dpd->timeout);
> +}
> +
> +static void dibs_pbd_peer_dev_destroy(struct dibs_peer_device *dpd)
> +{
> +	if (atomic_xchg(&dpd->destroying, 1))
> +		return;
> +
> +	cancel_work_sync(&dpd->event_dev_disabled_work);
> +
> +	/* Don't cancel if we're running in the timeout_work context */
> +	if (current_work() != &dpd->timeout_work.work)
> +		cancel_delayed_work_sync(&dpd->timeout_work);
> +
> +	device_unregister(&dpd->dev);
> +}
> +
> +static void dibs_pbd_dibs_dev_timeout_work(struct work_struct *work)
> +{
> +	struct dibs_peer_device *dpd;
> +
> +	dpd = container_of(to_delayed_work(work), struct dibs_peer_device,
> +			   timeout_work);
> +
> +	dibs_pbd_peer_dev_destroy(dpd);
> +}
> +
> +const struct bus_type dibs_pbd_type;

I get a compile warning:
drivers/dibs/dibs_peer_bus_drv.c:583:23: warning: symbol 'dibs_pbd_type'
was not declared. Should it be static?


> +
> +static int dibs_pbd_peer_dev_create(struct dibs_dev *dibs, uuid_t *rgid,
> +				    u64 rdmb_tok, u8 server_dev_id, u8 type,
> +				    u128 tok)
> +{
> +	struct dibs_peer_device *dpd;
> +	int ret;
> +
> +	dpd = kzalloc_obj(*dpd, GFP_KERNEL);
> +	if (!dpd)
> +		return -ENOMEM;
> +	atomic_set(&dpd->destroying, 0);
> +	dpd->id = server_dev_id;
> +	dpd->rgid = *rgid;
> +	dpd->type = type;
> +	dpd->dev.bus = &dibs_pbd_type;
> +	dpd->dev.release = dibs_pbd_peer_dev_release;
> +	dpd->parent = dibs;
> +	dpd->status = PEER_DEV_DISCONNECTED;
> +	dpd->rdmb_tok = rdmb_tok;
> +	dpd->dev.groups = dibs_peer_dev_groups;
> +	dpd->tok = tok;
> +	dev_set_name(&dpd->dev, "%pUb:%u", rgid, dpd->id);
> +
> +	INIT_WORK(&dpd->event_dev_disabled_work,
> +		  dibs_pbd_dibs_event_dev_disabled_work);
> +	INIT_DELAYED_WORK(&dpd->timeout_work, dibs_pbd_dibs_dev_timeout_work);
> +
> +	dpd->timeout = secs_to_jiffies(dibs_pbd_max_timeout);
> +
> +	ret = device_register(&dpd->dev);
> +	if (ret) {
> +		put_device(&dpd->dev);
> +		return ret;
> +	}
> +	ret = sysfs_create_link(&dpd->dev.kobj, &dpd->parent->dev.kobj, "dibs");
> +	if (ret) {
> +		device_unregister(&dpd->dev);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static void dibs_pbd_re_dev_msg(struct dibs_msg_hdr *msg_hdr,
> +				struct dibs_pbd_remote_endpoint *re)
> +{
> +	struct dibs_pbd_remote_endpoint_dev_msg redm;
> +	struct dibs_pbd_remote_endpoint_msg *msg;
> +	struct dibs_peer_dev_driver *dpdd;
> +	struct dibs_peer_device *dpd;
> +	struct device *dev;
> +	int ret;
> +
> +	msg = (struct dibs_pbd_remote_endpoint_msg *)msg_hdr;
> +	redm = msg->devmsg;
> +
> +	dev = bus_find_device(&dibs_pbd_type, NULL, &redm.id,
> +			      dibs_pbd_peer_dev_match_id);
> +	if (dev) {
> +		dpd = to_dibs_peer_device(dev);
> +		if (dpd->tok != redm.peer_dev_tok) {
> +			put_device(dev);
> +			return;
> +		}
> +		if (dpd->rdmb_tok != redm.dmb_tok)
> +			dpd->rdmb_tok = redm.dmb_tok;
> +
> +		device_lock(&dpd->dev);
> +		if (dpd->dev.driver) {
> +			dpdd = to_dibs_peer_dev_driver(dpd->dev.driver);
> +			ret = dpdd->reconnect(dpd);
> +			if (!ret)
> +				dpd->status = PEER_DEV_CONNECTED;
> +		}
> +		device_unlock(&dpd->dev);
> +		put_device(dev);
> +	} else {
> +		dibs_pbd_peer_dev_create(re->dibs, &re->rgid, redm.dmb_tok,
> +					 redm.id, redm.peer_dev_type,
> +					 redm.peer_dev_tok);
> +	}
> +}
> +
> +static void dibs_pbd_remote_endpoint_release(struct kref *kref)
> +{
> +	struct dibs_pbd_remote_endpoint *re;
> +
> +	re = container_of(kref, struct dibs_pbd_remote_endpoint, kref);
> +
> +	dibs_ring_unregister(&re->rb);
> +	kfree(re);
> +}
> +
> +static struct dibs_client dibs_pbd_drv;


pbd means 'peer bus driver' right? so why the additional _drv ??


> +static void dibs_pbd_handle_irq_work(struct work_struct *work)
> +{
> +	struct dibs_pbd_remote_endpoint *re;
> +	struct dibs_ring_buffer *rb;
> +	struct dibs_msg_hdr *msg;
> +
> +	re = container_of(work, struct dibs_pbd_remote_endpoint,
> +			  handle_irq_work);
> +	rb = &re->rb;
> +
> +	while ((msg = dibs_pbd_msg_recv(rb))) {
> +		switch (msg->type) {
> +		case DIBS_PBD_REMOTE_ENDPOINT_ACCESS_TOKEN_MSG:
> +			dibs_pbd_re_access_tok_msg(msg, re);
> +			break;
> +		case DIBS_PBD_DEV_MSG:
> +			if (re->trusted)
> +				dibs_pbd_re_dev_msg(msg, re);
> +			break;
> +		default:
> +			pr_warn("%s: Received unknown message type: %d\n",
> +				__func__, msg->type);
> +			kref_put(&re->kref, dibs_pbd_remote_endpoint_release);
> +			return;

I think it would be more robust to not return here.
Call dibs_pbd_msg_ack and kref_put, so accounting is correct and then
either:
ignore after the warning
or
shutdown the connection to this console server.

> +		}
> +		dibs_pbd_msg_ack(rb);
> +	}
> +
> +	kref_put(&re->kref, dibs_pbd_remote_endpoint_release);
> +}
> +
> +static void dibs_pbd_drv_handle_irq(struct dibs_dev *dibs, unsigned int dmbno,
> +				    u16 dmbemask)
> +{
> +	struct dibs_pbd_dibs_dev_state *dds;
> +	struct dibs_pbd_remote_endpoint *re;
> +	struct dibs_peer_dev_driver *dpdd;
> +	struct dibs_peer_device *dpd;
> +	unsigned long flags;
> +
> +	dds = dibs_get_priv(dibs, &dibs_pbd_drv);
> +
> +	spin_lock_irqsave(&dds->dmb_state[dmbno].dmb_state_lock, flags);
> +	dpdd = dds->dmb_state[dmbno].peer_dev_driver;
> +	dpd = dds->dmb_state[dmbno].peer_dev;
> +	if (dpdd && dpd)
> +		dpdd->handle_irq(dmbno, dpd, 0);
> +	re = dds->dmb_state[dmbno].remote_endpoint;
> +	if (re && !kref_get_unless_zero(&re->kref))
> +		re = NULL;
> +	spin_unlock_irqrestore(&dds->dmb_state[dmbno].dmb_state_lock, flags);
> +
> +	if (!re)
> +		return;
> +
> +	if (!queue_work(system_dfl_wq, &re->handle_irq_work)) {
> +		/* Work already pending, drop the reference */
> +		kref_put(&re->kref, dibs_pbd_remote_endpoint_release);
> +	}
> +	/* If queue_work returned true, work owns the reference */
> +}
> +
> +static int dibs_pbd_peer_dev_event(struct device *dev, void *data)
> +{
> +	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
> +	struct dibs_event *event = data;
> +
> +	switch (event->subtype) {
> +	case DIBS_SW_EVENT_REDISCOVER:
> +		dpd->rgid = event->gid;
> +		cancel_delayed_work(&dpd->timeout_work);
> +		break;
> +	case DIBS_DEV_DISABLED:
> +		if (uuid_equal(&dpd->rgid, &event->gid))
> +			schedule_work(&dpd->event_dev_disabled_work);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dibs_pbd_remote_endpoint_create(struct dibs_dev *dibs,
> +					   const uuid_t *rgid,
> +					   const bool trusted)
> +{
> +	struct dibs_pbd_remote_endpoint *re, *tmp;
> +	struct dibs_pbd_dibs_dev_state *dds;
> +	bool existing_re_found = false;
> +	unsigned long flags;
> +	int ret;
> +
> +	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
> +	list_for_each_entry_safe(re, tmp, &dibs_pbd_remote_endpoint_list,
> +				 list) {
> +		if (uuid_equal(&re->rgid, rgid))
> +			existing_re_found = true;
> +	}
> +	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
> +
> +	if (existing_re_found) {
> +		pr_warn("%s: remote endpoint already exists for rgid: %pUb\n",
> +			__func__, rgid);
> +		return 0;
> +	}

Why do you have a list, if only a single endpoint is possible?
Why do you store all previous res in the list?

What if you change the gid via discover and change it back?
then you are not updatign the dds ?
And not creating a new rb ?

> +
> +	re = kzalloc_obj(*re, GFP_KERNEL);
> +	if (!re)
> +		return -ENOMEM;
> +
> +	re->dibs = dibs;
> +	uuid_copy(&re->rgid, rgid);
> +	re->trusted = trusted;
> +
> +	ret = dibs_ring_register("peer_bus", &re->rb, &dibs_pbd_drv, dibs,
> +				 re->rgid, DIBS_PBD_RING_SIZE);
> +
> +	if (ret) {
> +		pr_err("%s: failed to register ring buffer\n", __func__);
> +		kfree(re);
> +		return ret;
> +	}
> +
> +	INIT_WORK(&re->handle_irq_work, dibs_pbd_handle_irq_work);
> +	kref_init(&re->kref);
> +
> +	dds = dibs_get_priv(dibs, &dibs_pbd_drv);
> +	spin_lock_irqsave(&dds->dmb_state[re->rb.dmb.idx].dmb_state_lock,
> +			  flags);
> +	dds->dmb_state[re->rb.dmb.idx].remote_endpoint = re;
> +	dds->dmb_state[re->rb.rd_meta_dmb.idx].remote_endpoint = re;
> +	spin_unlock_irqrestore(&dds->dmb_state[re->rb.dmb.idx].dmb_state_lock,
> +			       flags);
> +
> +	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
> +	list_add(&re->list, &dibs_pbd_remote_endpoint_list);
> +	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
> +	re->dibs->ops->signal_event(re->dibs, &re->rgid, 1,> +				
DIBS_SW_EVENT_DISCOVER,
> +				    re->rb.wr_ring_meta.meta_dmb_tok);
> +	dibs_pbd_boot_event_sent = 1;
> +
> +	return 0;
> +}
> +
> +static void dibs_pbd_drv_handle_event_work(struct work_struct *work)
> +{
> +	struct dibs_pbd_remote_endpoint *re, *tmp;
> +	struct dibs_pbd_event_work *ew;
> +
> +	ew = container_of(work, struct dibs_pbd_event_work, work);
> +
> +	bus_for_each_dev(&dibs_pbd_type, NULL, &ew->event,
> +			 dibs_pbd_peer_dev_event);
> +
> +	switch (ew->event.subtype) {
> +	case DIBS_SW_EVENT_REDISCOVER:
> +		if (!ew->dibs->ops->query_remote_gid(ew->dibs, &ew->event.gid,
> +						     0, 0))
> +			dibs_pbd_remote_endpoint_create(ew->dibs,
> +							&ew->event.gid, false);
> +		break;
> +	case DIBS_DEV_DISABLED:
> +		mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
> +		list_for_each_entry_safe(re, tmp,
> +					 &dibs_pbd_remote_endpoint_list, list) {
> +			if (uuid_equal(&re->rgid, &ew->event.gid)) {
> +				list_del(&re->list);
> +				/* Drop initial reference - free when all other refs are gone */
> +				kref_put(&re->kref,
> +					 dibs_pbd_remote_endpoint_release);
> +			}
> +		}
> +		mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
> +		break;
> +	}
> +
> +	kfree(ew);
> +}
> +
> +static void dibs_pbd_drv_handle_event(struct dibs_dev *dev,
> +				      const struct dibs_event *event)
> +{
> +	struct dibs_pbd_event_work *ew;
> +
> +	ew = kzalloc_obj(*ew, GFP_ATOMIC);
> +	if (!ew)
> +		return;
> +	ew->dibs = dev;
> +	ew->event = *event;
> +
> +	INIT_WORK(&ew->work, dibs_pbd_drv_handle_event_work);
> +	schedule_work(&ew->work);
> +}
> +
> +static ssize_t dibs_pbd_discover_store_handle_gid_prefix(const char *buf,
> +							 size_t count)
> +{
> +	struct dibs_pbd_dibs_dev_state *dds;
> +	struct dibs_pbd_remote_endpoint *re;
> +	bool remote_system_reachable = false;
> +	const char *gid_str;
> +	uuid_t rgid;
> +	int ret;
> +
> +	gid_str = buf + strlen("gid:");
> +	ret = uuid_parse(gid_str, &rgid);
> +	if (ret) {
> +		pr_err("%s: could not parse rgid\n", __func__);
> +		return -EINVAL;
> +	}
> +	if (uuid_is_null(&rgid)) {
> +		pr_err("%s: gid is null\n", __func__);
> +		return -EINVAL;
> +	}
> +	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
> +	list_for_each_entry(re, &dibs_pbd_remote_endpoint_list, list) {
> +		if (!uuid_equal(&rgid, &re->rgid))
> +			continue;
> +		re->dibs->ops->signal_event(re->dibs, &re->rgid, 1,
> +					    DIBS_SW_EVENT_DISCOVER,
> +					    re->rb.wr_ring_meta.meta_dmb_tok);
> +		mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
> +		return count;
> +	}
> +	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
> +
> +	mutex_lock(&dibs_pbd_dibs_dev_state_list_mutex);
> +	list_for_each_entry(dds, &dibs_pbd_dibs_dev_state_list, list) {
> +		if (dds->dibs->ops->query_remote_gid(dds->dibs, &rgid, 0, 0))
> +			continue;
> +		remote_system_reachable = true;
> +		ret = dibs_pbd_remote_endpoint_create(dds->dibs, &rgid, true);
> +		if (ret) {
> +			mutex_unlock(&dibs_pbd_dibs_dev_state_list_mutex);
> +			return ret;
> +		}
> +		break;
> +	}
> +	mutex_unlock(&dibs_pbd_dibs_dev_state_list_mutex);
> +	if (!remote_system_reachable) {
> +		pr_err("%s: remote system not reachable\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t discover_store(const struct bus_type *bus, const char *buf,
> +			      size_t count)
> +{
> +	if (str_has_prefix(buf, "gid:"))
> +		return dibs_pbd_discover_store_handle_gid_prefix(buf, count);
> +
> +	pr_err("dibs_pbd: unknown discover identifier type\n");
> +	return -EINVAL;
> +}
> +static BUS_ATTR_WO(discover);
> +
> +static struct attribute *dibs_pbd_attrs[] = {
> +	&bus_attr_discover.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(dibs_pbd);
> +
> +const struct bus_type dibs_pbd_type = {
> +	.name = "dibs_peer",
> +	.match = dibs_pbd_match,
> +	.bus_groups = dibs_pbd_groups,
> +	.uevent = dibs_pbd_uevent,
> +	.probe = dibs_pbd_probe,
> +	.remove = dibs_pbd_remove,
> +};
> +
> +static void dibs_pbd_drv_add_dibs(struct dibs_dev *dibs)
> +{
> +	struct dibs_pbd_dibs_dev_state *dds;
> +	const char *gid_str;
> +	int max_dmbs;
> +	uuid_t gid;
> +	int ret;
> +
> +	max_dmbs = dibs->ops->max_dmbs();
> +	dds = kzalloc(sizeof(*dds) +
> +			      max_dmbs * sizeof(struct dibs_pbd_dmb_state),
> +		      GFP_KERNEL);
> +	if (!dds) {
> +		dev_err(&dibs->dev,
> +			"Failed to allocate memory for dibs dev state\n");
> +		return;
> +	}
> +
> +	dds->dibs = dibs;
> +	for (int i = 0; i < max_dmbs; i++)
> +		spin_lock_init(&dds->dmb_state[i].dmb_state_lock);
> +	dibs_set_priv(dibs, &dibs_pbd_drv, dds);
> +	mutex_lock(&dibs_pbd_dibs_dev_state_list_mutex);
> +	list_add(&dds->list, &dibs_pbd_dibs_dev_state_list);
> +	mutex_unlock(&dibs_pbd_dibs_dev_state_list_mutex);
> +
> +	/* Send boot event to remote system when module parameter rgid is set.
> +	 * Send boot event with the first dibs device that is able to
> +	 * communicate with the remote system.
> +	 */
> +
> +	if (dibs_peer_address && str_has_prefix(dibs_peer_address, "gid:") &&
> +	    !dibs_pbd_boot_event_sent) {

dibs_pbd_boot_event_sent is only set to 1 in
dibs_pbd_remote_endpoint_create() and never reset.
What if the ism device is removed and added back? (e.g. as recovery action)


Shouldn't an invalid prefix also warrant an pr_err ?


> +		gid_str = dibs_peer_address + strlen("gid:");
> +		if (strlen(gid_str) != UUID_STRING_LEN) {
> +			pr_err("%s: gid is not valid\n", __func__);
> +			return;
> +		}
> +		ret = uuid_parse(gid_str, &gid);
> +		if (ret) {
> +			pr_err("%s: Could not parse gid\n", __func__);
> +			return;
> +		}
> +		if (uuid_is_null(&gid)) {
> +			pr_err("%s: gid is null\n", __func__);
> +			return;
> +		}
> +		if (!dibs->ops->query_remote_gid(dibs, &gid, 0, 0)) {
> +			/* Create a peer device for the dibs base client

			s/dibs base client/dibs peer bus driver/g ?

> +			 * This peer device registers the discovery DMB
> +			 */
> +			dibs_pbd_remote_endpoint_create(dibs, &gid, true);
> +		}
> +	}
> +}
> +
> +static int dibs_pbd_destroy_matching_peer_dev(struct device *dev, void *data)
> +{
> +	struct dibs_peer_device *dpd = to_dibs_peer_device(dev);
> +	struct dibs_dev *removed = data;
> +
> +	if (dpd->parent != removed)
> +		return 0;
> +
> +	dibs_pbd_peer_dev_destroy(dpd);
> +
> +	return 0;
> +}
> +
> +/**
> + * dibs_pbd_driver_register() - Register a peer device driver
> + * @dpdd: Peer device driver to register
> + *
> + * Registers a driver for dibs peer devices on the peer bus.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int dibs_pbd_driver_register(struct dibs_peer_dev_driver *dpdd)
> +{
> +	dpdd->drv.bus = &dibs_pbd_type;
> +
> +	return driver_register(&dpdd->drv);
> +}
> +EXPORT_SYMBOL(dibs_pbd_driver_register);
> +
> +/**
> + * dibs_pbd_driver_unregister() - Unregister a peer device driver
> + * @dpdd: Peer device driver to unregister
> + *
> + * Unregisters a previously registered peer device driver.
> + *
> + * Return: Always returns 0
> + */
> +int dibs_pbd_driver_unregister(struct dibs_peer_dev_driver *dpdd)
> +{
> +	driver_unregister(&dpdd->drv);
> +	return 0;
> +}
> +EXPORT_SYMBOL(dibs_pbd_driver_unregister);
> +
> +static void peer_bus_drv_remove_dibs(struct dibs_dev *dibs)
> +{
> +	struct dibs_pbd_remote_endpoint *re, *tmp;
> +	struct dibs_pbd_dibs_dev_state *dds;
> +
> +	bus_for_each_dev(&dibs_pbd_type, NULL, dibs,
> +			 dibs_pbd_destroy_matching_peer_dev);
> +
> +	dds = dibs_get_priv(dibs, &dibs_pbd_drv);
> +
> +	mutex_lock(&dibs_pbd_remote_endpoint_list_mutex);
> +	list_for_each_entry_safe(re, tmp, &dibs_pbd_remote_endpoint_list, list) {
> +		if (re->dibs == dibs) {
> +			list_del(&re->list);
> +			kref_put(&re->kref, dibs_pbd_remote_endpoint_release);
> +		}
> +	}
> +	mutex_unlock(&dibs_pbd_remote_endpoint_list_mutex);
> +
> +	mutex_lock(&dibs_pbd_dibs_dev_state_list_mutex);
> +	list_del_init(&dds->list);
> +	mutex_unlock(&dibs_pbd_dibs_dev_state_list_mutex);
> +
> +	kfree(dds);
> +}
> +
> +static struct dibs_client_ops dibs_pbd_drv_ops = {
> +	.add_dev = dibs_pbd_drv_add_dibs,
> +	.del_dev = peer_bus_drv_remove_dibs,
> +	.handle_event = dibs_pbd_drv_handle_event,
> +	.handle_irq = dibs_pbd_drv_handle_irq,
> +};
> +
> +static struct dibs_client dibs_pbd_drv = {

As mentioned elsewhere what does pbd stand for? peer bus driver? Then
why drv??

> +	.name = "peer_bus",

"peer_bus_drv" ?

> +	.ops = &dibs_pbd_drv_ops,

> +};
> +
> +/**
> + * dibs_pbd_register_ring_buffer() - Register a ring buffer for a peer device
> + * @name: Name for the ring buffer
> + * @dpd: Peer device to register ring buffer for
> + * @size: Size of the ring buffer
> + *
> + * Registers a ring buffer for communication with a peer device and associates
> + * it with the peer device's driver. The device must be locked before calling.
> + *
> + * Return: 0 on success, -ENODEV if no driver bound, or error from ring
> + *         buffer registration
> + */
> +int dibs_pbd_register_ring_buffer(char *name, struct dibs_peer_device *dpd,
> +				  u32 size)
> +{
> +	struct dibs_pbd_dibs_dev_state *dds;
> +	struct dibs_peer_dev_driver *dpdd;
> +	unsigned long flags;
> +	int ret;
> +
> +	device_lock_assert(&dpd->dev);
> +
> +	ret = dibs_ring_register(name, &dpd->rb, &dibs_pbd_drv, dpd->parent,
> +				 dpd->rgid, size);
> +	if (ret)
> +		return ret;
> +
> +	if (!dpd->dev.driver) {
> +		dibs_ring_unregister(&dpd->rb);
> +		return -ENODEV;
> +	}

Why don't you check it before dibs_ring_register()? Then you don'T have
to undo that.

> +	dpdd = to_dibs_peer_dev_driver(dpd->dev.driver);
> +	dds = dibs_get_priv(dpd->parent, &dibs_pbd_drv);
> +
> +	spin_lock_irqsave(&dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock,
> +			  flags);
> +	dds->dmb_state[dpd->rb.dmb.idx].peer_dev_driver = dpdd;
> +	dds->dmb_state[dpd->rb.dmb.idx].peer_dev = dpd;
> +	dds->dmb_state[dpd->rb.rd_meta_dmb.idx].peer_dev_driver = dpdd;
> +	dds->dmb_state[dpd->rb.rd_meta_dmb.idx].peer_dev = dpd;
> +	spin_unlock_irqrestore(&dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock,
> +			       flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(dibs_pbd_register_ring_buffer);
> +
> +/**
> + * dibs_pbd_unregister_ring_buffer() - Unregister a peer device's ring buffer
> + * @dpd: Peer device whose ring buffer to unregister
> + *
> + * Unregisters the ring buffer associated with a peer device and clears
> + * the driver associations.
> + *
> + * Return: 0 on success, or error from ring buffer unregistration
> + */
> +int dibs_pbd_unregister_ring_buffer(struct dibs_peer_device *dpd)
> +{
> +	struct dibs_pbd_dibs_dev_state *dds;
> +	unsigned long flags;
> +	int ret;
> +
> +	device_lock_assert(&dpd->dev);
> +
> +	dds = dibs_get_priv(dpd->parent, &dibs_pbd_drv);
> +
> +	spin_lock_irqsave(&dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock,
> +			  flags);
> +	dds->dmb_state[dpd->rb.dmb.idx].peer_dev_driver = NULL;
> +	dds->dmb_state[dpd->rb.dmb.idx].peer_dev = NULL;
> +	dds->dmb_state[dpd->rb.rd_meta_dmb.idx].peer_dev_driver = NULL;
> +	dds->dmb_state[dpd->rb.rd_meta_dmb.idx].peer_dev = NULL;
> +	spin_unlock_irqrestore(&dds->dmb_state[dpd->rb.dmb.idx].dmb_state_lock,
> +			       flags);
> +
> +	ret = dibs_ring_unregister(&dpd->rb);
> +	dpd->rb.dmb.idx = 0;
> +	dpd->rb.rd_meta_dmb.idx = 0;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dibs_pbd_unregister_ring_buffer);
> +
> +/**
> + * dibs_pbd_init() - Initialize the dibs peer bus driver
> + *
> + * Initializes the peer bus subsystem by registering the bus type,

s/Initializes the peer bus subsystem by registering the bus type/
Register the dibs peer bus type/g
dibs peer bus is not a subsystem imo, but a bus.

> + * notifier, and dibs client. Must be called before any peer devices
> + * can be used.

can be probed (?)

> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int dibs_pbd_init(void)
> +{
> +	int ret;
> +
> +	ret = bus_register(&dibs_pbd_type);
> +	if (ret)
> +		return ret;
> +	ret = bus_register_notifier(&dibs_pbd_type, &dibs_pbd_nb);
> +	if (ret)
> +		goto bus_reg_not_err;
> +	ret = dibs_register_client(&dibs_pbd_drv);
> +	if (ret)
> +		goto dibs_reg_client_err;
> +	return 0;
> +
> +dibs_reg_client_err:
> +	bus_unregister_notifier(&dibs_pbd_type, &dibs_pbd_nb);
> +bus_reg_not_err:
> +	bus_unregister(&dibs_pbd_type);
> +	return ret;
> +}
> +EXPORT_SYMBOL(dibs_pbd_init);
> +
> +/**
> + * dibs_pbd_exit() - Clean up the dibs peer bus driver
> + *
> + * Cleans up the peer bus subsystem by unregistering the dibs client,
> + * notifier, and bus type. Should be called during module unload.
> + */
> +void dibs_pbd_exit(void)
> +{
> +	dibs_unregister_client(&dibs_pbd_drv);
> +
> +	bus_unregister_notifier(&dibs_pbd_type, &dibs_pbd_nb);
> +	bus_unregister(&dibs_pbd_type);
> +}
> +EXPORT_SYMBOL(dibs_pbd_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("IBM Corporation");
> diff --git a/include/linux/dibs.h b/include/linux/dibs.h
> index 30ae03484b58..8c24f7b33e6f 100644
> --- a/include/linux/dibs.h
> +++ b/include/linux/dibs.h

Does all this belong into include/linux/dibs.h ?? Is this required for
other dibs clients??
Or should this be in a drivers/dibs/dibs_peer_bus_drv.h ??


> @@ -164,7 +164,9 @@ enum dibs_event_subtype {
>  	DIBS_BUF_UNREGISTERED,
>  	DIBS_DEV_DISABLED,
>  	DIBS_DEV_ERR_STATE,
> -	DIBS_OTHER_SUBTYPE
> +	DIBS_OTHER_SUBTYPE,
> +	DIBS_SW_EVENT_DISCOVER = 0x9,
> +	DIBS_SW_EVENT_REDISCOVER = 0x10,

We said that every client can define their own values for SW_EVENT subtypes
see smc_ism.c's
#define ISM_EVENT_CODE_SHUTDOWN		0x80
#define ISM_EVENT_CODE_TESTLINK		0x83

So the values for dibs peer bus events should not be listed here,
but in a dibs_peer_bus_drv.h.


>  };
>  
>  struct dibs_event {
> @@ -269,6 +271,12 @@ int dibs_unregister_client(struct dibs_client *client);
>  
>  /* dibs clients can call dibs device ops. */
>  
> +struct dibs_system_info {
> +	u8 system_name[16];
> +	u8 uuid[16];
> +	u8 hostname[128];
> +};
> +

Why is this here?? This is only used in pbd
(same question for everything? below)

>  /* DIBS devices
>   * ------------
>   */
> @@ -554,10 +562,72 @@ int dibs_dev_add(struct dibs_dev *dibs);
>   */
>  void dibs_dev_del(struct dibs_dev *dibs);
>  
> +/*
> + * Dibs Peer Bus
> + */
> +#define to_dibs_peer_dev_driver(x) \
> +	container_of((x), struct dibs_peer_dev_driver, drv)
> +#define to_dibs_peer_device(x) container_of((x), struct dibs_peer_device, dev)
> +
> +#define PEER_DEV_DISCONNECTED 0
> +#define PEER_DEV_CONNECTED 1
> +
> +struct dibs_peer_device {
> +	u8 id;
> +	uuid_t rgid;
> +	struct dibs_ring_buffer rb;
> +	u64 rdmb_tok;
> +	u8 status;
> +	u8 type;
> +	u128 tok;
> +	struct delayed_work timeout_work;
> +	unsigned long timeout;
> +	struct work_struct event_dev_disabled_work;
> +	atomic_t destroying;
> +	struct dibs_dev *parent;
> +	struct device dev;
> +	/* priv pointer for driver */
this comment is useless
> +	void *drv_priv;
> +};

Some explanations what the fields hat are not self-describing? Like what
is id vs rgid? rdmb_tok vs tok?

> +
> +struct dibs_peer_dev_driver {
> +	u8 type;
> +	int (*probe)(struct dibs_peer_device *peer_dev);
> +	void (*remove)(struct dibs_peer_device *peer_dev);
> +	int (*reconnect)(struct dibs_peer_device *peer_dev);
> +	void (*disconnect)(struct dibs_peer_device *peer_dev);
> +	void (*handle_irq)(unsigned int dmbno,
> +			   struct dibs_peer_device *peer_dev, u16 dmbemask);
> +	struct device_driver drv;
> +};
> +
> +#ifdef CONFIG_DIBS_PEER_BUS_DRV
> +int dibs_pbd_init(void);
> +void dibs_pbd_exit(void);
> +#else
> +static inline int dibs_pbd_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline void dibs_pbd_exit(void) {}
> +
> +#endif
> +
>  struct dibs_msg_hdr {
>  	u8 version;

Do you intend forward compatibility or backward compatibility?
Right now you only write the version field, so you intend that this PBD
client V1 will work with all future console servers.
Maybe you want to state that somewhere?


>  	u8 type;
>  	u16 datalen;
>  } __packed;
>  
> +int dibs_pbd_register_ring_buffer(char *name, struct dibs_peer_device *dpd,
> +				  u32 size);
> +int dibs_pbd_unregister_ring_buffer(struct dibs_peer_device *dpd);
> +int dibs_pbd_driver_register(struct dibs_peer_dev_driver *driver);
> +int dibs_pbd_driver_unregister(struct dibs_peer_dev_driver *ipdd);
> +size_t dibs_pbd_msg_max_payload(struct dibs_ring_buffer *rb);
> +int dibs_pbd_msg_send(struct dibs_ring_buffer *rb, struct dibs_msg_hdr *hdr);
> +struct dibs_msg_hdr *dibs_pbd_msg_recv(struct dibs_ring_buffer *rb);
> +int dibs_pbd_msg_ack(struct dibs_ring_buffer *rb);
> +
>  #endif	/* _DIBS_H */
> 

