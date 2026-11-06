Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967399;
	b=BfIxxSylxVeHF5shyvuBD7KzInOqCZ9aCAa5aLXP821uJ8orelFmSwkv3TrFnRUb4IYS
	 LTgOv05ZMcz+y3qnUESO9dX+2p1jMuPgPYCXaywON+GaNNEulIAZhsTxXVtUNGt+ZPs7M
	 crQp7wn3+J3By0jB/idI6d+6q6hKQ0lDVG2WKObqAnDNV0fSQ9/fnrQnmO3JUqGFVbm82
	 m9A58fKpLsJCprvQZY3TLp+Phj2kGY/7qB7ZMUWoc5SjTPIM3ExEGi95EdQr2u7L5dz7T
	 UYy3XPN8ke6fNskU1NcBryBaOR0M9daNyczIYAFTIB7Xc0NdumJL+CAs48qhTUS4iGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967399;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ko2SHT9WKvfumTuARCO9td57uzBOV1aZhASS9MQ0K20=;
	b=UIeAZbetFi8i6IvyP0/6M6XPRJvhysiC5hSBILtw+XPhGCj5UQIB7VvweNiXv8EUJ8H+
	 dyGD4ACooV/sgn6uyYYTk99/TcvLRmPObA7UheTXKGBUr5VyST16GDXZAjbywhM9Iby6m
	 xUMT/KrZpei6VX1zSqh/gmeQcNhQdH/v50LRSceQrTH/vkKFjsKJaHbRAvxV/im8+NRg5
	 aNku5i3N120ycIhNwMZhbeSO3K3vQMg9AzaiUCUg5y7HXic12XnrJnoUAU1aJijHyvZo1
	 I6bgPqj1bUWIzLaVgl3GfG7InGgz25B4KUXGVo2HnyzGnbJI4GnI1GCDP/HNVJnw99Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z7X2ydW5;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2E606D804;
	Fri,  6 Nov 2026 12:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E2E606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z7X2ydW5
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ai2rB2142948;
	Fri, 6 Nov 2026 12:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ko2SHT
	9WKvfumTuARCO9td57uzBOV1aZhASS9MQ0K20=; b=Z7X2ydW55KAdZXxKIr+R7z
	YBj25hFq42zQOfZCKJSPBQbduJYexjgpTM5+dn67XH9ymr3O5dgDd+4Z0hRnrclV
	d4w5K6laOQ+GtibKwsVxFKUO+2P5VOIIIeQjsiDomqLQsMBxBnHhQMVrwznam2m2
	i7SRkU48hxPVbkRvESlERR1uYjxidFmW0uvj7eAqo6vGjwBjVCDNzqXDPc/+Kt3a
	dQj/CbsGgqWMmGxDZc9cFFlxWY2B2/i1v/ddIkLJOqlVW8oQNMHS73Ds4Ydm0bFk
	9IoutLJ9zW8tnt5Ed/RT2vXvxHEuP3KZ9HJcBA4LY/zdpAWafhcpItg1xh0RcpIA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r9439u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 12:16:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AnsDE3260598;
	Fri, 6 Nov 2026 12:16:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v70cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 12:16:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6CGYUI23069330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 12:16:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CAF858063;
	Fri,  6 Nov 2026 12:16:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4CB5805A;
	Fri,  6 Nov 2026 12:16:33 +0000 (GMT)
