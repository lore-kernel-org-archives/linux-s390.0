Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C923B0AD3;
	Wed, 12 Aug 2026 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523965; cv=none; b=Q6PLSQkP+4ygl4b0aWRqZF7gcP6WJeY+dObpWe0/Bjzn/Mz6QmjstDpaJ4FDwyd3J6UInANl1ZtFDLRl7pXoyCBAjh+6JE3DvRwuhs5M200vg4uTi1bTAOj8i036kb5RqrgUOOwVN4B6FZHN4qDBF+vy1uAKMWi+2FMCP5lOB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523965; c=relaxed/simple;
	bh=hdocen/qwj5N8F9Gg2N8mxRz+jb+3u2m2Z0f3iWnUyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udMOT2y1WPT8buFpni9JKBO/kFkmm07iyeP2rFPovI6ZnQAhPYnCqr/ulkkqtbIjNnsdeIfgfv0N6yFQoxTPnu2WOmCe6tKFMgc3iZwxF5HCGQM3v8nrtyxBdKpjmgXvc/tQHtRjI5qkAqo01H/WzQy4pZVI1veTslNnAh5xoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bvR4BBLC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bvR4BBLC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62ean2679008;
	Wed, 12 Aug 2026 08:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d6HEyU
	knJoFu9FXspgQyyNqyDoQTtsZhFHrSZXTyqCY=; b=bvR4BBLCmRQuII30k/AjTr
	QzCb+HTatvlS+HR0bDZoFovyRrqjhlE68WXCYDlqbT9BfNbZECKFZg0UR9VToHN1
	FmirPm9uoIjHVjsHxLLPH3Y4/AgXtcEK9L04c3AlIN7H2MlYeq11CanGkQLwFtns
	IQtbzaNPANRZ/Nvhle4HXehSl13ywE2JIi31xvY2sM2MwpqCbNLbGhpsyhkcclAk
	Emz6+n2KAMvgOWXf5FSk0fjkLmjCasTa8k9tidqI5msl6FM5o2SKZpgbmm0gjNj8
	Y4uPEA41uxsAOZAwbAemP/B3eD9Ww2+ZhJP/hAFG5xLlkZ2mjEtNGXWkD+Z1EvZQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9skx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:39:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C8QRfe023476;
	Wed, 12 Aug 2026 08:39:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq5d35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:39:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C8dI8W38797608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 08:39:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E53F320043;
	Wed, 12 Aug 2026 08:39:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86D9620040;
	Wed, 12 Aug 2026 08:39:17 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 08:39:17 +0000 (GMT)
Message-ID: <4681efd5-2b71-4def-91a7-fe353b18d05f@de.ibm.com>
Date: Wed, 12 Aug 2026 10:39:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] KVM: s390: Move all code into
 kvm_arch_prepare_memory_region()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
 <20260811155641.219777-8-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260811155641.219777-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX+qliYXM1eFRu
 bG2ZiQsAgd6IYsjZkVBoQDmCtv+DEOkCDVooLs1iVixaiHsJDSHxJc8eUV+oDoSHQ993415j4uW
 /TEItTIxWb9e11yB29nNn4hxkNF8x16ErmS9I07URsJvlVsemFMNj9YZss40KEscF/AhCMWrPEm
 h22RqaN1L7j+AOV4Du5flh0fQJ6XlDbECL8XQvM+P3cbzcasxJaH4kcek8yVWSadXTRE0oNN407
 2oFVp4Z0/JinxZymQ2uFr1tlh6v/fbSosnkvyd63nhcCEkmpMbTYdbe+cSHM7CKjFJoQAZvLl0w
 iOMrBjFUTsJQa38TTkgVFt+hH4RRafB4mYNEsCFKOlbDXy6eHnHIvP29cwROqqVdq2PN/jPemeD
 YPq7l3fAoPZax7o6u2431Vm8EnubF2MuwFniBxFmskQPHSpJFntw3DmwkpPGyAezl/NCBY98HfN
 SOntxzXbLreKa1knKmg==
X-Proofpoint-ORIG-GUID: IKOHEhyaqz9_t6rTj2iHyVjAYwWh7cFv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX8dtHQrTCx94v
 jeY0onwC1teQj4AY1oHPWpZe7e9mwVAi3+osMbKR6UfP8Bj4Q9g/iw8/BkMcLY7uz3axQStDMsc
 +09xEaJaWdVpZ98ezlp87ZR/sEKIiX0=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c313a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=-t7BpDlB4R7MeXi6VmAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IKOHEhyaqz9_t6rTj2iHyVjAYwWh7cFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120067

Am 11.08.26 um 17:56 schrieb Claudio Imbrenda:
> Move all code from kvm_arch_commit_memory_region() into
> kvm_arch_prepare_memory_region(). This allows the function to fail
> gracefully if needed. The previous behaviour was to print a warning and
> continue execution with page tables incosistent with the memslots.
> 
> The new kvm_s390_mmu_cache_extended_topup() function is used to
> guarantee that the necessary DAT table updates can be performed
> successfully.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")

Uhh, this feels pretty large for stable. sashiko founnd the  KVM_BUG_ON return code
but this is hard tor review.


Another think.
kvm_s390_mmu_cache_extended_topup() asks for up to 32 order-2 allocations,
roughly 512 KiB. Even for a delete?

