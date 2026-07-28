Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6D41D64E;
	Tue, 28 Jul 2026 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277793; cv=none; b=lV0Zj23HtexnYzZz64KCk9BwNP8zy+tslMr/nNm39xZjWU9Ye9PmDntWr7EqCIWQbAayCkQr65ROlpOqxNv81XTFEn4frej/2/7U3Hftq7FzjfMpzt+ugGERHQgmT1abnra8EFvjFhDgK7CnWMFVJmtNaeXu2ts8I2VGs/bevoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277793; c=relaxed/simple;
	bh=F3TITQDsu/hD1ZoV5NLJy1EP/YsBTs/hPyttHKUn0o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8VAKvLmOFL49KZRprqtVOhN4cr5a7w/sMRX8fTc4lY7uag8bzbuHGSyau9Zm4dx2fqUXMsIPs9xQTkpxkwo4zOTfn3SbBg/mOLyyrvsiR/7EivgWQFpBoKBxrUed+vyCDmiZZam0lT1nYU9t0mlGfS9HV/Nr/6aNPLtq3tAU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UpkGeA5U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UpkGeA5U"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SLHevC2314612;
	Tue, 28 Jul 2026 22:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C7d6B4
	CPQNyVb+Dz8olwvmKAWGV8erneiKXzZxWPgIg=; b=UpkGeA5U6vP1WX11x3qfqF
	dlKjfLOXUyjSHGhqRg5790kKKvcdlKwNGLogOETNLCUTjmLF/VG0RNjgr8XVwSRo
	91ipbAJrFiFIyQdQgARURRF/xcvdx49Q7Ka86jHJYxDu00Aa2vAzR083XnB6yLhJ
	r3Ua6f+qiO859c+E3pO2rBxF27PEBJqUhhLd+JGStxxK8jHafu1yDs1OQ1ufKbOV
	SnEE0WQvQ7n0EW3hCWxuWi+Wx5hcT2NZYrteAKH55ySyx2wm62yXS7wRPIib5Ja8
	DKlUcpOoqIdqlqMdZjjct0bgE4pAJrpBak7HPoYDZwNku7pHRCRThO/TiRDr4YUQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7fuuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 22:29:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SMQHh0015728;
	Tue, 28 Jul 2026 22:29:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw4avy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 22:29:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SMTeTs31064592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 22:29:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AB4558053;
	Tue, 28 Jul 2026 22:29:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 799A658043;
	Tue, 28 Jul 2026 22:29:38 +0000 (GMT)
Received: from [9.61.138.160] (unknown [9.61.138.160])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 22:29:38 +0000 (GMT)
Message-ID: <41149777-2df1-4225-ac68-c9038302aee4@linux.ibm.com>
Date: Tue, 28 Jul 2026 18:29:37 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/15] s390/vfio-ap: Transition device migration state
 from STOP to RESUMING
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        Jason Herne <jjherne@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-9-akrowiak@linux.ibm.com>
 <20260727181408.805861F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727181408.805861F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oLcJUbYsYFkCJirNB54JCkZFm17nPQYR
X-Proofpoint-ORIG-GUID: oLcJUbYsYFkCJirNB54JCkZFm17nPQYR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE5MCBTYWx0ZWRfX08o3/FXB2zDA
 nFJwtbB1f1G7NIl2mJQeEA8jTGsOcGV2jN3FF9H/9PR7HsN851mB5QhXqRJ8scDM/6GhyVvjUfV
 8MbhS0E4Fpa6db/K/ysW2B0P3spFSCAl2htgfXL9dkL1OzL4tjyIjYEmWRORoF0w00korOdcg+R
 0bs9NozuuP5Hq0DnmoXwZGUd1RfBk8YLkryK4sHtDXqZZIlUBNUfp1QGA1wbnX70HCseW+56kdY
 Hlj8djhfUY+czfa6mMaAB5+mBkWGk3QgHb90uG7AgItkskr4vQefpAhZadQTOZJSNXUgghJDb8d
 nbH6Fn0lt7dpdxIWIf331+ECkBkbo2evsb54zjWBVj5dtQojPnazGTYVozzKT4Jmt1w8wNFltms
 M6OxsUCUh4k+I2/aNCsv2O3ZxEqV98OCWXBsL8+izpo/bqo6bb6DENjnlmPA6ZF2Dh7Bcdewj+i
 QhGfsXIfMWtB1tRc0Kg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a692d56 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4G_R_3pfNkNP-tWYsqoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE5MCBTYWx0ZWRfX7Xk0hXl9o2kE
 mX7EJvSPIXnESFmWUv31DXLITplSzsv+YqJ/atOe4oChuGfQ8ezZISlsN5dH2zkL6A8Q9xXY26/
 RHSmggowgQeV0rf+mXU4go7gbD/RUwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280190



