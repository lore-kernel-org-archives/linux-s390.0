Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967009;
	b=tmKWzhRzYvFoGZP1pfE8iLh7xLvLsoREBsFAuYFFhk0MYhMeWb2tjAMC7+2MeCDvNCvq
	 /pqyMO9JeghdqlvPKX+NlgwpfBrkHVOISmL1HjFRsXvfPo3+wAGqIgE2/lzmO31darVJi
	 HJSANOKhlJWkG6nS+77vVhvERbaH36E4GjYdsqR7Anb2NF76R3MsLhJd7KhaJZ2YJdlu9
	 UuEYIFd2IoNmVk9MLFX6pzKD5LQHYzC+Lht0SnX1QHZSElozz2Bw5Zw2v0Hi5z5tdXKwb
	 Sdtt3O0o0SAAz6JMmyM9PsJKU1qxQ0bhe16o9jIu/gIdBAx05Rr3B8HIxtYLOb3+Mmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967009;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2byU4wVi1StoOHLsHgcPhZKBXMDgVuCzlcG5Ij2GSIg=;
	b=hF5EJfTzdAAGhOrNiJy7j5e+kaWSvB+H0EDW/GW5IsiIrSBE75tSHqjZcU5VcszO4Y05
	 7zidYFmkB2NdgjqYKxWUDnWvG4V0Bxhw64GFW5d0xBm0LvBM557wmB5CKxTNlIB7aqog/
	 FHFVWwREiEPxA7U7ZbnK7AaR13dfuzHy35mlAU/JgqpI3xHQUJb91cT5rfJpvxb6OgLEp
	 DIxiRDxS9kUyzmVHV8O0B/y5jSzfoJP/oLWZyMZEw+e7UzYMtPyF86rhS8id0gmJrS1+i
	 hMJrLss+m2zj36aCnS+FzGcK1WVAjGqi396ci3AoRROZQwQuV/d+FnIYLalT540ggRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OGhsr59H;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A9606A339;
	Fri,  6 Nov 2026 12:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 816A9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OGhsr59H
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ai9lN2368358;
	Fri, 6 Nov 2026 12:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2byU4w
	Vi1StoOHLsHgcPhZKBXMDgVuCzlcG5Ij2GSIg=; b=OGhsr59HYN5jmPfIxZyNNY
	J9TCTXdSWz6KzktpgqHGdsbCU+x/s9946oKIW/0bW49zpXTxTwtaRLWZTFQKBgu5
	VqvQdAuXIXNY2fGDkG79KQulaP1exi4CpbdoYngB4itUMpnEME+/7m2m/pH9KiEx
	03/OTveaXdEyl36IjtSe9fxt+40rrRJ36T/xHueJTZDUWiSu4PpCRLPl1GWLML/z
	aXdhSCvMvO6dRrJJY21Hdysf+AcAAWTE8fOcn/A50DzlPgUnPIIdaVD1mMB9huu4
	o/csDMWXQUBO91WrFXtxsdgOkmqljKxyfLvUOOUoPrK+JRjP8MB1fNykMXDKnyYw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rcc2yk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 12:10:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Anoxs3260566;
	Fri, 6 Nov 2026 12:10:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v6ys9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 12:10:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6CA5lk49742220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 12:10:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C1875805A;
	Fri,  6 Nov 2026 12:10:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B1775805E;
	Fri,  6 Nov 2026 12:10:04 +0000 (GMT)
