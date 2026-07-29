Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7233EC818
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342257; cv=none; b=RfA0UWLG88RaqM/utU5HcOlQ+INRLB7+SLFLDY+pD17YoNZ9O038M/QyFLeIV/Ke3WRlHCvzRBt/1wExWBCg1Dt3cHDB9MukLTPzR4oq5SdxnkSX6TUemi3Uek6yfHE/TANdxEiHgUsDCtkkUz/x3Jt/+YgzCyq86xKvCqNSbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342257; c=relaxed/simple;
	bh=5U29WrmeGiikWZD24mQNXuSA/H3NIhUMCDS8qMTL6+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyzK35dq88bm5KHGMw0ZDQIu0UvgdIrWIVQI3w+m6Sh+ot1naKDkfKOfq99O8a6pg2ClCnMc/4GUDQkXbPUYmsg1CPFBDfMLjfaYlGDdOlADy/wOPiCcVMEEljIFW5WRKC9c34hn4OSN0yKvfdyjgmQwIQPIbQOsSMREau7TvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VPvpeZl6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VPvpeZl6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFI3fT279383
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 16:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cWOfxL
	bhZoAn5kC5iJXtICPhXtDe1x22vb5xR251yHo=; b=VPvpeZl6R+413Wmb4QlQwT
	FLlQnQcnUlkYrc0L0YJUTj8/aTwfR+fxbyIO+oN5j7BNV7LPsgRm+qv/zJ/W4G2B
	UFDdoW/CgskoyAegA1FzR3sWY6V2cnCW6MpNZcxAuOk0tsIQTDTjrz227Vr44PoD
	4TKIyzJlSJknCjvSM4EY+6W8ciDwzj6itRFjNkzSSH+1NxNvMF1ANVro8DIPdgD2
	4l3PDrYsyWWR6NcHDbXoKbB1uJ6xc+W7oaFx2wVdkV4wmGnsD/pOOs5xrzRh9xXR
	hJqAP4JLZrd7FyhnOeeTdd4q8veMVKVIMwn6CuvAou2dGy67z4tYdpdeQJoeu0yw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjau0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 16:24:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TGBLAH006039
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 16:24:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk7fs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 16:24:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TGO7Ni30081466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 16:24:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7F032004B;
	Wed, 29 Jul 2026 16:24:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EBF620043;
	Wed, 29 Jul 2026 16:24:07 +0000 (GMT)
Received: from [9.111.91.28] (unknown [9.111.91.28])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 16:24:07 +0000 (GMT)
Message-ID: <4cacb77b-8478-40f1-83c9-8a3e6ca2eb5e@linux.ibm.com>
Date: Wed, 29 Jul 2026 18:24:06 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] s390/zcrypt: Fix missing mem scrub at clear key
 import in cca_clr2cipherkey()
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260729140134.191448-1-freude@linux.ibm.com>
 <20260729140134.191448-2-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260729140134.191448-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyOSBTYWx0ZWRfX4P0hVU+zNXNV
 +vZQem/d+8U2cRsubpBZm4zvUpk9AM35ZU08PcxbxAUhXowj1UoqA+6lkJbW+YLlbX+9aqBSmT1
 wBTDzHED8FLRmItbRWxxsXob4+uLOp4=
X-Proofpoint-GUID: 6ssyuuI5k0CKEZYYy52hpXYzMtuYZUiM
X-Proofpoint-ORIG-GUID: 6ssyuuI5k0CKEZYYy52hpXYzMtuYZUiM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyOSBTYWx0ZWRfX0D+tGUtJWAjt
 70uBK/gn+mnp6GxFIM12Gfw34rO5K1HpgebGmTZ+DgZvaBoZPhKAHx2zY7xDJjpzWCQzICJKN7m
 Btey19LuTGfkXBS9TgS1RMkt+PLj3XA+aP46RFEj0GCgiGv1zwPg1jESH5GI4MME9gugqxOY4cE
 aH+jpVqdNNyucg5l02hBrdT+5kgPGyMwWuk5EtNAEfKLu6OYjW/dZAkyU7Pu91KqHmDogTaFCiJ
 4mYrHyN9tFAFJLYDtah9DmKGGGZ/BKOuX+ivgBOEoVR5lB+6KcX/7SDj2tdzcKTUElswXc5yoNX
 4IjwZ8XJ9+gZVQEwMcNxbf2WXD4n3U/3MWLsRZDMHUCvZKZXKzDiCSbUcaYwpyEtOmLb8jXKPhL
 TrTIoVAOo0gWqip2XI7XQn2pkQATnOsr15+7Q36d+r/5kEZK3l11arJBmUXh3RwUfgnt+wtX1B4
 h6WDSEUHEBZy1ShGd4Q==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a292c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=e2as-ruOGLGTfvegKZoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290129

On 7/29/26 16:01, Harald Freudenberger wrote:
> The helper function _ip_cprb_helper() uses internal buffer memory for
> building and processing CPRBs. After use this buffer was never
> scrubbed which could lead to leaving for example clear key material in
> memory which could be exposed via tricky reuse of this same memory.
> 
> Extent the _ip_cprb_helper() function with another parameter 'scrub'

typo: Extend

> used to steer scrubbing of this buffer. So now the caller has the
> opportunity to decide if scrubbing is needed or not.
> 
> Extent the clear key to secure key token import process in function

typo: Extend

> cca_clr2cipherkey() to tell the helper function from above to scrub
> the cprb buffer when the clear key value is part of the request data.
> 
> Add explicit scrubbing on return from function cca_clr2cipherkey() for
> the random EXOR buffer and the cprb buffer.
> 
> Overall this cleans the internal used buffer in case of clear key
> import to prevent sensitive data to get exposed.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

