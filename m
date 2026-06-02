Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154935DA78;
	Tue,  2 Jun 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424108; cv=none; b=sRT/pjk1My8EA2o7kGufTuO4KLAGggIDe38Ml2rt4TyI0s/tGJFYCEuplY6bi//C0dZgMAUooXAIGOlQV7ioV2HjYDxFwQ77WgqrnurZUjQUfuZIeIUqwj+comb6tuK7dGb9VTONmKrET8vRGMUDRjL41uA/BaGGFiyA387s/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424108; c=relaxed/simple;
	bh=z2WBzrcpkiiOuQYyIf2jC9WAE6sYs5+zd6bH1lL0eFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ljQ96cP0Cx+0yb/6uor5+XtC6Jk+Bg4ZNC51MLycmGOJst0nY0XMMNUp1VvKhuVeGr9dHSpzNsunCqr7oYS8eM7cq1NdfXZscnEJ3TvYKdHegiMXjuZxG8nBuOkFbXSdn5CL1AEZBxozbNcs9qg74CKQKr3w4kBIbX+WbLImPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MGPO33aI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MGPO33aI"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652HWGTS3708195;
	Tue, 2 Jun 2026 18:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R0MmQc
	zvvz7SpzEDxqmXXN+3teeuzliyednKPp5NERY=; b=MGPO33aIYaQP6vgXktl/k/
	Jq3iLkPpoSjAWc7R2C0AZxG/MabVI0QDmQJ0l+EOU5abhV0rmUaMBMotOp6s6qFp
	7sgRLLfTD2Te9ZtGPbzDn+GR9ABupLvB0rSdH/poAV/C7r0yqAFput0TrLczYMSz
	aU93PxHXAG/qbvoNReRuaVS6FhSCpfwJUpcIncGnpvsnpfSlCxTth6gmVW2L6AxD
	OB9eIpvwEnQIC4t1L6thBbjkRjdTPHwKWOa+tTuUDQwRQMr213nRsTP7r6GlRci9
	pmE0sEHNpHgPWSunyyt2oSBv/bNIL0kmM2RuU2Ur4QJeCxZ12txl6K8+cHIc/EDg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae6y4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 18:15:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652I9D49032019;
	Tue, 2 Jun 2026 18:15:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvvnv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 18:15:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652IF1fb18612940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 18:15:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B3F05804E;
	Tue,  2 Jun 2026 18:15:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AD1A5803F;
	Tue,  2 Jun 2026 18:15:00 +0000 (GMT)
Received: from [9.61.245.94] (unknown [9.61.245.94])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 18:15:00 +0000 (GMT)
Message-ID: <9c5f80d8-0a08-4cf2-8bbe-e071089e8531@linux.ibm.com>
Date: Tue, 2 Jun 2026 14:14:59 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
To: Matthew Rosato <mjrosato@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260531190353.204317-1-freimuth@linux.ibm.com>
 <20260531190353.204317-4-freimuth@linux.ibm.com>
 <c9797cc0-d661-4208-bd89-d96fff3b8a07@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <c9797cc0-d661-4208-bd89-d96fff3b8a07@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1f1da7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=UiGWTbJDlg0Xrmk02SUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8aJ0_19Ons9IiWmVGTPgNVxQ60U4bkQk
X-Proofpoint-ORIG-GUID: 8aJ0_19Ons9IiWmVGTPgNVxQ60U4bkQk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3NSBTYWx0ZWRfX44JpRYJwMhs0
 B+CKASZs54Gl8N9GeKbFxVkeu9HeZIlRQ5UzlKmEMx83G0tGNDM+fK3NpNkOz+guESn3NrNJjGG
 7kOtPkBvWPmWkyvcv1csZX3C58Zwf3boay5Oi+afIr27fR1g0X2WdkVIVYz1mucwEd+RSzCDInT
 EMCJcKJxwn3QTV2wSgFT1ZWx7Gi+gIN0wVLc/a4H+LmAnVoeaJ0udsqayUlkjzPYAZVuT/m2hve
 1YMIxVBRhudDPfvNKn7qE6hc6h6+Jz7Q6MfyxE1Xo9zvYE16PppYLRmZB47gHaPLwOhSukPiqgY
 GoWonyMiGZPd5QcgkNL/FFfIa1pobm8ZeBF6nLMf272ByBIRyS19ylccao+r9vuFKSeQdOeX1zm
 2gLQkejAtSUPirVPppWAZwK0ho3n8tLiO2ZfppFtBT32I9ZqUcWC62fahRbzN7gIVXU4aqQPvU2
 GYZlGQIRFus4gumBtIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020175



On 6/2/26 1:30 PM, Matthew Rosato wrote:
> On 5/31/26 3:03 PM, Douglas Freimuth wrote:
>> s390 needs a fast path for irq injection, and along those lines we
>> introduce kvm_arch_set_irq_inatomic. Instead of placing all interrupts on
>> the global work queue as it does today, this patch provides a fast path for
>> irq injection.
>>
>> The inatomic fast path cannot lose control since it is running with
>> interrupts disabled. This meant making the following changes that exist on
>> the slow path today. First, the adapter_indicators page needs to be mapped
>> since it is accessed with interrupts disabled, so we added map/unmap
>> functions. Second, access to shared resources between the fast and slow
>> paths needed to be changed from mutex and semaphores to spin_lock's.
>> Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
>> but we had to implement the fast path with GFP_ATOMIC allocation. Each of
>> these enhancements were required to prevent blocking on the fast inject
>> path.
>>
>> Fencing of Fast Inject in Secure Execution environments is enabled in the
>> patch series by not mapping adapter indicator pages. In Secure Execution
>> environments the path of execution available before this patch is followed.
>>
>> Statistical counters have been added to enable analysis of irq injection on
>> the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
>> io_set_adapter_int and io_390_inatomic_no_inject. The no inject counter
>> captures adapter masked, coalesced and suppressed interrupts.
>>
>> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Matt, thank you for all of your inputs across the iterations.>

