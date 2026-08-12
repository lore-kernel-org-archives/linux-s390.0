Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B75388E60;
	Wed, 12 Aug 2026 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551851; cv=none; b=Tp1LwBykVHXgdeCvojDAVv/0/i9JUApzoPjGcAXgS8vRSXQUkUSr1/m0TxBy54EO8Zp4pkOK21T/AnTNge1b3mQ46kKKb0G23Gw1bHcwEcIgwFIsm9elRpc4EHe5su2uV4w1kmobrNWhaFqn+cNtRWZvVQYi/ttpSbRVmp49OxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551851; c=relaxed/simple;
	bh=AMxoSUsgKz4VJmQ5W90BELXPa9YKX/193DjYnjssJ3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRAu4wOivn20/GXkCWt3s5k0qHLHsoZtG24rdObJe9llfMHrCDLBgTZCzprsKRjUFWvDSCm9chUMiMa0X9apQY5e57Y34ohRnbLwe0dzi1Lniu+nLFC6C+71WTRWHk2S3yYwNwabUMzfNeTooTbmLidZMNXx5ATi6OMTQm+h8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BZMUQjVO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BZMUQjVO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1jFg3640457;
	Wed, 12 Aug 2026 16:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QXGsst
	3b1jOdLAreikQoytspHpkcrc6B0NFwA4ix7kM=; b=BZMUQjVOKYZRY+Sd50Rlli
	om0SN7fcmJn2vkE3q6b0nXrxtVdcTFytc8Izc1w5rfM7sDsj4eaqTL80yDF39cZu
	uo3vNgPxEYXJootXfJrBVmcl7hTA3X/5qYSp47RKkGV3D/GvpoJVdcZIcRM/3nC9
	ldoFLJYNET1GVv4vwEKpZRkzHYPtk8Wva4kTL7A9JHVBILiWq8O9yNqzsfSY8rvt
	CnLf6Ou5vtT6qwhYr58MJW9tnsAp0MG7sCcl8kTpXvCSWaTPJq+rSsrAceADOtgW
	vYQ2RY57JrjfN4FBSm7oS/JHpZU6jxCKFsK3qttuilHqLxSPPVEx0Tr7YVLDL6Lw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9ketb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 16:24:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGBHMw018173;
	Wed, 12 Aug 2026 16:24:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gesf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 16:24:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CGO7Ya33030862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 16:24:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51DBC58056;
	Wed, 12 Aug 2026 16:24:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8FF458052;
	Wed, 12 Aug 2026 16:24:06 +0000 (GMT)
Received: from [9.61.9.29] (unknown [9.61.9.29])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 16:24:06 +0000 (GMT)
Message-ID: <4cb80178-f407-4ced-955d-47ec6ed894ae@linux.ibm.com>
Date: Wed, 12 Aug 2026 12:24:06 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] s390/vfio-ap: Fix NULL deref in status_show()
 during queue probe
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-9-akrowiak@linux.ibm.com>
 <20260812121639.90CB51F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260812121639.90CB51F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: icNog19HqC8Y8t6fSBr9w8sySg4exGSt
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c9e29 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=XHSveZEALy_iRrqKlYIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfXzxWJDZnUc0yf
 ld+Lz+LTZvW1N0BQgLrQh10aIhs+oC0B64Sn9IhT6PXbTgGe4r6tiOmP4uUv6667C5LhzpYpW0y
 h8b3aCVtMclR5dVzhi47KKP+gml+FWomMpfjny/WHpEdNziu/lmXmOCxjg/xNleHWmm8TODKAUc
 Gw1m57QgAKSQIyo4sPEBD5dlQkEqZ7l9ej5/F7MmWHnUQiPW1ioILdO9hlmEBc+0M9fKkrqDoLL
 y2MNGF74cA1ibkTXqYPa8/oA9nUWvf5IIB8K6TjURllpk2rZKysRts4NKNVoYNZlqpJ96V1R/vA
 oUbssCW4/rtP1Z+HE9+D1snE6+bt1G81QtbKy45eKRqXrFh77h9cxlgtqgzyG7tdKPMmr/J+JFP
 8/FG3CQbbyDXP+vQa+nkERDBnBHihzQyk5HWRG3h/dX+VvHW4tC8kklMTxNqMGB7lF88GPTSErv
 BMNXDfcybbF9KCvT9ZA==
X-Proofpoint-ORIG-GUID: icNog19HqC8Y8t6fSBr9w8sySg4exGSt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfXxzrZ0AQd5YsA
 oog2OedZbmhcpG3qbWAB2jd6leuebevUEqwuea2byTQ3YWSFafcd2TeOrFZ17xplEUfoCladCOj
 dfN6L+DN8G0Bz/hVDESNZXX+MSOjSXY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120130



On 8/12/26 8:16 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ABBA deadlock in the probe error path between kernfs active reference and guests_lock.
> --
>
> --- Patch [8]: [PATCH v3 8/9] s390/vfio-ap: Fix NULL deref in status_show() during queue probe ---
> commit dd5ddcd73e238630c53e21354f9251a158e8bee2
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix NULL deref in status_show() during queue probe
>
> This commit fixes a NULL pointer dereference in status_show() during queue
> probe by acquiring update locks before creating the sysfs attribute group.
> This ensures any concurrent read blocks until driver data is set and locks
> are released.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index cb1e5db69d8a7..3652ba792be73 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2419,14 +2419,17 @@ void vfio_ap_mdev_unregister(void)
>>   
>>   int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>>   {
>> -	int ret;
>> +	int ret, apqn;
>>   	struct vfio_ap_queue *q;
>>   	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>>   	struct ap_matrix_mdev *matrix_mdev;
>>   
>> +	apqn = to_ap_queue(&apdev->device)->qid;
>> +	matrix_mdev = get_update_locks_by_apqn(apqn);
>> +
>>   	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
>>   	if (ret)
>> -		return ret;
>> +		goto err_release_locks;
>>   
>>   	q = kzalloc_obj(*q);
>>   	if (!q) {
>> @@ -2434,11 +2437,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>>   		goto err_remove_group;
>>   	}
> [ ... ]
>> @@ -2468,6 +2470,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>>   
>>   err_remove_group:
>>   	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
> [Severity: High]
> Does this create an ABBA deadlock on the error path?
>
> If kzalloc_obj() fails, we jump to err_remove_group and call
> sysfs_remove_group() while still holding matrix_dev->guests_lock (acquired
> via get_update_locks_by_apqn()).
>
> If a concurrent reader opens the 'status' sysfs file before we hit the error
> path, it acquires a kernfs active reference and blocks on:
>
> status_show()
>      mutex_lock(&matrix_dev->guests_lock);
>
> Then sysfs_remove_group() blocks in kernfs_drain() waiting for the reader to
> release its active reference, resulting in a deadlock.

release_update_locks_for_mdev() needs to be called before sysfs_remove_group

>
>> +err_release_locks:
>> +	release_update_locks_for_mdev(matrix_mdev);
>>   	return ret;
>>   }

