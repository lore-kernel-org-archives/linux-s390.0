Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B0314D05;
	Tue, 23 Jun 2026 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232609; cv=none; b=AA7KLiRvJuvE4KyTy1JhPUpTsDMkSrT5eslK+L8NhggqxPyrmi11//EjxH9SOFp2PFN0YimJ6mwvHXrIV/PbdfTa3ZzhbIwn+7byOzvCZl2YywL/KYkEQZPWAqWsLeOovm93Z19VOTlssvCXwPJ2lAzbAOPP8E/tzk8azbop24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232609; c=relaxed/simple;
	bh=dV6XRYLXXzvzjaMZ04bEkU5gWpaY2N4AusVKiNZU2tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qq2ipWIaXFnisWX4PCtI7LXgBPBijlrVVXG6c8Zw01GGGD/ilUKpvEdKzNBvovoJ88dFj2AwVfqo1i1Z3pn+dlK6tRD5J57RZ0iWY6T/klC2kGeoviWBNewrO9uAm3Iw3VyEMEiI+88Du9gbs/0XCfMRDBP9s2xN3YqipqZfGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KwVEBCJk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KwVEBCJk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmRYH1805308;
	Tue, 23 Jun 2026 16:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EqNSVt
	0mvyumIqPhCRlsTU2s/+Hw8k+KMe7ciX5YfcU=; b=KwVEBCJkMV0T1T05ssuYUr
	AGOFB9yEPwmFRH5KWdyJj0xhakZF/OMlq0v9E6McbDWjqTHVwKuMbqq429TADL6/
	N6AlX2SHuu3HsQieGvYqySQ/2hgQEezE1puI0/okLypuSV3uXXwoCvSVkZ2fhxHB
	bAF6+erHYMVDSU3tk9yLuEbqCyW9vuLCKUTMrGsnCLujG9Ec2gbjpAsR8acGeJxk
	lYGPScOxECBm+pKhfX98D6ae3iT+NTiDl0trq7SNcRv0BmYF7prsg6JGqO7p/h3C
	K1TQ1xoTACAml12J9a53y9zo0gpmXRqwhE7DW3CHnmMTFCa3lUBCWFalxlFDngCw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gfnts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 16:36:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NGYfvv026629;
	Tue, 23 Jun 2026 16:36:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phc78f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 16:36:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NGagZZ19727012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 16:36:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08C2858065;
	Tue, 23 Jun 2026 16:36:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C30F58059;
	Tue, 23 Jun 2026 16:36:41 +0000 (GMT)
Received: from [9.61.246.142] (unknown [9.61.246.142])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 16:36:41 +0000 (GMT)
Message-ID: <730608ca-4a3f-4dd2-ab3e-4b83716a97d1@linux.ibm.com>
Date: Tue, 23 Jun 2026 09:36:39 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 4/4] PCI/MSI: Enable memory decoding before restoring
 MSI-X messages
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Thomas Gleixner <tglx@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, mjrosato@linux.ibm.com
References: <20260622171840.1618-1-alifm@linux.ibm.com>
 <20260622171840.1618-5-alifm@linux.ibm.com> <87ik7al3of.ffs@fw13>
 <c8abc1c8-71e0-443f-820f-182c0ff931e9@linux.ibm.com>
 <087b5cafd04d2fee89f3a4a941d425e967d1ee72.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <087b5cafd04d2fee89f3a4a941d425e967d1ee72.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s7Ydh_UkrSmtD3P7B4QXaLlLVwFQjkWv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzNCBTYWx0ZWRfX+CFI+Ad4r31W
 xcMUTRcz6LdevM+BGkPvAARj2UiEg3OUriQCT/hktF0nyZluhdfzUqVn7+/rp9+5TONpSLvPNBw
 4k6LaLW+ElaBFtk09d+ZqTTfQzfhrOE=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3ab61c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ylRXk-n9h8MM0u5Yn-8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzNCBTYWx0ZWRfX8/MARbqvKpRs
 2x0gYGPMBZCHRaOOM/otDYciPNg7YMHekSf7xTlolqXz9XO3svsNj9CYOyDjXiyv/Ko5pmNCCUo
 tZZwnijKoYtfSQWfa6oEysiSDqA47J4yrHSS7BJF0SxmIzz01OR8XE0DFhruVpp5nEABA8GjvA1
 EmEdF9bf4WfzlwmXk07UMXb9VjsCoQBlCNTCXkUOe3pphPOiGJI8v94Y5jewbSULbJxxQwz4xaN
 OsPeuJJhy8SI0Z7zJk5fzApYS8dw4wkakzkOfZlCnFwSyYqjDRO6frP9GsWIsYroxKrvzoC6YCJ
 6y6H6XYqpZik4LneyFkXj43SxOrDgj+rQ1TQEaG4hDBLIeK1R1OW9YQITDU5Y+GIpliJTzfW2j7
 YYoWP0U5VXZ0uyGgh1vU1WizjFNKII/IWVfTuqOM35VF3D1q/lO4M4uOS1uKzXSWAweLqVSbUAk
 iKOiNn0pCOshuCHH3uw==
