Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAEC339361;
	Mon, 12 Oct 2026 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787147; cv=none; b=VHDhiHCydt9dLUBBWnJbXA1DzCZ2NCBwGxFmafzAfFjbPT2pP39rz6wMqYBEq35NFPlWE4CfWuJCqsoApQpy/fz1Pb6GjVvdqhnQBPn1VFVimQS9Hs5ZUU8OoOwNvzIGn1tMCEvUDQnqNCvL11IWPAL1fobp/bx6MMMZbx5X4HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787147; c=relaxed/simple;
	bh=V7dZD6S4vkMjIkaJr4VxgOKsOxnqAOiL8J96nKBPvtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8sMKqruo9EU5o2d7ZU6umSzomwuqYUKvhuWSp6aGbZccRII0FVxWyS1BNN4+3mCE/p2kZFATRHcv4WKskl8V7LYpwcKMMZqyKyew4jTLEQpzvg2kFcphMN0bHVBBuKnk4bNEIR6ejrsGQZalRTLsKRQuoSobsw31noTabBJbrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mlVc7ohu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mlVc7ohu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5EZv13479824;
	Mon, 12 Oct 2026 06:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bd7MbNt0RDXg84hCtPS//flzfZXtXG
	PjVks/SEA4YX4=; b=mlVc7ohut4bs+9xTUqyQK+bT7ry5M1D9qsK2CxSnRadI2l
	Q1cvRcVlFAcNrYcKMZaB1y6Ddce/bwZe24qN0T3GK7Z0oM/49nRRz0wfaYfq5GBd
	kmBGLFCw3yRv8cWkYx4FKm6+AFwAbCv8hcT4HTJTd+68JvAPm4u/4xZU13gjt4RU
	Pp86SMuWWE6XhoIz8VXgmE5qDWbbTIs6KKtFGwRWamgb6ZOBvvvGj0S87D/i1Sur
	s4qjvsgO52MFEhl6RZROSXGAjw5Qjm1fkR0gXSHG+9l3IkPE4eClQRFZEXpYl7PZ
	P5QUiIVW4/wxed9tAR8FYrO5vzugiaGrYAwArPvg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1vy71g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 06:39:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5Js9J769661;
	Mon, 12 Oct 2026 06:39:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vm564-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 06:39:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C6cxC140829344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 06:38:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE6B72004B;
	Mon, 12 Oct 2026 06:38:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF1BC20043;
	Mon, 12 Oct 2026 06:38:59 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 06:38:59 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/extable: Fix mvcos instruction decoding
In-Reply-To: <20261002102750.1994830-1-hca@linux.ibm.com> (Heiko Carstens's
	message of "Fri, 2 Oct 2026 12:27:50 +0200")
References: <20261002102750.1994830-1-hca@linux.ibm.com>
Date: Mon, 12 Oct 2026 08:38:59 +0200
Message-ID: <yt9d33ub2zjw.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyNCBTYWx0ZWRfXwU8Gp3zqZ7qa
 zVHlsg+htH174M2RPGtPDV3TlsFAkVhK3KPKq1dJzSSKWLpHOygvogXnXnCeecM6QFH4T7r0JEL
 u5oF8hyZeyMM85K+ExjrWVY/VADJSF0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyNCBTYWx0ZWRfX9gkFpmIeQbTb
 UoxTieT8BzZr8eC0gPiyWkA7YaCddWhQ50P6BtBcITESc9oP9MGokvgayCpsEny/eMERalfcyE1
 c7V+GZTKyBdGl7dR7KqpSLOh7epSaJjltzDBIVkktsth+IHcnKuyh00gmJ/IXAzusH1aCcCTLqz
 UXZ54eITuvIr3MIW0CQg/DakN/cm3h2eUOUUqHqw3tou6LOP0FurLqS11Ny455LmPGJfOSDoQC4
 ODMlCM3/g8KubXnecRTgm04gZZN6cRolLt9JBxS9ZUaqlmLrYT4QC6mGzQf30ThLdCJc3qtTsgq
 644nBNr1YGyN2HG7dzumkeWCTkvcxCx2pilXPVeBWMqVLaUDYUFfDvcnHAKTeVGLTuqAsNv4NuU
 eoPVkH9ZRTvPxgxdg/7rDXj/bvPA+kASeD3LtMjAgBAO+JQLKdgjkkXAYGfCNfjItmkG0ZsaFCl
 jTO3WUKEAyUTfT9wGDQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acc8088 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=4RnNsjVToRJwR0ODri8A:9
X-Proofpoint-ORIG-GUID: RSlqgEYwDxAwonlyXUnZeqBJUmPqe0wE
X-Proofpoint-GUID: RSlqgEYwDxAwonlyXUnZeqBJUmPqe0wE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120024

Heiko Carstens <hca@linux.ibm.com> writes:

> If either the b1 or b2 field of the mvcos instruction is zero, register
> zero is not used for address computation; zero is used instead, according
> to the architecture. ex_handler_ua_mvcos() incorrectly uses the real
> contents of register zero. Fix this.
>
> This shouldn't be a problem for any generated code, since the compiler
> would only generate such code if it is possible to prove at compile time
> that either the source or destination address is within the first 4kb of
> the designated address space. Such code should not exist (also confirmed
> by an allyesconfig build and decoding all ~7000 mvcos instructions).
>
> Fixes: c488f5187a24 ("s390/uaccess: Shorten raw_copy_from_user() / raw_copy_to_user() inline assemblies")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/mm/extable.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
> index 7498e858c401..848855da9a70 100644
> --- a/arch/s390/mm/extable.c
> +++ b/arch/s390/mm/extable.c
> @@ -106,9 +106,9 @@ static bool ex_handler_ua_mvcos(const struct exception_table_entry *ex,
>  	regs->psw.addr = extable_fixup(ex);
>  	insn = (struct insn_ssf *)regs->psw.addr;
>  	if (from)
> -		uaddr = regs->gprs[insn->b2] + insn->d2;
> +		uaddr = (insn->b2 ? regs->gprs[insn->b2] : 0) + insn->d2;
>  	else
> -		uaddr = regs->gprs[insn->b1] + insn->d1;
> +		uaddr = (insn->b1 ? regs->gprs[insn->b1] : 0) + insn->d1;
>  	remainder = PAGE_SIZE - (uaddr & (PAGE_SIZE - 1));
>  	if (regs->gprs[insn->r3] <= remainder)
>  		remainder = 0;

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
