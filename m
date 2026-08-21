Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254838239D;
	Fri, 21 Aug 2026 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341304; cv=none; b=OoNcFxd7Jq9I73SKYlcpvVlMMgZ5y8Vlfl2INV1MR0BD9Dp9+SdtM4ZPpEiGiYRVElnzgYMMRn5Kf8MiRc4rOV7s2aXmGeqjTU7MjrSn0J1IYBGbg7Wvtd95cJrJ01GHxXQDP5zAoU1YRK58e0lxLLPRfHt289VU3fOPtXJThAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341304; c=relaxed/simple;
	bh=DbxUWY0qqcvPjEknuVti/oNfic++7WDAnMEtpJTayW4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YJPazc5YWW3EySGDUbCel+f5S/DWs3kTd7FjCvtHhzMUnnS6UWb6Tx5L5gqnaKutSMKFrkt9mRPImdbdt+afZCmRbrPBQizN/+M9d1nIEP1thvjNrPU5urrrkehF+8WOjOVwn2V/lOkJaIctPavM84Z/NBJ7bto5Pdms4SNjWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WwsFYJFe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WwsFYJFe"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVfq31237401;
	Fri, 21 Aug 2026 19:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Fz4uU3
	2VA7Lq2uTEivOVS1aUnH+mOYaaw2DFb9K6k6U=; b=WwsFYJFe9yHl/7KZz91ulN
	XlfPaTg5lWAaTDEsawBNvYSDBv6Ppe98I+AlVPJhZoXtmY3juPzq0aBMslKRhzDU
	z3PYbfESlwXjwGjGSFDR57rdKmWOoOJUD04nBw+x8igRR8JbDlZ2oN/HOnnoQ+C8
	g5JT84DoAmsnr+isBtWrRKiJcbMlap1suA/5lauTN6LSOfX0c44YyE2bBj7pQBLJ
	zL90gGaqS6tW7E+XjuXiz/6KDUCcWjzcDxC4SZe41UGS5gpSVbvT4oF+8AXOp/+F
	M6OrIauNb5pYEb+4R453WXKleApnjM8+1/3rtACJuFt6ElI3j2vuC+ih6nQeDvnQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2knsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfOVJ016649;
	Fri, 21 Aug 2026 19:41:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhpkem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfbsh33620294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DB4B2004E;
	Fri, 21 Aug 2026 19:41:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDE4E20043;
	Fri, 21 Aug 2026 19:41:36 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:36 +0000 (GMT)
Message-ID: <619b30bc-629f-4a69-908f-18e7d6e1b318@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 17/25] unwind_user/eh_frame: Ignore
 DW_CFA_GNU_args_size
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-18-jremus@linux.ibm.com>
 <20260818150448.31B4C1F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818150448.31B4C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88a9f6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=70T5dO4TaAuPqYxvtj4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8lOPie1xGfRvxoDnCUnHAaa03aYEJ6VO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX1k9uw3otbBTW
 0djsIzG694zAEMVMMpdAjNbUqTThuW4J00kdybXu7o96T05vV7qACkN+qjDZUdMSombBz8WeZuR
 9/g02mcHbGA9fyfZmhxehI2xeV6u9C8VJBU56xxfty/nvs3up0I6wxqyExVYXO/cfyQNwNklXqh
 ycoDS/l3CHi5hryFfiRkTpNJs9wGMbIi9WjoTvQC7Z5wc9UI59w1L7OB5VoRm/v27SbZMugPWso
 tqeB9RPtnSHnwmtIiC4cymwuWa5OQ0cmGHLstQoVP5isGh0JLhF4rM9nUxltx0M1d3RB8LQRhEO
 5NzRYQoZRqNoTll03qUfe2VaAEO88kYdPndxwl0wT9LyIQRdOgdBsbPZFoEe+082sZ7L048iIs7
 LQSM1uGSvO7NJTzWDqZwW4ZrjsiWv/8Ggvv2/PxXrEhm27puG6DH/3Hxj54DhuFSIiUNmIcyQ7D
 5Wavo8KwNckfNF6wLJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX0p8XBgRqpAwF
 r8OhDutOnZd5KURbAhRrirW/8GahFF6wbu/QNBJowYjOBz6x9BJ2vfCrtYONKIFLNK8Hz0cfTsb
 tJ86uhcn0FSaO08shvfB38U/5uByRMU=
X-Proofpoint-ORIG-GUID: 8lOPie1xGfRvxoDnCUnHAaa03aYEJ6VO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

On 8/18/2026 5:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] An integer overflow when evaluating `cur + expr_len` bypasses bounds checks, allowing an attacker to move the instruction pointer backward and trap the kernel in an infinite loop.
> - [High] The CFI interpreter loop does not impose a maximum execution limit, allowing an attacker to stall the CPU by providing a maliciously crafted, highly padded sequence of CFI instructions.

Will address in respective patches in next version.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

