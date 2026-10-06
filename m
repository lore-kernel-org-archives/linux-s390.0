Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ACB43FD1F;
	Tue,  6 Oct 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298476; cv=none; b=h2A2IMyhj6bosBDpdbI8wD+gQuGlPxdvJA5iCi2jDJBOo2dSFI++uTw45guWeCljOF2Z4gMvuqMBog71mC9gBz7r5DdGulTsaWdl7aR6Gfim27Ya3EVH8OTDOtFHglD97pVKXOngmX9xv66pEJnlg7G1CN8KL7s2p7J46MlgLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298476; c=relaxed/simple;
	bh=YC7s4g2WHBRfFy7TMHcjGEvlQzhjNK8Yk6mlrMskU3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKierGM+so/WVBxzsH0CS0xcovEIMfbRnRR8aPvr9OZjPzY5idJVWM1N1kJbBnJZUMFctTHCqWuMaZzEIMsZ44X02j1iAoPmCI2moBYTYv3ImldjLqRQcuyAH5gQyML5pTC6W8NQ9ywipBjMJKJExGgDrNF/g3s37I/+3wGhWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YpkMD3cf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YpkMD3cf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZaIi3974878;
	Tue, 6 Oct 2026 14:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nkUsov
	x5EfrhppLUnB9/rpcJ0EVZfcpfNX7Bs3540gM=; b=YpkMD3cfBm/a4Is9LZGW4Q
	AjjdM7qdg2jvakC7sZNB9tmaQ2iEdplrpqBlRS3JFTjCSLK1KqVlXLaGSduU4Cnl
	HZlayhn2RkB9UVaEd3RuksqR3rThMZGmhFXlcXXUBCrxytDc6Xy/aNrGLgxaeYO8
	MnsQzVBAinP0IZLpNnqxLQGCFTN8Ka5rTVWcn+BwL0uIGp/8mfHVvjMgFECaIL9K
	f33Qx8MAAvbnYaoZw5zLbbS4+c/d2pATEQ8rA0JlXGkbhQu6mzKUOkDnf99qCQkA
	Wxpt1Ykrq1yFQ0IONwVH/d/Tn2VeCZhM5iF19rvpg5rxT6b5kR0Oe5nTqJx9f4RQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5gkjc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:54:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHbYP387177;
	Tue, 6 Oct 2026 14:54:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jtc3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:54:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696EsQUw63701432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:54:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7FB858052;
	Tue,  6 Oct 2026 14:54:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53A1458050;
	Tue,  6 Oct 2026 14:54:24 +0000 (GMT)
Received: from [9.61.78.19] (unknown [9.61.78.19])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 14:54:24 +0000 (GMT)
Message-ID: <8947ddf3-e6d1-4ef4-a44d-7e91472525a7@linux.ibm.com>
Date: Tue, 6 Oct 2026 10:54:23 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/15] s390/vfio-ap: File ops called to resume the vfio
 device migration
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-11-akrowiak@linux.ibm.com>
 <dc3a7703-b4a9-4a7f-9078-f6f874962abf@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <dc3a7703-b4a9-4a7f-9078-f6f874962abf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1OCBTYWx0ZWRfX3eLOELrQGBlL
 vSrGvuVygRvWqWOujCgFcUn8qLVhRGzdGg6LcsMu3SrDU61UtBtVClG72622buU/Dc9BTi3+glT
 BjlnxmLocw97YAumcH9EznRhfbkFGqw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1OCBTYWx0ZWRfX2zO/1qDeh7iK
 QW1UC5GawvvcVX3rBtzygOR2BlI+eBPKfHzYusahcjc2LJAAOIOJ2OvbwkGRZ5Go0ZwlcMNe1Sn
 IPZceGKCCbCWn2AYQ0Z9JElZWznTUF/Qw3kPmWqOeLnbNT8DXZqZEw0YvGtB5hvKLeQRZtarY7r
 0DI6SCT0tpzamvVfjSpgZvVyaQ6udMzZO0qRVM4NA6nVsux6uP62ksrO4GAdhWE6Nl2SWX2SGA9
 N5EyrpHoGcYDgdXLpf7qfenNfQmzyz8nxZZLxHmXWqrmMKnjUK1p61xX3N+6mCyKoC27WXxkfCO
 HCihYIxCGetD606w9dcvjYp3f2uUWCNhH59yA+nguvMcLh7ygs+MN4MJZ3J58nLY5/943q+QKW8
 vKMRmadH3a8UU+SjUZTDzDCJvE9I0v4j5EOrBvKAsYD6vGH6WQKRJRuqWWWmzvprk7Kxj4Dvd8U
 vS4Tbzx4sz5mJzWqhVw==
X-Proofpoint-GUID: eRPDULf1UEaPcWsOCXJlQIMwflp5taiY
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac50ba4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_X_NOP1f7RCpyUVFa4AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eRPDULf1UEaPcWsOCXJlQIMwflp5taiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060058



