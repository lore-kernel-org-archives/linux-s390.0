Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80044A0EFE
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437443; cv=none; b=DwH2tD/J7/EMme3c+EJ68vDUX5PS6GrbzZFuAfPpWZDw7fUzg0WDu7bPo6gsl6NBSgq4WMbLxZ6RrfT3LqnOjW7jVNgX6W7AVheicnQHRcq/RekMJVA0VNen1vBiWkVT8DVK//C0EvvXc8VOVpLXWsOmE5kYT5mr1S1dLuFKhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437443; c=relaxed/simple;
	bh=5C1CP0+JFZkqxN4iy0WE+C4EmMcHYy0FuvuZVgw4kSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6h5/OCOBmPgw/LRRMDI57GnuHy3C19imVIj0+TKZOrwdadOAnCFQ6z/rJkKAHQQ3wyF1LStHP9J71RC71xMP/pZQTGJ68F+yhNs2E7h/sQGarLKPkGws9tEkDRKvdNOXgzLSYfxyJP34vTbMQpduzl53YlnMHAp39iK7BuULL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FhsGjfhb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FhsGjfhb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AWPjt2619348;
	Thu, 3 Sep 2026 12:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UJnBih
	Jq3E4aXdGX77j+QuKcKKS00SMRxVxEr4pShbI=; b=FhsGjfhbbBYBz7XF/71BZk
	ygX0+YKrwL5yWybVL7hwk5POlG+Wdii8Gmm3V57T3RfLTQZTF3ZynGNv3DcvQgsG
	iBUPMAGKFxll21gqNuCidW9iq/soYYESZayBv+5phUDLvQQS8dRWlpAbelbybdKm
	4fmmUMMOn+n5vCZunkt+uBila3oKMEu6lKJOYrVcoEQfc/+G0jcuLP7Vdqo6Y2K6
	HKgYTWM9sB1ZLXrSfG8RzX6aLdHeJaZ0AVCjancldgNtaCGTjF6eGTxgmMy89z2U
	QYStM36HMuScLE1A25ph1AI5UUtX6k8yFHS+ylJ9hVy6M6Be8m1KNJ7Qif9DIVew
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj4f82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 12:10:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683BuFb0015055;
	Thu, 3 Sep 2026 12:10:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjaqx27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 12:10:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683CAZDE33685766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 12:10:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0267B2004E;
	Thu,  3 Sep 2026 12:10:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA5302004B;
	Thu,  3 Sep 2026 12:10:34 +0000 (GMT)
Received: from [9.224.90.205] (unknown [9.224.90.205])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 12:10:34 +0000 (GMT)
Message-ID: <cffc6734-19c8-439d-a55b-79bdedd54eab@linux.ibm.com>
Date: Thu, 3 Sep 2026 14:10:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/stp: Drop CLOCK_SYNC_STP
To: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>
References: <20260814072223.2218864-1-svens@linux.ibm.com>
 <20260814073450.908631F000E9@smtp.kernel.org>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20260814073450.908631F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WEYdQSRSuy7rc2g2jh3q3FAi88PF94TK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwNCBTYWx0ZWRfX2Jzaha4nZxZZ
 jgaK6xq9mJkAPGwdCPkRkTeA+3BEyaKZWBgmKC24UZ3634pGflHr6nDWBTZEWJqGKiTbsHAfpZx
 fm5rQj7zA57faqv1lciO+zNTtd5umHlQf+NyZkNbMJ8IJE4Zdre/A2gWlvYRL38ND8lrgYA1nQt
 FYcIz930ZAUk0rwoi+JRGOWh9/QPf0+JFYzmWvm0Ona6f0nZhr1cZ/4uossERIjKPd1LnNDlAHM
 X4g383IUfhJGupw99aWik0tMRB/uUPWzIbFmCbQcuCPz1cCPARo1Oar3a79c5hdG990TzceDyGv
 kn/Yr9XWMzbnJQuzqK+8mvNjgpfsZFgNDOj+TfhJ/Aq0ByW4+oyx9IrqHK3vAWCyuYyya11g2h9
 vwPE+CqwmTPR6rP6KfMqDridexVfYZY69wvar9V6O2jThV27U7nqSpyeV2SxMS8F4fmXVXQrSaI
 jhOTFAKMt1zpBUzbs5w==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9963c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Y8nHDs0X6_NWWUcUHKQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwNCBTYWx0ZWRfX+vkNA+RIyIil
 zRfJsoap8Olv4E6UKVHHayYlAyWz9Ws21G6qjr3oFI+cjWAE4D5ie0R337rYh13zNtMJX9grQsm
 TR0+xTZf+92BtlZdZIafA/sD+jlyfaE=
