Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6523E95A9;
	Wed, 10 Jun 2026 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096078; cv=none; b=HOkgwPWsQo1hrxmbKD9Dq1RRZk7g0eBSzxaMgE91HDa2TCId/8nVLa5tECEOkFWlMh/fdMaMuLkbw0O8YstibeRqeUbhvxJdOEkqL2TCB2XggXHzr44kQ2v6cc4TBj/Uo8IX/YUdgVrrQur+iC7QkHOwqeadVrH3/9Z+4lcF96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096078; c=relaxed/simple;
	bh=95V44WO4pQh3SW/FBKaJedfb4BUPmEyIqQ8erLyBdzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXN8zTKFHOfDJeXylNOR0H5cOc+H6OxLT7j5m/kmUj0pSuz33lj6j9KCbvvt2h7cC7BxjdSrMwMsPxoDPRe6dXYP3Wg7sH7ep1aNXGEPRjnRdZ9K2fFUzfKaW3AA3MYV89pgHDKWHjGxILnuexFX2gDNx/doCtrO61GuFRsf1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OzZWw1PB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OzZWw1PB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A8sd0o3020105;
	Wed, 10 Jun 2026 12:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qvx23G
	I8mqoUKumPeKDPJF7sdWGYe4Fnoki4fwT3Bag=; b=OzZWw1PBLZQFst9nS40wmk
	3NvZ2LTvwY8Oep0Zp+XldHisfJiCTPsTn+cpg3CyikLliQbvMgluGSLj4mlfgi5Y
	Yj0mXZdruGCbtrCXppt5ftiTqUaDRKll6g+9wisaSXlris4qIoAdUmDKolGNxCQy
	izL0mWMkjRBiNVDzDRcwzoVOHmq2L4O1cHlUOv3qf8oESlwmuaB1KVX9uuHDwwZK
	Zfn/oXKUGKEzN8DYB5VSLd8zpSIXJblBGol3N6dnMBURLop6GlM/nyccrNgvQtnz
	Ge1Elc7P8L7XZoqE9ri2VL/72xL3j5h/C2rcz5Uvec3aARg2turHKysx7GBVtUbQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qs45c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 12:54:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ACna77018229;
	Wed, 10 Jun 2026 12:54:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjxnw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 12:54:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65ACsWPE22610646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 12:54:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15D3858061;
	Wed, 10 Jun 2026 12:54:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D7CE58057;
	Wed, 10 Jun 2026 12:54:31 +0000 (GMT)
Received: from [9.61.249.151] (unknown [9.61.249.151])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 12:54:31 +0000 (GMT)
Message-ID: <c7c0afe6-7c75-4e1f-b3cc-eff5f8335aee@linux.ibm.com>
Date: Wed, 10 Jun 2026 08:54:30 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] s390/pci: Fence FMB enable/disable via sysfs for
 passthrough devices
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com
References: <20260608171850.62829-1-oelghoul@linux.ibm.com>
 <20260608171850.62829-5-oelghoul@linux.ibm.com>
 <20260609165208.6aba1731@shazbot.org>
 <7a230cd2-757e-449b-bb66-4daac5df6185@linux.ibm.com>
 <986385851fb30f53b8899d61bfeae81979d36d58.camel@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <986385851fb30f53b8899d61bfeae81979d36d58.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a295e8a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=c7c2zXjs95nIFYyEgnUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0K7dVVEnDGsumKXn80AAr00vaUTo4Bfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEyMSBTYWx0ZWRfX7RTTIXFRXlCk
 BxM+YGvwdq7uXLsYBY4pxwMhdAbGsh+Vgw6uUsJz6GE/h0ow0p15deS0abxmTp4nH5Aj3230CKL
 beeIGZlgpWQueJddaRvvG/pBOwKHzteLS1axh7f32myt4bIqxIe5LXrotzhFqqrJIs5tucvnLar
 bbiwsJ0dGXEbtbeHRkmW3kww3gV9QnN0Nc9HZbTpa956YzpNp0U9pki3k6uwMSzKjxSNvq53yEW
 ocKOibayTLm7w1soLYyefMjUnu84FbCNcjv4FIuzExWCn9GPjwtiCsm8pd+CnITq+/aeCb13HXw
 j8zWZzKQc6ki5uBtSOPxOYlj9kPCFMK4Rxbo5SPE9BeZMF5OYfW/agqUbMA0b8cR6VGC00utTdg
 1zI1e67ArlCpcHUiINDBET+oKzxb+H+BNwU6J5pUbegDA4RW+EVjA5rgvs6UWh9P21w8imkjx+O
 +1R8NJ42XxH+fqNBvgw==
