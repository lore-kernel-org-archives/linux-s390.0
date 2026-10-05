Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA330675F;
	Mon,  5 Oct 2026 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232965; cv=none; b=SxPKhbKTLfMtX/AUifzjzKN1NvHItXZiuDjWjbkdDSjxCIrIhroxRWvViVyBtCFPqkYjwhU18Q57ofGdxAala9LY9/iCmMja0LTl7CvcBMKLlqFdRHK2kPp5xjT/0vNIE3VpmtfSg/Xjru22e3y4Nkzy1o8f0ADtmXtHvuVSxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232965; c=relaxed/simple;
	bh=H1rDcLnvs+tVMwkQ8HT2YzGfCTT7hI24NBFt7RRxI24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sC00Q3+/Wa2PC4O6Bf5pYxHePxxJ8cg6OuRG4dYkXIXu1n3WA5qSrd93r8jdCv35d+3cjBaxdK0s8uC0vJHUcYHSEWrMKm115sZGx93/QFNvyfmKoXBLQe/c8BsssD9hsiM89+HEIpuJWo3uwGz56rDQoGywTsosOyyLc17AK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RJ8+1wb2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RJ8+1wb2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HZkLn1131408;
	Mon, 5 Oct 2026 20:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+vlmp1
	zJJpBqZRTmdGJXupvkLn88Fqty6R/95+2PujM=; b=RJ8+1wb2GqvWe1dpst7kKk
	PlVaqM4hy1dtFnMPMO4EOCaE4bgm2z1GsVY2ysKouYwjfqd/uAJNgaAeYdGwmZ52
	vctjZq/MFWg6RUq8HkqvoMN432VY+AEsa/C7pWB16Slkn9L01Empw/PWfJnqz4vs
	UedlWLSRpXJXuBkfvF0Yqh3sz/nkOmRjyg6j77qUI9PowS1Od/YNToE9BizK97az
	Z8asut0Eo6nERKMszaVdZtqcRtJcbq5upBojfyfrOuQJ55CMvXv+FS1sG+7G1IHh
	sspz6nbdbsgZxxh4QVPKxeyo0DTyvvZW3uFIslLXa+Dh/dewPUCPBO1Zlqkg78Bw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jm120-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 20:42:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695HbVuU3231089;
	Mon, 5 Oct 2026 20:42:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvq6gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 20:42:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695KgVgw6816268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 20:42:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 175D75805D;
	Mon,  5 Oct 2026 20:42:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B81A58054;
	Mon,  5 Oct 2026 20:42:29 +0000 (GMT)
Received: from [9.61.34.243] (unknown [9.61.34.243])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 20:42:29 +0000 (GMT)
Message-ID: <8feaefbb-93ce-431b-a038-8d9d28576526@linux.ibm.com>
Date: Mon, 5 Oct 2026 16:42:29 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/15] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-6-akrowiak@linux.ibm.com>
 <e94dfa4a-e2b3-4cda-904a-ef571d2277db@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <e94dfa4a-e2b3-4cda-904a-ef571d2277db@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BeJV7Y1I8IzfSfdeNKKlbqb2NYDHQE8v
X-Proofpoint-GUID: BeJV7Y1I8IzfSfdeNKKlbqb2NYDHQE8v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfX5cwNbmZjYsLS
 hhXkNEcuqpsnoUc35mVa3PrOzYPkXr6eIQDs4p5A14DtTPb10IpMzweoQpKi16GFkpwmUxNOfp3
 thmJLxVQGF23XNSt1aL0B8ryXp73MgI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfX6voQaVV+NvaU
 52kdnYl57k7ifAHgXGvb91IxKACDULp413+vfOZopPuBgPwyDzvBcAYhEC3s9yhUqc41D3KRJQH
 CMC2956NXCPRwdaq1gIguaH7z0J5GsSGgefdt7DFtjxfwc6boHqpcwOoUPcNQrLPWtiWXjadF2U
 qblPdQvn/zdVp0hYKbHW3pbEOKHb3dqCuSOPkgc31r2MkP+AirtEL2+f1bsyGRV+IqMYrw9QSew
 mjXSbotsPYeTL27LCYmzL861jBZo7dtNiSi2K7AnBrVA9pPFkYwTgt0y2QLFmhxEM4FpOanFmgd
 ftt/xHvnKD0ofI8Qi/6BtIuqm4JC6v6T/Ip7pvlvxlr3GvcyBfKbO5Y+tK0465lsrLHDSjdWx0u
 HHgmOq04AU60LI0ou88IlD9Uuj4kFTygrM8Hk7tOySb++dNINBBNpOvweMvJ6J8mCFKXMmDsEMk
 pWfT6R/vPnmW+uzkFaQ==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac40bb9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=c-Gg0e3jJgsNnJN__rUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050081



