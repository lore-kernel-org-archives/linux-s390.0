Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF431A681C;
	Mon, 12 Oct 2026 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808895; cv=none; b=oO2GwWXhlWQoEUZfDY5OVySGAayvl9Xg0CEZePlrpA6m2BuTfm5qQtBT0t87q9EItxop4DP0sWLRHZZRoV/jXuOaKaWQYyZMPFUKjuxoxKQJZyDkjDpZHN0vsLUeTnsyRVrf+b7qvyYzw4QytHP2zG1lEqTWliscA4eBVXc+Ah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808895; c=relaxed/simple;
	bh=LOptAmH83ox+t+FTozjmeOLzxF3STV2WroNlSe1/jxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLtlW7+ApH/y26XLgIPIfkZyOjKzayXfOivSMkWyeadlzVg7L+Sn8tVQoMugL+YflcPg5JEvgZmjuUPeNmNiuov7lpzsTxdY61lyWxiVRkiUaXBUfpuHvpWaD9e2/F+VS5U0MdgMHbnxptTJMAD+V6XWNejPokYorHWuHcPgVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P9KnEanA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P9KnEanA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEFpr231222;
	Mon, 12 Oct 2026 12:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JQ3VbeDKz5TI+R0vjZq0WetHaiJf2m
	nduVPcuihj6Yw=; b=P9KnEanAMUQifoElvTpNwltuGlWBco+CY6VkQsj/MV94b4
	NNyAP4eLErXrJt/o9Cn22DejmOSICY8l8ekXuqY1gcGFfR2sl4Vje4aSFOjGoafa
	TvIaBqCnP+oetwSYD7Dd6VksV4fZpqiVIsWNmg1ISfJlP80T9lqnkDOZJFojNhC0
	KaGeN5xvyN4/CDwJyxPZSoOcOVEBJr8cWSTYD/ZBRfWmMvZuJNpzVjNtrJ/5v89V
	1mVZ5NfYFckI4085GaOhinwDlDd9Tri4TAg8K57PESkYtKE+/LCenI2Df36dcOcj
	xGdFyD2Nk2/ShScY0hE0BPhnoKQcxyuekB0eA6hw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w0hcr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:41:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC5AjD1238650;
	Mon, 12 Oct 2026 12:41:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppn9mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:41:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CCfTc842074502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 12:41:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F19C020040;
	Mon, 12 Oct 2026 12:41:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3E6B2004D;
	Mon, 12 Oct 2026 12:41:28 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 12:41:28 +0000 (GMT)
Date: Mon, 12 Oct 2026 14:41:27 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/4] s390/percpu: Use asm_inline for arch_this_cpu_add()
Message-ID: <2af61c70-bfa9-48d3-a197-41eac0b9c5aa-agordeev@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012114249.2898572-2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX93K1cxr2ApH+
 WiMl3kLtKGhgDIbYE2GNwv67BlYh/TZzqpULet/Lo51MtSPzhcH+GxGZER+Qeojc7O9ZmxZH3My
 lMvXtW3Z99yND3gQlZ5dp2+Q8WUfAMg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfXxAmVjQF3+4z3
 XiBkw91xh/VJAxtU0tOoy8FU/PsfWVNkQORPnSFCi+9vnVcfYZoPRo5ldjbJvFN6J1b/tNX+vm8
 y+3cbG76GRyZs6AvLdeduyQYRoxLo+AHt1KPzYIX1P/27uD1oVr56trhZLriLGC3Lvme+UedJ3i
 3LR9WGYAe+VIzw5RG1AVFtCr0QqN7k6AwcRGhqICAAYxdheixExDFCqwL6YCPxikSDWMYZoDzgb
 mRKnwnqJcMfJkDW+n+M06dti2o9SvGJ6HwMaqQfmwl7GiwSLewXaXSN1U48mvy0bhrvU2kX1Wyl
 i617nZBW9K+DeQ9c6AotdozvPVahz7Km60UFl+0VrKS/PXgZ+NbknTaSCV+XGzvedJgCd3GoA2c
 aiwya5Mr56YkP5fDx6R0yH0H7XjIRk6Mg+OJIUp2bzS8+N1o63mvWUG4RMfEW+PpMj/Jc7xJOif
 dnedyMNebQvgZYwqJyA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accd57d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=x59IMPMvzmwHi_HZdScA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: PmBHCKBR01ZzxpKYAL37ykbft33EnUn7
X-Proofpoint-GUID: PmBHCKBR01ZzxpKYAL37ykbft33EnUn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120048

On Mon, Oct 12, 2026 at 01:42:46PM +0200, Heiko Carstens wrote:
> When converting to preemptible percpu operations the arch_this_cpu_add()
> inline assemblies were not converted to use asm_inline instead of a plain
> asm statement.
> 
> With all the macro usage the inline assemblies grow significantly, and
> the compiler may decide to not inline even small functions. This can be
> observed with gcc16 and a defconfig build where many calls to
> __srcu_read_lock_fast() are not inlined anymore, even though it is
> basically only a this_cpu_inc().
> 
> Use asm_inline to address this.
> 
> Fixes: 18ec6c5d7ec6 ("s390/percpu: Use new percpu code section for arch_this_cpu_add()")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/percpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