Received: from [9.61.114.69] (unknown [9.61.114.69])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 12:10:04 +0000 (GMT)
Message-ID: <570bdfce-fc42-4aab-856b-dfe66656d3be@linux.ibm.com>
Date: Fri, 6 Nov 2026 07:10:03 -0500
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
Subject: Re: [PATCH v11 03/14] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-4-akrowiak@linux.ibm.com>
 <sashiko-outbox-193701@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-193701@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P3LMfPqEJAuQIw-OdTKBLwJgYEwbKcK1
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aedc39f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qGfIvsC6O27SEb7dLMIA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: P3LMfPqEJAuQIw-OdTKBLwJgYEwbKcK1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NiBTYWx0ZWRfXyaatC79fAflw
 c/2q3J2ipFIvuQXxeL1K+55MU9v1PQG7Dz7dsOZSmOWyfXrSlsHboR3fRY3XfBKbju4SzwEIHbi
 +/FZ8RbfsSs77OVwNzptk6bppGggpRKb+ceT7M8dyREG4HC3h19qFFfItWthI6LZxwHHygPfm0K
 EeYct6LxCNd1hI0dUhzHPRiWMh+8QtsIhWcme0aabxu8yHqzkzp/62ZlZ39fSNVHx4+Xx1aD+Wi
 rJspAluzXP7cX0JDyvRWm95dOF2eLz4BMSwK+Uw2gHB29uRe72xy59AvzDnqctRwVL0+kmWYOpL
 TVIhxav7RzhpbLaWydXQ5QOzjsStbjKZ0YsT5Jb8aBSDjlEO/FgnGd77f2tGQUhoT16AZpn8YJD
 6VBdsCn/mZ8BA+ymTKIyQBPzqUCvgIY3V/hS6XoXMhOmwiX/41wRREa5armUsEJvLNmoSfkDsdf
 KTg3GsCojHNo1/g7a6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NiBTYWx0ZWRfX3DGP//Rev2cX
 3ml4l2e66boEX1Ipn1rRaJH0KylnA+k4+A5LvSI2Qm5nNI6vtZHOK9EzEPcHjGA9vMqSwPj+vAk
 Sf/f4JjxTl19tciW24iXtDZeRyI9xX4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060046



On 11/2/26 10:46 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] s390/vfio-ap: use-after-free of mig_data when migration FD outlives device FD
> - [Medium] s390/vfio-ap: commit message does not match code in vfio_ap_migration.c
> - [Low] s390/vfio-ap: malformed kernel-doc comment on vfio_ap_release_mig_files()
> --
>
> commit 2bff67e6f9b81966cd8ed45a78897f37868b65ad
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Functions to initialize/release vfio device migration data
>
> This commit adds functions to allocate, initialize, and release the data
> structures used to maintain live guest migration state for vfio_ap mediated
> devices when the VFIO device is opened, closed, or released.
>
>>      s390/vfio-ap: Functions to initialize/release vfio device migration data
>>      
>>      Provides the functions that initialize and release the data structures
>>      used during live guest migration:
>>      
>>      * vfio_ap_init_migration_data
>>      
>>        Allocates and initializes the object used to maintain the state of the
>>        VFIO migration. It is called when the VFIO device is opened.
>>      
>>      * vfio_ap_release_migration_data
>>      
>>        Frees the memory of the object used to maintain the VFIO migration
>>        state. It is called when the VFIO device release callback is invoked
>>        and when the VFIO device is closed.
>>      
>>      * vfio_ap_release_mig_files
>>      
>>        This function is called from the vfio_ap_release_migration_data
>>        function (above) and releases the vfio_ap_migration_file objects
>>        contained within the vfio_ap_migation_data object used to maintain
>>        the state of the VFIO migration process.
>>      
>>      * vfio_ap_release_stop_copy_file
>>      
>>        This function is called from the vfio_ap_release_mig_files function
>>        (above) to release the vfio_ap_migration_file used during the
>>        STOP_COPY phase of migration. For now, this is a stub function that
>>        will be fully implemented in a subsequent patch after the
>>        vfio_ap_config object referenced within is allocated, as it will
>>        need to be freed according to how it is allocated.
>>      
>>      * vfio_ap_release_resuming_file
>>      
>>        This function is called from the vfio_ap_release_mig_files function
>>        (above) to release the vfio_ap_migration_file used during the
>>        RESUMING phase of migration. For now, this is a stub function that
>>        will be fully implemented in a subsequent patch after the
>>        vfio_ap_config object referenced within is allocated, as it will
>>        need to be freed according to how it is allocated.
>>      
>>      * vfio_ap_set_state, vfio_ap_get_state and vfio_ap_get_data_size
>>      
>>        These three functions are callback functions assigned to the
>>        vfio_ap_migration_ops (.migration_set_state, .migration_get_state
>>        and .migration_get_data_size function pointers).
>>      
>>      Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 2a0a8c76f820e..d525dec782a18 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -4,6 +4,7 @@
>>    *
>>    * Copyright IBM Corp. 2025
>>    */
>> +#include <linux/file.h>
>>   #include "vfio_ap_private.h"
>>   
>>   /* Magic number and version for the vfio_ap_config migration blob */
>> @@ -123,3 +124,105 @@ struct vfio_ap_config {
>>   	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
>>   	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>>   };
>> +
>> +static void
>> +vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
>> +{
>> +	kvfree(mig_data->stop_copy_mig_file.ap_config);
>> +	mig_data->stop_copy_mig_file.ap_config = NULL;
>> +	mig_data->stop_copy_mig_file.config_sz = 0;
>> +	mig_data->stop_copy_mig_file.filp = NULL;
>> +}
>> +
>> +static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
>> +{
>> +	kvfree(mig_data->resuming_mig_file.ap_config);
>> +	mig_data->resuming_mig_file.ap_config = NULL;
>> +	mig_data->resuming_mig_file.config_sz = 0;
>> +	mig_data->resuming_mig_file.filp = NULL;
>> +	mig_data->resuming_mig_data_complete = false;
>> +}
> [Severity: Medium]
> Is the commit message out of sync with the changes in
> drivers/s390/crypto/vfio_ap_migration.c?
>
> The changelog describes vfio_ap_release_stop_copy_file() and
> vfio_ap_release_resuming_file() as stubs to be implemented in a subsequent
> patch, but both functions are already fully implemented here to call
> kvfree() on ap_config and reset the fields on stop_copy_mig_file and
> resuming_mig_file.
>
> The changelog also states that this commit provides vfio_ap_set_state(),
> vfio_ap_get_state(), and vfio_ap_get_data_size() assigned to
> vfio_ap_migration_ops, which are not present in this patch and instead get
> introduced in later patches in the series, along with the usage of the newly
> added linux/file.h include.

