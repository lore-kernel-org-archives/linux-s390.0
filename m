Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10C2F0C45;
	Wed,  3 Jun 2026 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491768; cv=none; b=clqlMtWLnd6km+W2/ltVHYs2ECBUMnx4vl+Yd9fpZ5kMxt/kZAQJfESRXtD2guJ4/wtzVHaCE3f0Rn8wJdlZ9Ai1sTt9oQrAkbTQOsJAWPbankSaclRNdEcbSMZLw5jEauH3CatST+aLgnuoQtvLcGXfwEdgVHDE9YT2SUYxrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491768; c=relaxed/simple;
	bh=fySIKq9qHPsbGx1ef8qFJiNVDYmdA/+Doh97AIxaQEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6FqG6D+cnfdb7COp5TA0Lr0+KjhnBAex75TBLLfj09hXoelr+ySE+ORfaLonUrIQPy3ztiUTqSsHE3FVtC1Efck88VJ/66Nd3VX5LoQnroYqTNDIKQNwt/pTeAGH1XW3K3hvtbxFeMfSuN+v+jhpS9xJWBZp3Lh0jLYFXdBTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DlaR1G6E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DlaR1G6E"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65330SQv500650;
	Wed, 3 Jun 2026 13:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aNmmYu
	C46maQ+ckV3d/E0K8cXTJS0ueK5GEV989esYg=; b=DlaR1G6EUDilVIOfeWky2F
	R/iQkZSOynOt6aXApwHVhuGrgJMtXeDrUN3FkpXTmqR2XNfQGFyJnfBtv1Rq6O0Y
	4GiyTNc7OAHsXDZOMkUP7anT0LIxLCKTbcrhPo6jMkDTj5tgl22ppNap5LRsMYwi
	6C4lAi8v0N9mfL2P3FwxKQDTjXElbtGYRhLfaeyqPt3R5m8HZoCKhyYRtIK1vjhE
	uOozj0x0bPijf17vmmPoftwNVdPF5Zn/ajyXWJazhyrYCd2/nR2GRqu81AKwwxke
	uFU0SnOiECv9/00RTcuJ27vYqU7f8R72/i34NHXT5kuhi9uIpGWDkraI/jMFz0cg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqay2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 13:02:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653Cs7HC030661;
	Wed, 3 Jun 2026 13:02:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegr0ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 13:02:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653D2fEu590362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 13:02:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 844035806D;
	Wed,  3 Jun 2026 13:02:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A4E25805A;
	Wed,  3 Jun 2026 13:02:40 +0000 (GMT)
Received: from [9.61.244.94] (unknown [9.61.244.94])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  3 Jun 2026 13:02:39 +0000 (GMT)
Message-ID: <856915b2-9d12-4720-b882-dce67a91eadc@linux.ibm.com>
Date: Wed, 3 Jun 2026 09:02:39 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] s390/pci: Fence FMB enable/disable via sysfs for
 passthrough devices
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        alex@shazbot.org
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
 <20260519224204.19154-4-oelghoul@linux.ibm.com>
 <1100af0f55ba592e37b799f7e285345410fe47a8.camel@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <1100af0f55ba592e37b799f7e285345410fe47a8.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5y9TnnDs2WnbVgT6zT983Oe43vDU5pEP
X-Proofpoint-GUID: 5y9TnnDs2WnbVgT6zT983Oe43vDU5pEP
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a2025f3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=J20d4E7c8D6Z6fu7BkQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyMCBTYWx0ZWRfX4oyePPnap01x
 4WqQksQ3265iC5YJONJjq1gfWyEcnoVzJdlSiUkx1lBffRLgY+YdvgQCXMt9vCq2vNFaOpCXP5T
 dwVbRvHYL+9KkNjwrwAUy2MIqGDjWlNQDp8ThxizQFkLju0Wp9cSaO+Mt8L1XOAFQfpze0wmkyr
 DldsNMcvsHp2hphlccjldHog1e4YRx2tjWv8YZ3P+2gB45AJBXmtSX9a7oIaZYbblIufPPd7HY7
 OECISuM5ZoeyYR3lHY5FMZvEIFmdVr9vjlej4l2auNhQbXCpJhoLiFeJGF1btOqHy/h8kxyK4wl
 LEHQsMRYm1CDqyV+0O/XpcV2RqaPpiByGho+O97+4TYEie3UHW51OoBQoIi4uIrobr/nHMs6lnx
 7w4CSOBs0SOJK+AONwDyW8L/A9zMP4uTiWITssCj7N/+9EWe929b4G3Hl1/ixbsUYVj4La5Fprh
 5urzRRCG4/u8d/tJ1Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030120

On 6/3/26 8:15 AM, Niklas Schnelle wrote:

> On Tue, 2026-05-19 at 18:42 -0400, Omar Elghoul wrote:
>> Introduce a fence over enabling or disabling FMB via sysfs when the zPCI
>> device is associated with a KVM. This will allow a KVM guest to use FMB
>> passthrough and avoid the edge-case where the host disables FMB while the
>> guest is still using it, which may cause partial counter resets and
>> inconsistent reads which have no parallel in the architecture.
>>
>> With this patch, the userspace driver, likely QEMU, is still able to enable
>> or disable the FMB using the VFIO device feature introduced in the previous
>> patch, effectively securing what is associated with the VM state and
>> isolating it from other processes on the host.
>>
>> For VFIO devices that are not associated with a KVM (i.e., for userspace
>> drivers other than QEMU), this fence does not take effect.
>>
>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>> ---
>>   arch/s390/pci/pci_debug.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
>> index c7ed7bf254b5..2601614b919b 100644
>> --- a/arch/s390/pci/pci_debug.c
>> +++ b/arch/s390/pci/pci_debug.c
>> @@ -149,9 +149,15 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>>   	if (!zdev)
>>   		return 0;
>>   
>> +	mutex_lock(&zdev->kzdev_lock);
>> +	if (zdev->kzdev) {
>> +		rc = -EPERM;
>> +		goto release_kzdev_and_out;
> Nit: "release" to me sounds misleading here since it's not about any of
> the things called "release" in the kernel but about unlocking a mutex,
> I'd probably go with "out_unlock_kzdev" for the label.
Noted, I will rename it.
>
>> +	}
>> +
>>   	rc = kstrtoul_from_user(ubuf, count, 10, &val);
>>   	if (rc)
>> -		return rc;
>> +		goto release_kzdev_and_out;
>>   
>>   	mutex_lock(&zdev->fmb_lock);
>>   	switch (val) {
>> @@ -163,6 +169,9 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>>   		break;
>>   	}
>>   	mutex_unlock(&zdev->fmb_lock);
>> +
>> +release_kzdev_and_out:
>> +	mutex_unlock(&zdev->kzdev_lock);
>>   	return rc ? rc : count;
>>   }
>>   
> Can't say I love having to fence the host from being able to disable
> the FMB via sysfs, but the potential inconsistencies really aren't
> covered by the architecture and I don't see a better way.
>
> So with the nit handled feel free to add:
>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Thanks.
>
> Thanks,
> Niklas
>
