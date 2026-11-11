Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411153;
	b=NuvdHoSUIIQV065OGXv1Nolw+GpAzHwy2DeuIxuO0n9aB5S+qz2JZQ3dDH5dNz6byS7V
	 tEuwFSHsaMNkgqpukJhb5ONs5kOsYI1D7/7PZrWdNyJ1HX34ZfeGtvK3gzEhvwEOj3HgD
	 6ynlVm3sFks/sWaeAzgVnmjSxyH97wpRqj0/sOqsL2VJpwR3n7nJ+DnK7jR852vlJpVzN
	 FKF9WG+nY5XkDnnlidkH8s9B7+6agIFPPOreHA1aC4EJDuzI5iybprrf9EdHwENhq9Nl+
	 hoa1y4ky7lPDxc1vZga2wvtMnpB3ztWhRoL4ulWArli+S3oftnGyd1GtyDzqDBcjrbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411153;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HbIYwUvdCF/rcWDA0aAqCb5MdD4dtRR03IC0RYr6j8w=;
	b=IcVRuoO8HzQfZ+TPIqey/Ee32R5m7TrYLUqJalUmQzXMfZmD+bn2Lq8b8XpDGDj65+EX
	 dowqyF9A8HzoA8Pte9lmUQb1x5iSRP3BHIc0Kb0heCbFB3b3jWSwv0LqzvM4ZSVgI8Vdc
	 5Rc7G7bdGo9f1qEVgyv9qc8zGrdFKnbPPDTqG/FJVyMtsg5WvLNwMIcyJEY24wX3M4m18
	 C+oS2FOMlK3uxE4WaSugKarpwQ3MsKrZ9fdZOFAX8MC6vpqjlB4d/fSwDO9YPL7Go5Bd/
	 GxLel45Fqx9vy13zmzpYw8EiqX5gmChytEbFS5KzrjgTR5EG5SW0jOYkIB16y+BccpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SQ3iuRRR;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA333606A324;
	Wed, 11 Nov 2026 15:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA333606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SQ3iuRRR
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFEKdN1392022;
	Wed, 11 Nov 2026 15:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HbIYwU
	vdCF/rcWDA0aAqCb5MdD4dtRR03IC0RYr6j8w=; b=SQ3iuRRRPmXS6zny0q9wZK
	zeMVVe4RsGAUpBEvyNwJwDQo7UjhvTljzIRpM9lDDKNfSs78+ps37gD0daVL9LEZ
	OE0nTBte4CmtbwcW6m8FNHy+T+XmJaMpD0rwdPEAHqLuo8T3KiXbshy29ySHw4Kn
	1xujgNuzEHiXCCph6atm7iAm+c29kKBVxox99ODirAxEGVUgyWaoTxmcISmTwez6
	PRRS+FX23UJgKzC3yMHtIgQC6Wvbwxrvr5M34Moe9P7PL5T3Qy3g5FhrRxVAUHDS
	ZtzsZJVqhaDTFlxhYTpfY/Fd24SgLsF1vIsY5TJk/Q7JZsvZwVVp8ZAzRpPpm/iw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkttqc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 15:32:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFJpVY3536671;
	Wed, 11 Nov 2026 15:32:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0sg0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 15:32:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABFWTBX16384680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 15:32:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61E445805A;
	Wed, 11 Nov 2026 15:32:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0EDA58052;
	Wed, 11 Nov 2026 15:32:28 +0000 (GMT)
