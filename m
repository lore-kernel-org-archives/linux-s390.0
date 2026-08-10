Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF847143A;
	Thu, 13 Aug 2026 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622117; cv=none; b=GGdhXfdNcaG8xNmsCbI8C0GJ5mXilspwscya4HkM0Z/7iSVSBdj+TEP1dxRtsOw6AYLz8g2mYhj+L0FYJ4i+2B0G8lNiU0um9+Sona2hc1EKVkBj+H+C+SQ+j/hoGDDC7jXiNkWWLLmoqpf2LaReI7L0tz2QMlvcrcNEoJIFOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622117; c=relaxed/simple;
	bh=VM9/L4TusEJHo/STTYPWxflqzdUq1R15Up3vTL4j5jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhBMW3t5DrO+VEnHDwntlgHWY5MoDlI17wilW5gwixKjhif0g9+nMRg/y/9Jz/2ftZDCyb2N1VaVD7mC3uvl5VbUT+2gzNY/U8wW7nytUa2shXt9YP4gWfjzG7rZYxEm8fEQF4PBR64OPF+dQBRv4MDDzd6ILEz07CUPAKmzKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PWh9RK5n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PWh9RK5n"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98tTN1949513;
	Thu, 13 Aug 2026 11:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sAiz7n
	lQrgbc5W18LNd6COInHonfoDjnB0ZrEbS1364=; b=PWh9RK5nOBAQtIFdEZ07Cf
	Ytc8v9UGFWNBrk63D1PJJpX8R6hs3BP+rKwTmy2gGtQ2skNIvZzXZXtiJHdXYy42
	Z7RRX/QpoLeRhh8aWv+iE/Zhwgq2ojg5zRrd1qPbcPMcadQqLIz1UVSw5sooYr/A
	qlNTTMLUGmhbz/LsqyNK2Eu7hQDUhxwp3pLG1tRX3OpoG4BdWGv/sur0ZI6g/SIl
	n9uYJdnDUWSOId4t6M4UpTGBHV2LqArzqhQSFt/yDDD6uocmD42nO/MHpJMLPIYl
	IM6NFpH4QfKHKsB308PFcMLKixzgucgibSnEkril+hFRv7XZS3Q4PnZ4qcfgOMeA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwepu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:55:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DBfKXO030579;
	Thu, 13 Aug 2026 11:55:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gjqrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:55:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DBt6tf39191254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:55:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25ECF58052;
	Thu, 13 Aug 2026 11:55:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A14D758045;
	Thu, 13 Aug 2026 11:55:04 +0000 (GMT)
Received: from [9.61.3.203] (unknown [9.61.3.203])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 11:55:04 +0000 (GMT)
Message-ID: <5a18d610-d943-4bc5-bb50-0a4ff037f6b3@linux.ibm.com>
Date: Mon, 10 Aug 2026 09:45:26 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-3-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7db09c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=kFuMASqMmKH19ukc8TMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OPYaUIbfrxp8c6W0XSlwp7dRXebfKAXs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfX+AR/XLZFzKT4
 nTQkQps3mR2kr9+qLggMjh7OSU8zeey7RPrSA6ZOhqtTBuYt71pb/nge3PmWlui+2PltCIyIGck
 fS4HqD+K3lGeJwXDRjo1CkyAlZrknY5eYh/NWawrsKWiWDXOH8wCMYaVfbc6goDGdcU8S5lnUO7
 SIANFfu8tuTxgs0IyJOvFb8GbHTLPUXBjX1Ze7G0xGigi9DSaKrDuUOz5MVecbRYIK10YHvaBdE
 mPSYpGvhbqYs3vnKaNffWxCxa88+t+3FDiSWBpw7suk5LBDceR3/TE/ffsbDFXEhTskdwjDPL6i
 JiNMSg56EgznZCyvRbVWLcdQJiXDYejbG0m7Fh5T1RVUAMYIFoeIqUujQzOe6yTWo23Z4jz2riP
 dEbG36mqNCuXu3JM7O+nj1KSwoa+X+7oI+AUs0vZQny/cgK51zT7P/5mq8853ZQ41DgB3wAUMES
 MUgiA19dYnejov2NSbA==
X-Proofpoint-ORIG-GUID: OPYaUIbfrxp8c6W0XSlwp7dRXebfKAXs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfXxzOEhWXZcO/K
 Fo3sT4hx9WkL+AWjhmFcKZt7DI39JnWWkxeGtj/VoPi9Y5rPKgcoL2nsnYTmz4JjgvDM0D7kkT1
 HfFrQRooljHcTIfLZxeaGLWHlrcwBh0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130081



