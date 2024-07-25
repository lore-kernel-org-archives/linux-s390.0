Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BB1741EF
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898629; cv=none; b=YNUpGYIX4w5xTNBzBmalfD4EdVQb1qxDr4T2FTQ2f7S8Opi8gE5F28KdJUyPS+eOF+c6Njd4kwCkWo6TF3XdvwQf7TdswcFPKI8eDky5bwKlsDR1Pt+X869Cen3ELHsOowbvUhn3QEAIIezLeTZ8x/whGIP573rPWo0Op74q0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898629; c=relaxed/simple;
	bh=vrxalikU9lqXaLRxVHhSmYmU2+COO1EZdWCDOLQKdME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAb87p9Bs5Jpaf+DJKPHyWSYKh16hGoa8UhQquVW9iWcYLs6snIunD/p6D5fi0QWsVsKAO6zrq4NKqme+72xgtnChKD/+X2iAgqySnRJJQPAaNsTEBO6lcaAbRdPg9iquc+eYis3so8lcLIEP0WTfCHsKI4oEBTl65sEAuHBflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qAGahr4W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qAGahr4W"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P978wV005653
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 09:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=RcLf1/bqcBMnZqbPsazWATGg4QS
	tfTYPn5l3MeKsXmU=; b=qAGahr4WVK8IB/PAzfwmJI6SCJa0c2iKgQJt9MmkKYE
	9MkMvQ5T7ptZ0tNU/BSYYUd0C8t0IQlPudJQG360Zoq01L9fcHMmmdHoANEWQ/AJ
	0x/ubL94tRU2FvsmYA2cVtI2yeUmuGgrvFLm/gJAOBWoaTCOEQ9CG68qpfusygNR
	Ot4Y9plpAPOGpVzamEZPqhXDDDTgb8WT22q4DxiKkqEpdKkprzRperABTk2TuFkr
	0Y7vdxW1GzlxHeBEk16VOAWsa+jhu1+BfSBMswmvzN0mKW0YCkNnDsCk+aMf4Ai9
	nBrm/Rge5RXkroUDXaBm9ChtUPbnqlPdoq6yUaFvT0g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kfq58m9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 09:10:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46P8JPB6018513
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 09:10:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40kk3hg6gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 09:10:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46P9AHmd53019006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 09:10:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73F9D20063;
	Thu, 25 Jul 2024 09:10:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B85720043;
	Thu, 25 Jul 2024 09:10:17 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.38.250])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 25 Jul 2024 09:10:16 +0000 (GMT)
Date: Thu, 25 Jul 2024 11:10:15 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/kmsan: Fix merge conflict with get_lowcore()
 introduction
Message-ID: <ZqIWdzxicB7bCnZb@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240723124441.120044-1-iii@linux.ibm.com>
 <20240723124441.120044-2-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723124441.120044-2-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h9hhOp0_C6RCfKRi0a46gVl3jjzbh3lB
X-Proofpoint-GUID: h9hhOp0_C6RCfKRi0a46gVl3jjzbh3lB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_09,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=575 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250058

On Tue, Jul 23, 2024 at 02:44:11PM +0200, Ilya Leoshkevich wrote:
> Resolve the conflict between commit 2a48c8c9cf87 ("s390/kmsan:
> implement the architecture-specific functions") and commit 39976f1278a9
> ("s390: Remove S390_lowcore").
> 
> Fixes: 2a48c8c9cf87 ("s390/kmsan: implement the architecture-specific functions")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/include/asm/kmsan.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
