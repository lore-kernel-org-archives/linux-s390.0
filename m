Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E831AAAA
	for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395578; cv=none; b=jlP2qgHI/1eLgP+jutkFzFj9as4nzXA1tVDKhPWmd6EtbfN2UXtgQD84T6HxXqD2y83IL43QvqOqmWEziVFPTYw/IiQyed4sWF2lLP8pZ3BO3FYyLfZopdfiqYkfzCQ7ZUCuWxuOnZrpEkSVoUPy1FCrcZm9pi8TFBUCSWJ/dMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395578; c=relaxed/simple;
	bh=vUxiP1rwSH+fXvXDrkj+vPrS0DP3eca4sl3Gn+M6or4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzVykTxB+YiR/oiWr5lrSZgY06V89T4mS1qQHCpHR+rrximVqIbUmruzkgZg/bFjixJH7FIheZ410Gmp+5qNc5E2burYpJUCDzhJSIgcTCAJdX66Nf6sIJlDf/bpLJIpz/5mAmPKonxqkk2uC4lFcmYEiw4xvubd8BXwI8udtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kHJe09Cm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kHJe09Cm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mN5l3040864;
	Thu, 25 Jun 2026 13:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kfwAmb
	/BBmc3nkaPleOW5wi1m0sSk47vjsgik7/uIjQ=; b=kHJe09CmKwaRaHWLv2Gf0v
	GrCBf3xGWZ3kvxgkeRXOG4oFZqKR3XQNnjDM+eBZBWo1nUZc4mAzkmI7+k4VM4QO
	8pbu7ammVqDcLBkoHeXRGrLbwouFaX1auWAXUVZRjy3uDqppk1kxx5VPGTFeasCs
	iObstTtd0XGdhjg0Ywj40A3oVMKCocqu9UXW4UQi4KOVFyXdrEIHcmYRi9zEja9J
	O3imUTjJ2QhDgtM/rRk2/7cFpgbEVQXSEasgxcveNncRaIjdXdC2n2L5G1ye03iE
	PcR4JPz6j1E+lrf35BHkWumwWE1ehMajSew2aLFQNrJhZAq/r+TSIN20u55PSibQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3t684-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 13:52:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PDngId032114;
	Thu, 25 Jun 2026 13:52:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66kee4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 13:52:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PDqoT211141454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 13:52:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2672E2004B;
	Thu, 25 Jun 2026 13:52:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C475B20040;
	Thu, 25 Jun 2026 13:52:49 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 13:52:49 +0000 (GMT)
Message-ID: <1c6845c5-6f16-40d2-aa50-887fb13d5a42@linux.ibm.com>
Date: Thu, 25 Jun 2026 15:52:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Improve DIAG 9c observability
To: Ciunas Bennett <ciunas@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
References: <20260625131615.262367-1-ciunas@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260625131615.262367-1-ciunas@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3d32b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=uNpy-0L2wzZnJY0atOQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDExOSBTYWx0ZWRfXxzdIL+y8tifM
 nYhR1MShrH7AhxpJjqWy6VwJHO2JicgpvHKOc+lxX1oA7pP4rs6GX5W+4eyHalPuPCTftR2JAm8
 OpcvNSbaMP5j5z7CZjT6md+z2wyTxrQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExOSBTYWx0ZWRfXw6Aq4pqw6q4V
 iFOvm86QdqXxCHoSwyZJ8prDiFqZcNbS4RhVu6ahlfA0kVfg+kXT4sxa7LAy+VrLyQcokPjfBdc
 kEv1tCBGxG3TaDxEzENslinK9r4mVHTf4QOZJqE1jb99W4gBToKS6Txm1rdZigNacXbEIpVEKou
 an74OhLTbXnv1SvWQoZ0CfSbE0PaFkpVUnK/g5cDGRdDtLLV/qx3tndVNSA1p2rk9cDhtX8hum5
 g/hzdlRw8AwJsezTm2SDufseDk5fK1BHj4NKfzV9gAyr0iZpn8nn9g5RYtqSicdftuyfP4cuvUB
 7QQbOkBFFyiYoI750sKrxBFcCDhbrZO9Eh71xOylHV5k44rtKqR9BJ2YF2dCfgF9hEoQ52+xP3X
 nNmiapMzXpzIHplcB0u4vpHpIquSm9zlX8bnyvj+BDogOLmZtRb5/mcYIW3lvI93a34bwTvzFRq
 aEYOS7v7wzMvPlYL0ow==
X-Proofpoint-ORIG-GUID: 1IK6xV8adJmZ_ppIr9RTUDD64S9XXlkg
X-Proofpoint-GUID: 1IK6xV8adJmZ_ppIr9RTUDD64S9XXlkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250119

On 6/25/26 3:16 PM, Ciunas Bennett wrote:
> This series enhances observability for DIAG 9c directed yield operations
> in s390 KVM by refactoring the handler and adding comprehensive tracing
> support.
> 
> The first patch refactors __diag_time_slice_end_directed() to use a
> single exit point with a result string variable. This consolidates the
> control flow and eliminates code duplication in logging statements,
> making the function more maintainable.
> 
> The second patch builds on this refactoring by adding a new tracepoint
> kvm_s390_diag_9c that captures detailed information about directed yield
> operations, including source/target VCPU IDs, physical CPU numbers, and
> operation results. This enables better analysis of VCPU scheduling
> behaviour and helps diagnose performance issues in virtualised s390
> environments.
> 
> Together, these changes provide kernel developers and system
> administrators with better tools to understand and debug VCPU scheduling
> patterns related to directed yields.
> 
> ---
> Changes in v2:
>   - Add system maintainers to review mail
> ---
> 
> Ciunas Bennett (2):
>    s390/kvm: Refactor __diag_time_slice_end_directed for single exit
>      point
>    s390/kvm: Add tracepoint for DIAG 9c directed yield operations
> 
>   arch/s390/kvm/diag.c  | 19 +++++++++++--------
>   arch/s390/kvm/trace.h | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+), 8 deletions(-)
> 
> base-commit: 184fc1890bcc8242f00fee660d2651290f1461a2

I gave the patches a quick spin using a single kvm guest.

Both VCPU_EVENTs and ftrace events works well.

Tested-by: Mete Durlu <meted@linux.ibm.com>
Reviewed-by: Mete Durlu <meted@linux.ibm.com>
