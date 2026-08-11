Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87873474248;
	Thu, 13 Aug 2026 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622119; cv=none; b=AzofrdjcuQcD6v1uMjmtxACO4iyxahDXkr6B1VwR5I/sFEXUi9Sb46dYREOn0b/KqtCQdqmD47hJufhoxriI5Yj3eLR1u8Nh1iuxvHlu65v6fyn0/FUlpju/KXQvAL4JT8sHAHRcUaa8+wLUnPogS3leSIbCdLpiIqWdt6ofzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622119; c=relaxed/simple;
	bh=d37V1PxzHBSfgf0hkF/YE3KfJRsMai7yDBUv+ukkrUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRucubsG+g1sCffySGUuJWkO9hC52v4b06oHb9ZJipgjjVk0EU370hLYfO7Gpp+lgLr3hKvsgfikw79vTRo6nqZsgBPQP0UBjg2NkX5+wqcy6yoSLwUbb3/DTnM918Xlj5XjMHf88CXacjMLLk0B7lj/6OP7zznLFILJw86S/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bq3hQWwP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bq3hQWwP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D9934C1865925;
	Thu, 13 Aug 2026 11:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AWFzoe
	YIDI0llFQuCsBpdh2TAWfwHFk+bi9axTdZPng=; b=bq3hQWwPi8t5Fg3RMH13NG
	5mbFuiR6AJrdJQ03mUd5GBPBW38jy4uieC2JyLiY5tCHsB+G8nUkWRCOzCDLkbie
	rnRYXshRelsEU0xjLURd9pvWZfqpZgTZiVMr1DQY8f0OOfo2s58ucOvsJpUXpsH7
	fuM03suhEGb3NDOTq7a3qtA5E1uE3rznJit2Kb7FSTzJxpCklX1ZLhsqcirAL2m/
	TBgq8/AkflIuA9AexlWqTV7lYHNYwp13RI7v0vnmLIXkK4yxvAEj1iZSZfogUxDS
	RKo3lh9/kLuK51haNHbChgyAqornwfuep3PN4v05lcsE3vtOBUXR5En8sUUb+40A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9qnvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:55:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DBfL2b017670;
	Thu, 13 Aug 2026 11:55:10 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hat1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:55:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DBt9jE54788500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:55:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4AE758054;
	Thu, 13 Aug 2026 11:55:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DBD258050;
	Thu, 13 Aug 2026 11:55:08 +0000 (GMT)
Received: from [9.61.3.203] (unknown [9.61.3.203])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 11:55:08 +0000 (GMT)
Message-ID: <d3c453ce-6e9f-4c1b-aef7-8d1b1f1be46e@linux.ibm.com>
Date: Tue, 11 Aug 2026 13:05:35 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/15] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-5-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aptbzrJAPJmpGRpS3aa1iPjwvHCQ2T3O
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7db0a0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=coQzJRR7ZUmZXtf9PiAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfX1GAyKuynwxRd
 a5dCzMWDFBNFi7l/A64EPsMorqArkVhR1rEy+kdVOMzWzdFBzczwpinYltPN3diRP6lHGcPbQhx
 2Sk3K9uyOmO6tbe7dkeBj/12JVi1Uzpi2yn2cQKZfPobfKp6gkeAkYslDGeYaQU1YfMLdNNIK+Y
 p/nCE5R/QrhS2ZZ4FhvI/OQNrWOwx7ZzktboUEWEAQs3XLO1jd1r+HpzBbkvPuLXo7uRmBoguJw
 erU5PZauui17RkgQzIST6y7OSbBRiYztaYBSq19HSbA5MWU5GDPnPs5rCIC7yY+X04Kj7oFfjAy
 GQiETVZ+GZP0VFGybh6fmBh9vJ7bBhp2ydq+/A7NOK+z4RvUylKKCCpPaiuAtS2lsLd7/Hd2kWI
 SWOJqhef5/GiKuGs41PMf9iMU5VagUBk75M+BpfLCk5R9XKZScZ40oEAEm7TGTtACzMHj5cFGuf
 9SPW5TfqjNk0uiUNyfw==
X-Proofpoint-ORIG-GUID: aptbzrJAPJmpGRpS3aa1iPjwvHCQ2T3O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfX5OD1KOlv/ksk
 bGUQ4RZN1gsEV8Uc+gUBgA9aAO+koNLdVHf9HfaWC5SHwveXXDgl8HKLBZbSLJnoQxiqJISzs/A
 uoPE5QDJW/aJsNDhexxOvSVvwHHqNyI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130081



On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> According to the VFIO migration specifications, userspace must issue a
> VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
> state transition to recover the device and return its migration state to
> RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RESET
> is issued that releases the migration files and frees the storage allocated
> for maintaining the migration state.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_migration.c | 20 ++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_ops.c       |  4 ++++
>   drivers/s390/crypto/vfio_ap_private.h   |  1 +
>   3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
> index cf303d228a0a..1613813124b6 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -238,3 +238,23 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
>   	kfree(matrix_mdev->mig_data);
>   	matrix_mdev->mig_data = NULL;
>   }
> +
> +/**
> + * vfio_ap_reset_migration_state - Reset the vfio-ap migration state
> + *
> + * @matrix_mdev: pointer to the object maintaining the vfio-ap device state
> + *
> + * Called during VFIO_DEVICE_RESET to clean up any active migration
> + * state and reset the device to RUNNING state as required by the VFIO
> + * migration specification.
> + */
> +void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	if (!matrix_mdev->mig_data)
> +		return;
> +
> +	vfio_ap_release_mig_files(matrix_mdev);
> +	matrix_mdev->mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
> +}
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 90b0fce0123b..d05372b50d2f 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2330,6 +2330,10 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
>   		break;
>   	case VFIO_DEVICE_RESET:
>   		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
> +		if (ret == 0) {
> +			/* Reset migration state per VFIO migration spec */
> +			vfio_ap_reset_migration_state(matrix_mdev);
> +		}
>   		break;

Why do we only reset migration state when vfio_ap_mdev() returns 0? Even 
if this call fails, we are in the VFIO_DEVICE_RESET path and we need to 
clean up the migration data, right? Or did I miss something?


>   	case VFIO_DEVICE_GET_IRQ_INFO:
>   		ret = vfio_ap_get_irq_info(arg);
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index a2a713f93674..1fbdfcce5a11 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -175,5 +175,6 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
>   void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev);
>   int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
>   void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
> +void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
>   
>   #endif /* _VFIO_AP_PRIVATE_H_ */

