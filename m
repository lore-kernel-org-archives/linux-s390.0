Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69219444701;
	Wed,  5 Aug 2026 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930913; cv=none; b=bjm2uduRhyJOfTT9hazqOyP5HEt6ZWEbR0nOrdH3fATTMKegfxq5gXxCk/50Qb5l60rUH00AWsUgKgKrjeRi1J0UBANR339NEOuVZrb8xRqhCpX75EToUS+4nm3iBeUogBFB23gIB6iDto7Gj3A1hTRqyC8KUMEc7VBikbwabjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930913; c=relaxed/simple;
	bh=cx1OoxWe/TQtTsDRzEzsjNZ9ci6+HcE0OO9pdmkjA6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsWiGkD0iOdXG9q/KjKvsO2B34AGaxq4ieV2AEB+Sz7gTSRK/wYWRSWJn5aKJDlmOa5ju8Z0fgZ8H07DvV3+RMfB/ZGZwvjSoaoQtrc1CGhqdTdGxTZS0i10JEBhFqjOjnLY2VVHg/cii48yVheHv3su7uig+GZ9Sadv9e3RglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g5jj+VBp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g5jj+VBp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758nLfn3440529;
	Wed, 5 Aug 2026 11:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x7X5U4
	8+aLx4jj6UuIGB2BX4ekVFgM9FIxa6OSBWoF4=; b=g5jj+VBpxvw+D7EKlBOJal
	/QDM5OZOpP6QVcsrSAZSoY+XWAmu6hCyRJKv3+qOfFqP5lC7z95/zVWlgsDchrj0
	NXp3232Shh4/NunGgeAy82SzRROFvTIart0aFuCLcJJYDX7b++dPh4l5z9vjj6f3
	LRfJnb2K3/lfGyPyTJGGPiLQ9I6f1sMJ76qCc27+DBrcNhrq81Qxjw5hhTQiZLxv
	E5wnZypcKrLVy7Muaa61Q0WzH8a/Mtg5vMwQGK1JftWFdQWmKyxVD6FnSic0a8mK
	8r12Oc7bwAb9GA6zRwUUvM/hvqh434954fOwQQzzS582akrMqsL3LBpfMf+s5ogw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euta3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:55:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BfFLX015387;
	Wed, 5 Aug 2026 11:55:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyp51r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:55:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675Bt5PK22151932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:55:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC5D22004D;
	Wed,  5 Aug 2026 11:55:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0D1E20040;
	Wed,  5 Aug 2026 11:55:04 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  5 Aug 2026 11:55:04 +0000 (GMT)
Date: Wed, 5 Aug 2026 13:55:03 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas
 Freimuth <freimuth@linux.ibm.com>
Subject: Re: [PATCH v3 0/8] KVM: s390: More fixes
Message-ID: <20260805135503.450af833@p-imbrenda>
In-Reply-To: <20260805110455.7200-1-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zlSJ-gJJ4Mk9Ko4uSpTq0QXYVQ9sXhng
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX7XlEHzieMBnr
 VL6ojg2dAiOw2fPTF6UUrnjk0NAzVxDaR2xjRzmqDWTbcut2ZPcLS0PCkShbGizKgUnqFPSAJe+
 DYbqI5QuzEclumgIXA7j5r8F32lS5Yg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX/ioZ2oHhaftg
 Vwwko3aP7l/u7h2jdXRN+J3mJCM/b+Kgyr4L7lmTtvolUHDDnNSd1T4fVVvVSAicxzUQr4McEnj
 o8F6Ob0zX4oQuEw7NGUBucf+B6MqTIVyXlCDjO9yNSHVeTdZp0/guRDzN7VTjf0Nhb/R1D5QQgf
 wMIcsMM/p1kjOSo0gTE/Fj4osaGxV/9oDAuabbhuFZIgMyaIO+9Wntiypg5CLEHxv1toE1SQaHS
 XuUx0A36fBgh6QzX4kv9CtUZoKHYIA/FYb0kgY5t3e6C5R4oV/29so8rHmvRg4UjKjzbyMQpBPi
 xvp9lAtSUljaZeG+D10t/5ePfRPhLleTpHmYPNhEJ32xSajSjiK9BS4CLpEAZ/lVdQ2Xpzk/y9f
 T5r4eo8hEz7wjlZa2W36pGfuYFPND4fKQuFKeJfKw0CEWuMMjk+mQgSn1MCN9x9ZiVUrS3R9MOa
 RPdif/qP0xKmIo3t/2w==
X-Proofpoint-GUID: zlSJ-gJJ4Mk9Ko4uSpTq0QXYVQ9sXhng
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a73249d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=3ZA6qf5-gVS7gfmb9nQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050094

On Wed,  5 Aug 2026 13:04:47 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> v2->v3:
> - add length check fix for guest debug
> - add RB
> 
> v1->v2: several sashiko reports added
> - machine check stack exposure
> - extend zeroing to pfault done interrupts
> - old_data leak
> - srcu protection missing
> - guest debug allocations not freed on destroy
> - uppercase patch title

Whole series:
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> 
> 
> Christian Borntraeger (8):
>   KVM: s390: Remove user triggerable WARN_ON
>   KVM: s390: Zero initialize data structures for inject_pfault_token
>   KVM: s390: Zero initialize irq in reinject_machine_check
>   KVM: s390: Fix memory leak in guest debug handling
>   KVM: s390: Fix old_data leak in guest debug error path
>   KVM: s390: Take srcu when importing watchpoint data
>   KVM: s390: Free guest debug data on vcpu destroy
>   KVM: s390: Fix length check __import_wp_info()
> 
>  arch/s390/kvm/guestdbg.c  |  9 +++++++--
>  arch/s390/kvm/interrupt.c |  4 ++--
>  arch/s390/kvm/kvm-s390.c  | 11 +++++++----
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 

