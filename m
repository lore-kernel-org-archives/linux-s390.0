Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2BF53C3B3;
	Wed, 14 Oct 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993111; cv=none; b=PpoGXyrWJ05z2zXxOqwfBsq8fQxIBzhrMtS0A5LiYIARZR0851Twn7pSiRZ+LqGoyS6kmbElfWG74/9xBF5JyYuhYLTcowMpAk+xYsMdJIEiWTMVFfiiAGwBIhUHLtFk/p2wO2Gcoz+htdNvM2n4j3V6Iplwrrsqs+/OUNqAbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993111; c=relaxed/simple;
	bh=mnqBnGq9fS13stKAjzfcYTt4IKnEDnWtO0F8Yy/oAJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeAWEqZBB6LUZX8Zo/Degkl8TDlp9xJhXTwh7uq1CgsdZmBL4bprabjjT3FZbDn8sEt1Wjd611rYivN1L6FveMSno34SmkJBRT8Ipd/NPd0XYCExvYkfMpEAdGg6Tg3IGijx9NQny4YHSGIvxnLTobTqCrr+YdJc88m6X7YDTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZxLj+Vxm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZxLj+Vxm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEiDfB694904;
	Wed, 14 Oct 2026 15:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DgjryW
	dHXCZNMU6pLG9BW34rYh1DMSIzd5U2y8tOR8I=; b=ZxLj+VxmHx9itxphi/fCii
	RWpnHxEWOeAbzc/AFynpc0n6XpsW61f/c7FrAQE7TutsoIYvn18wDfm4/o9XKjyp
	1Mfgi3N+kfPkJIbT0YQ9r9AENE6YIV1tnhvWBQ7PzvbXg1xzxFtzBQIXrvOf8O2t
	VG0f+J3Pn/z8irJQySdAs0SwKaeb0u4pjOxEZOuVlZ2fdG1mBIcW/A0Qdjnu5AOP
	2UujgtCABBske/3ZfgC+OBVJM+yaCwEM+/mDhEsQWc50bgVyZ2A+J58CIF9WM7Ny
	mWtxo+KaZisfvcs0Gddy7RxDxmNEw37lTOoP/zb9dGlo4Ht2g7UWBH0rSfmeGkzA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhnbs0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 15:51:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEbYI73639707;
	Wed, 14 Oct 2026 15:51:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg3akp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 15:51:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EFpj5A31130356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 15:51:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEB5A58054;
	Wed, 14 Oct 2026 15:51:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C361A5805A;
	Wed, 14 Oct 2026 15:51:44 +0000 (GMT)
Received: from [9.61.158.18] (unknown [9.61.158.18])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 15:51:44 +0000 (GMT)
Message-ID: <21a7ab10-2e9d-4167-afba-a0bb37e5cbc4@linux.ibm.com>
Date: Wed, 14 Oct 2026 11:51:44 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-4-akrowiak@linux.ibm.com>
 <sashiko-outbox-170040@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-170040@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2MiBTYWx0ZWRfXw78LbncbW8BA
 UyXK1Aa/8tiFWhJVqxPd93Cx5VaHrF2ie77gMSaLUZrSFkLI2mYToTITkHP+5rdeIowyxu5tSnJ
 RAXU6UmxBr9mCoA+EKOx51lDraqJMEY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2MiBTYWx0ZWRfX5XqPobD4mYmo
 JBZKWTqCEhPGqV72PCboUL2v2TFSSnrPi0cxLdGn2HaAY74xb9ze77sDIhhFbfyjOEoW8D+6geH
 qqFWtObr1BUvykP7Cba85Q30nXoTvA1fqJX39lOV3ZhlBwyUCLdP6D48sgKkAJPr/5GBN45r2fU
 CTd80MTfb7n9hGJC+hK68o/GtvVp8cfj1H/J5qf6DXdtYwHt45jeJgSf19FisJx8JoVH19J6zks
 WOuHgnSJFjNb0G+Cz1hAUba6vyClH8fEqCtyZDaWXFV9SweJHleWu5hwl6446YGATMlf9ttg7M2
 by0MgSsoX0tara8kzH4HRn4Bp7ZVu+7dDTXdpR8iPEizdvrGO9BzBKCxlMt2m8YSQr+A/JSs0gk
 7QgHsMwpMXnB+ck4MuxdOO5XVL1lmRWO6Yzp7leVkUZmPm9uO5RYeM/N3oRUPgeeindFhp3NWHW
 b98CsFh0PkDyOFNKxow==
X-Proofpoint-GUID: IBM1AcXIR_EI00VWXvAJWgTiBUIQnugb
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acfa514 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Y5rATk9AAFfwMYsNrMYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IBM1AcXIR_EI00VWXvAJWgTiBUIQnugb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140062



On 10/13/26 11:47 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] s390/vfio-ap: Data race on matrix_dev->info during mdev init
> --
>
> commit 61bb5cee71d03ac3e82343abe74a853a264da523
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Functions to initialize/release vfio device migration data
>
> Provides the functions that initialize and release the data structures
> used during live guest migration.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 01439f0ca42ab..6829e423b5a46 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -782,18 +782,30 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
>>   
>>   static int vfio_ap_mdev_init_dev(struct vfio_device *vdev)
>>   {
>> -	struct ap_matrix_mdev *matrix_mdev =
>> -		container_of(vdev, struct ap_matrix_mdev, vdev);
>> +	struct ap_matrix_mdev *matrix_mdev;
>>   
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>> +	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
>>   	matrix_mdev->mdev = to_mdev_device(vdev->dev);
>>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
> [Severity: Medium]
> Could this result in a data race on matrix_dev->info?
>
> The modified vfio_ap_mdev_init_dev() reads matrix_dev->info via
> vfio_ap_matrix_init() while holding only matrix_dev->mdevs_lock.
>
> However, vfio_ap_on_cfg_changed() updates matrix_dev->info via memcpy()
> while holding only matrix_dev->guests_lock:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_on_cfg_changed() {
>      ...
>      memcpy(&matrix_dev->info, cur_cfg_info, sizeof(*cur_cfg_info));
>      ...
> }
>
> Since memcpy() is not atomic and the two functions acquire different locks,
> can a concurrent AP configuration change cause vfio_ap_mdev_init_dev()
> to read a torn or partially updated ap_config_info struct, potentially
> leading to incorrect apm_max, aqm_max, or adm_max values?
>
> Note that follow-up patches in the series do not resolve this lock mismatch.

This is actually a pre-existing bug. Also, the chunk above is unrelated to
this patch series. This will be fixed in a separate patch.

>
>>   	matrix_mdev->pqap_hook = handle_pqap;
>>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
>>   	hash_init(matrix_mdev->qtable.queues);
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>>   
>>   	return 0;
>>   }

