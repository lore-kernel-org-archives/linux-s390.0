Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105113F824D
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990829; cv=none; b=dJuKB7wwMvHka5VuURIXGpQdZ8kAV7qnusGYrj/ZAo55J70BSbsnIkqitbzf41G/AdmdnCIdJVnufI6IUKgo/GN7rqFhC9/5ufpt8IKbGpTghYrhOSlK8ExPY6F+3FT+g/AwHyJ39+RTcn9R6RpjNAHeJqTwW0avBR7iPQFZCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990829; c=relaxed/simple;
	bh=Cn2wTAw75fH2CZfcHXQT+M+V4xaGcrGF8bqitTTzXVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLGBFXro6fESTQ3BQegw+/zAwSvwFYqEX0IOCyW6w1C8j9CTFpgK+/x3WvjWpuofBHlrJ88JCtnyFyQa37lV023XlKjuGqm6nR/N/iXomKP0bjeNbH+2o+8i0GiZG1MorqSS2sRnQe1cvr4Cr/LA38mv0aWm72lMy2UrL1+QgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QTHyj+p2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QTHyj+p2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5bvZ1169494
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 11:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zJdZG+
	o9JRQ2cjoHCqnC4N2U8O9v/kpzNQcMVkn2JC4=; b=QTHyj+p2RDONspB7RgDkRj
	nGgwOe35gjMsP1EpI3ZBtjci+ho/Wp0ju4wXYOKaj82uJ2SRWzmvMpJWV8dTaFzP
	NzoeXDs39CAOhwdaSIZLAHMMQu9gZ7QCLcFPb+XTymQpkvkN6CwZ/IgC89L7aeCf
	OZshpVLUYBaNlAf6dhkXOH9hkfiKbRfe2VD1g+lPVOEN+8GeSg1mIlBZGBr6j/ox
	sg50H6wt4gbOTRe57cLcli8Eef3nH7bna5nuTuoXg1192Vhf7gBClASD9YmMwC0o
	3hu7PdLXP4rFm9AfH4DjqkHA3NQm1/yCfNjUY/emgcxA3mA5CyWDNKPiZQRtxrEg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske18421-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 11:40:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlUND1159913
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 11:40:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt6xgcvrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 11:40:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LBeLT048365964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 11:40:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4E3320040;
	Mon, 21 Sep 2026 11:40:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A69992004F;
	Mon, 21 Sep 2026 11:40:21 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 11:40:21 +0000 (GMT)
Message-ID: <fc096eca-cc22-40e0-b059-39d02d84431f@linux.ibm.com>
Date: Mon, 21 Sep 2026 13:40:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/pai: Simplify pai_init() and always return -ENODEV
 on failure
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, japo@linux.ibm.com, sumanthk@linux.ibm.com
References: <20260903081557.2023814-1-tmricht@linux.ibm.com>
 <20260914121406.39845Aa3-hca@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260914121406.39845Aa3-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R1czZPv4VDZs9FzMAvc5yLwi7OuZTK7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX++/txr0l70EM
 KYpiSCBbZu0HfyrL8hBVrGKHSYvsNTv6hm+5RJr7QVP32lwUKOCpZ9ACJ638McncoC1xENW9Img
 RC/4Hum7CPqPKJDNhnzkJ34deYLF4IN/HgdLmw/sCvmbYMwbaYRWi8UP5z3PWPzACDQ+xLvh9zD
 9T+aUbCKIpIAja2CeM+YWN+D4LUlvjo2gj6fPVyoBKuEJy5eNxzwDw8Vcaj9ZHSyVixSC5d8GdD
 AiZA3xJ/lviOapBlQTUvkmEQw1KU1TOuc4CgEN01ZBWf8Z0Mle0zJNVAwC0tLD6fKt42CQGeNCe
 LMtsXsNkWZUuVANug6H5MNCP0LSy2U2ZU8wWXl8jZzpp5rjMDNxLfO7k2scvWHCuYcAQPWCgp77
 Q/rqCkYgVap77Hf+w1VCvFyQu2P1RdNYkUcVC5uN1qR3rEyY4MvBat/AVsLRYNrvyF0DTpUsDT7
 ClYGLogjZVADMtSwyHw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab117aa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Y1TyXL7_Fa6Ebye-X74A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX7sxtPcU7A0a2
 8Ws+KhmOEX22qGJLmvFdG0ZZfOuZTWf5QPHn7O7tPZsMAKtV7Z48gs4BZBUoen6o+EzCtknbE4p
 IhD7WVHzhHVmXxGLkkU0yL1s+1Qk6iQ=
X-Proofpoint-GUID: R1czZPv4VDZs9FzMAvc5yLwi7OuZTK7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210168

On 9/14/26 14:14, Heiko Carstens wrote:
> On Thu, Sep 03, 2026 at 10:15:57AM +0200, Thomas Richter wrote:
>> Code simplification and remove variable state.
>> Return -ENODEV in all failures to indicate the PAI PMUs are not
>> available.
> 
> Why do you want to hide different error / return codes? That makes
> debugging in case of an error more difficult.

Well, hiding was not the intent.

The kernel common code does a lot of checks at event creation,
then calls the PMU event_init() call back to install the event.
When this fails the return code is checked and further action
depends on this return code. See

  perf_init_event()
  +--> perf_try_event_init()
       +--> PMU->event_init()

See include/linux/perf_event.h for return code meanings.

When we return the value from cpuhp_setup_state(), it must no be
-ENOENT and some other values. Because those are used for postprocessing.

Thats why I always return -ENODEV, meaning event is valid for PMU, but
PMU not operational. I thouhgt this might fit best.
  
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
