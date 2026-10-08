Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A061370ADF;
	Thu,  8 Oct 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464923; cv=none; b=sflzO5o2EpP/y/yq+t3Ph8zkwX0hvB2lgVbI6mAZGp27X2urmcWC3+CDCPd3vOj7yM3CqLJ1KJ4OdBvlbrP7ig1FHeOHiPEbt/Vcpgy1jW2mhtbnj4o0BABrt83wETIZD5BooePyD0YAJMVDNC6UmHFwgpjH8gsUCeUfyhtGztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464923; c=relaxed/simple;
	bh=H5NJEt7yqMOxy2xNJagzstQ0Al3T8AXoJEniT1Zx0ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thMTF/4/QlnoOjtjyk60fLga5HxuMCr9jeK1UvffAx4t9RJggHPeIZ86cvfQl+K65u6+e8FGrvB53sLSkeghhbHz1S/Bm97KOFAzWAZ21Yt4JbEjV/Bpu5QXY1uvk2+1oHTkUuDUqASU6AHPmfn5Fd4eVOqMZ8auqwAK/Me9YtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PpWsnrIg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PpWsnrIg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698BZjX5005448;
	Thu, 8 Oct 2026 13:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0S7Y1Y
	G8Vfh/MGfmUDV8Mrn2GW3PZELRw5BkIarHP/U=; b=PpWsnrIgEM6DU0sNeu4rI6
	JQvlLnMXdgKGLkJhivaSSiwjmJFfniwz2DL+J0CKGriYZCMSNoJri9JFZThb7znZ
	/OiB4MvbtxPNSlhYWCKQh8UADK/kDq79WbVQg77QQbKdLGoGER1rtAUMvCugpMD2
	zc+NINwRKAXhF+Ga+YA55zK8gMTPVfPvcTqNJCX0TlZL5bz8Gw7G63NgkRPs7PQc
	sVHwFQlWZJIuGZjQ24YNhwmSJFNZqJcUOI8XiVeRqAscpfShTpTMF1CBmJiuVy7u
	VhXgvaLn0Ip4pdrlqW4ib4BBVmwPWT35CG+xL5oXi14Y21hQ7Z4XdVuWGTNDkoEw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1bhcq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 13:08:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698BHsC52134675;
	Thu, 8 Oct 2026 13:08:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3tx9q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 13:08:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698D8dMq28836392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 13:08:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 657C358055;
	Thu,  8 Oct 2026 13:08:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5C355805D;
	Thu,  8 Oct 2026 13:08:38 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 13:08:38 +0000 (GMT)
Message-ID: <a73af766-7013-4598-83d9-60bd291fdc7d@linux.ibm.com>
Date: Thu, 8 Oct 2026 09:08:38 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/15] s390/vfio-ap: Transition device migration state
 from STOP to RESUMING
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, kvm@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-9-akrowiak@linux.ibm.com>
 <20260807224158.85FFE1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260807224158.85FFE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac795d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yHdRKbl5wnh_rvcmk_oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfXyCvVGaAd6Xdl
 a5bxpWw9BuaXSjCKa7dzbo4r5l7c07CgkeLj5KA7b1vrLIg4NesZDrHdTJ5Xl6b48C9MtRpAkFI
 LVl9tmFXNQgpgT98eDj8DHyZ7GS2KaEYk2lNtQZeeFLlQVUCsbyKfvRSlzbH06uhKIsZChBbWPh
 1lBYgz32N1VOtHZrGkMyLgOdzxL4xOliIT6ol4coE7slHwxY/upiG8wg10Gd5Hn46HxAylf82kZ
 +m4CKQ2LFZxAzYaFOcqF6ubVh4dxhKh0U7Zf665hjSytuSPXWKO5haAX4JJ3Wgd1bLK6F92YaXK
 LyLJ+MaeDmacZQ4SiiNhBR+ZEyh4VjoFy5RQBBu+IVNGb5Y1rFkd/QikF/KG6JvkREbY0dRvoWG
 +VDfK3GYHR7sItW2QCe6CeS3IyIp6mz0w6vPFojk1lizns4z/W1BLeW2PcfOYlbxItSNIamljzE
 ejCke8iXF2EeluEIzAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX1Rc9ncP5rm2a
 AflzlRwhRfxPCQUODg586Hnipnwl6aDb12UU3D1+Y7jR28ndO+zO4KC85p2fUDiQgGAJeQMBJ0q
 1ig0Jd9gaSnhtQJAnvZ/WIhWCmzJtWc=