Will change for next version

>
>> +
>> +/**
>> + * vfio_ap_init_migration_data - initialize migration data and functions
>> + *
>> + * @matrix_mdev: pointer to object containing the mdev state
>> + *
>> + * Return: zero if initialization is successful; otherwise, returns a error.
>> + */
>> +int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	struct vfio_ap_migration_data *mig_data;
>> +
>> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +	/*
>> +	 * Live guest migration is not supported for SE guests, so there is no
>> +	 * need to initialize the migration data.
>> +	 */
>> +	if (ap_is_se_guest())
>> +		return 0;
>> +
>> +	mig_data = kzalloc_obj(struct vfio_ap_migration_data, GFP_KERNEL);
>> +	if (!mig_data)
>> +		return -ENOMEM;
>> +
>> +	mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
>> +	mig_data->resuming_mig_data_complete = false;
>> +	mig_data->resuming_mig_file.matrix_mdev = matrix_mdev;
>> +	mutex_init(&mig_data->resuming_mig_file.lock);
>> +	mig_data->stop_copy_mig_file.matrix_mdev = matrix_mdev;
>> +	mutex_init(&mig_data->stop_copy_mig_file.lock);
>> +	matrix_mdev->mig_data = mig_data;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * vfio_ap_release_mig_files:
>> + *
>> + * Free the ap_config buffers for any open migration FDs. Although a
>> + * migration FD may still be held open by userspace, it is safe to free
>> + * mig_data here because:
>> + *
>> + *   1. matrix_mdev remains valid for the lifetime of any open migration
>> + *      FD via the vfio_device registration reference taken in
>> + *      vfio_ap_open_file_stream() and dropped in
>> + *      vfio_ap_release_mig_file().
>> + *
>> + *   2. mig_data is only accessed by the migration file ops
>> + *      (vfio_ap_stop_copy_read, vfio_ap_resuming_write) under
>> + *      mdevs_lock. Once mig_data is set to NULL by the caller, those
>> + *      paths will see NULL and return -ENODEV before dereferencing it.
>> + *
>> + * @matrix_mdev: The object used to maintain the state for a mediated device
>> + */
>> +static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
> [Severity: Low]
> This isn't a bug, but the kernel-doc comment on vfio_ap_release_mig_files()
> in drivers/s390/crypto/vfio_ap_migration.c omits the short description on the
> identifier line and places the @matrix_mdev parameter description after the
> body text, which triggers a scripts/kernel-doc warning about a missing
> initial short description. Should the short description and @matrix_mdev
> parameter be moved to the top of the kernel-doc block?

