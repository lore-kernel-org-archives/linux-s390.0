Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8E377563;
	Tue, 18 Aug 2026 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066101; cv=none; b=l82fl8K4T9R38HpGwzBgeJXihV9pR4hUDJ4ALrGQXvPAWXn9XdHQhe1n+I2twva0BWwbu47nycrhKYjnPZFbb6r6iVxj2X5k9o+SIeXD+oZwfa3oPcu3EUOkDmCVchSl9mA71/iJBOun0RZatSb8kP/xI2hHkttquUD1PfYwCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066101; c=relaxed/simple;
	bh=UtKHPU7LgYeqF7pEdbbr5qpCC5qokgkZW2+ag8nr3KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTIGKwoFxuYDkGtdS0iOsRZp0A4X1/gA1zdw2yeiKrgh6cvrd4CdxIcm1Sjto9WfYFN432XMRiDryyEeGDNX3XrhrvggjhS8feXEKPFmr260BNgKXUK4lAoJywnFlds1+SuxkLCT+9h+woULNKQByEab2i50m3qSjWmunYR+/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ODPHnIU7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ODPHnIU7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3VWH505027;
	Tue, 18 Aug 2026 15:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z4d3+a
	tjiJsDT4/c8d9SPB69V+GK4aoijm3zu/E4Cx8=; b=ODPHnIU7JVLe5ozXQEKFhW
	MWYXbW1wb1bTG64HUXszroWYLq38EzS4C11DGBbdYRUeMdGAbBe9BV8Rs/huu4Ie
	lpHct08KfUYLxdMy9HdOyECIJomMUapk9eMM0sAc00CfhBJR/n4dFbFvhvw12kWv
	Jyh3Bmy+OTu20ZMCxcUVNLFSLvbsbGEsk/nQPeL0ofJMlp8XD0INJBRrwUzyAzMl
	kS5RZViaPnSl/kwluU+v0t+l0kUoPDn15J+CEBP6gt1ykuFnmgVEzikR4yq0CEkt
	LHNZJjffw9PQBxlgs+EWL+vazlH6XtItpkCqvN/OBtBHIyHC9EsiGh39EduMCChA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4s35y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 15:14:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IFBSt1001655;
	Tue, 18 Aug 2026 15:14:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh3u8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 15:14:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IFErnY45482376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 15:14:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9384F20043;
	Tue, 18 Aug 2026 15:14:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA4F120040;
	Tue, 18 Aug 2026 15:14:52 +0000 (GMT)
Received: from [9.111.45.90] (unknown [9.111.45.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 15:14:52 +0000 (GMT)
Message-ID: <4f233ae1-2a30-4498-bd5d-2a001c96b2d8@linux.ibm.com>
Date: Tue, 18 Aug 2026 17:14:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: s390: Improve floating IRQ injection behavior
To: Halil Pasic <pasic@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260817121631.159451-1-frankja@linux.ibm.com>
 <20260817122849.9F8061F00A3A@smtp.kernel.org>
 <3562788b-150c-4387-a840-60d9e6b6e49d@linux.ibm.com>
 <20260818163226.68c6bea4.pasic@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260818163226.68c6bea4.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7oyVCJAtDwDm8b9vwPVE6Oy0CML7dt0h
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a8476f2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=0b-LWui6CJ47Kv1T03UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExMCBTYWx0ZWRfX+F5Vos5luRpK
 P0AMPT3R6SKL8sPYkDhg/u6tSzshLuk1YeFwC8mpg1GwXPwxdIQ9Ge5JMdhVG4DXmXUtkbkP/lA
 7QCIxUZu9KOJMLwOVHB85QYx6or4b+4=
X-Proofpoint-ORIG-GUID: 7oyVCJAtDwDm8b9vwPVE6Oy0CML7dt0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExMCBTYWx0ZWRfX+3ULzZAWplGR
 zgezgXVtbQXb5hYzxluy+gX3SaC/Ykb3lu49/Qz1YsouQCHZ2fP32fTEs1PLv6snXu9dsPG3kvu
 oJtG0AJh9oQVzZti3UsJTCmOy2Cihc5yOmY67PxEqqjV575gY5n11pt5UrrVfhi+2PhpJoy5Vai
 QKFx+gLAEwocZD5Dx3sS6FjHUlNa8b9sFdSAX8s+tGg6ecp6NUZ2TMwRMF+HE5DjX815yYV7Er6
 1DtsaMJKLaY4NQUXSp+XlJSlN3EWImOydQzoZs57TMbUF5PNNlUlYvgowqtCRePrjNDEWL06Gl7
 buiVOAnFL548ZdT3tztH68SU5G34i1U41kwCisSLNnzCLMhOWGPxCO3afjdafKF4NgimTX3MlUS
 /+X1gxj8VjA8JKmbHrIGEnje8NUko2q46ojF1KFB/DOY1FUEg3EL1iKc7wCsnlkw0wWMh2B6C4U
 dN4x+ppFFZt0Ct7cZ6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180110

Am 18.08.26 um 16:32 schrieb Halil Pasic:
> On Mon, 17 Aug 2026 15:22:41 +0200
> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> 
>>>> +	irq_pend_mask = inti_to_irq_pend_mask(inti);
>>>>    	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
>>>>    		sigcpu %= online_vcpus;
>>>>    		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
>>>> -		if (!is_vcpu_stopped(dst_vcpu))
>>>> +		if (!is_vcpu_stopped(dst_vcpu) &&
>>>> +		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
>>>>    			break;
>>>>    		/* avoid endless loops if all vcpus are stopped */
>>>>    		if (nr_tries++ >= online_vcpus)
>>>>    			return;
>>>
>>> [Severity: High]
>>> Does this code drop the interrupt kick entirely if all vCPUs currently
>>> have their interrupt masks closed?
>>
>> I think this is a corner case but still a valid finding. We can probably consider this
>> slowpath and wakeup/set cpuflags for ALL cpus? maybe after doing 2 rounds instead of one?
> 
> With GISA, I think the FW is supposed to deliver the floating interrupts
> without dropping the vCPU out of SIE. I'm not 100% sure but I think we
> can rely on that mechanism for the CPUs that are in SIE. Without GISA,
> I think, it is reasonable to assume that vCPUs don't keep running for
> ever. It has been a while since I have looked at this code, but I think
> the SIE exit path would catch this. If that is true we would not really
> lose initiative, but just see delayed interrupt delivery.
> 
> Sleeping vCPUs on the other hand are not of interest in this context, I
> think.
This is all corner case handling. Imagine one CPU running with IO disabled
and all other CPUs sleeping. If now the "opportunistic" wakeup fails the
GISA IO interrupt will never be delivered unless there is another wakeup.
In reality this is a will not happen, but see the latest kvm unit test
patch from Janosch and it might also create latencies, the "pick one CPU
to deliver and wake it up if normal processing does not work" obviously
has a hole in specific cases.
