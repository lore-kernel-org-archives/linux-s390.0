Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A63515F5;
	Fri, 24 Jul 2026 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922708; cv=none; b=M5Cn3Drg/KlzWTFGjblE+bXO/b4s6nCbXp7vIeWMa6C9hCmq0/9HV3xwK+yICmTT5oaK5RxINsSqOXwZMPGlUS5HoO5qPTwv8reDT1sV+q2z71FUAoAIHYFJGV0B7MI6Vry0ujbc01U+Se263EAx6uYTu4WiLEglfe8bA2c4I6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922708; c=relaxed/simple;
	bh=1FnwVaLGPw/Oyeeyw6xvcos/JyAwaP2mHVlSXzMCC9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKF4FI1I7QlOIuTE03ybyyeRu9Awo5PUqdC8WsRJRKkvDUV44NVUHDDZ4K4nrOBcuPuzHdIghlg8S+dJf8iV4Pb4Tkrgybywn4iGP0Ekl0M8xkLFfFyj1wNS1suTrfHftDNbbBzcgIT6Y4fOA5Tk36p0FkkFcDgEQMO6WpYCMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IMyhKpVU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IMyhKpVU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OHBg2j2429268;
	Fri, 24 Jul 2026 19:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ge9PfB
	yjoN1nt4ECoCyIIp+S1bPfve12dbQmbA/t1kY=; b=IMyhKpVU4j03rLI93SbMP7
	xixkQ/t33XQ3tsBKB7uglrgYghraw/gvKLHkIj59+PuEX/9hGHhHw6ylYry8HaS7
	76QVRl3wtm8VSJ8SHMCrLQMoe+Dl1VOIxMmInLd6BTj2Q8oxGqDVIPCQzyubs8IR
	rVbcPrv9/lx4uZ+H9tJKmGgn5KmLn3KB+JTCYKJhQC3RvfqRmkja65ImKb0BGnxc
	hJhzloYn/J6DZa9bPwrhUsck0QEWxIEOCMKtVAB2b3h/rNB/ccH5Tovan0k6oGID
	xt6WkZ7u9pt2G1W4eBtKliZVrCKh6C/m+HeJBSnW7oLxLRILdaz3RBWzPQuSYURA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h51pt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 19:51:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OJnhqp005926;
	Fri, 24 Jul 2026 19:51:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wjgsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 19:51:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OJpgOu26673902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 19:51:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32F0058058;
	Fri, 24 Jul 2026 19:51:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B775805B;
	Fri, 24 Jul 2026 19:51:40 +0000 (GMT)
Received: from [9.61.19.212] (unknown [9.61.19.212])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 19:51:39 +0000 (GMT)
Message-ID: <8e4083fe-8c3f-430b-8688-965a3e1cce17@linux.ibm.com>
Date: Fri, 24 Jul 2026 15:51:38 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] s390/vfio_ccw: ensure index for read/write regions
 are within range
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-7-farman@linux.ibm.com>
 <1fc1a866-74d5-49a8-9ea9-f2554589548e@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <1fc1a866-74d5-49a8-9ea9-f2554589548e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE3NyBTYWx0ZWRfX/VIkZWkgbWfG
 Br4cC7uZkaQJpFU3xy9KZeM+fCAtgISlG8A7ycvyWCb5dkoamJNP+QevLa0+OZDEwmSkgWIbcXb
 dxYm5J3DCtWnTH3khPvMyg0Zn99JeTc=
X-Proofpoint-ORIG-GUID: XsEnrcYv9IirEnZFVwWZm-EZI2pcycif
X-Proofpoint-GUID: XsEnrcYv9IirEnZFVwWZm-EZI2pcycif
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE3NyBTYWx0ZWRfX82JMVLEUKPEW
 luKkgMx2vAWnRSqDhC/HQydL8hJIqj1sh3xaNfF+6t7On5IpuaHPnzoDdzelq+Srpx5BdMUnELw
 SyIHZnMxYdvEarbrKwHi1RQH2SpIaSvtg5P7ghBvhAOUmKjupk0PSKykixRtqqyutYLmOHZpBpQ
 r+WZvsV4Xz4RkosrXJ6pAxawB9eTJL7COL1RYKqvtJqn9fx4Y06IX3K0eJYhc4IjfexJQ1UxI9C
 mHny3peO+lhWBWPll0DhviT2T+/QwjuuXLP4OtPzQz3m3b2OaEPO1X0Q48BRcVUuAJwbGmuCZ3T
 gUr8otVcQL4Npf0m/6rpRuqZhcvMd3FXBDDAeeuWPafJ/fuwpJdYd4JoUaSLSEyF47GKWttoIXx
 fvqviIvcex753hlXEVuVm7sGZirHcddLkVLoJc1NUbWeWGuJHhC38JKwzNicieXw6YSUYwrzJF+
 JS50B0suj1Q6xsRLWhQ==
X-Authority-Analysis: v=2.4 cv=du3rzVg4 c=1 sm=1 tr=0 ts=6a63c250 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=s7n_ci8m_2MWQJal8bwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240177



