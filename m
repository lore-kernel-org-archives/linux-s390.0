Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FDE3612E7;
	Fri,  2 Oct 2026 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929500; cv=none; b=giSL1PhquU5vCLHGifppjWAfJHnBYTyLgoTKHZK8sWZowzonxIaRgOQz8NTYNgZtSrlr+Cf9341gtnOoRwgHDTPL4lXKqveRGnZDPspV0V81Wax5gezuYkG+BUB3hB+W9E/lbJZhT+yCRDl+ilYecUcSZQI2q/+iVuhBRZuwzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929500; c=relaxed/simple;
	bh=cSlJKgcVaYkUD/98/epE3mTHPAuTim6rqpsE+ti61p4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQIjpqmTKrfBNWJ7+O43R2h87nYz0EEOYMq4WMFZZ5jZ1KVY+K/X5mSJG1Dnvga+L//loqoY3cXMWF99t+R39tt+9ALT4eyN1ot2pPqcx9zuR7vEDAhCZnRN5n6Xk343vtTh9Xjlku/KIgs8tViBMJH/iVLdBlRBP/Ge5Y1KA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kHysi55D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kHysi55D"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69265bSQ2089098;
	Fri, 2 Oct 2026 08:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hOkCoT
	SkqWke1EdZ7ohZzgALhoa8gYK8zrdaGahCFB8=; b=kHysi55D4YaeHGblwE9LQA
	fWgS+IwYWg7WSUOsKWOWY5BPKLOuPxfHcTrBjX2lwRE0FeiWhh4vkopMzVkDLeg7
	WMWCHaQWMiG+ZGsHmPDgIPreH/U882ExjgCl/URXfZ72lm3UeLF8+0pWDG7Ej/eV
	w8mFY38UScL8mCp813Yoi/BuV28Q2ggJUTeMH6NzHD8Kd2048qHVMXp1R0UecENC
	37bPbbF68YNra8vgxVd+ikaPx8doARe3Lhh4QSxVCTseD6UGLL+vjxACrDURhHzz
	ZPqbkWFsFtiB0KrdG0Y4yUXf4oXJeMCUV0TzJ+sT5WUfr0MaWMdJIUuY1xjG0F4A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrr74y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 08:24:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6925lpIT2090660;
	Fri, 2 Oct 2026 08:24:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h1xk123g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 08:24:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6928OrkG41222584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 08:24:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C86F42004B;
	Fri,  2 Oct 2026 08:24:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0A6720040;
	Fri,  2 Oct 2026 08:24:52 +0000 (GMT)
Received: from p-imbrenda (unknown [9.87.132.161])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  2 Oct 2026 08:24:52 +0000 (GMT)
Date: Fri, 2 Oct 2026 10:24:51 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan
 <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler
 <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner
 <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch
 Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 24/32] s390/kvm: Convert inline assembly to
 EX_TABLE_INSN
Message-ID: <20261002102451.7e21e99a@p-imbrenda>
In-Reply-To: <20261001103247.1989111-25-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
	<20261001103247.1989111-25-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzMiBTYWx0ZWRfX5fDOR2mVYqld
 KS4CSrVJH7FgR2rYqRWW5hW3cUkXlq+uB/N1XFIGNmc3eKtRxapvEyYmxb+Dxiov55Bqr70iXZa
 akUwcEJYJwyJeqpbDPoWsdPbK2ugqQfkaJFhvp3AOrgs2NzfLbAi2plholCVezwuUoWQrsJVtyO
 MRzNKtUyvVTR9yTKu8X7OS2R5LRUeQpvOXdc8bDJBcii34KfOVfr23xxyN8bm+A9LiKMPCwxHN6
 chuVS8SIznQENzvlE2og8kUYlUY5ql6neg876GLQ24jMrd1R7V+0C8CyZZlUZXMHohwz34PZe0w
 aiE1/1Nmv7bG9xazUK/vS7TSbLIjxTjLM3xdj4RTfp8+RSDSe0xC89MwdPSSOkIHGyBItFvwu6U
 ei4ftPitHa/ZyWYBnYlVwzXd/uZd1aH4OHToCEKDmkw0xwbBeBkR7cI2qWhPA3Rw2F77WL6tqDF
 //pt6UOHde8OF8ukdkg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abf6a5a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=J19Xoqk6y7OjH45k9WEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1lj7fbOvbEvDEJbQziOD3c63kY59twUk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzMiBTYWx0ZWRfX3OX4aLH6SxQE
 iOvmM4giOPqC10PmhRmZiNqj+pqC/XAdGwbFGaD3UHUtNe3UNC1d7TUIzcnFYhZGn9PElT4L71y
 bxRVXm40b+QmNCo6OFz/P3DBOOBlH+I=
X-Proofpoint-GUID: 1lj7fbOvbEvDEJbQziOD3c63kY59twUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020032

On Thu,  1 Oct 2026 12:32:39 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> Convert the gaccess mvcos exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries are removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/s390/gaccess.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kvm/s390/gaccess.c b/arch/s390/kvm/s390/gaccess.c
> index 405345ccc4f1..2d27dcb68002 100644
> --- a/arch/s390/kvm/s390/gaccess.c
> +++ b/arch/s390/kvm/s390/gaccess.c
> @@ -838,12 +838,11 @@ static int mvcos_key(void *to, const void *from, unsigned long size, u8 dst_key,
>  	int exception = PGM_PROTECTION;
>  
>  	asm_inline volatile(
> -		"       lr      %%r0,%[spec]\n"
> -		"0:     mvcos   %[to],%[from],%[size]\n"
> -		"1:     lhi     %[exc],0\n"
> -		"2:\n"
> -		EX_TABLE(0b, 2b)
> -		EX_TABLE(1b, 2b)
> +		"	lr	%%r0,%[spec]\n"
> +		"0:	mvcos	%[to],%[from],%[size]\n"
> +		"	lhi	%[exc],0\n"
> +		"1:\n"
> +		EX_TABLE_INSN(0b, 1b)
>  		: [size] "+d" (size), [to] "=Q" (*(char *)to), [exc] "+d" (exception)
>  		: [spec] "d" (spec.val), [from] "Q" (*(const char *)from)
>  		: "memory", "cc", "0");