Received: from [9.61.182.62] (unknown [9.61.182.62])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 15:32:28 +0000 (GMT)
Message-ID: <d6fcd8d5-d614-4a8b-8625-8feacc754a8a@linux.ibm.com>
Date: Wed, 11 Nov 2026 10:32:28 -0500
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/14] s390/vfio-ap: Set up for vfio-ap device
 migration
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-13-akrowiak@linux.ibm.com>
 <sashiko-outbox-201766@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-201766@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af48a8f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=MkKTXG4A8xCSamybnNwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2MCBTYWx0ZWRfX0hLE4p+yVquw
 SPDPSHo3Kjs8ghJNjU+iktc3jfpMIC59dfY94PLBRAs+hSZvSC//nTaFjtUIgpJhYnkMjV53BKm
 Qi+fMUK/v9X7/n2wpDtdho3jTZBpzW7CiNKZ4ZYzutL1bzqDHaF1G4Te8p6mfcd/lQOJ7Z9gPZ/
 +VZH73A5MXj8m3atbZR05I0Xub/ljMiKmSVrsCi8u4IJ2ari/BNqjiWlPh8YZSpJXfelXORmvRb
 VqyRMYo69t9fesKqJYKYDb+/xIZ39vHbly3O7Uve64hyCOfMWsX83i6/arviisIv24yET3hKrPV
 ojZmD0EHPGnUd28mGM8y3m7dSUZ1MXqBKxuKWI15hbva/skUWHY1wHz4fSIq82tGsvqcnLlHMbr
 UbtpT4Fpo8NMkHfaFqy/cxTM2e1rw6rz0PfXQ6qLVzgmtiOOv+4WyyaImITuekcWpqOk5RgRXPn
 We6K6fRgl2J8J2/DNyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2MCBTYWx0ZWRfX60GilzvjxDUQ
 CjK4IzmxjqZG0s8HC66bCzRTKXkOMapk52aldensFxamU1mTvstkHREfBQifM8b9TOdlBFznueW
 77kP+ZnChrDCLjmsku+z+KIdJChERnc=
X-Proofpoint-ORIG-GUID: bbZKGcE3DsH2quWGHjyjKG-J32NrlPRi
X-Proofpoint-GUID: bbZKGcE3DsH2quWGHjyjKG-J32NrlPRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110060



On 11/6/26 11:05 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] s390/vfio-ap: stale commit message in
>    vfio_ap_setup_vfio_device_migration()
> --
>
> commit 91bb5c1f210ed8cb015ed15a312ace69b31f9fa7
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Set up for vfio-ap device migration
>
> This commit adds vfio_ap_setup_vfio_device_migration() to configure
> migration flags and callbacks on the vfio_device for non-SE guests and
> calls it from vfio_ap_mdev_probe() prior to device registration.
>
>> * The initial migration state of the vfio-ap device is set to RUNNING
>>
>> * The boolean flag indicating that all data sent from userspace during the
>>    RESUMINMG phase has been received is initialized to false.
> [ ... ]
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 4af734aeee17e..924c25585987c 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -217,6 +217,30 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
>>   	return 0;
>>   }
>>   
>> +static const struct vfio_migration_ops vfio_ap_migration_ops;
>> +
>> +/**
>> + * vfio_ap_setup_vfio_device_migration:
>> + *
>> + * Plug the object containing the function pointers to the migration callbacks
>> + * used to facilitate migration into the vfio device and set the flags
>> + * indicating migration states STOP, STOP_COPY and RESUMING are supported.
>> + *
>> + * @matrix_mdev: pointer to object containing the vfio device (vdev)
>> + */
>> +void vfio_ap_setup_vfio_device_migration(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	/*
>> +	 * Live guest migration is not supported for SE guests, so there is no
>> +	 * need to initialize the migration capabilities.
>> +	 */
>> +	if (ap_is_se_guest())
>> +		return;
>> +
>> +	matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
>> +	matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
>> +}
> [Severity: Low]
> This isn't a bug, but the last two bullet points of the commit message
> describe initializing mig_state to VFIO_DEVICE_STATE_RUNNING and
> resuming_mig_data_complete to false, which was already done in
> vfio_ap_init_migration_data() in commit "s390/vfio-ap: Functions to
> initialize/release vfio device migration data" rather than in this patch.
>
> Also, placing vfio_ap_setup_vfio_device_migration() after the definition
> of vfio_ap_migration_ops alongside vfio_ap_init_migration_data() would
> avoid the forward declaration of vfio_ap_migration_ops.

Fixing both for v13

>

