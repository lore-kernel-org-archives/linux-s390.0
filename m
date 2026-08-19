Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F349218C;
	Wed, 19 Aug 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161817; cv=none; b=MWFcZ7TyDdK5vaMr00yJ+8Tja2N5chOkAd9FOUpu9VyajEDDqranWFDo8xAhOVLYInHbjaEx8cDOhuvzN482uOxJ0uwgkVs5ffKojDn+03LWo/N0XN5xMKhBXyOxfymy0dIX2LnrWEuOabG01bnOoFzoNRpAmkZozE2QHdzJx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161817; c=relaxed/simple;
	bh=ENj6lWXtNQFPtaLkxj4yZGX6Fl1DfwmaHHMkY2thZWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io3NSDAcb2GMNnhp8Aa1qUusG1xBuDqbEa/2JyFGyiS0jD4hzXgAwFeMKsiPBmgi/HD81E+gccIt4St4SyFTxOoDw/0lrDztyLggQtnx38ycnVg3imRkz/Rlalg2gfuZQasmQL/4Tym4qx/HTzZHsSXjqYzmF+Hqsk9lUf0wAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mh8SWsXZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mh8SWsXZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1fxT3838596;
	Wed, 19 Aug 2026 17:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7py10z
	vULZhPS38qmXt0Mu5SEU/c7RMqWAZfzg2704s=; b=Mh8SWsXZ7FX5T5bohjEUUT
	yR5ahW21bqmIt4Ipt5HSgonORnkxE9UecRnrFTpEhi3yI0TWG2WzVrZNiwgfHkuz
	YSIGlaIjWxcH350BePbPmD1JFEnbKeL62Z6l2lNm8qyEjqc549HMonqHbfoLPcit
	lA5q9oqT98KxYXCkKLf4u9ShZbnNOmiS3ADkSV3tsrH6ilNAJ8+uSYid0K44ub2a
	YRtfxv+SDBre6CJwLqfP3c5/k73l/81rLAPnPKTXenlA6VWfL8nOCPBajsyFmnGP
	tL6CA58ixKJQRnJ0HQWotNJ18FlYWTmOQLLjnNMBF1Z81J1IZAHe+VVeNIcnmiSQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu458b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:50:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHfHWu029207;
	Wed, 19 Aug 2026 17:50:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yhxaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:50:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JHo2wm5702296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 17:50:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48F4E5805E;
	Wed, 19 Aug 2026 17:50:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5497C5805F;
	Wed, 19 Aug 2026 17:50:01 +0000 (GMT)
Received: from [9.61.88.99] (unknown [9.61.88.99])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 17:50:01 +0000 (GMT)
Message-ID: <dc3a7703-b4a9-4a7f-9078-f6f874962abf@linux.ibm.com>
Date: Wed, 19 Aug 2026 13:49:13 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/15] s390/vfio-ap: File ops called to resume the vfio
 device migration
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-11-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a85ecce cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ObZecPCjnUXit1mtK18A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S9VgNezJkCL7LUAmFQwgDpi2YMQae5DV
X-Proofpoint-GUID: S9VgNezJkCL7LUAmFQwgDpi2YMQae5DV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfX4h6UPz26yIX/
 jTlUpLcuVYK31OoQm/o0wV9aLG0un0uMOti9TXrII8FBrZHxau0uiVN37c3GDAwevDy2KrW76dt
 zhDENlDB4BkpeDdeTRcEAk6Kq7DLN5s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfX8tzgmqXgh4Y1
 ejqQbYiZgOaNpFhS0Yel0IVCpUaFjKEFCuID9qwKQuKEHmaN8UIg4RPU5NuWtef+MV5eexg8Kzh
 cJXV+Ww8zAtGQA8GJuC4p+ImZ/bqkAN3NXCzBMUzeowWwUazoRRFbIMHNjQVpNoUwFI18ps8H/3
 /wHBUYlda5mAmQfbKerjwJbW4Lfdm5BLHrUDBWFzeLKioyqevh8lTZqHB+C+r8QVyF6xvZes/+Q
 2ZOrOfVOukh+D4K4NHLV0H6Gc8wH61gtKIFFqv1+mdUu9jUJ1EZ58I8wV4IhqgjW6zOxY9qja8f
 bTHwahStxeh3+NNRWCcQ+f4bMcPKMGo4Qef0D/TKEYxrypuAmQpZQCrBCSdNL+xEpA4kDL8cS79
 X1wQHCebnoyrTT4vgG0J0wuvEYaJi6ITjLcKhc2JxDNzIP6bQ3Q+WvFhaoIfCu+eqkHiOx9lHgk
 Yj9c39R5xMB3eEYcW3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190136