Received: from [9.61.114.69] (unknown [9.61.114.69])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 12:16:33 +0000 (GMT)
Message-ID: <1748fc92-1915-43ae-b061-b4bbcb9dffd6@linux.ibm.com>
Date: Fri, 6 Nov 2026 07:16:33 -0500
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
Subject: Re: [PATCH v11 06/14] s390/vfio-ap: Transition guest migration state
 from STOP to STOP_COPY
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-7-akrowiak@linux.ibm.com>
 <sashiko-outbox-193746@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-193746@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedc525 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VYjU2es3atCwa4kvyGUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Jwszwc9_0OcRDmsJwAWAPWqSJRr-0ACH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0OCBTYWx0ZWRfX1XxODKdn9Eeo
 TI3Nk69SSSz+BVw295VaW2u8XpgdRXpbIwEbm5vcRjru/hutlLr+/zoE8IV7X1jnB5LXtgSqo6j
 WH4DS/dfAmoTFr9ZdblZNbTTsS47gFolZHqyIM69HuYKsR8MMx4phyU/KyRjL1wWI2CSqPSaWhL
 UA9hedhB8GOMVcXVbZcUAGn2yLw0mVKQPYUb3D/yrbUVTQ/95A8wzj9QRK3LYfvlnaMo7YlyW8f
 YZi3yT9nj9h4ojRbkSteHqJ0whZd25pZMIOCJgvlkOUGMsYtHj9cWhfZGW6/EHkyKE3VAnYfaHJ
 bhgnXGFU7Lo9+xPaAzhaXRZTsyudNkebmstRE/2BAzv+/Kteaka8qaLe4vYhQYA6d/ScCniWYsx
 ApOYu1r2VoBUmIvGchobnnhNevsurOPYXasiQSWXJB7R398hPHyC7ql1qEYdNaSKXSWcjfOwuXC
 UzmBNcRogv7j111536A==
X-Proofpoint-GUID: Jwszwc9_0OcRDmsJwAWAPWqSJRr-0ACH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0OCBTYWx0ZWRfXwtULQKu5tsvp
 0WgDTFmcdzR+JUuomPGLBTrCRtEj20gE4p9mZA7lIL6Jw2ZT5l7lZY9w6bwC2+fqdCU3mWyuwvu
 Kht6KtQ2ZGDNksUrTBcZeco2e1/SP8s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060048