On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> Creates the data structures used to facilitate state transitions during
> vfio device migration.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/Makefile            |   2 +-
>   drivers/s390/crypto/vfio_ap_migration.c | 113 ++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h   |   5 ++
>   3 files changed, 119 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/s390/crypto/vfio_ap_migration.c
> 
> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
> index e83c6603c858..20f29184825a 100644
> --- a/drivers/s390/crypto/Makefile
> +++ b/drivers/s390/crypto/Makefile
> @@ -34,5 +34,5 @@ pkey-uv-objs := pkey_uv.o
>   obj-$(CONFIG_PKEY_UV) += pkey-uv.o
>   
>   # adjunct processor matrix
> -vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o
> +vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o vfio_ap_migration.o
>   obj-$(CONFIG_VFIO_AP) += vfio_ap.o
> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
> new file mode 100644
> index 000000000000..374d3a67cb21
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Drives vfio_ap mdev migration.
> + *
> + * Copyright IBM Corp. 2025
> + */
> +#include "vfio_ap_private.h"
> +
> +/* Magic number and version for the vfio_ap_config migration blob */
> +#define VFIO_AP_MIG_MAGIC			0x76666170U  /* "vfap" */
> +#define VFIO_AP_MIG_VERSION			1U
> +
> +/**
> + * struct vfio_ap_migration_file
> + *
> + * This object is used for chunk processing of multiple reads and writes of
> + * AP configuration information.
> + *
> + * @filp:	file stream used to read or write AP configuration data
> + * @ap_config:	object used to store AP configuration data between read or write
> + *		calls
> + * @config_sz:	the size (in bytes) of @ap_config
> + */
> +struct vfio_ap_migration_file {
> +	struct file		*filp;
> +	struct vfio_ap_config	*ap_config;
> +	unsigned long		config_sz;
> +};
> +
> +/**
> + * struct vfio_ap_migration_data:
> + *
> + * Manages the migration state for the VFIO device that maintains the AP
> + * configuration of the guest being migrated.
> + *
> + * @mig_state:		the current migration state
> + * @resuming_mig_file:	the object used to restore the state of the vfio-ap
> + *			device on the destination host.
> + * @stop_copy_mig_file:	the object used to store the AP configuration of the
> + *			source guest for transfer to the destination host.
> + */
> +struct vfio_ap_migration_data {
> +	enum vfio_device_mig_state	mig_state;
> +	struct vfio_ap_migration_file	resuming_mig_file;
> +	struct vfio_ap_migration_file	stop_copy_mig_file;
> +};
> +
> +/**
> + * struct vfio_ap_queue_info - the information for an AP queue
> + *
> + * @data: contains the queue information returned in GR2 from the PQAP(TAPQ)
> + *	  command
> + * @apqn: the APQN of the queue
> + * @reserved: padding to ensure consistent structure size across platforms
> + */
> +struct vfio_ap_queue_info {
> +	u64 data;
> +	u16 apqn;
> +	u8  reserved[6];
> +};
> +
> +/**
> + * struct vfio_ap_config:
> + *
> + * Stores the state of a guest's AP configuration.
> + *
> + * VFIO device migration state transition from STOP to STOP_COPY:
> + * -------------------------------------------------------------
> + * When the migration state transitions from STOP to STOP_COPY, the vfio_ap device
> + * driver will open a file stream in read-only mode and return the fd to userspace.
> + * This fd is used during the STOP_COPY phase to read the current state of the
> + * vfio-ap device on the source host. In response, the driver will store the
> + * source guest's AP configuration data in a vfio_ap_config object and copy it to
> + * userspace.
> + *
> + * VFIO device migration state transition from STOP to RESUMING:
> + * ------------------------------------------------------------
> + * When the VFIO migration state transitions from STOP to RESUMING,
> + * the vfio_ap device driver will open a file stream in write-only mode and
> + * return the fd to userspace. This fd is used during the RESUMING phase to
> + * write the source guest's vfio_ap_config data that was read in during the
> + * STOP_COPY phase to the vfio_ap device driver on the destination host. In
> + * response, the device driver will copy the data sent from userspace to a
> + * vfio_ap_config instance which is then used to update the destination guest's
> + * AP configuration.
> + *
> + * Since the source and destination hosts may be running different versions of
> + * the linux kernel, the vfio_ap_config object provides two fields (@magic and
> + * @version) which must be set by the source device driver and verified by the
> + * destination device driver to ensure the migration ABI of the source and
> + * destination hosts are compatible.
> + *
> + * Note: Since a guest's AP configuration could be comprise of a large number of

Typo. I think you wanted 'comprised' here.

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