Will fix for next version.

>
>> +{
>> +	struct vfio_ap_migration_data *mig_data;
>> +
>> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +	mig_data = matrix_mdev->mig_data;
>> +	vfio_ap_release_stop_copy_file(mig_data);
>> +	vfio_ap_release_resuming_file(mig_data);
>> +}
>> +
>> +/**
>> + * vfio_ap_release_migration_data: reclaim private migration data
>> + *
>> + * @matrix_mdev: pointer to the object containing the state of the mdev
>> + */
>> +void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +	if (!matrix_mdev->mig_data)
>> +		return;
>> +
>> +	vfio_ap_release_mig_files(matrix_mdev);
>> +	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
>> +	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
>> +	kfree(matrix_mdev->mig_data);
>> +	matrix_mdev->mig_data = NULL;
>> +}
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 01439f0ca42ab..1aada3068df5f 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> @@ -2052,19 +2062,39 @@ static int vfio_ap_mdev_reset_qlist(struct list_head *qlist)
> [ ... ]
>
>>   static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
>>   {
>> -	struct ap_matrix_mdev *matrix_mdev =
>> -		container_of(vdev, struct ap_matrix_mdev, vdev);
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>> +	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
>> +	vfio_ap_release_migration_data(matrix_mdev);
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>>   
>>   	vfio_ap_mdev_unset_kvm(matrix_mdev);
>>   }
> [Severity: Critical]
> As reported by Sashiko on v3 [1], can closing the VFIO device file descriptor
> while a migration file descriptor remains open trigger a use-after-free of
> matrix_mdev->mig_data?
>
> In drivers/s390/crypto/vfio_ap_migration.c, struct vfio_ap_migration_data
> embeds resuming_mig_file and stop_copy_mig_file by value:
>
> struct vfio_ap_migration_data {
> 	enum vfio_device_mig_state	mig_state;
> 	bool				resuming_mig_data_complete;
> 	struct vfio_ap_migration_file	resuming_mig_file;
> 	struct vfio_ap_migration_file	stop_copy_mig_file;
> };
>
> When a migration stream file descriptor is opened in
> vfio_ap_open_file_stream() (added in later patches in this series),
> anon_inode_getfile() sets filp->private_data to &mig_data->stop_copy_mig_file
> or &mig_data->resuming_mig_file, and takes a registration reference on
> vdev via vfio_device_try_get_registration().
>
> That registration reference keeps struct ap_matrix_mdev alive until
> vfio_ap_mdev_release_dev(), but it does not prevent the last close of the
> VFIO device file descriptor from calling
> vfio_ap_mdev_close_device()->vfio_ap_release_migration_data(), which destroys
> stop_copy_mig_file.lock and resuming_mig_file.lock and frees
> matrix_mdev->mig_data with kfree().
>
> When userspace subsequently reads, writes, or closes the open migration file
> descriptor (including during process exit when close_files() closes the
> lower-numbered VFIO device FD before the migration FD),
> vfio_ap_stop_copy_read(), vfio_ap_resuming_write(), and
> vfio_ap_release_mig_file() dereference filp->private_data (mig_file->lock,
> mig_file->filp, and mig_file->matrix_mdev) inside the freed mig_data object.

Confirmed. Closing the VFIO device FD while a migration FD remained open
freed matrix_mdev->mig_data because vfio_ap_mdev_close_device() called
vfio_ap_release_migration_data(). While vfio_ap_open_file_stream() holds a
vfio_device registration reference that keeps matrix_mdev alive, it did
not protect mig_data from being freed on device close.

In v12, this is resolved by decoupling migration data lifetime from device
close

>
> [1] https://lore.kernel.org/r/20260630111142.08F0A1F00A3A@smtp.kernel.org
>

