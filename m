Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B538F92A;
	Wed, 25 Mar 2026 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425089; cv=none; b=DAf534Sj9SIrTEikfh8nN65gDnJT6IOrYRPUxgym0idH8gb/mh6Jcy1Hu2bef9/F/f10KDYLSq4c1f7UuO7RvfozLbPlQZUd42rpWuKonIt5p0To9tEbwjMUcgwTWzFV81dqIMeuuYTcxU8bh9ClapDXmc0aC6btSCmORtT6Z3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425089; c=relaxed/simple;
	bh=ZBVOQ5yiGoQZBL1laVgj9Y13kOi/PlpIrWUFxMSiDko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQVDQzP8/2LtBSkj+g41bjjHhmV2q6Usl0hR6Wpqs15BHy2pZCCYalL14E5UowVOnAnVL3BUO/A+MTIt1gxuVcXOj9PyczcMLHvHwPpTtP2auwlvx4pM+T8lvXwA6BJtxX8K0GaUuIg0Bt/SxrWYtxrT1b/AZRcg7KLj1PHrFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q8/BRb2g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q8/BRb2g"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OGtahQ107409;
	Wed, 25 Mar 2026 07:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EhZEOY
	MDq2HCDJhDzVEC0WWeBwK9qjkngwdA168/FFw=; b=q8/BRb2g0qgvanUnqQLzIM
	jlceqnBFVmGP5/8NwGXSZD1+0SL8AOAlSH2n8MS6/7lm/aPXyPMUvTOArMGmaXEG
	oyjZyaCn0XNDvKnQEgtDWP9OlrHcmqxCsxFOgRJCE2yQkbeB0ONvhruDH8cHSUDa
	MYBlP0fewSdMSZl77DlWG0zgsfrgG1JpG7YvzNDsBO+aiTvE+paBA7n4MEzWWjaV
	mhlpAghE91w3Eg932ROYoBztJzCwwULh5VWG+bcS4Rl+el8h7gFrcwQx/5e8E5Hw
	taDOAof0c7aNdjdfhVd9T3eYPDQFEYWGVbHkS4p7feW8Lj/YLRaubrH4GzuC0LnQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxybs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 07:51:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P5JNXv031592;
	Wed, 25 Mar 2026 07:51:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nswq5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 07:51:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62P7pIWB53018910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 07:51:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B7FB2004B;
	Wed, 25 Mar 2026 07:51:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4E9920040;
	Wed, 25 Mar 2026 07:51:17 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 07:51:17 +0000 (GMT)
Message-ID: <1c15f3ce-3673-424e-9eca-4866a733a581@linux.ibm.com>
Date: Wed, 25 Mar 2026 08:51:17 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: s390: Fix lpsw/e breaking event handling
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
References: <20260323153637.3683-1-frankja@linux.ibm.com>
 <20260323153637.3683-2-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260323153637.3683-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c393fb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=4RSiKU3I6NhEqefK0yoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA1NCBTYWx0ZWRfX3V/JGYBBPWWY
 pJ4BzobIcm2Zy45VGGbbYuLrEMBurDGvafxiKHlgMbACWp+NJAAJDynWpNzkpWpwO+kk8zvkbUs
 xsG4csfoLIaCjItc6Q2f6qT+Qv0FHbVE7kxTakOPK0r3PJf7vT/D6awpFlXG840arQGjCpS0t3w
 xaU7/qvA9nbKbtWQ1AKkrpHLI+An8Cq58EI6dAaa927IKC/OZ3IEEq9pX0BMTcJq0L/54faWdH8
 SDhlx1RWep/ofdqcxXJXpYUjzb1UAdDKWl2KLTR5bi47a/WeqWa4VII52+4O6OKFXbnGrAHYb1H
 CZsV8SEq1R9fAV6py2NGr1rHl4A61apR/XwyWDzGJrk4EMZT/mL7oqM3TJiV4RKAUiPb+HknoLW
 z1/it9ZC0cYLkmj5BxhSflky6THK5mbetsJVklmymVZ7OKqZd8ci+bc8Rf7K0Qjw1jtm6QTpJsR
 oz7qkvc6YTkJqIgKGhQ==
X-Proofpoint-GUID: jNO7a4zUW-1ir9cBnE055kQwrd7N63An
X-Proofpoint-ORIG-GUID: jNO7a4zUW-1ir9cBnE055kQwrd7N63An
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250054

Am 23.03.26 um 16:35 schrieb Janosch Frank:
> LPSW and LPSWE need to set the gbea on completion but currently don't.
> Time to fix this up.
> 
> LPSWEY was designed to not set the bear.
> 
> Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

