Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC240D599;
	Wed, 10 Jun 2026 00:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051535; cv=none; b=m/RwgOpkf7me1qB70WZiDQIxBCCRrXaVhQRB7AEFuqMN3miRkbleGBXEAMNJ64yIcPLKUh0RYdOnVIg/74PttrL0ppb3zPxsZ1D6Kiv7G3/nj380+Ehjilc4GOaUKsYpSBJyceqqeYWN1yvcpC1dJdceIVVofiuTEIpLeKFOHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051535; c=relaxed/simple;
	bh=54v+Qp1EI1F/YvHPRCsZgh7rwQrGHkIoDLG3wzureyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MC2hXNJQxP3wD25hajav3ulAeZPqhlkcBj/f9L0gXsQkNUPpf2/OMlxv4m+Jd4dx4Q2s1MpIZ+vCwfnnYl3G1xxcODx2kldxHYj1iZ/UHgaj4u4+ERfjKwlLOs3Kad6kncpO9WazSZaHIIeQpOmjmwZcvY+LlMjzHRmC0VBvlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o7jPwRHS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o7jPwRHS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659C0kZp3404977;
	Wed, 10 Jun 2026 00:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x1cn9t
	0QD/G/eUJx8klegDJD01di+3VqHTVX8G9SWi0=; b=o7jPwRHSgBjLUAkQSbc4pH
	pUHh7LwdUXLoc171pGshu5KSpnV7B61poQPTiNmxHdeGg8ppykkqzenzVbSaCUn6
	KMwWLw9JZIc4UARrHbhQEoR17LWoYcFiyAtCTRXaDqbdt8IciSuguHSF5uP5y5mk
	meA7hatBOxuY4sUinvDtwDkF0GPRD0DybingdbkE74TXvyryBSKZKolh35WqnYQz
	YquCsH5Ft8T0sGXUZ7QDJhbkK5AQTlYSZL4MSBQKzOOPGJbME+3Id0inOsB2HanN
	E8USy2iB1uAtmpSY20VO5mdZR6tCVGaZfUD2cCpoOiSIz1SVTDAeACXKFoLJiQSA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye6j7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 00:32:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A0Jflq017507;
	Wed, 10 Jun 2026 00:32:10 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g48b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 00:32:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A0VbmP28246638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 00:31:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 936F658065;
	Wed, 10 Jun 2026 00:32:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C4EF58052;
	Wed, 10 Jun 2026 00:32:07 +0000 (GMT)
Received: from [9.61.246.182] (unknown [9.61.246.182])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 00:32:07 +0000 (GMT)
Message-ID: <7a230cd2-757e-449b-bb66-4daac5df6185@linux.ibm.com>
Date: Tue, 9 Jun 2026 20:32:06 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] s390/pci: Fence FMB enable/disable via sysfs for
 passthrough devices
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com
References: <20260608171850.62829-1-oelghoul@linux.ibm.com>
 <20260608171850.62829-5-oelghoul@linux.ibm.com>
 <20260609165208.6aba1731@shazbot.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260609165208.6aba1731@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyOCBTYWx0ZWRfX+2WviqtFa4Sa
 wduHR/67twf4//XxFOk/1D3+TCTZd9hzVDqDtVgjITXNY3LP1KE5UGRRLK3lMyt3PeTaheGA+pp
 aztZiaNJ12LekFgzrxqyoxhWZlY79qMjZXa3EJpHQ6WIv65q9FtIkQY8pW9cydFDNuV7Yj7PuCa
 bhY90zbY+mW8e1uFGDuJN5O6yVJxeRDwWq00nFhhjmrjmm/2M7xqcP4WSvIoKEd5d1K0AAq/tt4
 xDZB1lWvD61ZlBGK5o4ejAnUNJVsikOLzX2ItoAnCO/+Kpy6bVCjnSuj3m2VipHsWdqgqR9TJpN
 CtUP22dcmcuiB+jfcVnbTYiUcccSYgox734MODw5HTC8sNb76POpGW6NDOXrYRXJI6/j5BfQhw6
 tGj6ze5AqAck6HmvdoCyxvA3PPj0TYtQiP9pRMJZ4fVsgcMCJ9pyHcViTjNBdYWoiz1bpSH47CV
 cz6jvkJ2ZLZAlQtlDdQ==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a28b08b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=J20d4E7c8D6Z6fu7BkQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qU52u7HvqdtuIU9qSXsMUSWPyM8Im7-d
X-Proofpoint-ORIG-GUID: qU52u7HvqdtuIU9qSXsMUSWPyM8Im7-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090228

On 6/9/26 6:52 PM, Alex Williamson wrote:
> On Mon,  8 Jun 2026 13:18:50 -0400
> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> 
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
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>>   arch/s390/pci/pci_debug.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
>> index c7ed7bf254b5..a2dc79418c21 100644
>> --- a/arch/s390/pci/pci_debug.c
>> +++ b/arch/s390/pci/pci_debug.c
>> @@ -149,9 +149,15 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>>   	if (!zdev)
>>   		return 0;
>>   
>> +	mutex_lock(&zdev->kzdev_lock);
>> +	if (zdev->kzdev) {
>> +		rc = -EPERM;
>> +		goto out_unlock_kzdev;
>> +	}
>> +
>>   	rc = kstrtoul_from_user(ubuf, count, 10, &val);
>>   	if (rc)
>> -		return rc;
>> +		goto out_unlock_kzdev;
>>   
>>   	mutex_lock(&zdev->fmb_lock);
>>   	switch (val) {
>> @@ -163,6 +169,9 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>>   		break;
>>   	}
>>   	mutex_unlock(&zdev->fmb_lock);
>> +
>> +out_unlock_kzdev:
>> +	mutex_unlock(&zdev->kzdev_lock);
>>   	return rc ? rc : count;
>>   }
>>   
> 
> Why not also use a guard for the mutex here and avoid the goto
> unlock... also moving the guard below the kstrtoul_from_user()?
> 
> The fmb_lock could switch to a guard too, but that's existing.

 From where I'm standing I don't think there is any particular reason to
do it one way vs the other. Thanks.

> Thanks,
> 
> Alex
> 

