Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5ACA5A;
	Thu, 30 Jul 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410786; cv=none; b=R2zUC24ULQlVO3yEKBgks8x0s+77cDdHb2ZbF44pPLdhuhAJEvEWuQ34/T4GaSPzxry/iv+IpIfRNPiVvs66WJu3C3R0Ql87vzVC284MP5HxxwWtgDdagTQQEoiHo6FIjVioF+ZjYadJQIHCGz+XHCJBFNpaCiwV0w+H0sD92gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410786; c=relaxed/simple;
	bh=VwsJo+dyG5xGCwHpGacQjBXpVL3UJu2vpgHddIUaPK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/J//YUAat9+4oarIIUGXRjWo7CFHMzwtEjvCOn7hj/HNvFyzHNP9GOTKCN5FNTpl99AhqxDXUcDdLXqiIG60SMOrlF8pM1zZkJXK5+8tA8DGu81dJcU2WaPYhlQ8HpGlj2GY53jYCrXxh5KkpNqh3TqdcZTFkJ/qVlP9cuTrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eipaESMq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eipaESMq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAI4BW2639922;
	Thu, 30 Jul 2026 11:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8DlZ8p
	ofFYVSLAClCazett30FZ/G+yCHYXXXON/xBqQ=; b=eipaESMqU2Nx5DN9/xunNN
	QucSE1YMtbhKl9nOQYr4jyqWSlWkaCc+4JiSJ5fAyupFUfXGXJ1aqNQMlLfNA0Wd
	Ka3i8tV+CC9Y+4g6e0WhpdTYCDfeX7tEwPdBaxaCtspXOWigkQAzcGPEj7r3cNV5
	H/swToQqdfsEzdkH6UmjwfnHqLPELc5NkI0QaDCAqexsLvEEIEe1Z/2orlGtUn4s
	TjwJSW0XqSqJhEeSux0VE+0blUPK7cP3O2zaSByhgKsVzQ+q1ACLNb9hL8nacD08
	yOCxc5F49f9W/pXfSmgHf9dKUUPsBw4C9bPnZrKtjuflj6rN9mVzy3DvC0uuaU0Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nxh5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:26:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UBBNKf022774;
	Thu, 30 Jul 2026 11:26:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwb676-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:26:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UBQ9G18717016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 11:26:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB40E5805A;
	Thu, 30 Jul 2026 11:26:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0BA458064;
	Thu, 30 Jul 2026 11:26:08 +0000 (GMT)
Received: from [9.61.176.239] (unknown [9.61.176.239])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 11:26:08 +0000 (GMT)
Message-ID: <3a54b8bf-94ec-4069-b654-9f9b5d77839c@linux.ibm.com>
Date: Thu, 30 Jul 2026 07:26:08 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/15] s390/vfio-ap: Callback to get the size of data
 to be migrated during guest migration
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, frankja@linux.ibm.com
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-14-akrowiak@linux.ibm.com>
 <20260727181947.66E251F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727181947.66E251F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4NCBTYWx0ZWRfX6hvfbJhCubJU
 muukH47pFuVtuK7KuRVMPgvepxZcdPOuqFe91juiapDxt1reQt/ZdGqa8zm5hTsKjYh2NaYJkw2
 nKETK9VqCsMemUsc5vALzWYmbYF1czY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4NCBTYWx0ZWRfX932R6F7p6JjI
 wuPwZuQ3vBfDzjlmFIT8k66ZD5+xWGnoHqhBuFfjYtCUnZ1+SBdWQY68DP/N4oX+GA/fm4jO/p8
 x3NHABk/ob9DG1rV/u0hT4X6nNQZAKsX0u8miHHzanbC7gDWtLsnVk4uN1JoZDMzZoA0iaeeuI6
 Y6pxi3yhCf7HFPXyHhDgMzke+3/8TRf7p9f1VrDVI6/tnriCYAWHlommPgslR+zYrB8dIBctPgP
 Zev/DDiX+QfG5X8CdYyvZvKT0tU90avqe8cyoY5YmuMq5FEFogHisSYfHO5ccWwcEiZkjqwdL/U
 ccozqCKvQDoXhkR5fxoinb51sg4BA9A52d0qyjPwmJguWMNGKaaCU06NvaARv0+BigBI0rXPewM
 HXI034dNRpfQijsGFz9CdBuxPGYCeIee7ivAI5yojYo8zfoNZ6PF5F09ygpRFF3IvRL7rTaghnQ
 02GRDVP5o8T4iWXa3jA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b34d4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=vmaoYyxeFlKKWzEfrrgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BPQEqKNozr45mQ0jwd_egNSMpnQiNhj4
X-Proofpoint-ORIG-GUID: BPQEqKNozr45mQ0jwd_egNSMpnQiNhj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300084



On 7/27/26 2:19 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Logic duplication for calculating the configuration size.
> --
>
> --- Patch [13]: [PATCH v6 13/15] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration ---
> commit f0e78a002713b19ca67967cef71fbd73dea59ee7
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
>
> This commit adds the mandatory migration_get_data_size callback for VFIO
> migration support on the s390 vfio_ap driver. The callback calculates the
> estimated data length required to migrate the device's internal state.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 1c385908fc39b..8379cf8bbce89 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -1392,7 +1392,18 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
>>   static int vfio_ap_get_data_size(struct vfio_device *vdev,
>>   				 unsigned long *stop_copy_length)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +	size_t qinfo_sz;
>> +	int num_queues;
>> +
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>> +	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
>> +	num_queues = vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
>> +	qinfo_sz = num_queues * sizeof(struct vfio_ap_queue_info);
>> +	*stop_copy_length = qinfo_sz + sizeof(struct vfio_ap_config);
> [Severity: Low]
> Does this code manually duplicate the size calculation logic already present
> in the existing static helper vfio_ap_config_size() within this same file?

Yes, it does. The vfio_ap_get_data_size function will be modified to 
call the
vfio_ap_config_size function to set *stop_copy_length.

>
> Additionally, since struct vfio_ap_config uses a trailing flexible array
> member for qinfo, would it be better to use the standard struct_size() macro
> to compute the total length instead of manual multiplication and addition?

struct_size(p, member, count) expects a pointer to the structure for which
the size is to be calculated, so this can not be used; however, I think the
struct_size_t

>
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +	return 0;
>>   }