On 7/27/26 2:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Use-After-Free in `vfio_ap_stop_copy_read` leading to kernel memory leak to userspace.
> - [Low] The `.release` callback logic for cleaning up the resuming and stop-copy file states is completely unreachable dead code.
> --
>
> --- Patch [8]: [PATCH v6 08/15] s390/vfio-ap: Transition device migration state from STOP to RESUMING ---
> commit 798f82863e85b4d37fd3594dc855fe7caaaaf7f5
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
>> index e4bc67b1eb842..c7fecad0b6769 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> @@ -99,6 +108,8 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
>>   
>>   	if (filp == matrix_mdev->mig_data->stop_copy_mig_file.filp)
>>   		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
>> +	else if (filp == matrix_mdev->mig_data->resuming_mig_file.filp)
>> +		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
> [Severity: Low]
> Is this conditional branch actually reachable?
>
> During vfio_ap_open_file_stream(), the driver takes an internal reference to
> the file via get_file(). This means the VFS .release callback is only invoked
> after the driver explicitly drops its reference by calling fput().
>
> If fput() is called in vfio_ap_release_mig_files(), which first sets
> mig_data->resuming_mig_file.filp = NULL, won't filp inside mig_data always
> be NULL by the time this .release callback executes?
>
> Consequently, will this check always evaluate to false, leaving
> vfio_ap_release_resuming_file() as unused dead code?

This is correct; those branches are unreachable. The root cause is
that vfio_ap_release_mig_files() calls fput() on the stored filp and then
immediately sets it to NULL, before the deferred .release callback can
fire. Since fput() always defers __fput() via task_work or a workqueue
(it never calls .release synchronously while a mutex is held), the .release
callback always arrives after the pointer is already NULL — making both
else if branches dead code.

The design will be reworked.

>
> [ ... ]
>
>> @@ -400,6 +411,26 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
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
> Could the migration file stream logic be vulnerable to a use-after-free when
> the device file descriptor is concurrently closed?
>
> Looking at the related vfio_ap_stop_copy_read() stream implementation, it
> drops mdevs_lock before calling copy_to_user():
>
> drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
>      ...
>      mutex_unlock(&matrix_dev->mdevs_lock);
>
>      if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
>          return -EFAULT;
>      ...
> }
>
> If the device file descriptor is concurrently closed, vfio_ap_mdev_release()
> could invoke vfio_ap_release_migration_data(), which acquires mdevs_lock and
> frees the mig_data structure.
>
> When vfio_ap_stop_copy_read() resumes, will it dereference the freed mig_data
> structure via mig_file->ap_config and leak kernel memory to userspace?

The use-after-free described is not present. The safety relies on two
invariants:

1. matrix_mdev (and therefore mig_data) cannot be freed while the migration
    FD is open. vfio_ap_open_file_stream() calls
    vfio_device_try_get_registration() which pins matrix_mdev until
    vfio_ap_release_mig_file() drops it. Device teardown
    (vfio_ap_mdev_close_device()) can free mig_data independently, but
    matrix_mdev itself remains valid.

2. mig_file->ap_config is allocated once in vfio_ap_get_config() and freed
    only in vfio_ap_release_stop_copy_file(), which requires mdevs_lock.
    Since vfio_ap_stop_copy_read() advances *pos and snapshots read_pos
    before dropping the lock, any concurrent path that acquires the lock and
    frees ap_config can only do so after the position has already been
    committed — and copy_to_user() only touches the buffer contents, not the
    pointer itself.

>

