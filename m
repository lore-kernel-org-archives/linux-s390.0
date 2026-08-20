Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10874399DB;
	Thu, 20 Aug 2026 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231295; cv=none; b=V9IfB4fxVRKvRT86rXtq0wshdJxuayPvjZBjT/WmvmE1lmLCrAZMF9RtJ684Y3eRfUjSxFQXm1cWdnonc/1bMR4ijHFLZ4Tw83J6iNvwPAuYxRrPMnLvuYj5a7RpGrR1uI0FfpFQHfyGvQPoPLIX8ue/KmZy4f8yOESlI7c21GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231295; c=relaxed/simple;
	bh=fEGwxH07hLQvIik5CzvcHfwRemN21Dan7yJBVAMQKsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMMAH9RM4KsOA+cmphW049mFKzuHsylw4jtKph9LO3wmpzYghIly6LRF3DRUn/SUdb0wtriOESMdFlH5ZxtpFJN9C3BCvBPwJUWDr3TGVcIAA+lTtH3Qwf6icY9mcCGuJxpqEjkS3bf2G2HW0AnWCKd22kdn47pgWpEwRjOQc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H3jAAgfD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H3jAAgfD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8OSYH424041;
	Thu, 20 Aug 2026 13:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EIiJPB
	iE3OGlWOR37QBvaGDf9IbzwYkiKv4iLr2p92Q=; b=H3jAAgfDiqS22lb2XFakBg
	lcpu7juR5xFue+IsXWJ6Y2lbGe57pFJ7oK+0tZlMr25Rh1cHpm29OuzpKVe+uett
	E17M4VTWk2DPWQ6mTE+8CZAOyCNpW8bjPBKJYCfs+RfuzvqULugQaHqacdH8lvui
	Cg1ku77T5M0gefu6qZtFyJxflGVvKQuiWz+Y4TyKEIiA3I47uvxKCB/lDmEEnGOk
	KCsKV2Ki0VaBptEz/ZUHqmCBtzxd0FIrVds1JzIBz00t248yRd63nUzuN82tdxO6
	w9xQlndZvhSHdtjYnPEVGkz6LK9qIC1QxAz1rivcRFFX5WkOs2uWuL6MJEgPtpYQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1jdy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 13:08:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KCuJ1Y001768;
	Thu, 20 Aug 2026 13:08:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ypd6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 13:08:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KD848e30802524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 13:08:04 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D37458065;
	Thu, 20 Aug 2026 13:08:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1EF65804B;
	Thu, 20 Aug 2026 13:08:02 +0000 (GMT)
Received: from [9.61.142.83] (unknown [9.61.142.83])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 13:08:02 +0000 (GMT)
Message-ID: <90102b8c-6ece-4158-8a7c-f70fcf34f0c6@linux.ibm.com>
Date: Thu, 20 Aug 2026 08:52:31 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/15] s390/vfio-ap: Callback to get the size of data
 to be migrated during guest migration
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-14-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a86fc36 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VnNF1IyMAAAA:8 a=pz8EXP51tcLMhwfu3-AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2E4IUHSZNfdMZNe1aVkSIfgBXB8YLrOQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfX/JM7x4xmJYCS
 Yfmyc4f1jvvBDvTrFXcNvMiSlHOjtjVhG7TIREFINBP679Gb4ZnrlK0aL/h03cbB6cQvLNa8JTt
 OIsEvLBjuJlxVSc4k/KvvnqRIsRziwM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfXxdAH2cvPFpKc
 5xLwrRo5wZ4I/7hVcDb6XEa3PaqtLifaSylgXwT3hEn4cB9DJ7ctWj5SCTfQFjkt18M9c3/szW2
 qvXNNVpPaOD/x0H/nCR6FRSNueYIbbFfuQaW7UGZQgPzApLJoE77kZD726vzXxI+Ns7v6cFwm83
 DZ37PkA458eHujSFf5kSIUcR3weivOsrVts5F26kGU8nSuIkPMB13dAiDsUL6pcvARRdSUm49Y9
 9IRljz18jxY7W6ZyX9ojaOCbz8H93FYnUS+ZGWUSKECgiR1mtoe3dyrVd+FwDvJ94qkXb+JPteG
 EmmF7glKRXsdOXeQpfl5qW0sSuzStmCqSIBHBUeBfm/fkjEPpVd+1a+OcACKLHt4LIpiPTz6Z4J
 c4ccwkrkI2kT+3ct6A+wkMXjabFXqg1Wrp0a0EZM9Lap9asWLaBT7cCnd1+6qANfSLddCnEN+SF
 GD6VmHvnXV+yzED9mmA==
X-Proofpoint-ORIG-GUID: 2E4IUHSZNfdMZNe1aVkSIfgBXB8YLrOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200097

On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> Callback to get the estimated data length of the data that will be required
> to complete reading of the vfio device's internal state. It's mandatory for
> VFIO_DEVICE_FEATURE_MIGRATION migration support.
> 
> The function pointer for this callback is specified via the
> 'migration_get_data_size' field of the 'vfio_migration_ops' structure
> which is stored with the VFIO device when the 'vfio_device'
> structure representing the mediated device is initialized.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_migration.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
> index 24955f70e13e..01933a62dab9 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1636,7 +1636,15 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
>   static int vfio_ap_get_data_size(struct vfio_device *vdev,
>   				 unsigned long *stop_copy_length)
>   {
> -	return -EOPNOTSUPP;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	int num_queues;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
> +	*stop_copy_length = vfio_ap_config_size(matrix_mdev, &num_queues);
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	return 0;
>   }
>   
>   static const struct vfio_migration_ops vfio_ap_migration_ops = {

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
