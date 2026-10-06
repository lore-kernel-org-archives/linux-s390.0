Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E333B83E1
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272936; cv=none; b=A9hGhj6c+MFvAwNc1K635wxcz8lj3Cx7qs8KhsNUm9EMGH+0sZo6/Ap93KGh81TPxJvkQra4vZ6PC4x5M97h8s+tIgO8lnjN9kbzWejoFQete15Jy5pr+cGADC+yy6s14kAvPN0TgGsy0vzIK8Cguuv1v5CCN84sKI74dYqm18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272936; c=relaxed/simple;
	bh=Wb9Q54U6oLT58W6xJ89KLxa2t6eAakVCmboE5kzC1DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+JDByC5A1ubCXp5N/s4sLi2xKv2cflLd5iP1GUTb5lqQlDvvq6ppvxvMtFkXZeSJzZktpgH4LrZ85pN7fQ0RMuMTQ/6KMvXITKGaxaG9nGYrvL8XatvsvuTNqTxsHfBctv4mgD7uxPny8l6ThVE+8cfkAFnCkdFy9g3Cty8/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ma7CZKS+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ma7CZKS+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966bNTr2992184
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 07:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aLwo89
	fTQDMy6ODaHKb9hbmjMFJIP1wxhPHn/nd1pwo=; b=ma7CZKS+aMhSKtqaSLdCCA
	uoOPLWh/eyt5e+3bnbsiM5Xfyhgiflgmg2XnfrhaDt6LSSPTYTetGXzAMebUBlPg
	f4ZAuJTUe1tBQk0BnE0Bqcn9VDd59qfeOLDTQ1h+JPFTeRLFciFu93gaKubxqaC2
	VSk1f8Y/WvTso608YmapBewZmIgGqkt+zO9ZpPl6PjAnixCWdeo0JYlN3Xiggx1/
	2u3w4P5D6D722aWqoEq6JjactEp7S1wdUJ011ueNCZ+WDfkR7cfUC3jCR/9hQbMH
	ZA3F7a4hMl9YZZX7Sx4EMMctHCneG11fqppnPbSKUYcxINUTh2WhcsMQH9+QRJ2A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74psey-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 07:48:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69672Rws4103011
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 07:48:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvs2q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 07:48:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6967mntx40829394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 07:48:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EF862004D;
	Tue,  6 Oct 2026 07:48:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DB9520040;
	Tue,  6 Oct 2026 07:48:49 +0000 (GMT)
Received: from [9.111.8.112] (unknown [9.111.8.112])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 07:48:49 +0000 (GMT)
Message-ID: <51762259-154f-49a1-8a6f-aff175ee5696@linux.ibm.com>
Date: Tue, 6 Oct 2026 09:48:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] s390/cpacf: Rework cpacf_kma() to return condition
 code
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
 <20261005141417.65822-2-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20261005141417.65822-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 92-1Zm-L923mWy6bthNs98Pzc2qUy-iW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMCBTYWx0ZWRfX9UuHbC/MQqWf
 YK+Np8Dqs5PoaHPk12oawgLXAV6pHijeQsMZ2vKrrDRYgDAIEBWBEA7DMNsWBYvgvpaRYBEoLJL
 /fMnpxDQID7Z4zShJqwpGY9E0ohSBi0=
X-Proofpoint-GUID: 92-1Zm-L923mWy6bthNs98Pzc2qUy-iW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMCBTYWx0ZWRfX6w2ZB7ZGqNTD
 7/3OGp9nACVzGYZikRD2aPifjbamRAYGRt8vuHWVfllk7e/CkKPOJ1hPNO7EowoijjFhvnniOJG
 wBaOJBc5aTOkfkGm2q4PS/ogXP7YWQS0ssjCpo4E2yytEz/YqdYgl2XS4rXOLYQaOOHq80BW9zf
 bzaJxvRmc0XbVVTTvg+nAcEgkLQleKqyvhKPYFNMrbaALSTQRY5QvKVzqXkPoBf3hPY5JLOeBDG
 9FGmk2WIfRiitT+5Dh7y+KvliVmCCyD6pwEKjjgWjyZCjCMW9WvElwvbgzpvOt8vvTnT1zw7mZI
 iRn4L9sWNA1a92CE8vs4jCpAUQptGwxmu2iCWhqd3HMuQwJrnn/Bxrq+H3j8U5YEhVytYDKpVXh
 zShLj0Lz2/L0+x088hdgqc8rkyZjoz8Hj/g25nc0k4gD02rgzrzYouWhEKSxUGhLtv9IhczbOw7
 8FluySyWOwIl4huLBKA==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac4a7e6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=u7jxrZStoYL8Atr7YQQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060030

On 10/5/26 16:14, Harald Freudenberger wrote:
> The KMA instruction can signal a verification-pattern mismatch (CC 1)
> when a protected key is used, or incomplete processing (CC 2) when a
> sub-block-size chunk is submitted without the appropriate LAAD/LPC
> flag. Both conditions shall be visible to the caller similar like the
> other CPACF instructions.
> 
> So rework the cpacf_kma() inline function to return the condition code
> instead of void. However, CC 3 (partial completion) continues to be
> handled internally. Also improve the function to use the CC macros for
> better readability. Additionally add an kmsan_unpoison_memory()
> statement to reflect the updated memory by hardware.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

