Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8BE27A47F;
	Mon, 12 Oct 2026 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785534; cv=none; b=hTjEd5XkqxzErT3wjyYbC2m9MQQJECX/cBhQuHMfSxefqOBhVruCaNpzkpX1bY1TrB7e/V11eJBqi2AEjE7cdXmuvTpNY6uOd9NafSb0QVjOeCNjXe4xroS3ppq882znkLEoWv0RcbXL3Zv+1S9S3dumnWcDI+ZwoFoO0J6gaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785534; c=relaxed/simple;
	bh=AejdLHqNJuS+qrfHNbiaPnHQtObdu0DK5yNQu/dY9HY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C1APMatz1yBGW+Nh6cFEOdo23LvT6FsKyCz16z+Mbe3A+5ydZpZGN43V9uuS9+xagy2yOD+6kTI2knYOpdUgcwX4YXEZQCNuYAePsySzzWQ0st9db97+ZgZDZi5noVaaKRxSAqOODFBAUE71iZ2bCfoRPQpszijNkWirxmN6gvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E5X0mTVN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E5X0mTVN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5EGtP3479576;
	Mon, 12 Oct 2026 06:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9usDvnFmfqDsJsVnMt9jVkSnSCvHms
	T8+YUnH855LaE=; b=E5X0mTVNhr8siawTyTQ+sGAMRVzTLQy+Ma3vzgLItxtpmn
	GDhBjkh+bnbNyhI/RJYoKIiUzcqOqEabU996eYL3xHU8vM32P3we7Zdp+E6O3pgv
	VmlNvrdpUBU8BjaxFhrgP5F5D5DmvXuaYGjmliHUzOfpv36b7ZBNGnd6gDCMnEdr
	yJma54AhecBvXpY2ad2R0W2b2282+OHnMGTxbCEhJkHcuKknnIHAW6n657LrQ6fH
	DJp26qBTp6/sFj6rUjf8XhIWgFMGTD9cHXKvgPCTvlipbnh84WUFkHZ4Qmws/SpG
	hHYTgSuX8p3EtFnt7Vw573HTHOcDPAicnE/PQPHA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1vy44f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 06:12:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C55FGF804951;
	Mon, 12 Oct 2026 06:12:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cybpa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 06:12:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C6C6kh17826226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 06:12:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C98DC20043;
	Mon, 12 Oct 2026 06:12:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA3A420040;
	Mon, 12 Oct 2026 06:12:06 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 06:12:06 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/ptrace: Preserve ILC when updating system call number
In-Reply-To: <20261009152132.1113325-1-hca@linux.ibm.com> (Heiko Carstens's
	message of "Fri, 9 Oct 2026 17:21:31 +0200")
References: <20261009152132.1113325-1-hca@linux.ibm.com>
Date: Mon, 12 Oct 2026 08:12:06 +0200
Message-ID: <yt9dcxtf30sp.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX03Rta/ed0FPz
 c5kW9+hgGEEO8gbwJvL/5DgDPKVgFDWFNVbbzmHR5aY7v+IsLJHWJt3qPALaLVVZ+RcejppIsI0
 qdmCnMNM3EQTkbp7YKB69U1hiULtkng=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfXwPMTVoO0lkkK
 /U/1uKBiT6HZgZk9y53+LdTsirCPx4sWUjCr1tuWrPt8ulFurVmDfnbCLKNirwURD7QOzQQzBnb
 tAHyo4dH3r+wh0Pjc/s/lrQKAHukZy9FsRWPLnn9Nd/5O7+UIkYV+M7pXtUhXxu6fU8lLKY/67l
 /8WmkQbuQ/Spb3Dv58WmPSoPTfYwv3S6409smA05uOIoSPCGSzpkbg0Aj2HPKkXu+OHRmBKk7HL
 lCRrOVV38+yiTEDnkZMNhEFWtL6u5Gn1LEvg1cPE1wLGZAxcpWmuZy96vsHKTKihuFLVKiGDQGy
 afEVAigxiBSHMb7cn+3NxbUoC+yN+eIa7hN0MkLSQxKjBEBvDaCm4+zx8/BdZ3LN7+nytxzATOU
 0eeTMVzPs/Q+Pi8OcyHJNJjGi5c5zdtcHDfYE/+RLOV+jXtB0wV0ohLDcdwG+jUVdIeg+rdaxC6
 Ec66sDGWkv30zbAH1nw==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acc7a3b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=31u72ZEnUxVqjmpZp2QA:9
X-Proofpoint-ORIG-GUID: srHuSWHhLNOzFUnmMXEsaJ0LsLguDThK
X-Proofpoint-GUID: srHuSWHhLNOzFUnmMXEsaJ0LsLguDThK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120022

Heiko Carstens <hca@linux.ibm.com> writes:

> When an attached debugger changes gpr2 via PTRACE_POKEUSR while the
> traced process has PIF_SYSCALL set, the int_code in pt_regs is also
> updated. In case of an svc it contains the instruction length code
> (ILC), as well as the system call number.
>
> The ptrace code sets the ILC unconditionally to a value which matches the
> svc instruction. However the svc instruction also may have been executed
> via the execute or execute relative long instruction, which have a
> different length. Therefore preserve the ILC and only change the system
> call number using syscall_set_nr().
>
> This makes sure that in case of a PSW rewind the instruction address
> points to the correct instruction.
>
> Fixes: 56e62a737028 ("s390: convert to generic entry")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/ptrace.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
> index 125ca4c4e30c..d8d5e843859c 100644
> --- a/arch/s390/kernel/ptrace.c
> +++ b/arch/s390/kernel/ptrace.c
> @@ -34,6 +34,7 @@
>  #include <asm/ptrace.h>
>  #include <asm/rwonce.h>
>  #include <asm/fpu.h>
> +#include <asm/syscall.h>
>  
>  #include "entry.h"
>  
> @@ -345,11 +346,9 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
>  				return -EINVAL;
>  		}
>  
> -		if (test_pt_regs_flag(regs, PIF_SYSCALL) &&
> -			addr == offsetof(struct user, regs.gprs[2])) {
> -			struct pt_regs *regs = task_pt_regs(child);
> -
> -			regs->int_code = 0x20000 | (data & 0xffff);
> +		if (addr == offsetof(struct user, regs.gprs[2])) {
> +			if (test_pt_regs_flag(regs, PIF_SYSCALL))
> +				syscall_set_nr(child, regs, data);
>  		}
>  		*(addr_t *)((addr_t) &regs->psw + addr) = data;
>  	} else if (addr < offsetof(struct user, regs.orig_gpr2)) {

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