On 8/19/26 1:49 PM, Jason J. Herne wrote:
>
>
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> Implements the 'write' callback function that was added to the
>> 'file_operations' structure for the file stream created to restore the
>> state of the vfio-ap device on the destination system when the migration
>> state transitioned from STOP to RESUMING
>>
>> The write callback retrieves the vfio device migration state saved to 
>> the
>> file stream created when the vfio device state was transitioned from
>> STOP to STOP_COPY. The saved state contains the source guest's AP
>> configuration information. This data is copied from the userspace buffer
>> passed to the 'write' callback and stored in the vfio_ap_config 
>> structure
>> used to set the state of the vfio-ap device on the destination host. 
>> If the
>> source guest's AP configuration is compatible with the AP 
>> configuration on
>> the destination host, it will be hot plugged into the destination guest.
>>
>> In order for the source guest's and destination host's AP configurations
>> to be considered compatible:
>>
>> * Each APQN in the source guest's AP configuration must also be in the
>>    destination host's AP configuration
>>
>> * Each matching APQN in the destination host's AP configuration must be
>>    bound to the vfio_ap device driver
>>
>> * Each matching APQN in the destination host's AP configuration must
>>    reference a queue device with compatible hardware:
>>
>>    - The source and destination queues must have the same facilities
>>      installed:
>>      ~ APSC facility
>>      ~ APQKM facility
>>      ~ AP4KC facility
>>
>>    - The source and destination queues must have the same mode:
>>      ~ Coprocessor-mode
>>      ~ Accelerator-mode
>>      ~ XCP-mode
>>
>>    - The source and destination queues must have the same APXA facility
>>      setting
>>      ~ If the APXA facility is installed on source queue, it must also
>>        be installed on the destination queue and vice versa
>>
>>    - The source and destination queues must have a compatible
>>      classification setting. If the source queue has full native card
>>      function, then the destination queue must also have full native
>>      card function. If the source queue has stateless functions, then
>>      the destination queue can have stateless functions or full 
>> native card
>>      function because the latter includes the stateless functions.
>>
>>    - The binding and associated state for both the source and 
>> destination
>>      queues must indicate that the queue is usable for all messages
>>      (i.e., BS bits equal to 00).
>>
>>    - The AP type of the destination queue must be the same as or 
>> newer than
>>      the source queue (backward compatibility)
>>
>> Note: The get_hardware_info_for_queue function that was created in
>>        a previous patch was modified to take a mediated device name 
>> rather
>>        than an ap_matrix_mdev object because that is what is needed for
>>        this patch so the function can be executed without holding the
>>        matrix_dev->mdevs_lock.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_migration.c | 1009 ++++++++++++++++++++++-
>>   1 file changed, 1001 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c 
>> b/drivers/s390/crypto/vfio_ap_migration.c
>> index e2e7ae8515e5..4dd7373c3d9d 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> ...
>>   static ssize_t vfio_ap_resuming_write(struct file *filp, const char 
>> __user *buf,
>>                         size_t len, loff_t *pos)
>>   {
>> -    /* TODO */
>> -    return -EOPNOTSUPP;
>> +    struct vfio_ap_config_buffer *resuming_config_buf;
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +    struct vfio_ap_config *ap_config;
>> +    bool new_allocation = false;
>> +    ssize_t ret, cfg_sz;
>> +    loff_t write_pos;
>> +    size_t write_len;
>> +
>> +    /*
>> +     * This file was opened with stream_open(), so pos should be 
>> NULL for
>> +     * sequential write() calls; a non-NULL pointer will be passed only
>> +     * for positional pwrite() calls in which case we return an error
>> +     * indicating broken pipe/illegal seek on a non-seekable file
>> +     */
>> +    if (pos)
>> +        return -ESPIPE;
>> +
>> +    mutex_lock(&matrix_dev->mdevs_lock);
>> +    pos = &filp->f_pos;
>> +
>> +    ret = validate_resuming_write_parms(filp, len, pos);
>> +    if (ret) {
>> +        mutex_unlock(&matrix_dev->mdevs_lock);
>> +        return ret;
>> +    }
>> +
>> +    matrix_mdev = filp->private_data;
>> +    matrix_mdev->mig_data->write_in_progress = true;
>> +    resuming_config_buf = &matrix_mdev->mig_data->resuming_config_buf;
>> +
>> +    /*
>> +     * If we have not yet filled the vfio_ap_config_buffer, then we 
>> need
>> +     * to continue filling it with data sent from userspace.
>> +     */
>> +    if (!resuming_config_buf->filled) {
>> +        ret = fill_resuming_config_buffer(resuming_config_buf, buf, 
>> len,
>> +                          *pos);
>> +        if (ret) {
>> +            matrix_mdev->mig_data->write_in_progress = false;
>> +            mutex_unlock(&matrix_dev->mdevs_lock);
>> +            return ret;
>> +        }
>> +
>> +        /*
>> +         * If the vfio_ap_config_buffer is not yet filled, we don't
>> +         * yet have enough data to allocate the vfio_ap_config 
>> instance;
>> +         * otherwise, go ahead and allocate it.
>> +         */
>> +        if (!resuming_config_buf->filled) {
>> +            *pos += len;
>> +            matrix_mdev->mig_data->write_in_progress = false;
>> +            mutex_unlock(&matrix_dev->mdevs_lock);
>> +            return len;
>> +        }
>> +
>> +        ret = allocate_ap_config(resuming_config_buf, &ap_config);
>> +        if (ret < 0) {
>> +            matrix_mdev->mig_data->write_in_progress = false;
>> +            mutex_unlock(&matrix_dev->mdevs_lock);
>> +            return ret;
>> +        }
>> +
>> +        new_allocation = true;
>> +        cfg_sz = ret;
>> +    }
>> +
>> +    /*
>> +     * If this is not a new allocation of the vfio_ap_config object,
>> +     * then create a copy of it so we can continue filling it in via
>> +     * the copy_from_user() while the mdevs_lock is dropped.
>> +     */
>> +    if (!new_allocation) {
>> +        cfg_sz = matrix_mdev->mig_data->resuming_mig_file.config_sz;
>> +        ap_config = kvzalloc(cfg_sz, GFP_KERNEL_ACCOUNT);
>> +
>> +        if (!ap_config) {
>> +            matrix_mdev->mig_data->write_in_progress = false;
>> +            mutex_unlock(&matrix_dev->mdevs_lock);
>> +            return -ENOMEM;
>> +        }
>> +
>> +        memcpy(ap_config,
>> + matrix_mdev->mig_data->resuming_mig_file.ap_config, cfg_sz);
>> +    }
>> +
>> +    /*
>> +     * If ap_config is a new allocation, then the contents of the
>> +     * 'magic', 'version' and 'num_queues' fields will already have
>> +     * been copied in; so the write_pos must be set to the location
>> +     * following the 'num_queues' field and the length to be written 
>> must be
>> +     * adjusted accordingly.
>> +     */
>> +    if (new_allocation) {
>> +        size_t nbytes_already_copied = VFIO_AP_CONFIG_BUF_SIZE - *pos;
>> +
>> +        write_pos = VFIO_AP_CONFIG_BUF_SIZE;
>> +        write_len = len - nbytes_already_copied;
>> +        buf += nbytes_already_copied;
>> +    } else {
>> +        write_pos = *pos;
>> +        write_len = len;
>> +    }
>> +
>> +    *pos += len;
>> +
>> +    mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +    if (copy_from_user((char *)ap_config + write_pos, buf, 
>> write_len)) {
>> +        if (new_allocation)
>> +            kvfree(ap_config);
>> +        ret = -EFAULT;
>> +        goto out_clear_write_in_progress;
>> +    }
>> +
>> +    /* Check if we've completed writing the entire configuration */
>> +    if (write_pos + write_len == cfg_sz) {
>> +        ret = do_post_copy_processing(matrix_mdev, ap_config);
>> +
>> +        if (ret) {
>> +            kvfree(ap_config);
>> +            goto out_clear_write_in_progress;
>> +        }
>> +    }
>> +
>> +    ret = set_new_ap_configuration(matrix_mdev, ap_config, cfg_sz);
>> +    if (ret) {
>> +        kvfree(ap_config);
>> +        goto out_clear_write_in_progress;
>> +    }
>> +
>> +    /*
>> +     * If this is not a new allocation of vfio_ap_config, then the 
>> contents
>> +     * of ap_config would have been copied into the existing object, 
>> so we
>> +     * can free it so we don't leak the storage.
>> +     */
>> +    if (!new_allocation)
>> +        kvfree(ap_config);
>> +
>> +    ret = len;
>> +
>> +out_clear_write_in_progress:
>> +    mutex_lock(&matrix_dev->mdevs_lock);
>> +    if (matrix_mdev->mig_data)
>> +        matrix_mdev->mig_data->write_in_progress = false;
>> +    mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +    return ret;
>>   }
>>     static const struct file_operations vfio_ap_resume_fops = {
>
> Why can't vfio_ap_resuming_write() just copy the data it is given into 
> a buffer, remembering the next position to write and then exit if the 
> buffer is not full? If the buffer is full then it can then process 
> that buffer. Whatever is happening here seems very convoluted.
>
> The AP config for a guest is pretty small. At most it will be 16 bytes 
> * 64k queues = 1 MB. Allocating a max buffer up front would be a 
> reasonable thing to do, in my opinion. Even if we don't,  I feel like 
> this code could be simplified quite a bit.
>
> I'm imagining an algorithm similar to the this:
>
> read_data();
> if (not have_all_data):
>     return;
> post_process_data();

This is a good suggestion, I'll simplify the logic.


