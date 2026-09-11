Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE93AB285
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120061; cv=none; b=nDNl+IebPqb3YNGjVnYND0QewVgnyPH+LEjMXHwB732TCX2AWgUnBgkCcX4DAIBQLLr0eBdUxQeVvoa0u8M+EyW4U8myvQ6nToA4NnsZqTgAU50IH4jjY3JLlgIThtoqu5zU2rcUHR88qIjQEFIbA/g+8ucv2IesZzhWhoydRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120061; c=relaxed/simple;
	bh=xGGCc2ntSoMFPb3Xhvkc7zrCAk8Ispg/ZB1L3ojoz8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjY4QPRkOaRE9etBcRgj0JMmRJlFHX5QdyiOotNpsGyxNEQLfjy2wBlhPcE6v3uBTt2gMkWBL/UlpmYvK2crPVR4u86UkDWqxmO4qaKePGP9GMdwNCg7GOXF2hKyTVYhXde+t43q5WR61fbdOrwspVLTYlZ7eq+HKnehqALFxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GqGE4f8x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GqGE4f8x"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B81Z2b1237483
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z9QwjP
	bAxcXeI3iHMqjOI9GxAp3WZdNmDpNzUS13O4A=; b=GqGE4f8xeszevYOkK/8cKT
	Ah6/mHS/dFsvALNBHbdO6XnbrJHGdiQctzCa/P3cK+NXtKZLT8+7Lp7ZH8lPXpiO
	2MFSkPNQWXC8vdS7AT66BgwF2VAn0v7aQdCUFiWOCX9RYUrtnTe9nugtpCMEP5B6
	fEP53ZcCGMF2ghFvPebRFPdxjRgdhDoTu9p0+q7RYQdRZtdVVhGx+lhQyY7aioly
	wqvjJ3js+RMyyalsUMXKBVg8rBSDI8sUdyueiQktYEyqrA11fanwy4ufqS2A924K
	+sCpFAK8CbJ16WbrbSlTneCUDF4UEuENcIUgpa6C9lOtVRZVvHbw8kiKc7Z823yQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qtmk7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:47:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7o87q1318015
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:47:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvtfdjpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:47:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68B9lYwu14614816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 09:47:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8C792004B;
	Fri, 11 Sep 2026 09:47:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E92620043;
	Fri, 11 Sep 2026 09:47:33 +0000 (GMT)
Received: from [9.111.80.234] (unknown [9.111.80.234])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 09:47:33 +0000 (GMT)
Message-ID: <1402f797-77c0-4e27-b9dd-713abf763d5d@linux.ibm.com>
Date: Fri, 11 Sep 2026 11:47:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/hiperdispatch: use system_dfl_wq to reschedule
 hd_capacity_work
To: Euan Bourke <euan@linux.ibm.com>, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc: linux-s390@vger.kernel.org
References: <20260911091309.1238604-1-euan@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260911091309.1238604-1-euan@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa3ce3a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=51Nsnpwx8Kpt3tMXxvMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7zOpgbvZwJgiCeU_SP38vnV5Exah4XFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEzMiBTYWx0ZWRfX6RuMVKeXMMQ4
 y+Z+tuF+yfxis+ClFzxPSpTdHTzPVIH5uSOn0+5qsYNaruiA0xo/pEiwy+sZ6fhvztu35XUU13j
 qMj9a2Hto7SndIzqss/BHkm5tHEsdZTR6cJQMSRZJsoKn7S9a6eygoTlwhhXfXAHzjzCasY9dzH
 jMNNIgq3x0gVgpCIAhPOKzktlOv0f5yGix+q1iZIEZPxMoHXvxfgdX2eeByxrPE7vMgtewWeFM9
 yaB8yvRVosCQCWZvMQHEs/5F95bcSfLkkHoGobOvfnP2M/Mg95QCehszzKRCyyJvFhkbEhnlCwz
 rkFxX4dxVSx/Be3zaz7DSguWKrBfzSIxsqg2fJJEnZQpZid9+mTf5xQodALLoczZAe0DwXl7bVO
 frqVKYyfx0jWMJYbKRWpfFAGxGoaTLsFbXs9sC3t3lwrIwT9turMztFzwX2AVGEc8GbIWAkLpO6
 1ADFpMxoo6JVNfBjkBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEzMiBTYWx0ZWRfX0i11K0GC/30G
 t1o1NFs5Yx4ofd2Q+ZYRTGY4lmTDSAOcQbPx/mkl7Jm2QtdJOeyLU4pAb0CvUdyCcLJfbdIIzoO
 qgj7onicdSV2DWHJsQXxfehskTFsPHY=
X-Proofpoint-GUID: 7zOpgbvZwJgiCeU_SP38vnV5Exah4XFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110132

On 11/09/2026 11:13, Euan Bourke wrote:
> In hd_enable_hiperdispatch(), hd_capacity_work is scheduled on
> system_dfl_wq, however the work function reschedules itself with
> schedule_delayed_work(), which uses system_percpu_wq.
> 
> Hiperdispatch does not benefit from using the percpu workqueue. Use
> queue_delayed_work() with system_dfl_wq for consistency.
> 
> Changing the workqueue from system_percpu_wq to system_dfl_wq causes no
> functional changes.
> 
> Signed-off-by: Euan Bourke <euan@linux.ibm.com>
> ---
> v2:
> - use queue_delayed_work() instead of mod_delayed_work()
> 
>   arch/s390/kernel/hiperdispatch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
This disparity is first introduced at;
commit 72105fc1c1cb ("s390: Replace use of system_wq with system_dfl_wq")

I must have missed that schedule_delayed_work() always moves the
work item from its original work queue to system_percpu_wq.

Thanks for the patch and feel free to put my r-b and tested-by
as it looks good and tela test cases for hiperdispatch show no
regression.

Tested-by: Mete Durlu <meted@linux.ibm.com>
Reviewed-by: Mete Durlu <meted@linux.ibm.com>