On 8/12/26 12:04 PM, Jason J. Herne wrote:
>
>
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> Implements two callbacks related to the current state of a vfio-ap 
>> device:
>> * The callback that sets a new migration state of a vfio-ap device 
>> during
>>    live migration of guests with pass-through access to AP devices. This
>>    callback is mandatory for VFIO_DEVICE_FEATURE_MIGRATION support.
>>
>>    The function pointer for this callback is specified via the
>>    'migration_set_state' field of the 'vfio_migration_ops' structure
>>    which is stored with the VFIO device when the 'vfio_device'
>>    structure representing the mediated device is initialized.
>>
>> * The callback that returns the current vfio device migration state 
>> during
>>    live migration of guests with pass-through access to AP devices.
>>
>>    The function pointer for this callback is specified via the
>>    'migration_get_state' field of the 'vfio_migration_ops' structure
>>    which is stored with the VFIO device when the 'vfio_device'
>>    structure representing the mediated device is initialized.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_migration.c | 130 +++++++++++++++++++++++-
>>   1 file changed, 128 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c 
>> b/drivers/s390/crypto/vfio_ap_migration.c
>> index 1613813124b6..af740b177c97 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -128,16 +128,141 @@ static void 
>> vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
>>        */
>>   }
>>   +static struct file *
>> +vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>> +                enum vfio_device_mig_state new_state)
>> +{
>> +    struct vfio_ap_migration_data *mig_data;
>> +    enum vfio_device_mig_state cur_state;
>> +
>> +    lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +    mig_data = matrix_mdev->mig_data;
>> +    cur_state = mig_data->mig_state;
>> +    dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, 
>> cur_state,
>> +        new_state);
>> +
>> +    if (cur_state == VFIO_DEVICE_STATE_STOP &&
>> +        new_state == VFIO_DEVICE_STATE_STOP_COPY) {
>> +        /* TODO */
>> +        return ERR_PTR(-EOPNOTSUPP);
>> +    }
>> +
>> +    if (cur_state == VFIO_DEVICE_STATE_STOP &&
>> +        new_state == VFIO_DEVICE_STATE_RESUMING) {
>> +        /* TODO */
>> +        return ERR_PTR(-EOPNOTSUPP);
>> +    }
>> +
>> +    if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
>> +         new_state == VFIO_DEVICE_STATE_STOP) ||
>> +        (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
>> +         new_state == VFIO_DEVICE_STATE_STOP)) {
>> +        /* TODO */
>> +        return ERR_PTR(-EOPNOTSUPP);
>> +    }
>> +
>> +    if ((cur_state == VFIO_DEVICE_STATE_STOP &&
>> +         new_state == VFIO_DEVICE_STATE_RUNNING) ||
>> +        (cur_state == VFIO_DEVICE_STATE_RUNNING &&
>> +         new_state == VFIO_DEVICE_STATE_STOP)) {
>> +        /* TODO */
>> +        return ERR_PTR(-EOPNOTSUPP);
>> +    }
>> +
>> +    /* vfio_mig_get_next_state() does not use arcs other than the 
>> above */
>> +    WARN_ON(true);
>> +
>> +    return ERR_PTR(-EINVAL);
>> +}
>> +
>>   static struct file *vfio_ap_set_state(struct vfio_device *vdev,
>>                         enum vfio_device_mig_state  new_state)
>>   {
>> -    return NULL;
>> +    int ret;
>> +    struct file *filp = NULL;
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +    enum vfio_device_mig_state next_state;
>> +    struct vfio_ap_migration_data *mig_data;
>> +
>> +    matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
>
> The container_of() pointer swizzle is done under lock in 
> vfio_ap_get_state, but not here. Why? They should probably be handled 
> consistently.

The vdev pointer is stable. It is passed in as a function parameter from the
VFIO core and is guaranteed valid for the callback duration. On the other
hand, in the interest of consistency - as you explained - I'll move it after
taking the mdevs_lock.

>
>> +
>> +    mutex_lock(&matrix_dev->mdevs_lock);
>> +    if (ap_is_se_guest()) {
>> +        dev_err_once(matrix_mdev->vdev.dev,
>> +                 "Migration not allowed from or to a Secure 
>> Execution guest\n");
>> +        mutex_unlock(&matrix_dev->mdevs_lock);
>> +        return ERR_PTR(-EPERM);
>> +    }
>> +
>> +    mig_data = matrix_mdev->mig_data;
>> +
>> +    /*
>> +     * The mig_data pointer is set in the vfio_ap_init_migration_data
>> +     * function which is called when the vfio-ap device fd is opened.
>> +     * Since the implicit pre-open state is RUNNING, a request to set
>> +     * RUNNING is a no-op. Any other state transition is invalid before
>> +     * open_device.
>> +     */
>> +    if (!mig_data) {
>> +        mutex_unlock(&matrix_dev->mdevs_lock);
>> +        if (new_state == VFIO_DEVICE_STATE_RUNNING)
>> +            return NULL;
>> +        return ERR_PTR(-ENODEV);
>> +    }
>> +
>> +    dev_dbg(vdev->dev, "%s -> %d\n", __func__, new_state);
>> +
>> +    while (mig_data->mig_state != VFIO_DEVICE_STATE_ERROR &&
>> +           mig_data->mig_state != new_state) {
>> +        ret = vfio_mig_get_next_state(vdev, mig_data->mig_state,
>> +                          new_state, &next_state);
>> +        if (ret) {
>> +            filp = ERR_PTR(ret);
>> +            break;
>> +        }
>> +
>> +        filp = vfio_ap_transition_to_state(matrix_mdev, next_state);
>> +        if (IS_ERR(filp))
>> +            break;
>> +
>> +        mig_data->mig_state = next_state;
>> +
>> +        if (WARN_ON(filp && new_state != next_state)) {
>> +            fput(filp);
>> +            filp = ERR_PTR(-EINVAL);
>> +            break;
>> +        }
>> +    }
>> +
>> +    mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +    return filp;
>>   }
>>     static int vfio_ap_get_state(struct vfio_device *vdev,
>>                    enum vfio_device_mig_state  *current_state)
>>   {
>> -    return -EOPNOTSUPP;
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +    struct vfio_ap_migration_data *mig_data;
>> +
>> +    mutex_lock(&matrix_dev->mdevs_lock);
>> +
>> +    matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
>> +    mig_data =  matrix_mdev->mig_data;
>
> Why bother with temp variable? You could just access 
> matrix_mdev->mig_data directly.

No other reason than for readability and shortening lines of code that 
access it multiple
times. I see no good reason to remove it.

>
>> +
>> +    /*
>> +     * The mig_data pointer is set in the vfio_ap_init_migration_data
>> +     * function which is called when the vfio-ap device fd is opened.
>> +     * If mig_data is NULL, report RUNNING as the implicit pre-open 
>> state
>> +     * so userspace doesn't need to perform any state transition 
>> before the
>> +     * device becomes active.
>> +     */
>> +    *current_state = (mig_data) ? mig_data->mig_state :
>> +                      VFIO_DEVICE_STATE_RUNNING;
>> +
>> +    mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +    return 0;
>>   }
>>     static int vfio_ap_get_data_size(struct vfio_device *vdev,
>> @@ -159,6 +284,7 @@ static const struct vfio_migration_ops 
>> vfio_ap_migration_ops = {
>>    */
>>   void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev 
>> *matrix_mdev)
>>   {
>> +    /* Live guest migration is not supported for SE guests */
>>       if (ap_is_se_guest())
>>           return;
>
> Comment is unrelated to the rest of the patch.

This belongs in patch 03/15. I'll move it.