X-Proofpoint-ORIG-GUID: s7Ydh_UkrSmtD3P7B4QXaLlLVwFQjkWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230134


On 6/23/2026 4:28 AM, Niklas Schnelle wrote:
> On Mon, 2026-06-22 at 13:49 -0700, Farhan Ali wrote:
>> On 6/22/2026 1:29 PM, Thomas Gleixner wrote:
>>> On Mon, Jun 22 2026 at 10:18, Farhan Ali wrote:
>>>> The current MSI-X restoration path assumes the Command register Memory bit
>>>> is enabled when writing MSI-X messages. But its possible the last saved and
>>>> restored state of device may not have the Memory bit enabled, even if a
>>>> device driver later enables Memory bit and MSI-X. Attempting to access
>>>> Memory space without Memory bit enabled can lead to Unsupported Request
>>>> (UR) from the device. Fix this by enabling Memory bit and restore
>>>> it afterwards.
>>>>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> ---
>>>>
> --- 8< ---
>>>> @@ -882,6 +883,8 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>>>    	pci_intx_for_msi(dev, 0);
>>>>    	pci_msix_clear_and_set_ctrl(dev, 0,
>>>>    				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
>>>> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>>>> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
>>> Can we please have a comment there which explains this? Three month down
>>> the road this will results in head scratching otherwise.
>>>
>>> I agree with Niklas that this wants a Fixes and a Cc:stable tag.
>>>
>>> Other than that:
>>>
>>> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
>>>
>>> Thanks,
>>>
>>>           tglx
>>>
>> I can add a comment, how about something like below?
>>
>> "The restored device state may not have Memory decoding enabled in
>> Command register. Since the MSI-X was enabled for the device, enable
>> Memory decoding before restoring MSI-X"
> Missing "the" before "Command register" other than that this sounds
> good to me and I agree with Thomas that a comment makes sense here.
>
>> For the Fixes tag, do you have a suggestion for a commit? This behavior
>> has been present since 41017f0cac92 ("[PATCH] PCI: MSI(X) save/restore
>> for suspend/resume" which introduced these restore functions. So should
>> be Fixes against 41017f0cac92?
> I'm not sure but my guess would be that for suspend/resume this isn't
> an issue since the suspend part would save the state with Memory Space
> enabled. So it wouldn't be broken in this original use-case. I think
> the problem only occurs in case restore is done for error recovery.
> Might it make sense to have the Fixes tag point to a2f1e22390ac
> ("PCI/ERR: Ensure error recoverability at all times") even though that
> only helps to expose the issue?
>
> Thanks,
> Niklas

Yeah, commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all 
times") exposes this issue. I am okay if we want Fixes tag to point to 
this change, unless someone objects. I will also add a note in the 
commit message to specify a2f1e22390ac exposes this issue.

Thanks

Farhan

