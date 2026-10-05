Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE74C33EC;
	Mon,  5 Oct 2026 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213492; cv=none; b=dpbUw0fn+RWsD87Cc/apg8Gyj323CMvhHQWhvqV/XFXtcO437bHXeYL06RyXFJcsSGY/2+dRjgJ8GH4iYrgEqqDlPqcNhrdmVwkOQB0oORMd+kI/Vj1Ywqz/f70siP4+mNldE7ezfZWlJ/ldMeHFzDE5LglhB1LYrE9bKwTrTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213492; c=relaxed/simple;
	bh=Jm4aLG3gcpRIf1LQ2iNa975BPCXs2HJoJaAFOiE4ABo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXjkX07dxpRsJzLjwXGvHoCXFnYHXjR/sIl+KlGOox7Bois3C9+358gYUspflJR+JoGuJnqa2ctP9MFfjEFzCH6/5UzVjTW0oGeOghWweKdWINBjtEm5yvZjzkhLbx7Fcghj6xsrnuEWsU59DMABYSOQB5Z6dOtKCg2qTEeoNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E4oJPv/b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E4oJPv/b"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EZcYe756380;
	Mon, 5 Oct 2026 15:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+lZqYL
	im6GgdQX3w1CPozjK91hBLHlv5RTBKE+yHCus=; b=E4oJPv/bhShauXWNJmNigR
	3npwBq9xAuWOgWck/xXpVn2oIocW/q2FC47mp90vt+PGb2NFIN4z8xdfbKXjIEQ9
	hTjY2C43cH/OlA2nJHu6At5eXEquBpiLD3/x4MlJvEfqNMepA37xapvhroo1FLAz
	U1E0l8AyBhAt7ITuo1d0VX+T3VhwKabtRwEpTbLNdKMlHLm+iHLEOn89KpeDP7Qv
	T0kkRM7dZAkT5+n4SRCuJ0+qD+iUVUqM3xlMnBTCUC4TcVAA2nxCs5h2vVrVw7Fl
	ru9lJ1OtjwBRBfcBJN2F9DKAH5P4SlVrQnY+nBBCSXhaXGb3tUgCJVthxaLtU2lw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jjmjn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:18:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695EWUoG3092275;
	Mon, 5 Oct 2026 15:18:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgnwry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:18:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695FI2Rg7799556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 15:18:03 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E316F5805A;
	Mon,  5 Oct 2026 15:18:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 504E158054;
	Mon,  5 Oct 2026 15:18:01 +0000 (GMT)
Received: from [9.61.34.243] (unknown [9.61.34.243])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 15:18:01 +0000 (GMT)
Message-ID: <03a49243-cf6c-4aae-9a94-0deb497e869d@linux.ibm.com>
Date: Mon, 5 Oct 2026 11:18:00 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-3-akrowiak@linux.ibm.com>
 <5a18d610-d943-4bc5-bb50-0a4ff037f6b3@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <5a18d610-d943-4bc5-bb50-0a4ff037f6b3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7b7hq0TtGXU9yGNmWfD4JWb6Z54a6W1O
X-Proofpoint-GUID: 7b7hq0TtGXU9yGNmWfD4JWb6Z54a6W1O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1OSBTYWx0ZWRfX11OiremwUruS
 4AoQJJiXznhknIgHNTzSsYK5J9wt/55pQ2M8fVbaUyPiouO8I3oJnmo4UdrUB6HSicngAM/tYwm
 CiyFJEX9w+purvccbnwjDbvEu9Eyrmw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1OSBTYWx0ZWRfX20CXwd3206eE
 PUx7p5GB52qiaQrwa4R+QOBFzwZcBvhyhyKgE7Wt4uOMBmSr+avxTpiy+ajw9hubal5RTZ7uYjd
 0HNaHg0UtiN0O2+5E+zSI/w1m8OiPLiY61syFflrlGzHwKv4gA3eiPUmPXc3iM4yWEAP9UcmXds
 sXVQ0zA5TTdOWj9BKGzJgmuomiBpRIYhw4NPxuer8OsYY97W1i+3rtWY78w/y6PgvY01RR0iau4
 OEyMxLBQ+N2NbXHVoKavJJ4UWZYrls8dpZx5WznIpAR7kMjoGFtZqQ8XSD5bCIosKYkU/oi/2JM
 YH366faj+Iv68TsSX2z2VEoNMveASU+pkqrGqEqj3dU29MXnzWAjF4INREFv5GVmGO7/RXyVw1/
 plwiXVC1r7WDpPv9Xh4BK0B5Yr6xdHFq5MVpBAGZKuElacXSi79RAsIPPJMnsU8l8snbMMF+vRj
 DLcJP8zNR9Bg2aEKNdw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac3bfac cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=7DrxliqlWOFhgiiUTFoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050059