X-Proofpoint-GUID: 8_4xDEgq1ZgqA4NPxc4S1UeYtHaccJs-
X-Proofpoint-ORIG-GUID: 8_4xDEgq1ZgqA4NPxc4S1UeYtHaccJs-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080052



On 8/7/26 6:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Dangling pointer dereference and Use-After-Free (UAF) in `vfio_ap_stop_copy_read` due to dropped lock.
> --
>
> --- Patch [8]: [PATCH v7 08/15] s390/vfio-ap: Transition device migration state from STOP to RESUMING ---
> commit d54f2e0efd43f553196ad099672d0319fbd7c8d9
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Transition device migration state from STOP to RESUMING
>
> Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
> starts a process of restoring the device state of the vfio device on the
> target system. To prepare for restoring the device state, open a file
> stream to receive the guest's AP configuration saved when the device state
> on the source system transitioned from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_STOP_COPY.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 50781b61f7f18..e2e7ae8515e55 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -451,6 +451,26 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
>>   	return filp;
>>   }
>>   
>> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>> +				      size_t len, loff_t *pos)
>> +{
>> +	/* TODO */
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static const struct file_operations vfio_ap_resume_fops = {
>> +	.owner = THIS_MODULE,
>> +	.write = vfio_ap_resuming_write,
>> +	.release = vfio_ap_release_mig_file,
>> +};
> [Severity: Critical]
> Can a concurrent device close or reset cause a use-after-free when reading the
> migration state?
>
> While looking at the migration file operations, I noticed a potential regression
> in vfio_ap_stop_copy_read() where mdevs_lock is acquired but explicitly dropped
> before copy_to_user():
>
> drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
>      ...
>      mutex_unlock(&matrix_dev->mdevs_lock);
>
>      if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
>          return -EFAULT;
> }
>
> If userspace concurrently issues a VFIO_DEVICE_RESET ioctl or closes the device
> FD while the read thread has dropped mdevs_lock, vfio_ap_release_mig_files()
> will acquire mdevs_lock and call kvfree() on
> mig_data->stop_copy_mig_file.ap_config.
>
> When the read thread resumes, copy_to_user() will read from the freed buffer,
> which could leak kernel memory contents to userspace.
>
> Additionally, mdevs_lock is also dropped in vfio_ap_get_config() for a
> potentially long-running operation:
>
> drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_get_config() {
>      ...
>      mutex_unlock(&matrix_dev->mdevs_lock);
>      ret = vfio_ap_store_queue_info(mdev_name, ap_configuration);
>      mutex_lock(&matrix_dev->mdevs_lock);
>      ...
> }
>
> If the device is closed and re-opened during this window, mig_data itself can
> be freed and reallocated.
>
> However, vfio_ap_stop_copy_read() caches a local pointer before calling
> vfio_ap_get_config():
>
> drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
>      ...
>      mig_file = &matrix_mdev->mig_data->stop_copy_mig_file;
>
>      if (!mig_file->ap_config) {
>          ret = vfio_ap_get_config(matrix_mdev);
>      ...
> }
>
> This leaves mig_file dangling when vfio_ap_get_config() returns. This could
> lead to a use-after-free when subsequently accessing mig_file->config_sz or
> mig_file->ap_config.
>
> Are there protections against mig_data or ap_config being freed while
> mdevs_lock is dropped during these operations?

This is a legitimate observation.
The fix will be to hold mdevs_lock for the full duration of
vfio_ap_stop_copy_read(), including across copy_to_user() and the
vfio_ap_store_queue_info() call in vfio_ap_get_config(). This
serializes against vfio_ap_release_stop_copy_file() (called from
both vfio_ap_reset_migration_state() and vfio_ap_release_migration_data()),
eliminating both race windows.

>
> [ ... ]
>

