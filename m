Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F642D2381;
	Wed,  7 Oct 2026 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403695; cv=none; b=tIoFQC/+StlA98M7EAtExY0mhHo4R4VNrCxuDh6z3qtXTv3USl71wpvByIayurlkEils0Dj8760dlgynlX/8M3xdKUtyOujzfnW0ALWLNxR+vtdx/o3IDadAFMP2Sr5CUnKobq44yGL4SDSprECMyDn6l8I/IHyVmEm/GcaVUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403695; c=relaxed/simple;
	bh=kJH+69InDl/8CsBSaYyFDb7vhFylBUDVhQ0zsCVp/Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6BrTAmKUrDF4CLEBzsl3tq67zk+OeUgP0a2wAWJY3Sf8YM+sg17e0yzvQO0N55K/uCSk7cMB1ZUsZvxGWhp0pOrGL3eF8ONtDyWOSdbZxOPAXk7bUdyexpm0RpxEb2NxzxT4Blk+M5egdXzOTY7q7sDYvTDQjBJTz5s8k4/hrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VyOMoiU+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VyOMoiU+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697IZelA2078379;
	Wed, 7 Oct 2026 20:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v2qEj/
	gs7xkvrdjVvyLvnauaDuM4FRQ3RNNjkn81lpc=; b=VyOMoiU+VdcPDQwoxLMoEQ
	egikhEoqkZeCJDJHxxuQsWplpH3t92dEXBmUrp7g+64a1zwL7UH1M2RZDecGPrIQ
	qHmPUBxi1/CEJn8TLX+dufbB0Hemex6Rgymov1o3DHtANIToDAFxS7hYFj1vw5Zs
	nDNkHQY8etKOtuwXn7dtlDWeKuJxEZ92PC9mTiipVlv6JJppui6u2coRh04QfSHE
	XTNWRGGbiAUXlVCTTApDZkKarD10PuGxdiezWlE3BtprztRBTFG638FhG6FNtptQ
	+VH/J2msQb401+4OQZ/kSnQlr3AasJNCnJrNX664BbBMIe1U3a0RvWfgGKIc7H0g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4g6t2s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 20:08:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697IHVGp2307737;
	Wed, 7 Oct 2026 20:08:12 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhh06h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 20:08:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697K8AJO65405188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 20:08:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 659AC58065;
	Wed,  7 Oct 2026 20:08:10 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F72758055;
	Wed,  7 Oct 2026 20:08:09 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 20:08:09 +0000 (GMT)
Message-ID: <8f7a957e-4448-4fcc-b1b4-8467a825e02a@linux.ibm.com>
Date: Wed, 7 Oct 2026 16:08:08 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/15] s390/vfio-ap: File ops called to resume the vfio
 device migration
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-11-akrowiak@linux.ibm.com>
 <20260807223030.D808E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260807223030.D808E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac6a6ac cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mk3SxhDi-9axmNQgaW0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4MCBTYWx0ZWRfXxcHkKvdPg+3r
 pmfHQ1JkVVcmNSq0pQxmNhBwG4QZxa4wmX/4hCvi7bYQ0B0fklXnAmg2FjZbTCp5mBfzCCpS4Cp
 wATNFIu0AkbWG5bMO377EmLkRTyYMCQIpFov+8sCTzZhAVMaQPzxqVK3TCayc+acLuiqFqh3gLG
 MLNo7dnJCAYjddWA5JjeI6iXXxQITj9Zx8gG+tbJ4+uaZiQEAgHft7WPkD+jNJabuhMI8ZzbVUQ
 B+zbn9jxyQ8HolUNhIARpBgRJbBPE1o6Lv8G+YnVeTd7XwaHkFKgLY2h+9hNubxQ0GDwZiAX/fl
 rehxvg5YsJTggCsR/VbisiiB//mLuEgYXYfPyR43IFGPFxB9BOcdzI7dnjzZz5F5TYcZN7DeQPN
 liiUXEuoqB0COnMeeilcLaLpgHuVPqDbBXI1IalqpHgo5Q7CYhKLVM0oOXxCrSoMQm0GYVHSVRN
 NCHHWD78rTvyppqIVeA==
X-Proofpoint-GUID: qjRvNtB768fNjhNWCB2p4WB3-_Ifoe8V
X-Proofpoint-ORIG-GUID: qjRvNtB768fNjhNWCB2p4WB3-_Ifoe8V
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4MCBTYWx0ZWRfXwiGqgnhjidM3
 mkCwlHJlFGHmfTNKtx/B075LUL3YOsw6Gzek1KQyRIES+j9oz+CJYpf+2EO3eGwuzM9hap+ZelN
 qBkd1JEvAW8qvas7ckWhjiaZ8841BfI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070080



On 8/7/26 6:30 PM, sashiko-bot@kernel.org wrote:

