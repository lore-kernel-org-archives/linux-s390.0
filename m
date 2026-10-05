Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA94C2247;
	Mon,  5 Oct 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226345; cv=none; b=Els9gHzouDnJEjv+SRnqk9J/oxKVGQ/x51tI6Na38piL16GExPZkN2yxaIw2R+mLOM3+e5dtuPHhZRsJvYMfzsarR1Xyzr52UnWvCt7PQxWQ3mUJxjrmOFn2T0LZjebcWrQ2JE92iX0fd+DNjtCHXI1lnwgnkbisIq4CTCqrpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226345; c=relaxed/simple;
	bh=io1ma+FCGtzcTYiMn6NEb1oTjjDWX1Xm5d+C1HlDY7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6krxq5kDLeyI7zK7zPJMD/17L7gan7pAUQswfOivehueEvCKn0667GVO3JkoKPW2dU14KEo/Nzn92CPn6H5XE5xk6Se4dxobMR6TXMZz9P2y1TXny3dt3dXtFUIcES5X1b+BDgl/+sgKsZFLbnvQmpaCb3wxAEUQHFU+sY5sZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OVGUhC5v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OVGUhC5v"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HZOBi1256933;
	Mon, 5 Oct 2026 18:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FWYTv8
	8690CZNQcrfIzt0A7pFkyXKF3PfGE3ZdieKs4=; b=OVGUhC5vIYpLhkWMQrS8lV
	qSJbe9kafZZw4GzNgBlcaJS8UR915yE/mkw+Y5m2FXlTreuE7VxHhX2x+89l0Ail
	un/ImjmCfdfKmh2dP3fsH0ZgfMr73BQq39YOt4JpyN++Ji1TmmUypBmGW7Y4UrRq
	kAjN7vV59JmqYC9wWQuzQFhiYe70foabV/OzMv6crOIsjZdvsn5uWBo4nvg3wJXp
	8Vw22PWjAcCfrytBNS0nSABWhSmHOqkcSHfMkHVyc9R30a57Wh0c7hEBs9EvkgxS
	errWwLdGyi5QrfTd3AOu/WauFemw3TUEVh7yEg/8vRIOKdmF8heF5Bg8zHARbzeQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5bxf4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 18:52:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695HMYX73238815;
	Mon, 5 Oct 2026 18:52:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1ppwdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 18:52:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695IqGLU29753860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 18:52:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BE3A5805A;
	Mon,  5 Oct 2026 18:52:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E903558054;
	Mon,  5 Oct 2026 18:52:14 +0000 (GMT)
Received: from [9.61.34.243] (unknown [9.61.34.243])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 18:52:14 +0000 (GMT)
Message-ID: <a88bf7e9-10f3-4c46-a8a3-8f029e555c70@linux.ibm.com>
Date: Mon, 5 Oct 2026 14:52:14 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/15] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-5-akrowiak@linux.ibm.com>
 <d3c453ce-6e9f-4c1b-aef7-8d1b1f1be46e@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <d3c453ce-6e9f-4c1b-aef7-8d1b1f1be46e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MyBTYWx0ZWRfX9sonKXMyjMsd
 had47/AcPbdqQIkgIU1VPqilWP90CeOirjyc/O5Mnqvw+rDXN0GkDPU9Epsz4hvpn2FkIs5lpdo
 D9a5dEVf94KLOtHasEI82fZTMdQvcXY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MyBTYWx0ZWRfX9hiXL6fEib5b
 nf5VlIxBDHY0kzwju2x/Ks+//8uZPJkjYEn6n9RibiOsyh+gB1cUfs8t2VAu4+wXSLHAB9ObILZ
 DY2HIWXi/hDy3lOfBTXRunZDNtPjPM9LE1eQx0t9nPhhrcRwEg/Lzu2Dxb8Wcj2eqLuANkX3RNI
 vW2X7JvfGbagNKnTehrN3DGbTrLdj5YC7o50war5Tpr/Rt0BEaHcbDYuf5ilII/O+AKdNfa0m/o
 zKJCdJWPh/4pInSL3tl+YBfk+T0pWAXKVL13Tefnz/OCklsyS67F3+xgHuMVhm5+7JhyibNirTw
 CMJm/DdsqxLUiz2Ts3V7fiPTQDnGj7y1yMMkVdiUxToigObQruXjigvBMnsW7z7JTxbJdw2+52D
 C8hK2V7YtlPRa8qbc6OGkkH/jBkiPaHgBbaV6d+ICKGgWWWZjxcOIGSRHpWNPnQ8htJBO9ZrZCp
 uG9Nw/evXXVSoNbpr9g==