On 8/10/26 9:45 AM, Jason J. Herne wrote:
>
>
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> Creates the data structures used to facilitate state transitions during
>> vfio device migration.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/Makefile            |   2 +-
>>   drivers/s390/crypto/vfio_ap_migration.c | 113 ++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h   |   5 ++
>>   3 files changed, 119 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_migration.c
>>
>> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
>> index e83c6603c858..20f29184825a 100644
>> --- a/drivers/s390/crypto/Makefile
>> +++ b/drivers/s390/crypto/Makefile
>> @@ -34,5 +34,5 @@ pkey-uv-objs := pkey_uv.o
>>   obj-$(CONFIG_PKEY_UV) += pkey-uv.o
>>     # adjunct processor matrix
>> -vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o
>> +vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o vfio_ap_migration.o
>>   obj-$(CONFIG_VFIO_AP) += vfio_ap.o
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c 
>> b/drivers/s390/crypto/vfio_ap_migration.c
>> new file mode 100644
>> index 000000000000..374d3a67cb21
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -0,0 +1,113 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Drives vfio_ap mdev migration.
>> + *
>> + * Copyright IBM Corp. 2025
>> + */
>> +#include "vfio_ap_private.h"
>> +
>> +/* Magic number and version for the vfio_ap_config migration blob */
>> +#define VFIO_AP_MIG_MAGIC            0x76666170U  /* "vfap" */
>> +#define VFIO_AP_MIG_VERSION            1U
>> +
>> +/**
>> + * struct vfio_ap_migration_file
>> + *
>> + * This object is used for chunk processing of multiple reads and 
>> writes of
>> + * AP configuration information.
>> + *
>> + * @filp:    file stream used to read or write AP configuration data
>> + * @ap_config:    object used to store AP configuration data between 
>> read or write
>> + *        calls
>> + * @config_sz:    the size (in bytes) of @ap_config
>> + */
>> +struct vfio_ap_migration_file {
>> +    struct file        *filp;
>> +    struct vfio_ap_config    *ap_config;
>> +    unsigned long        config_sz;
>> +};
>> +
>> +/**
>> + * struct vfio_ap_migration_data:
>> + *
>> + * Manages the migration state for the VFIO device that maintains 
>> the AP
>> + * configuration of the guest being migrated.
>> + *
>> + * @mig_state:        the current migration state
>> + * @resuming_mig_file:    the object used to restore the state of 
>> the vfio-ap
>> + *            device on the destination host.
>> + * @stop_copy_mig_file:    the object used to store the AP 
>> configuration of the
>> + *            source guest for transfer to the destination host.
>> + */
>> +struct vfio_ap_migration_data {
>> +    enum vfio_device_mig_state    mig_state;
>> +    struct vfio_ap_migration_file    resuming_mig_file;
>> +    struct vfio_ap_migration_file    stop_copy_mig_file;
>> +};
>> +
>> +/**
>> + * struct vfio_ap_queue_info - the information for an AP queue
>> + *
>> + * @data: contains the queue information returned in GR2 from the 
>> PQAP(TAPQ)
>> + *      command
>> + * @apqn: the APQN of the queue
>> + * @reserved: padding to ensure consistent structure size across 
>> platforms
>> + */
>> +struct vfio_ap_queue_info {
>> +    u64 data;
>> +    u16 apqn;
>> +    u8  reserved[6];
>> +};
>> +
>> +/**
>> + * struct vfio_ap_config:
>> + *
>> + * Stores the state of a guest's AP configuration.
>> + *
>> + * VFIO device migration state transition from STOP to STOP_COPY:
>> + * -------------------------------------------------------------
>> + * When the migration state transitions from STOP to STOP_COPY, the 
>> vfio_ap device
>> + * driver will open a file stream in read-only mode and return the 
>> fd to userspace.
>> + * This fd is used during the STOP_COPY phase to read the current 
>> state of the
>> + * vfio-ap device on the source host. In response, the driver will 
>> store the
>> + * source guest's AP configuration data in a vfio_ap_config object 
>> and copy it to
>> + * userspace.
>> + *
>> + * VFIO device migration state transition from STOP to RESUMING:
>> + * ------------------------------------------------------------
>> + * When the VFIO migration state transitions from STOP to RESUMING,
>> + * the vfio_ap device driver will open a file stream in write-only 
>> mode and
>> + * return the fd to userspace. This fd is used during the RESUMING 
>> phase to
>> + * write the source guest's vfio_ap_config data that was read in 
>> during the
>> + * STOP_COPY phase to the vfio_ap device driver on the destination 
>> host. In
>> + * response, the device driver will copy the data sent from 
>> userspace to a
>> + * vfio_ap_config instance which is then used to update the 
>> destination guest's
>> + * AP configuration.
>> + *
>> + * Since the source and destination hosts may be running different 
>> versions of
>> + * the linux kernel, the vfio_ap_config object provides two fields 
>> (@magic and
>> + * @version) which must be set by the source device driver and 
>> verified by the
>> + * destination device driver to ensure the migration ABI of the 
>> source and
>> + * destination hosts are compatible.
>> + *
>> + * Note: Since a guest's AP configuration could be comprise of a 
>> large number of
>
> Typo. I think you wanted 'comprised' here.

I did, thanks.

>
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>

