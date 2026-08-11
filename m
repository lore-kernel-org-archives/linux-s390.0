Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4D471437;
	Thu, 13 Aug 2026 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622118; cv=none; b=QhiQh/39MRCuHTSfC1UDGuEdElNQZ6a+/XRs2qbUSm/IJBxWY3iOWTGQiDn3rg0+a2po5WRVKV6LopQzpWizXZjKbk9K/q4l22oCRiC0R1j/1JbF9VeLzvDSZ4IIqiKkQc6NHwZQI1T/tUNC54bm4mzAIOAnkt0F0NI4wv7aSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622118; c=relaxed/simple;
	bh=7BxzqjCC5SOvxz30KZlRucl1lBB26D8z2vgmULpOZMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNbmj4ddn82CHvYJ5nWKsJrZdICII6iavk52g6DAhTu+PXQTI//9mF/D/digzP1Dy8FYTeHDKlc2EYvIREPv1j5bOezXhzXLgM69YYNFE8QHMfehPjQFLJagSN7s7OtrEvoK4p8Cf1EjMBZQWIhbhDSpIbHkygoyM9jZlO/ZG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eqRP94AX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eqRP94AX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D99Ons811920;
	Thu, 13 Aug 2026 11:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fhzLtV
	iCXvCT3SpLx/DkG5rRbNPv5Yyqv1kDkkodezc=; b=eqRP94AXCDPRWdIwM41DlF
	TP6WwvST1QVjduBCojr2Px23kmcwDZeKHoBlTTvhqAVUBnLKfVO/ps8YOxhQa4Wu
	daVPImv2BDZqIpsvrRj2MB4aibPhjZaDr+8myPSfm2s1Y+Orp14t9QZKAUOVTNtN
	vxP7sB8QTZF/LH3Rz24ROJGMsJfSVZMiOQUR3acECJPOytD06zQrjB2KmZtZr2xp
	NqyGWysSNnKnJYvDmm4zklMudAWeJ2SFQSe/bVjX3pjV7inl3Vjm7XKy9rssLJXm
	nBYI7nVWDRlEkCXWkQboBwI9Eg90asBEs2Z7GrNxe4hzc9bg2leP3qfFO6o4iyXw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb2402kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:55:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DBfG3T030517;
	Thu, 13 Aug 2026 11:55:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gjqs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:55:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DBt7Ax27394734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:55:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E217A58050;
	Thu, 13 Aug 2026 11:55:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6073E58045;
	Thu, 13 Aug 2026 11:55:06 +0000 (GMT)
Received: from [9.61.3.203] (unknown [9.61.3.203])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 11:55:06 +0000 (GMT)
Message-ID: <46194cc6-b5de-4f03-abb0-927b6c72960e@linux.ibm.com>
Date: Tue, 11 Aug 2026 09:57:26 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-4-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7db09e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=-sUVcY9UDplZPLypd4sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfX6JbACF1U6ArZ
 WoZSNBfdFU/2zfvUn2K382bxVVKvh5/yBgds2HaGBYMOLScSXTsQK40V7OJkP/W6ojjd5bEKbRv
 V/Owkc5OmYJa7hTfF3ToWCqLAiZP+CapPV8c682QitnRWt10w2yqLBiF3CBI+zgxMSnVyKSR9Y1
 dpDkUPx1J82gBf0uCBxractHI0jZQIgp/1PfSL5G0JOGQfBY4/Z6uaPnHZlK9Jp+AQCPmIsLGQl
 dbToPOmanMizaqzEKW9mtWpii078dqUS2LGaoPkgRO3JxhRXvsRj9F+sm/lSf7+U+l/pf7HhzeM
 uBFxriZCNaZi7PNXUfmuntDK1Vf750n9UMwo+BP39sbEMIJo6oQs9KpPLJGQCAGFCvlkToB1wvB
 wRWT+JYn7YUz9NgWL0GvepZ8xLabJcDvdfL2FH3Eix33zW8i35MXr85Rk+ceEtlCxTmHY1Y97Qs
 My2yCU7El3mV0JtyIxQ==