X-Proofpoint-ORIG-GUID: 0K7dVVEnDGsumKXn80AAr00vaUTo4Bfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100121

On 6/10/26 5:07 AM, Niklas Schnelle wrote:
> On Tue, 2026-06-09 at 20:32 -0400, Omar Elghoul wrote:
>> On 6/9/26 6:52 PM, Alex Williamson wrote:
>>> On Mon,  8 Jun 2026 13:18:50 -0400
>>> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
>>>
>>>> Introduce a fence over enabling or disabling FMB via sysfs when the zPCI
>>>> device is associated with a KVM. This will allow a KVM guest to use FMB
>>>> passthrough and avoid the edge-case where the host disables FMB while the
>>>> guest is still using it, which may cause partial counter resets and
>>>> inconsistent reads which have no parallel in the architecture.
>>>>
>>>> With this patch, the userspace driver, likely QEMU, is still able to enable
>>>> or disable the FMB using the VFIO device feature introduced in the previous
>>>> patch, effectively securing what is associated with the VM state and
>>>> isolating it from other processes on the host.
>>>>
>>>> For VFIO devices that are not associated with a KVM (i.e., for userspace
>>>> drivers other than QEMU), this fence does not take effect.
>>>>
>>>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>>>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>> ---
>>>>    arch/s390/pci/pci_debug.c | 11 ++++++++++-
>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
>>>> index c7ed7bf254b5..a2dc79418c21 100644
>>>> --- a/arch/s390/pci/pci_debug.c
>>>> +++ b/arch/s390/pci/pci_debug.c
>>>> @@ -149,9 +149,15 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>>>>    	if (!zdev)
>>>>    		return 0;
>>>>    
>>>> +	mutex_lock(&zdev->kzdev_lock);
>>>> +	if (zdev->kzdev) {
>>>> +		rc = -EPERM;
>>>> +		goto out_unlock_kzdev;
>>>> +	}
>>>> +
>>>>    	rc = kstrtoul_from_user(ubuf, count, 10, &val);
>>>>    	if (rc)
>>>> -		return rc;
>>>> +		goto out_unlock_kzdev;
>>>>    
>>>>    	mutex_lock(&zdev->fmb_lock);
>>>>    	switch (val) {
>>>> @@ -163,6 +169,9 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>>>>    		break;
>>>>    	}
>>>>    	mutex_unlock(&zdev->fmb_lock);
>>>> +
>>>> +out_unlock_kzdev:
>>>> +	mutex_unlock(&zdev->kzdev_lock);
>>>>    	return rc ? rc : count;
>>>>    }
>>>>    
>>>
>>> Why not also use a guard for the mutex here and avoid the goto
>>> unlock... also moving the guard below the kstrtoul_from_user()?
>>>
>>> The fmb_lock could switch to a guard too, but that's existing.
>>
>>   From where I'm standing I don't think there is any particular reason to
>> do it one way vs the other. Thanks.
> 
> I do prefer the guard(mutex) because it does remove the need for a goto
> exit in many places including the above. That said it should also take
> the surrounding code into account and definitely needs to be applied to
> the whole function. In this case pci_perf_seq_write() uses both the
> kzdev and fmb_lock so to use guard you'd have to convert both. That
> then feels out of scope for this patch so I'd prefer you stick with
> plain mutex here but use guard in cases where the whole function ends
> up using guards. So for patch 2 you can also go with guard, it's not a
> must for me though.

Acked, thanks

> 
> Thanks,
> Niklas
>>

