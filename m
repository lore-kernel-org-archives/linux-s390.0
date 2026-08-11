Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED43403E1;
	Tue, 11 Aug 2026 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479586; cv=none; b=KRg9DptRkVOR6QKl8UbIYkl0oiSNURUM3mGVrSCIe2Fc+nT/AnZkUIJS9YYaVs3/yDovlnK7Ey9Uju89+6xT3tXvHCwX6F7hbiDIYNdNK+Woph8NwUnBGciBGO5GiltTLyqUL/DOC1qHMwtukKm1/5F9eqy7/nk2o9EROGQDaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479586; c=relaxed/simple;
	bh=OlrLX0jxwpvycrWXtEwq1aiJUOF2m0izVrhEh5b7YbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXr8iPcjqTi3MXNIsa3l698lGUxZvN+bDBcBnIqBgOjxtKDhUBFRkn8ei2YkCc64WdwHPLfU2kVWPZ0FuC2rPYByVuk+LNj8qyiBnIiajrhBuJQQbB50g3BbTwULJXONXAeVGbmhw+aRFE8P+GR0yIqjr/WhkVm1rYmKnG5yf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C6xQnCLg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C6xQnCLg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BJVlf41328319;
	Tue, 11 Aug 2026 20:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WEa3Wu
	z158taaoH96APSfUKY7SLj2FnHmekc3Zx8Fy4=; b=C6xQnCLgFGQjRpUnvoigS+
	CJbrIO9DyqjfSZ7UNmVUi+5RZYmX9LehfEbgSS88Ep9oHU7T3zBVzR4I7h6xQe4t
	1yfErFZ0gPc7+/R0Nnh2OMFYrsjGNsZoMdr8dv5Q9Lyvp++9vWuKzAjs31Fkld65
	lHTOoXQKdr6TMKDcBfUGYW6uhL3ePHyeMZ8AIZLIh1rvuCcZ2CJ/GL5C29b8KNB1
	GGOykGt3776E0MEWME2rcQof6UaBGxPvbvU2ceutV/AEfIbY9bKSri1bcLJSEYNj
	7kowUEKy50FD5my43pMriX5Tmi5c9H8EMaxGbZKO2AVZi6iTeeEeJ4z3WtjnuWsQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9q1nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 20:19:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BKBBhj029896;
	Tue, 11 Aug 2026 20:19:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjtr9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 20:19:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BKJRAg65208728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 20:19:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C00D458056;
	Tue, 11 Aug 2026 20:19:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C250158052;
	Tue, 11 Aug 2026 20:19:26 +0000 (GMT)
Received: from [9.61.58.252] (unknown [9.61.58.252])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 20:19:26 +0000 (GMT)
Message-ID: <e7ec1795-27f4-431b-8e92-54a58e46a3db@linux.ibm.com>
Date: Tue, 11 Aug 2026 16:19:26 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] s390/vfio-ap: Fix required lock not held during
 display of sysfs status attribute
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-8-akrowiak@linux.ibm.com>
 <5d755e25-be9d-4227-b06c-63563fcce0b5@linux.ibm.com>
 <c3b21393-d01f-4816-90b6-4c868d4a0f9d@linux.ibm.com>
 <48f2d952-3116-4e0c-b0e6-bc6460446c08@linux.ibm.com>
 <404259da-2b79-42ff-b663-fc0237cd753f@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <404259da-2b79-42ff-b663-fc0237cd753f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE2OCBTYWx0ZWRfXwbM5R1wj6fc4
 Ae2BKkzCfCjCah//+uDM+XCi1kC5lVWuoopEUXPQyNtZJipSKd8ywA9Xx89l2r+R4vv8EV2uoK6
 /hFoH2hZvB5hl9n2cBh+nq2Zo+fJBcLTdK1yTOZBx3THYRtHpPe2k9Uk977FFinXxgEf3UFTZru
 iP96JDLm5XQw4swuC3fD7QwM/JKdWseMQiT73AvyPfRH7/JbvwxYHjSBDwx/GWTy2uAKYlMwzTY
 bKpnhH9CY5+kUay6PIplD+k64mSzPJ5HomXPwHnNr4jfLZscgc6Dp+aoo2o20YBtsi5UG3/81jM
 lzoT5Vi4JuRjzz8J2LGcys2/zRzbVjl7Yb+g65M5+cQsVLHXrQB2QknwdyG8TgPkHamLrfKFNqs
 hOX+DOXYkg6Y7MbKMe4x2TSLDkbxZWcilgC26EHMHHGF/D0WOtk4552E2xEbJjOndrl8TOby9d4
 3TU+sq0Bod8Tzq3rrTQ==