On 11/2/26 11:18 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] s390/vfio-ap: use-after-free in vfio_ap_release_mig_file() after device close
> - [Critical] s390/vfio-ap: use-after-free of mig_file in vfio_ap_release_mig_file()
> --
>
> commit d4f19cfbfd83130bd2529cc5a305e86f834b23bb
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
>
> This commit implements the migration state transition from
> VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_STOP_COPY by opening an
> anonymous file stream for reading the guest's AP configuration.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 8e4e04e039658..48028b12b26f9 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>> @@ -143,6 +144,62 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
>>   	mig_data->resuming_mig_data_complete = false;
>>   }
>>   
>> +static ssize_t
>> +vfio_ap_stop_copy_read(struct file *filp, char __user *buf, size_t len,
>> +		       loff_t *pos)
>> +{
>> +	/* TODO */
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
>> +{
>> +	struct vfio_ap_migration_file *mig_file = filp->private_data;
>> +
>> +	/*
>> +	 * The mig_file (and by extension mig_file->matrix_mdev) is tied to
>> +	 * migration FD lifetime (see vfio_ap_open_file_stream() function) to
>> +	 * guarantee that the matrix_mdev remains valid for every read/write
>> +	 * operation. Let's drop it here since the migration FD is being
>> +	 * released.
>> +	 */
>> +	vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations vfio_ap_stop_copy_fops = {
>> +	.owner = THIS_MODULE,
>> +	.read = vfio_ap_stop_copy_read,
>> +	.release = vfio_ap_release_mig_file,
>> +};
>> +
>> +static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_file *mig_file,
>> +					     const struct file_operations *fops,
>> +					     int flags)
>> +{
>> +	struct file *filp;
>> +
>> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +	/*
>> +	 * Pin the vfio_device registration so that matrix_mdev cannot be freed
>> +	 * while the migration FD is still open. The matching put is in
>> +	 * vfio_ap_release_mig_file().
>> +	 */
>> +	if (!vfio_device_try_get_registration(&mig_file->matrix_mdev->vdev))
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	filp = anon_inode_getfile("vfio_ap_mig_file", fops, mig_file, flags);
>> +	if (IS_ERR(filp)) {
>> +		vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
>> +		return filp;
>> +	}
>> +
>> +	stream_open(filp->f_inode, filp);
>> +
>> +	return filp;
>> +}
>> +
>>   static struct file *
>>   vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>>   			    enum vfio_device_mig_state new_state)
>> @@ -156,10 +213,23 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>>   	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
>>   		new_state);
>>   
>> +	/*
>> +	 * Begins the process of saving the vfio device state by creating and
>> +	 * returning a streaming data_fd to be used to read out the internal
>> +	 * state of the vfio-ap device on the source host.
>> +	 */
>>   	if (cur_state == VFIO_DEVICE_STATE_STOP &&
>>   	    new_state == VFIO_DEVICE_STATE_STOP_COPY) {
>> -		/* TODO */
>> -		return ERR_PTR(-EOPNOTSUPP);
>> +		struct vfio_ap_migration_file *mig_file = &mig_data->stop_copy_mig_file;
>> +		struct file *filp = vfio_ap_open_file_stream(mig_file,
>> +							     &vfio_ap_stop_copy_fops,
>> +							     O_RDONLY);
>> +		if (IS_ERR(filp))
>> +			return ERR_CAST(filp);
>> +
>> +		mig_file->filp = filp;
>> +
>> +		return filp;
>>   	}
> [Severity: Critical]
> Can this trigger a use-after-free of mig_file in vfio_ap_release_mig_file()
> (and in vfio_ap_stop_copy_read() in the subsequent patch) if the VFIO device
> file descriptor is closed while the migration stream file descriptor remains
> open?
>
> In vfio_ap_transition_to_state(), mig_file points to
> &mig_data->stop_copy_mig_file, which is embedded inside struct
> vfio_ap_migration_data:
>
> struct vfio_ap_migration_data {
> 	enum vfio_device_mig_state	mig_state;
> 	bool				resuming_mig_data_complete;
> 	struct vfio_ap_migration_file	resuming_mig_file;
> 	struct vfio_ap_migration_file	stop_copy_mig_file;
> };
>
> vfio_ap_open_file_stream() stores mig_file in filp->private_data and calls
> vfio_device_try_get_registration(&mig_file->matrix_mdev->vdev). However,
> vfio_device_try_get_registration() only pins struct vfio_device (and thus
> matrix_mdev) against unregistration; it does not prevent vfio_df_close()
> from invoking vfio_ap_mdev_close_device() when the VFIO device FD is closed
> (which also happens during normal process exit when close_files() closes the
> lower-numbered VFIO device FD before the higher-numbered migration data FD).
>
> When the VFIO device FD is closed, vfio_ap_mdev_close_device() calls
> vfio_ap_release_migration_data(), which destroys stop_copy_mig_file.lock and
> frees matrix_mdev->mig_data:
>
> void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
> {
> 	...
> 	vfio_ap_release_mig_files(matrix_mdev);
> 	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
> 	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
> 	kfree(matrix_mdev->mig_data);
> 	matrix_mdev->mig_data = NULL;
> }
>
> When the migration stream FD is subsequently closed (or read),
> vfio_ap_release_mig_file() retrieves mig_file from filp->private_data and
> dereferences mig_file->matrix_mdev from the freed mig_data allocation (and
> if the VFIO device was reopened in the meantime, a new mig_data is allocated
> while the old migration FD still points to the freed mig_data instance).
>
> Should filp->private_data point to matrix_mdev (or should mig_file/mig_data
> lifetime be tied to the open migration FDs) so that releasing or reading the
> migration FD does not dereference freed memory?

Confirmed. This is the same mig_data lifetime bug described in the 
review for
03/14.

As you noted, vfio_device_try_get_registration() protects the struct 
vfio_device
and matrix_mdev against unregistration, but did not protect mig_data 
from being
freed when vfio_ap_mdev_close_device() was invoked on device FD close.

In v12, this will be resolved this by tying the lifetime of mig_data
directly to the vfio_device lifetime

>