All of the observations in this email are resolved with a simplification 
of the
vfio_ap_resuming_write() function that is forthcoming in the next version
of the patch series.

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] Heap buffer overflow in vfio_ap_resuming_write when processing the initial chunk of migration data.
> - [High] Memory leak of the dynamically allocated temporary ap_config buffer in vfio_ap_resuming_write on copy_from_user failure.
> - [High] Use-After-Free condition in set_new_ap_configuration due to a TOCTOU race when the migration session is concurrently replaced.
> - [Medium] Missing validation of migration magic and version fields when the entire configuration payload is submitted in a single write.
> --
>
> --- Patch [10]: [PATCH v7 10/15] s390/vfio-ap: File ops called to resume the vfio device migration ---
> commit 1f7d34b59709567819d8ff6eb6bf255fe0360e1b
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> Subject: s390/vfio-ap: File ops called to resume the vfio device migration
>
> This commit implements the write callback for the file stream created to
> restore the vfio-ap device state during the RESUMING phase of migration.
> It parses chunks of user data into a vfio_ap_config structure and sets
> up the new device configuration.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index e2e7ae8515e55..4dd7373c3d9d9 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>> @@ -451,11 +539,916 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
>>   	return filp;
>>   }
>>   
>> +static int validate_resuming_write_parms(struct file *filp,
>> +					 size_t len, loff_t *pos)
>> +{
> [ ... ]
>> +	/*
>> +	 * If the vfio_ap_config object has been allocated, then the 'config_sz'
>> +	 * field indicates the total size allocated. If the write operation
>> +	 * will exceed the allocation, return an I/O error.
>> +	 */
>> +	if (resuming_mig_file.ap_config) {
>> +		if (resuming_mig_file.ap_config->magic != VFIO_AP_MIG_MAGIC ||
>> +		    resuming_mig_file.ap_config->version != VFIO_AP_MIG_VERSION)
>> +			return -EINVAL;
>> +
>> +		if (*pos + len > resuming_mig_file.config_sz)
>> +			return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
> [Severity: Medium]
> Does this miss validating the magic and version fields if userspace writes
> the entire configuration in a single chunk? The validation here is skipped
> if the configuration buffer is not yet allocated. If all data arrives at
> once, it appears to be allocated and processed in do_post_copy_processing()
> without the magic or version ever being verified against the expected
> values.
>
> [ ... ]
>> +static int set_new_ap_configuration(struct ap_matrix_mdev *matrix_mdev,
>> +				    struct vfio_ap_config *ap_config,
>> +				    size_t cfg_sz)
>> +{
>> +	struct vfio_ap_config *cur_ap_config;
>> +
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>> +	/*
>> +	 * Re-read mig_data under the lock; the device could have been closed
>> +	 * concurrently while the lock was dropped for copy_from_user().
>> +	 */
>> +	if (!matrix_mdev->mig_data) {
>> +		mutex_unlock(&matrix_dev->mdevs_lock);
>> +		return -ENODEV;
>> +	}
>> +
>> +	cur_ap_config = matrix_mdev->mig_data->resuming_mig_file.ap_config;
>> +	if (cur_ap_config)
>> +		memcpy(cur_ap_config, ap_config, cfg_sz);
>> +	else
>> +		matrix_mdev->mig_data->resuming_mig_file.ap_config = ap_config;
> [Severity: High]
> Can a concurrent state change cause a use-after-free here? The mdevs_lock is
> dropped prior to the copy_from_user() call in vfio_ap_resuming_write(). If
> the migration state is cleared during that window, the original ap_config
> pointer would be freed and cur_ap_config will be NULL upon reacquiring the
> lock. This path then assigns the temporary ap_config to resuming_mig_file.
> However, if the write was a continuation (!new_allocation), the temporary
> ap_config is unconditionally freed at the end of vfio_ap_resuming_write(),
> which would leave a dangling pointer in the active migration session.
>
> [ ... ]
>> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>> +				      size_t len, loff_t *pos)
>> +{
> [ ... ]
>> +	/*
>> +	 * If ap_config is a new allocation, then the contents of the
>> +	 * 'magic', 'version' and 'num_queues' fields will already have
>> +	 * been copied in; so the write_pos must be set to the location
>> +	 * following the 'num_queues' field and the length to be written must be
>> +	 * adjusted accordingly.
>> +	 */
>> +	if (new_allocation) {
>> +		size_t nbytes_already_copied = VFIO_AP_CONFIG_BUF_SIZE - *pos;
>> +
>> +		write_pos = VFIO_AP_CONFIG_BUF_SIZE;
>> +		write_len = len - nbytes_already_copied;
>> +		buf += nbytes_already_copied;
>> +	} else {
>> +		write_pos = *pos;
>> +		write_len = len;
>> +	}
>> +
>> +	*pos += len;
>> +
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +	if (copy_from_user((char *)ap_config + write_pos, buf, write_len)) {
> [Severity: Critical]
> Is there a missing bounds check on the user-supplied len parameter here?
> When allocating a new ap_config, the driver calculates cfg_sz based on the
> num_queues field. However, the calculation for write_len uses the unmodified
> user input len, which is not verified against cfg_sz. If a userspace process
> provides a len that exceeds the dynamically calculated cfg_sz, it seems this
> copy_from_user() will write past the allocated heap buffer bounds.
>
> [Severity: High]
> Does this leak the dynamically allocated temporary ap_config buffer when a
> continuation write fails? During a continuation write (!new_allocation),
> the ap_config buffer is freshly allocated via kvzalloc(). If the subsequent
> copy_from_user() fails, this error path explicitly skips the kvfree()
> because new_allocation is false, leaving the temporary buffer permanently
> leaked.
>
>> +		if (new_allocation)
>> +			kvfree(ap_config);
>> +		ret = -EFAULT;
>> +		goto out_clear_write_in_progress;
>> +	}
>> +
>> +	/* Check if we've completed writing the entire configuration */
>> +	if (write_pos + write_len == cfg_sz) {
>> +		ret = do_post_copy_processing(matrix_mdev, ap_config);
>> +
>> +		if (ret) {
>> +			kvfree(ap_config);
>> +			goto out_clear_write_in_progress;
>> +		}
>> +	}

