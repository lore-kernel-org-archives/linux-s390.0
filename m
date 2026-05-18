Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2048B398;
	Mon, 18 May 2026 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123399; cv=none; b=OXpBp15sdTIQ/wOP1zqZclZ9YPOKQ8nuFwPiZx/cJ7S8/wIxXgyo7tkYs9kYWPdrqGT0Hv13xqGiRcCFVCFBIQtngn8Bw+9uQhP9kxdejFARV+3ytxmtzwzyPPPRJFEb+AjBUPDrGeq5taDGNzqiE0wITMa02BxwLZT91BGc8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123399; c=relaxed/simple;
	bh=SJp6gypjAIfD2fhuQhFY+xDUer/dMRcd2rSnFRful1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVuyAO7nqp1ZpCn+K5z3i+evSqrT8R5unKH2NeYKJ3J6EswnG9Dsr4klDYYZRRruXPD+8akc9CxXNMeOne9sfnNxGB7oNy+PTuZoHOkN0/zhdBIjHrCJK1OHGxLLbfk2ag1QUqHWUB7rr1byEIyHsZ0M3re+8ka5FN83S+YjLj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HFsEYyeE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HFsEYyeE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I5mPPd3350414;
	Mon, 18 May 2026 16:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WYLmot
	f6AJZhFv1QcOAgrB7Bt0BiDWEclGamt2r/t/M=; b=HFsEYyeE2+HFtvl7R9ywWJ
	F+rB9A5cdsbbpO7hALk5QETBVEtqG/xaEnRWRw+E/9eKrqz2aLGIssy/ZBDCY7D4
	bIGxYMgPjMGRssdW8pac+bSUq9pFZaE9Uy69sFWjtSz6e6YhWYoAdTsPvzgJtjny
	mrgYAks3zd+Yv3csnWKkmriEh9LItgC/1PkOX6F2gUnw9TZI2HuR3yykPkiDLxwb
	mdWDff/7gbA9ZbuPmWTl/kz9wOAQtmRuopPeg2LggEQMkKP7ZIf/vuRugPlvhZNb
	2UWoo9A2+BJ199ta0Pc7ckm5TDKnm9QNnvLP2YJCu5uFNRcKeDm15eJ9jQj0K7pw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74s6se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 16:56:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IGs9dY030635;
	Mon, 18 May 2026 16:56:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wjxv2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 16:56:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IGuUFg30999232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 16:56:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F7C5803F;
	Mon, 18 May 2026 16:56:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C52358056;
	Mon, 18 May 2026 16:56:30 +0000 (GMT)
Received: from [9.61.241.47] (unknown [9.61.241.47])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 16:56:30 +0000 (GMT)
Message-ID: <57cb4b55-1305-4936-bf17-1c57532bea0a@linux.ibm.com>
Date: Mon, 18 May 2026 09:56:29 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 4/7] s390/pci: Store PCI error information for
 passthrough devices
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, mjrosato@linux.ibm.com
References: <20260514180059.1553-1-alifm@linux.ibm.com>
 <20260514180059.1553-5-alifm@linux.ibm.com>
 <388849fec888031cfbbe227c587a92521243e83e.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <388849fec888031cfbbe227c587a92521243e83e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0b44c1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=vYJSjNBhiLaGWKpjGKMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3HavXvzlBjH7k9Q6QLFTo9bvBRaL_ywE
X-Proofpoint-GUID: 3HavXvzlBjH7k9Q6QLFTo9bvBRaL_ywE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2NCBTYWx0ZWRfX4Opn6vHqHFeG
 M5uYjdWU7IOmpT/VKdHgP2VdBhy/xBcgya4l22ckheLkZZzjYgYXxdWV9eA6OgPApZIAfAVJgEU
 oenmO0yjvaENAk7TiAkHY5k/64iOzZsQN4CO/ENMDRIoh3hB55vnIjJuE+8YDAO6z0RGER2c3gH
 sdKtC3MGkaStbg/WEFY/lN+CeUHvStBbzfwbfCcWDDPnZP3RaUInU4BaWnWBz8A6wltHOVJ03Aw
 jHyLYvBta5byMf1vNzF3OdXXcsJoL0F5M4wgiPwfaZL1cnA9Nl4XQb1rNqCXxeL/BAXNUxclnKe
 hCBssx1rzheeesqHAOUWaPFfDBtj1ISvgWpAN8ZPdDVABKZLpbsAWIz9BwHGpaBVymj5BwvpfC6
 UCzkZTH8r837lyyDZGu1MKFZ0U4m1CXBpLGXUJJT38X7h+HtggXLUDhJ1KvLmOSTiDlFtBgbP8F
 iMKTcbSRy2L/O3lAMyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180164


On 5/18/2026 3:07 AM, Niklas Schnelle wrote:
> On Thu, 2026-05-14 at 11:00 -0700, Farhan Ali wrote:
>> For a passthrough device we need co-operation from user space to recover
>> the device. This would require to bubble up any error information to user
>> space.  Let's store this error information for passthrough devices, so it
>> can be retrieved later.
>>
>> We can now have userspace drivers (vfio-pci based) on s390x. The userspace
>> drivers will not have any KVM fd and so no kzdev associated with them. So
>> we need to update the logic for detecting passthrough devices to not depend
>> on struct kvm_zdev.
>>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h      |  30 ++++++++
>>   arch/s390/pci/pci.c              |   1 +
>>   arch/s390/pci/pci_event.c        | 114 +++++++++++++++++--------------
>>   drivers/vfio/pci/vfio_pci_zdev.c |  18 ++++-
>>   4 files changed, 109 insertions(+), 54 deletions(-)
>>
> --- snip ---
>> @@ -216,12 +223,23 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>>   		goto out_unlock;
>>   	}
>>   
>> +	mediated_recovery = zpci_store_pci_error(pdev, ccdf) == 0 ? true : false;
>> +
> This incorrectly treats it as not-mediated recovery when the queue runs
> full and zpci_store_pci_error() returns -ENOMEM (Sashiko also noticed
> this though the explanation is a bit hard to read).

Yes, will fix in next revision.


>
>>   	ers_res = zpci_event_notify_error_detected(pdev, driver);
>>   	if (ers_result_indicates_abort(ers_res)) {
>>   		status_str = "failed (abort on detection)";
>>   		goto out_unlock;
>>   	}
>>   
>> +	if (mediated_recovery) {
>> +		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
>> +			pci_name(pdev));
>> +		ers_res = PCI_ERS_RESULT_RECOVERED;
>> +		status_str = "in progress";
>> +		mutex_unlock(&zdev->pending_errs_lock);
> The unlock here seems like a bad leftover from the previous code.
> You're not holding that lock here. (Also found by Sashiko).

Ugh yes, left this from last version. Will fix.

Thanks

Farhan

>
>> +		goto out_unlock;
>> +	}
>> +
> --- snip ---
