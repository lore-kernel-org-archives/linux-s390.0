Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D8420899;
	Wed, 15 Jul 2026 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107175; cv=none; b=ngMycn/Um1yh7HVDAGluSJUvs+GYj4ZY8yAu/nqfHfR8Z47M2WcCJr/Wmqz47kPpmekOCQj0inRTUneEmrocbachdiBsowTxI2xpvCgYxAZKhnzmOzD0HE3DH77Sr5Gz00dsnuCFIjYbSZhlxL9MH3WOFukU5qFkTplP/fr+S4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107175; c=relaxed/simple;
	bh=nUk7g+IhB5Nyz/prQTTYbYB25//DpD+rB1OcRETpl5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpyJroKk8prBZKs/ic5/k0rEay1noGi1Y7Gb8+8KEJulLRLLyzwkK4WqxlZPCTOfS19Vb5wAleJaD8T3fzT4rZShn8rkHAMAsvyBCfwZS9GuXU/zV43j3AfaBRcAAtIEyRk+Pq1f1lsl4iMyC3qgwE1b9c+5xhxChvHpx+jAA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kkt4dOEb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kkt4dOEb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F4C5oU3272900;
	Wed, 15 Jul 2026 09:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Coji7X
	c69oHilevycZqRnTjxpr+xLAAwbkdPXHNk9To=; b=Kkt4dOEbDrhdFoWNK+rYMz
	AjTqce7fP9KG/q0CrETsRlA1G65Lq7yLbp9v5v0AFP/aLuyKkj0ijW7DBq44VXLS
	mhSE1K+KLKar0YyZx+vdwN1djcOUzyTUW/m5fbV1k1n2mFGJz4A2MuPy603TzSzF
	W+/6ecTFpc13UhnbZMsLgl6n1IIuSXnV9FMYMisGA4zJzTt3tCAE/G9U2REqYfzh
	YXeEUOE5c7Ax2hBVWr1MNcEWax49Dii7F8yihpBNEeYDkJT3A2aouSUHJ75YpSyP
	5ynlHp/DveCqVJ+BUvyguXsyHzCyoyGS0R34YftpB80AlQ6bp8WMPShX3ziqmVFw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbt3b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 09:19:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66F94dAp017046;
	Wed, 15 Jul 2026 09:19:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy6tw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 09:19:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66F9JQ9r34406872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 09:19:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 558582004B;
	Wed, 15 Jul 2026 09:19:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D9920040;
	Wed, 15 Jul 2026 09:19:26 +0000 (GMT)
Received: from [9.111.23.116] (unknown [9.111.23.116])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jul 2026 09:19:26 +0000 (GMT)
Message-ID: <869ceed8-1c04-46ff-aa0d-c1ae5e01badb@linux.ibm.com>
Date: Wed, 15 Jul 2026 11:19:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/21] KVM: s390: vsie: Add helper to pin multiple guest
 pages
To: sashiko-reviews@lists.linux.dev,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        kvm@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-13-ea9f12066408@linux.ibm.com>
 <20260709152820.BA50D1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260709152820.BA50D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a5750a2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=0UtCLVEFYwN47_7NgLQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA4OSBTYWx0ZWRfXx/3B99pr1eWr
 8CJk8TT/cBOjw28vTs6RBPeKDTB0jALnFlu4haArlrQv1DowFO5lXIKhZpO50V+3t3Pp9DBG+7U
 GGCpRs7gpQBREq7UXk2m8UkuJgcP06VVoATaOmasGcOf2RmM6jRhjmwHP41V3HY1B9xHDc3JWUU
 c2XBv0Dpp9qyRMCWKFI2Cbu0EPQfvHFVUq5SrKvHamwkm/8XMh2oLLGxy4wlRnTAP9SOxRIcYGE
 oj3JHq8oU3ehU9DHOlR0fjmL3REg80FfETyVEt7AyW/7MHsV4jQRDRhwsTmX9UUFt9kniT2X5RC
 3hFly69v6/6WjndQLzaMgPX3tThNhIM4GDAaph2j3In9ZOxE5uA/T1DRqb0zW3XhEVTtkemSQE5
 EF7wOYdRPOTQPfstN1ZXuf1Dfb6wmP91ZY41EVxxW3wiSfYEAaFqTpe+yHwRkQ+/boGhH3xBk7p
 Aoqm1sIE4edltbrW53g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA4OSBTYWx0ZWRfXza9QSkZwZmtD
 x9q5+eDUqXYTDwIH0O8pcMeK5y7RlbsBesEspuN0XkyYRTYrHtfrdo1sM02R+bsieG8jQvARVBm
 vUUQqm78HM/Th8YPdxjAnIlyv/eQzW8=
X-Proofpoint-GUID: aJroS7LVlYVadbndY5Nfpuik1B_SGNSn
X-Proofpoint-ORIG-GUID: aJroS7LVlYVadbndY5Nfpuik1B_SGNSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150089

On 7/9/26 17:28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incorrect address calculation for unaligned GPAs in `pin_guest_pages`, leading to data corruption for multi-page contiguous buffers.
> --

[...]

> 
> [Severity: Medium]
> Could this address calculation cause issues if the initial gpa is unaligned?
> 
> If a caller passes an unaligned gpa to pin_guest_pages() (for example, 0x1010),
> adding PAGE_SIZE * i propagates this initial page offset to every subsequent
> page. This would mean the calculation requests 0x2010, 0x3010, and so on,
> skipping the guest memory between 0x2000 and 0x200F.
> 
> Would it be safer to align the gpa calculation for the subsequent pages to
> ensure a truly contiguous buffer is correctly pinned?
> 
>> +		if (rc)
>> +			goto err;
>> +		addr[i].gpa = gpa + PAGE_SIZE * i;
>> +		addr[i].hpa = hpa;
>> +	}
When unpinning that shouldn't matter since gpa_to_gfn() removes those 
remaining bits. Are you ever using a hpa other than the index 0 one?

But yeah, there shouldn't be any offsets for follow on pages.