On 7/24/26 3:01 PM, Matthew Rosato wrote:
> On 7/23/26 1:47 PM, Eric Farman wrote:
>> The introduction of the capability chain rightly clamped the
>> region indexes to the range of the capabilities itself, but
>> neglected to do so for the existing read/write regions which
>> should also be enforced.
>>
>> Fixes: db8e5d17ac03 ("vfio-ccw: add capabilities chain")
>> Cc: stable@vger.kernel.org
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_async.c | 4 ++++
>>   drivers/s390/cio/vfio_ccw_chp.c   | 4 ++++
>>   drivers/s390/cio/vfio_ccw_ops.c   | 7 +++----
>>   3 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
>> index 420d89ba7f83..f213f62f6641 100644
>> --- a/drivers/s390/cio/vfio_ccw_async.c
>> +++ b/drivers/s390/cio/vfio_ccw_async.c
>> @@ -8,6 +8,7 @@
>>    */
>>   
>>   #include <linux/vfio.h>
>> +#include <linux/nospec.h>
>>   
>>   #include "vfio_ccw_private.h"
>>   
>> @@ -24,6 +25,8 @@ static ssize_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
>>   		return -EINVAL;
>>   
>>   	mutex_lock(&private->io_mutex);
>> +
>> +	i = array_index_nospec(i, private->num_regions);
>>   	region = private->region[i].data;
>>   	if (copy_to_user(buf, (void *)region + pos, count))
> 
> Couldn't using array_index_nospec cause us to accidentally operate on
> region[0] if ppos were ever out of range?

Hrm, yeah as I keep pondering this I think you're right. The parent 
routines (vfio_ccw_mdev_read(), for example) checks that it's not above 
num_regions + NUM_REGIONS, but there's no check against the subset in 
any of these. I'll add them; thanks.

> 
> By comparison, vfio_pci_ioctl_get_region_info() does an explicit check
> first, so to do something similar here and elsewhere in this patch:
> 
> if (i >= private->num_regions)
>     return -EINVAL;
> i = array_index_nospec(i, private->num_regions);
> 
> (Note that for this case and vfio_ccw_async_region_write my pseudocode
> doesn't account for io_mutex)
> 
>>   		ret = -EFAULT;
>> @@ -48,6 +51,7 @@ static ssize_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
>>   	if (!mutex_trylock(&private->io_mutex))
>>   		return -EAGAIN;
>>   
>> +	i = array_index_nospec(i, private->num_regions);
>>   	region = private->region[i].data;
>>   	if (copy_from_user((void *)region + pos, buf, count)) {
>>   		ret = -EFAULT;
>> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
>> index 38c176cf6295..bf678270c457 100644
>> --- a/drivers/s390/cio/vfio_ccw_chp.c
>> +++ b/drivers/s390/cio/vfio_ccw_chp.c
>> @@ -9,6 +9,7 @@
>>    */
>>   
>>   #include <linux/slab.h>
>> +#include <linux/nospec.h>
>>   #include <linux/vfio.h>
>>   #include "vfio_ccw_private.h"
>>   
>> @@ -26,6 +27,8 @@ static ssize_t vfio_ccw_schib_region_read(struct vfio_ccw_private *private,
>>   		return -EINVAL;
>>   
>>   	mutex_lock(&private->io_mutex);
>> +
>> +	i = array_index_nospec(i, private->num_regions);
>>   	region = private->region[i].data;
>>   
>>   	if (cio_update_schib(sch)) {
>> @@ -97,6 +100,7 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
>>   		list_del(&crw->next);
>>   
>>   	mutex_lock(&private->io_mutex);
>> +	i = array_index_nospec(i, private->num_regions);
>>   	region = private->region[i].data;
>>   
>>   	if (crw)
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>> index 45ec722d25ea..032a1cdf4df7 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -243,6 +243,7 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device *vdev,
>>   		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
>>   	default:
>>   		index -= VFIO_CCW_NUM_REGIONS;
>> +		index = array_index_nospec(index, private->num_regions);
>>   		return private->region[index].ops->read(private, buf, count,
>>   							ppos);
>>   	}
>> @@ -295,6 +296,7 @@ static ssize_t vfio_ccw_mdev_write(struct vfio_device *vdev,
>>   		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
>>   	default:
>>   		index -= VFIO_CCW_NUM_REGIONS;
>> +		index = array_index_nospec(index, private->num_regions);
>>   		return private->region[index].ops->write(private, buf, count,
>>   							 ppos);
>>   	}
>> @@ -338,11 +340,8 @@ static int vfio_ccw_mdev_ioctl_get_region_info(struct vfio_device *vdev,
>>   		    VFIO_CCW_NUM_REGIONS + private->num_regions)
>>   			return -EINVAL;
>>   
>> -		info->index = array_index_nospec(info->index,
>> -						 VFIO_CCW_NUM_REGIONS +
>> -						 private->num_regions);
>> -
>>   		i = info->index - VFIO_CCW_NUM_REGIONS;
>> +		i = array_index_nospec(i, private->num_regions);
>>   
>>   		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
>>   		info->size = private->region[i].size;
> 