X-Proofpoint-GUID: QeQadU53vPfxMm543ZlJagMY5B4sCp8n
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac3f1e2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=y0eLMb8oXC195jKi86oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QeQadU53vPfxMm543ZlJagMY5B4sCp8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050073



On 8/11/26 1:05 PM, Jason J. Herne wrote:
>
>
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> According to the VFIO migration specifications, userspace must issue a
>> VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or 
>> fails a
>> state transition to recover the device and return its migration state to
>> RUNNING. This patch adds a function that is called when a 
>> VFIO_DEVICE_RESET
>> is issued that releases the migration files and frees the storage 
>> allocated
>> for maintaining the migration state.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_migration.c | 20 ++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_ops.c       |  4 ++++
>>   drivers/s390/crypto/vfio_ap_private.h   |  1 +
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c 
>> b/drivers/s390/crypto/vfio_ap_migration.c
>> index cf303d228a0a..1613813124b6 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -238,3 +238,23 @@ void vfio_ap_release_migration_data(struct 
>> ap_matrix_mdev *matrix_mdev)
>>       kfree(matrix_mdev->mig_data);
>>       matrix_mdev->mig_data = NULL;
>>   }
>> +
>> +/**
>> + * vfio_ap_reset_migration_state - Reset the vfio-ap migration state
>> + *
>> + * @matrix_mdev: pointer to the object maintaining the vfio-ap 
>> device state
>> + *
>> + * Called during VFIO_DEVICE_RESET to clean up any active migration
>> + * state and reset the device to RUNNING state as required by the VFIO
>> + * migration specification.
>> + */
>> +void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +    lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +    if (!matrix_mdev->mig_data)
>> +        return;
>> +
>> +    vfio_ap_release_mig_files(matrix_mdev);
>> +    matrix_mdev->mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
>> +}
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 90b0fce0123b..d05372b50d2f 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2330,6 +2330,10 @@ static ssize_t vfio_ap_mdev_ioctl(struct 
>> vfio_device *vdev,
>>           break;
>>       case VFIO_DEVICE_RESET:
>>           ret = vfio_ap_mdev_reset_queues(matrix_mdev);
>> +        if (ret == 0) {
>> +            /* Reset migration state per VFIO migration spec */
>> +            vfio_ap_reset_migration_state(matrix_mdev);
>> +        }
>>           break;
>
> Why do we only reset migration state when vfio_ap_mdev() returns 0? 
> Even if this call fails, we are in the VFIO_DEVICE_RESET path and we 
> need to clean up the migration data, right? Or did I miss something?

I think you're right here. After reading through the documentation and 
doc blocks, it looks like the
contract on a reset is to do what is necessary to set the migration 
state back to RUNNING. That
would include cleaning up the fds etc. Besides, reset status and 
migration state are two unrelated
issues.

>
>
>>       case VFIO_DEVICE_GET_IRQ_INFO:
>>           ret = vfio_ap_get_irq_info(arg);
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index a2a713f93674..1fbdfcce5a11 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -175,5 +175,6 @@ void vfio_ap_on_scan_complete(struct 
>> ap_config_info *new_config_info,
>>   void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev 
>> *matrix_mdev);
>>   int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
>>   void vfio_ap_release_migration_data(struct ap_matrix_mdev 
>> *matrix_mdev);
>> +void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
>>     #endif /* _VFIO_AP_PRIVATE_H_ */
>

