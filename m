Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3A839B94A;
	Mon, 12 Oct 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814861; cv=none; b=B80cORj3HlvWj2MmAI/GuaprT8NwjSW9+YPTuWrrNuuliT3DLiP2jk7EvInlNI51dt2yH9q3XfTJSsVE3Uv7IrhwrmmsB+ch1+G5c119kVIzY8RcVFfyEOSV0v2dcQ688g5MTr+jsh1FPJcpkBWEyXkGE2E9/XQ7fQY+XZbalbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814861; c=relaxed/simple;
	bh=KKZd5Eozk0Pg1osACbDxktLAJlM+tgNySddW98aviqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4lhuDGe8p+iA+gwFgCAEmthL2P0SjklEwQxsIWrENGsFQA+YS6c23DJYRw8F35kID8lUhUrNJu+iTLbVxmi6FiuIpy9xGVJ8NsC/WJQR3Vf5dRCzX1WZNZmmC2dAdlLxH5mMeZRVlwAeCU7b+F7clHHML4YeujNbWSjrPvWG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dmfggqAc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dmfggqAc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEaBh2641239;
	Mon, 12 Oct 2026 14:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vLrPbi
	M+rYLTsWCNmAl3QviMKLQkJAWJ5WmhTWJGDko=; b=dmfggqAcWXAMSIUDvYoiO4
	a131Q50huzHM28OOb4zuNImEpID2jPl7WmwWa20leapqwzhxq3vQhW8vOhzrtu6m
	HuvzsNzin34ZqrIrNLik0rx2QHhwlOuYXh1+Byprb860mdf4gg2jwXA5fxLQNQ4x
	72qgdj0hHufF0ef8ruimFJ1lcAoG4R7biMLOTpWj7y7eUxLfnPb3YNya3SfHCKWv
	ae8AVHTwtvEH+h3cYHBaqVlQnbW5qIJFtZg8TLBurXK217QUj1Cl3PHHua4uoANi
	TqJn+EwR0X7WFbI6E6ervbr2ZuJd85mc/SWlBLAZ8d/jAdfa8DuQ3g7h3H5+XmJQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh9atg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:20:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4uIA1286251;
	Mon, 12 Oct 2026 14:20:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyd8sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:20:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEKsKp49742120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:20:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84B192004B;
	Mon, 12 Oct 2026 14:20:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03C1020040;
	Mon, 12 Oct 2026 14:20:54 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:20:53 +0000 (GMT)
Message-ID: <e816cec7-c1af-4f22-876f-421ad4a5f383@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:20:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/32] s390/diag: Convert inline assembly to EX_TABLE_INSN
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-15-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-15-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXzJ45dgMPo+Qb
 3O5LtBweyOBLDzKsK3/1UV/fV5elFEqqdhCqC12Fq2ngXrjGzbzO8ekL2oiiTUiI5/zmmdVJYZB
 nvaA4hYn9ITjR0HpddtFgqhxE4U3I0w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX3mcvlmMF0sq1
 mzeoJSe4W0ckkLjk9wLgz+vUpbHq8watw1O/Li1k8AB3ALBSy4ItGy254BTSBOxlX/7xSxWAVZj
 8inKO+CD0g5opCOrng7pUlNYU978ZldRXORgCDN3zMPSGMoBvd5HNq9uWK0mQc34VtW/6Ym/ZBE
 AuBMwpdwycC4kUFLwyrAtV3Q+2hH5BJrucPXbe8HqlU63upuQuZzf1FFDNGWhuidlBMFP+yRzJ/
 1ArDT228hfxBcHIvQYl1r39m8bA6+dJ+DMWmHPDpV3D7noQB7db7ShHuMjpBfhOJEA1DQNPn9BO
 dUHhhLtvYGjzRQuYMcNYTE4GV/GO2Jg7xhkNLMfw22GXOXbAnztXfiOXpADi6vd/m5abWEQrquJ
 wxdJT/08tcb2m8sdmcCipHteOXNYGvlAflMLFv9yFR2Dsmu5H++5tLcjrptNj7qF3g9S9/r2Ybp
 eR5k+DcM/mr5iOLK+ow==
X-Proofpoint-GUID: GwqgHc0IKXgXvrWETQw11pgoRGfy8uaf
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acceccb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ctijNTvuJCJVYrYTotAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GwqgHc0IKXgXvrWETQw11pgoRGfy8uaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert all diag exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries and nopr padding are no longer needed and removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/diag.h    |  5 ++---
>   arch/s390/include/asm/diag288.h |  6 +++---
>   arch/s390/kernel/diag/diag.c    | 12 ++++++------
>   3 files changed, 11 insertions(+), 12 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


