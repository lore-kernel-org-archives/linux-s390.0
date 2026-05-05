Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AD3E929C;
	Tue,  5 May 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001720; cv=none; b=pWLy3aVdYnZ7xVntsg61YBQBE1B9DKFSnrJ+Zv68TuWYn/Fqsfc7C82cqs3OEg9cDaLqGdeMLkW/7fV8x1GRpZl1Mi4ZGkxAkRgJpdSREDac4nLPGQIRbfh+BTBM1aznGxljirydEZ3jr5XADF1g/8Y1EZaknpIhtUMTe+sCLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001720; c=relaxed/simple;
	bh=QAt9E3f2WV3xHTVmpBbBdssMurE9cKrS1P1fPUA8YHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+habJv1wEUu2P6gyYC87SdVJKULhQjiguHqkw2rfEbxXgyPGWB4T0Y/2IppkbnWG4WrPohtc48LhIRRp2RY7b7py4mWj9IYQjoqUjL1QJcd4nxrRF8KWLs/WUEthdsYExxyiN+/qDq+BkPNsXgDpv5eVloG6VYHr7VMEQlCAFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WOD5ORIs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WOD5ORIs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645DpT6h1385448;
	Tue, 5 May 2026 17:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xdGhk3
	yoHbdEXDfxnIG0V0zUZX7BLUksdM3LTIuIpco=; b=WOD5ORIsbU/Lg9i7UHfALo
	6XE/cYp92uvTg/pDODNzj4TlniuZpw7ay+Dr3u5DOjCLmU8AG5mVMwD0I4GLe6hp
	yQYVODQy6mf7IcqVRePfYZWroU4UGcDpzV+MVHASP1Wf1PRwQCW6kjp/Cm3As60E
	SiWrU8qMF2+SnbBnZqw0QHQ+zHDO3jwaGhh6sWb5bTfaFHa1Qx3klLofcW2MTdPS
	L5I8fOE5RGpiKWZpn/E613BxFd8+g0YgzcePuqVy9aj8iwHKo7gzmmyoE511kva1
	NCMXv2Tj1jQCDd5wLl+Fu+795YZ2ksqq6ArA1exhtPJ2rXPcNIeQ/iWxWcdzIxag
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4mw3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 17:21:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645H9SDP031896;
	Tue, 5 May 2026 17:21:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqau3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 17:21:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645HLgMt34865692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 17:21:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CA2458068;
	Tue,  5 May 2026 17:21:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28AC058065;
	Tue,  5 May 2026 17:21:41 +0000 (GMT)
Received: from [9.61.249.171] (unknown [9.61.249.171])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 17:21:41 +0000 (GMT)
Message-ID: <d989de34-f41b-4164-96d0-840bb999e628@linux.ibm.com>
Date: Tue, 5 May 2026 13:21:40 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260423235316.3665-1-freimuth@linux.ibm.com>
 <20260423235316.3665-2-freimuth@linux.ibm.com>
 <92f35384-7b03-4071-b7f9-32375b2badda@linux.ibm.com>
 <20260430173106.1da375d8@p-imbrenda>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <20260430173106.1da375d8@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2NiBTYWx0ZWRfXyT1ahq2Bjy4n
 jKNXDwqIIDC0cuLqjTRJpHQpSmsn5lToVdIdmBIQJsaoxXbUqk51kHt5PUlSnDfC5bqPbwOxQpX
 b8YbP1bmx/2qzGRW6NdY7Mho+7rCNw/wSwsSi5GHrSW6meEjglqpK7IlG6qnfA/5aDAJCFKLhrl
 18MCPfKtyCbI0YZXx6qfrDfE3cK0SvVcRk4rrVAx7fAvv4Z4Hi1sBvJkwNXyt1bhe5oAeqwhbDq
 rVTb88uGCFdpBPgDx6IrKh4BVYIQStTTIQ63WkW3zhgLUQqM+QnVHzRT+FK1IrbFGDQUbEboPXJ
 /H9cCsRwX91wEn8KN2cDYeiJFigkSUiP/UCgFMn5kvdSfl5mcc+kj36mKgr+5x+uMXUwLEoEnH4
 Fedb/TEGXm1vA1xPSMmDEay+lOvzdqemCKsAdZSpEogggnH5O6FuIb4yJEf14gdbHhnaRJjwY4m
 jkiO5aPeXRSTcjLFTEA==
X-Proofpoint-ORIG-GUID: k41wExaXNTwuRNxQdXrvXKMzhJIlnmxU
X-Proofpoint-GUID: k41wExaXNTwuRNxQdXrvXKMzhJIlnmxU
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fa2728 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=5ocAmaF1Slgxoixf_MwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050166



On 4/30/26 11:31 AM, Claudio Imbrenda wrote:
> On Wed, 29 Apr 2026 10:44:51 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
> [...]
> 
>>
>>> +		if (locked)
>>> +			mmap_read_unlock(mm);
>>> +		mmput(mm);
>>> +	}
>>> +
>>> +	return page;
>>> +}
>>> +
>>> +static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
>>> +{
>>> +	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
>>> +	struct s390_map_info *map;
>>> +	unsigned long flags;
>>> +	__u64 host_addr;
>>> +	int ret, idx;
>>> +
>>> +	if (!adapter || !addr)
>>> +		return -EINVAL;
>>> +
>>> +	map = kzalloc_obj(*map, GFP_KERNEL_ACCOUNT);
>>> +	if (!map)
>>> +		return -ENOMEM;
>>> +
>>> +	INIT_LIST_HEAD(&map->list);
>>> +	idx = srcu_read_lock(&kvm->srcu);
>>> +	host_addr = gpa_to_hva(kvm, addr);
>>> +	if (kvm_is_error_hva(host_addr)) {
>>> +		srcu_read_unlock(&kvm->srcu, idx);
>>> +		kfree(map);
>>
>> Drop this kfree(), you already do this when you goto out
> 
> have you considered using __free(kvfree) and let the compiler free map
> for you automatically? (or it doesn't work here?)
> 
> [...]

Claudio good suggestion to consider, thank you. At this stage I will 
consider it for follow-on including looking at how you have used in 
other parts of the kernel. And will consider for new projects too.