On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> Implements the 'write' callback function that was added to the
> 'file_operations' structure for the file stream created to restore the
> state of the vfio-ap device on the destination system when the migration
> state transitioned from STOP to RESUMING
> 
> The write callback retrieves the vfio device migration state saved to the
> file stream created when the vfio device state was transitioned from
> STOP to STOP_COPY. The saved state contains the source guest's AP
> configuration information. This data is copied from the userspace buffer
> passed to the 'write' callback and stored in the vfio_ap_config structure
> used to set the state of the vfio-ap device on the destination host. If the
> source guest's AP configuration is compatible with the AP configuration on
> the destination host, it will be hot plugged into the destination guest.
> 
> In order for the source guest's and destination host's AP configurations
> to be considered compatible:
> 
> * Each APQN in the source guest's AP configuration must also be in the
>    destination host's AP configuration
> 
> * Each matching APQN in the destination host's AP configuration must be
>    bound to the vfio_ap device driver
> 
> * Each matching APQN in the destination host's AP configuration must
>    reference a queue device with compatible hardware:
> 
>    - The source and destination queues must have the same facilities
>      installed:
>      ~ APSC facility
>      ~ APQKM facility
>      ~ AP4KC facility
> 
>    - The source and destination queues must have the same mode:
>      ~ Coprocessor-mode
>      ~ Accelerator-mode
>      ~ XCP-mode
> 
>    - The source and destination queues must have the same APXA facility
>      setting
>      ~ If the APXA facility is installed on source queue, it must also
>        be installed on the destination queue and vice versa
> 
>    - The source and destination queues must have a compatible
>      classification setting. If the source queue has full native card
>      function, then the destination queue must also have full native
>      card function. If the source queue has stateless functions, then
>      the destination queue can have stateless functions or full native card
>      function because the latter includes the stateless functions.
> 
>    - The binding and associated state for both the source and destination
>      queues must indicate that the queue is usable for all messages
>      (i.e., BS bits equal to 00).
> 
>    - The AP type of the destination queue must be the same as or newer than
>      the source queue (backward compatibility)
> 
> Note: The get_hardware_info_for_queue function that was created in
>        a previous patch was modified to take a mediated device name rather
>        than an ap_matrix_mdev object because that is what is needed for
>        this patch so the function can be executed without holding the
>        matrix_dev->mdevs_lock.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_migration.c | 1009 ++++++++++++++++++++++-
>   1 file changed, 1001 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
> index e2e7ae8515e5..4dd7373c3d9d 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> ...
>   static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>   				      size_t len, loff_t *pos)
>   {
> -	/* TODO */
> -	return -EOPNOTSUPP;
> +	struct vfio_ap_config_buffer *resuming_config_buf;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	struct vfio_ap_config *ap_config;
> +	bool new_allocation = false;
> +	ssize_t ret, cfg_sz;
> +	loff_t write_pos;
> +	size_t write_len;
> +
> +	/*
> +	 * This file was opened with stream_open(), so pos should be NULL for
> +	 * sequential write() calls; a non-NULL pointer will be passed only
> +	 * for positional pwrite() calls in which case we return an error
> +	 * indicating broken pipe/illegal seek on a non-seekable file
> +	 */
> +	if (pos)
> +		return -ESPIPE;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	pos = &filp->f_pos;
> +
> +	ret = validate_resuming_write_parms(filp, len, pos);
> +	if (ret) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return ret;
> +	}
> +
> +	matrix_mdev = filp->private_data;
> +	matrix_mdev->mig_data->write_in_progress = true;
> +	resuming_config_buf = &matrix_mdev->mig_data->resuming_config_buf;
> +
> +	/*
> +	 * If we have not yet filled the vfio_ap_config_buffer, then we need
> +	 * to continue filling it with data sent from userspace.
> +	 */
> +	if (!resuming_config_buf->filled) {
> +		ret = fill_resuming_config_buffer(resuming_config_buf, buf, len,
> +						  *pos);
> +		if (ret) {
> +			matrix_mdev->mig_data->write_in_progress = false;
> +			mutex_unlock(&matrix_dev->mdevs_lock);
> +			return ret;
> +		}
> +
> +		/*
> +		 * If the vfio_ap_config_buffer is not yet filled, we don't
> +		 * yet have enough data to allocate the vfio_ap_config instance;
> +		 * otherwise, go ahead and allocate it.
> +		 */
> +		if (!resuming_config_buf->filled) {
> +			*pos += len;
> +			matrix_mdev->mig_data->write_in_progress = false;
> +			mutex_unlock(&matrix_dev->mdevs_lock);
> +			return len;
> +		}
> +
> +		ret = allocate_ap_config(resuming_config_buf, &ap_config);
> +		if (ret < 0) {
> +			matrix_mdev->mig_data->write_in_progress = false;
> +			mutex_unlock(&matrix_dev->mdevs_lock);
> +			return ret;
> +		}
> +
> +		new_allocation = true;
> +		cfg_sz = ret;
> +	}
> +
> +	/*
> +	 * If this is not a new allocation of the vfio_ap_config object,
> +	 * then create a copy of it so we can continue filling it in via
> +	 * the copy_from_user() while the mdevs_lock is dropped.
> +	 */
> +	if (!new_allocation) {
> +		cfg_sz = matrix_mdev->mig_data->resuming_mig_file.config_sz;
> +		ap_config = kvzalloc(cfg_sz, GFP_KERNEL_ACCOUNT);
> +
> +		if (!ap_config) {
> +			matrix_mdev->mig_data->write_in_progress = false;
> +			mutex_unlock(&matrix_dev->mdevs_lock);
> +			return -ENOMEM;
> +		}
> +
> +		memcpy(ap_config,
> +		       matrix_mdev->mig_data->resuming_mig_file.ap_config, cfg_sz);
> +	}
> +
> +	/*
> +	 * If ap_config is a new allocation, then the contents of the
> +	 * 'magic', 'version' and 'num_queues' fields will already have
> +	 * been copied in; so the write_pos must be set to the location
> +	 * following the 'num_queues' field and the length to be written must be
> +	 * adjusted accordingly.
> +	 */
> +	if (new_allocation) {
> +		size_t nbytes_already_copied = VFIO_AP_CONFIG_BUF_SIZE - *pos;
> +
> +		write_pos = VFIO_AP_CONFIG_BUF_SIZE;
> +		write_len = len - nbytes_already_copied;
> +		buf += nbytes_already_copied;
> +	} else {
> +		write_pos = *pos;
> +		write_len = len;
> +	}
> +
> +	*pos += len;
> +
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (copy_from_user((char *)ap_config + write_pos, buf, write_len)) {
> +		if (new_allocation)
> +			kvfree(ap_config);
> +		ret = -EFAULT;
> +		goto out_clear_write_in_progress;
> +	}
> +
> +	/* Check if we've completed writing the entire configuration */
> +	if (write_pos + write_len == cfg_sz) {
> +		ret = do_post_copy_processing(matrix_mdev, ap_config);
> +
> +		if (ret) {
> +			kvfree(ap_config);
> +			goto out_clear_write_in_progress;
> +		}
> +	}
> +
> +	ret = set_new_ap_configuration(matrix_mdev, ap_config, cfg_sz);
> +	if (ret) {
> +		kvfree(ap_config);
> +		goto out_clear_write_in_progress;
> +	}
> +
> +	/*
> +	 * If this is not a new allocation of vfio_ap_config, then the contents
> +	 * of ap_config would have been copied into the existing object, so we
> +	 * can free it so we don't leak the storage.
> +	 */
> +	if (!new_allocation)
> +		kvfree(ap_config);
> +
> +	ret = len;
> +
> +out_clear_write_in_progress:
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	if (matrix_mdev->mig_data)
> +		matrix_mdev->mig_data->write_in_progress = false;
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	return ret;
>   }
>   
>   static const struct file_operations vfio_ap_resume_fops = {

Why can't vfio_ap_resuming_write() just copy the data it is given into a 
buffer, remembering the next position to write and then exit if the 
buffer is not full? If the buffer is full then it can then process that 
buffer. Whatever is happening here seems very convoluted.

The AP config for a guest is pretty small. At most it will be 16 bytes * 
64k queues = 1 MB. Allocating a max buffer up front would be a 
reasonable thing to do, in my opinion. Even if we don't,  I feel like 
this code could be simplified quite a bit.

I'm imagining an algorithm similar to the this:

read_data();
if (not have_all_data):
     return;
post_process_data();