X-Proofpoint-ORIG-GUID: Jev4aOFX6ZxvY327wIHMqL0NisDPKPbT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE2OCBTYWx0ZWRfX8jIr5cAV9epY
 IZ0Ny+LwTHLoQHG1YAE+uz4MEvaDVPbqCSRuVLj6uLfty8niljiE/ZRj1yzNLF/jM1sP8ci+oWG
 6aDep0jQ9b6uFcXtzLVikEJR7Og1CVM=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b83d2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=MiFXiCKfpTDM_XYcmggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Jev4aOFX6ZxvY327wIHMqL0NisDPKPbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110168



On 8/11/26 2:55 PM, Matthew Rosato wrote:
> On 8/11/26 2:51 PM, Anthony Krowiak wrote:
>>
>> On 8/11/26 2:20 PM, Matthew Rosato wrote:
>>> On 8/11/26 2:03 PM, Matthew Rosato wrote:
>>>> On 8/10/26 3:22 PM, Anthony Krowiak wrote:
>>>>> The status_show function that supports display of the status
>>>>> attribute of
>>>>> the devices in /sys/bus/ap/devices calls the vfio_ap_mdev_for_queue
>>>>> function which iterates the matrix_dev->mdev_list to find the object
>>>>> representing the queue device whose status is to be displayed. In
>>>>> order to
>>>>> traverse this list, the matrix_dev->guests_lock mutex must be held
>>>>> which is
>>>>> not the case.
>>>>>
>>>>> To fix this, the guests_lock mutex is taken prior to taking the
>>>>> matrix_dev->mdevs_lock mutex in the status_show function. It is taken
>>>>> there rather than the vfio_ap_mdev_for_queue function - where it is
>>>>> needed - because it must be taken prior to the mdevs_lock mutex in
>>>>> order to
>>>>> adhere to the proper locking order and prevent a lockdep splat; also
>>>>> because the mdevs_lock is needed there to access fields within
>>>>> the matrix_mdev object in that function.
>>>>>
>>>>> Fixes: f139862b92cf ("s390/vfio-ap: add status attribute to AP queue
>>>>> device's sysfs dir")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>>>> Please see my comment on patch 3.
>>> Also same idea here, I don't believe the pre-existing finding from
>>> Sashiko against this patch is resolved by this series, so have a look
>>> and consider a follow-on patch if it's a valid report.
>> Can you be more specific as to which Sashiko finding you are talking about?
>>
>>
> It only found 1 against this patch.  Quoting:
>
> This is a pre-existing issue, but can this sequence lead to a NULL pointer
> dereference if status_show() is called during device probing?
> If a userspace process reads the status sysfs attribute before
> vfio_ap_mdev_probe_queue() has finished setting the device driver data:
> vfio_ap_mdev_probe_queue() {
>      ...
>      ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
>      if (ret)
>          return ret;
>      q = kzalloc(...);
>      ...
>      dev_set_drvdata(&apdev->device, q);
> }
> Userspace could trigger status_show() while the driver data is still NULL.
> The dev_get_drvdata() call above would return NULL for q, which is then
> passed to vfio_ap_mdev_for_queue() without any checks.
> Inside vfio_ap_mdev_for_queue(), the uninitialized q is unconditionally
> dereferenced:
> vfio_ap_mdev_for_queue() {
>      struct ap_matrix_mdev *matrix_mdev;
>      unsigned long apid = AP_QID_CARD(q->apqn);
>      ...
> }
> Does the sysfs group creation need to be delayed until after the driver
> data is fully initialized and set, or should status_show() check if q is NULL?

I have a fix for this, shall I include it in this series or send it as 
an individual
patch?

>

