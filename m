Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67041387351;
	Fri,  6 Mar 2026 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772796542; cv=none; b=HyRHGrZTpykW8iZ3yW6AaDTnt0ieCQ29X1WMhgtRdKE7EW4/BQnd/Xfogvgh8bRzbWmFVEavoaSANEhOxqWFSGwiS4kLEhC/wJlD0DTYngt9NvjI5eRSrVEhq1FE9TLqUjqc1w+oN3OJ7w0jaOaQsw6xqcTJtFksWlsG7h6T6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772796542; c=relaxed/simple;
	bh=m1CveIwiQIYcMrz1GzItDSU95IKrvMa/RrY4/CaVyoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iShDjEXGeUdyKBK9Gg2Xt0sLC6gr5HYzqJrWY2e7lQrY5Zy8HrG03T6GbbVn5LoQzG/qPsDzbfQHy56gmW9JHYL1p/vwhVujGXpgzq11ibNY7Hxcaj4wvolPgFOYv4oMfIakQUFAVHGbZVBAgM+iQSu34UCJg6ldm9pGROWSn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iqmyO630; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iqmyO630"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626BOvEt2104794;
	Fri, 6 Mar 2026 11:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ENUACZux0SfkPI3P2x6y0bUPQnrDRR
	cvaMVhio4YhX8=; b=iqmyO630c/axwBsxkl+QLb/NCxLNEPc0VOS0FvyogPLnS3
	DCR1yZ6x884btDyZV1+nFOll8seCj7oUNzUdKcqeSmYDVuDc7nqfsMZphKAuY//E
	2rBwMT8xkWhJ6c3M3ENWdjCMBqInQSEmhQ7KTeOnjefjTjGOaEFJmNdodm54RLxM
	RLBfDcTEbSr88nEpTNO6kOSjrm6J/azAY47aPC7G37gdBksnJAwn4hTlrA1ln+wa
	Fbks6vTwswhPyIqLJX1yAnJOIjq+pgYOTLrjDIkjgfEqsRwk1WoB+219ky54neOG
	3aPXLMVRXuini+0lKk0Yf+kL90AvzvtMWiQCnnfA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdr77c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 11:28:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626AEpt5008782;
	Fri, 6 Mar 2026 11:28:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1qayq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 11:28:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626BSjKt40436032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 11:28:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A05AE2004D;
	Fri,  6 Mar 2026 11:28:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ACEA2004B;
	Fri,  6 Mar 2026 11:28:45 +0000 (GMT)
Received: from localhost (unknown [9.111.48.204])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 11:28:45 +0000 (GMT)
Date: Fri, 6 Mar 2026 12:28:43 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: Revert "s390/irq/idle: Remove psw bits early"
Message-ID: <ttbh6jv@ub.hpns>
References: <20260306111919.362559-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306111919.362559-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69aaba72 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=ppuWM-M1jrCgF4sErI0A:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: hXmkvoLWoOeUNbQDGEWJTZnKEzDORs-2
X-Proofpoint-GUID: hXmkvoLWoOeUNbQDGEWJTZnKEzDORs-2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEwNiBTYWx0ZWRfX7MNMLWEr3gF6
 2qyWsrXlnvVI6jbetZUWGzXDbwbscGkduJS4CZ1e3BZAazMZKUfazdRsKXrrcsaktDkSde7CXVi
 Ic9ugd7+GTU16yX7jiXUTAlA/WHY4Bih7Pp3z8e1PbuVOcI9kPpufnNdATAXuppdyF+pvXOTPvd
 rFvf65PXujx+gBufzAvmqcw7ZEeQVwCX7FJYWqRyha02FT/RUgD7gRdHcPBfyty33Ce/URI809Y
 ZwcDG3D+ni9KncyxKjSWbIAIHCf8mjonCHOBydNfA6pMUGe5azIOZpQ2cACwgg40NdoXYFkupdT
 8URNju8pSxnyLA+SE5XYuhMYaDv3pqcfvEpDezrXuOOMV6acV4/XxVfHNnF+WNjZhhKOvnup7rT
 gySoztqpp/VDbjc9N1hrK02iHksnZ1OiewzqXyluXLPuCEjPyMjlVAxYz/Dppf+H26Q7m0MdNTd
 cyxjNVuhT9gapsBa30w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060106

On Fri, Mar 06, 2026 at 12:19:19PM +0100, Heiko Carstens wrote:
> This reverts commit d8b5cf9c63143fae54a734c41e3bb55cf3f365c7.
> 
> Mikhail Zaslonko reported that linux-next doesn't boot anymore [2]. Reason
> for this is recent change [2] was supposed to slightly optimize the irq
> entry/exit path by removing some psw bits early in case of an idle exit.
> 
> This however is incorrect since irqentry_exit() requires the correct old
> psw state at irq entry. Otherwise the embedded regs_irqs_disabled() will
> not provide the correct result.
> 
> With linux-next and HRTIMER_REARM_DEFERRED this leads to the observed boot
> problems, however the commit is broken in any case.
> 
> Revert the commit which introduced this.
> 
> Thanks to Peter Zijlstra for pointing out that this is a bug in the s390
> entry code.
> 
> Fixes: d8b5cf9c6314 ("s390/irq/idle: Remove psw bits early") [1]
> Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Closes: https://lore.kernel.org/r/af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com/ [2]
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/irq.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Applied, thank you!