X-Proofpoint-ORIG-GUID: M7Xc-D5YRWEFfBmzgwiqROV3wCvHzBYz
X-Proofpoint-GUID: M7Xc-D5YRWEFfBmzgwiqROV3wCvHzBYz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfX/qd87HUaRyR7
 Gb7YH1mMw2kP2jCWD/3edkhZPivzwE6PuY6Mk/OUqCchBPKoCXIOcQ33jkLkSt73h6Em0FQH8ZO
 awFTildTwZ7TcjLp8N2kKGta7F5JfrI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130081

On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> Provides the functions that initialize and release the data structures
> used during live guest migration:
> 
> ...
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_migration.c | 127 ++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_ops.c       |  64 ++++++++++--
>   drivers/s390/crypto/vfio_ap_private.h   |   4 +
>   3 files changed, 187 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
> index 374d3a67cb21..cf303d228a0a 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -4,6 +4,7 @@
>    *
>    * Copyright IBM Corp. 2025
>    */
> +#include <linux/file.h>
>   #include "vfio_ap_private.h"
>   
>   /* Magic number and version for the vfio_ap_config migration blob */
> @@ -111,3 +112,129 @@ struct vfio_ap_config {
>   	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
>   	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>   };
> +
> +static void
> +vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
> +{
> +	/* Stub to be implemented when the mig_data->stop_copy_mig_file.ap_config
> +	 * object is allocated.
> +	 */
> +}
> +
> +static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
> +{
> +	/* Stub to be implemented when the mig_data->resuming_mig_file.ap_config
> +	 * object is allocated.
> +	 */
> +}
> +
> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
> +				      enum vfio_device_mig_state  new_state)
> +{
> +	return NULL;
> +}
> +
> +static int vfio_ap_get_state(struct vfio_device *vdev,
> +			     enum vfio_device_mig_state  *current_state)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int vfio_ap_get_data_size(struct vfio_device *vdev,
> +				 unsigned long *stop_copy_length)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct vfio_migration_ops vfio_ap_migration_ops = {
> +	.migration_set_state = vfio_ap_set_state,
> +	.migration_get_state = vfio_ap_get_state,
> +	.migration_get_data_size = vfio_ap_get_data_size,
> +};
> +
> +/**
> + * vfio_ap_init_migrations_capabilities - initialize migration capabilities

typo: vfio_ap_init_migration s _capabilities

> + *
> + * @matrix_mdev: pointer to object containing the mdev state
> + */
> +void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	if (ap_is_se_guest())
> +		return;
> +
> +	matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
> +	matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
> +}
> +
> +/**
> + * vfio_ap_init_migration_data - initialize migration data and functions
> + *
> + * @matrix_mdev: pointer to object containing the mdev state
> + *
> + * Return: zero if initialization is successful; otherwise, returns a error.
> + */
> +int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	mig_data = kzalloc_obj(struct vfio_ap_migration_data, GFP_KERNEL);
> +	if (!mig_data)
> +		return -ENOMEM;
> +
> +	mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
> +	matrix_mdev->mig_data = mig_data;
> +
> +	return 0;
> +}
> +
> +/**
> + * vfio_ap_release_mig_files:
> + *
> + * Free the ap_config buffers for any open migration FDs. Although a
> + * migration FD may still be held open by userspace, it is safe to free
> + * mig_data here because:
> + *
> + *   1. matrix_mdev remains valid for the lifetime of any open migration
> + *      FD via the vfio_device registration reference taken in
> + *      vfio_ap_open_file_stream() and dropped in
> + *      vfio_ap_release_mig_file().
> + *
> + *   2. mig_data is only accessed by the migration file ops
> + *      (vfio_ap_stop_copy_read, vfio_ap_resuming_write) under
> + *      mdevs_lock. Once mig_data is set to NULL by the caller, those
> + *      paths will see NULL and return -ENODEV before dereferencing it.
> + *
> + * @matrix_mdev: The object used to maintain the state for a mediated device
> + */
> +static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	mig_data = matrix_mdev->mig_data;
> +	if (!mig_data)
> +		return;

Both callers already perform the above check under lock. This one seems 
redundant.

> +	vfio_ap_release_stop_copy_file(mig_data);
> +	vfio_ap_release_resuming_file(mig_data);
> +}
> +
> +/**
> + * vfio_ap_release_migration_data: reclaim private migration data
> + *
> + * @vdev: pointer to the mdev
> + */