X-Proofpoint-ORIG-GUID: WEYdQSRSuy7rc2g2jh3q3FAi88PF94TK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030104

Am 14.08.26 um 09:34 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Booting on systems with XRC-capable DASDs but no active STP network will hang indefinitely due to an unhandled -EAGAIN loop.
> - [Low] Lockless plain read/write of `stp_online` introduces a formal data race.
> --
> 
> --- Patch [1]: [PATCH] s390/stp: Drop CLOCK_SYNC_STP ---
> commit 39bb08d28d4e120a87017a08eb301d774dd6baa2
> Author: Sven Schnelle <svens@linux.ibm.com>
> 
> s390/stp: Drop CLOCK_SYNC_STP
> 
> This commit removes the CLOCK_SYNC_STP flag in favor of using the stp_online
> boolean directly. This change prevents get_phys_clock() from returning -EACCES
> when the kernel command line option stp=1 is used or STP is enabled by default.
> 
>> diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
>> index 2b989bebd220a..de80e2a316ba7 100644
>> --- a/arch/s390/kernel/time.c
>> +++ b/arch/s390/kernel/time.c
> [ ... ]
>> @@ -299,7 +299,7 @@ int get_phys_clock(unsigned long *clock)
>>  		return 0;
>>  	if (!test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags))
>>  		return -EOPNOTSUPP;
>> -	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags))
>> +	if (!stp_online)
> 
> [Severity: Low]
> Does this introduce a formal data race under the LKMM?
> 
> get_phys_clock() now performs a lockless plain read of stp_online.
> Meanwhile, online_store() modifies it concurrently via a plain write:
> 
> arch/s390/kernel/time.c:online_store() {
>     ...
>     mutex_lock(&stp_mutex);
>     stp_online = value;
>     ...
> }
> 
> Could this trigger KCSAN warnings when userspace toggles the sysfs
> online attribute while get_phys_clock() is executing?
> 
>>  		return -EACCES;
>>  	return -EAGAIN;
>>  }
> 
> [Severity: High]
> Could this change cause a boot hang on systems with XRC-capable DASDs
> but no active STP network?
> 
> Because stp_online is initialized to true, if the machine supports the
> STP facility but is not connected to a usable STP time source, time
> synchronization won't occur and stp_online will remain true.
> 
> With stp_online remaining true, get_phys_clock() will continuously fall
> through and return -EAGAIN, rather than safely returning -EACCES as it
> did prior to this patch.
> 
> The DASD driver ignores -EACCES but propagates -EAGAIN:
> 
> drivers/s390/block/dasd_eckd.c:set_timestamp() {
>     ...
> 	if ((rc && !private->rdc_data.facilities.XRC_supported) ||
> 	    rc == -EOPNOTSUPP || rc == -EACCES)
> 		return 0;
>     ...
> }
> 
> If -EAGAIN is propagated up, will the block layer endlessly retry the I/O,
> resulting in a complete hang during boot?
> 

From what I see, Sashiko is right. This will break how the DASD driver
actually checks if the clock is enabled and in sync.

The DASD driver relies on -EACCES to know that the clock exists but STP
sync is not online/applicable which in turn will skip it, whereas
-EAGAIN means the clock does exist but is not in sync yet and we should
wait and retry, which in turn leads to endless loop of request never
being built because we never get a valid timestamp.

So I guess we will still need a third bit to differentiate those states.
