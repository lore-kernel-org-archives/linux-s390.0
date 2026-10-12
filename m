Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F344163B;
	Mon, 12 Oct 2026 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788716; cv=none; b=XNgwndfJc1yobmkl19XbeOxyn7hquNb4iybu3/1MY4QkPZgJuYBLqKTkWbLjkJHVfORdqts/o4LhivR1a4eb4FdBoF3Zw5GlfyhlDl/TXIRFdWIfO6R6553kdoETGucHPT7FYIHXI3h5RApq4RGAHjif5HoXm/C2S6S1psaOTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788716; c=relaxed/simple;
	bh=QVLNZ8QIewLlanawYIhcmIZAoO4arU4+ENEF66/rkGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NnyElC8uP5YWN8EQ88ZrU+d4VuCcQNCOKS89CLrfm8qMu0jki99yr40MolFojDgyAUacIjI1iWMLCxKwOmLnuygr97MMZGfMK9YfhPSel7HHkc4V4c1qtlu0bg+pBxzZThNRTBat7eEXx8zr94Ifa0cwod0ghdFmjq987ut//Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YZWTY4z/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YZWTY4z/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5EGP23321417;
	Mon, 12 Oct 2026 07:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4sTzJfQbkePzRY4+AisrZX7lhEyv1Y
	hWJaDPwYZv/wA=; b=YZWTY4z/A2/IXOXnOpG+BUFz5sj+xveDElEtdwulXtAvVw
	opARiO2ZkjNh+QIGg6EFBEXFGBA1axYWJXafH2EJALrLqrp/dfIU7hRgF9fH9WWf
	TUnTnPyxpWLlJfgjld1Gy+AQZPtgmYgB1luJLDsalP4SLgtHWWSdfz1EuLhymyT1
	7WhzZbL2zUXcOrlBate7auEQMNz3WdTp+qfHQRp1mFzm/71eBrXhtGdOGqaQsqze
	+WXi8PipBMXG+KGS4z6YEyId9FPKy5Y3u9p8swI35LaCJEK3EFFgMFxCuLxuuTX+
	YL3kGC02UvIaLM8EBRkPgp2ZSY/pOmF8fBw2w89w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhqbsv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:05:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5JstP769658;
	Mon, 12 Oct 2026 07:05:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vm85x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:05:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C758tq41091526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 07:05:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25BDE20043;
	Mon, 12 Oct 2026 07:05:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AA1820040;
	Mon, 12 Oct 2026 07:05:08 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 07:05:07 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/uprobes: Fix off-by-one bug in emulated PER handling
In-Reply-To: <20261009132604.2434271-1-hca@linux.ibm.com> (Heiko Carstens's
	message of "Fri, 9 Oct 2026 15:26:04 +0200")
References: <20261009132604.2434271-1-hca@linux.ibm.com>
Date: Mon, 12 Oct 2026 09:05:07 +0200
Message-ID: <yt9dy0c3pffg.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyNiBTYWx0ZWRfX8rUyY5Igegig
 E7qjupxD7tXx23SSkG4wyAWNo3l4DTVc+4stLyQRrEQkhMQmJXduNYlDNi6JDutCiUZZz1jFLga
 i2O6efuPHA4jitYCnQefqbJY5WVC/Bd6iHBvIATralAU0tY6e0MehU/yTFsESCd4rnLrTguz+xd
 w88xwU85IUpIQCdUvMy5zH3sawZZlYuSycDVPHEdbj+0HwLzdGFjB4c78vwEkwfj2pu5jM6Mgt2
 mJSOgQPvscUN1cHbvLx0YdnyW8tRJXdwmrUmMNLr1n3ovq+c2ljnvUCwR61GZ0my5WNa8a2eblO
 ZYk/L6LEh6riJuNFfYl4sJmKOaB4Z0YbPAjxQWUqrA/xswlRVK3qCDu6C1fDV6Wwhe9doBoQQI0
 k8YE82jg8czXt8DoH88nOH1MxeCKpvYfoaLghAKykUIr4Kg0Yqc31S69jFyDv3Nn/Y0z2Yk5JkD
 VDtAQ3Jgk6uUrJb9eVQ==
X-Proofpoint-GUID: e3o8cxNSJ2zkq2KBARHHJQ8XJV6JsKdm
X-Proofpoint-ORIG-GUID: e3o8cxNSJ2zkq2KBARHHJQ8XJV6JsKdm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyNiBTYWx0ZWRfX5MLwCN3NbyOw
 hWxQdicPYuIDM3dmpFb2sh7yhbfDnfxsdigwx3puBQLUOKGogsC10FgolPcfU/mBsgcThW7wEJu
 52Dggx3DZQpYdDty/oxihhb52866rec=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acc86a8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=KGQMB7Ug8lH89wmqnMIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120026

Heiko Carstens <hca@linux.ibm.com> writes:

> The uprobes code emulates some instructions, and with that also
> PER storage-alteration handling, in case a debugger is attached.
>
> The PER storage-alteration handling contains an off-by-one bug, which
> may lead to PER traps which should not happen. Adjust the comparison
> in sim_stor_event() to fix that.
>
> Fixes: 8d1a2427d8fc ("s390/uprobes: fix user space PER events")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/kernel/uprobes.c b/arch/s390/kernel/uprobes.c
> index c624f3361e43..b2b8a377ced6 100644
> --- a/arch/s390/kernel/uprobes.c
> +++ b/arch/s390/kernel/uprobes.c
> @@ -241,7 +241,7 @@ static void sim_stor_event(struct pt_regs *regs, void *addr, int len)
>  		return;
>  	if (!(current->thread.per_user.control & PER_EVENT_STORE))
>  		return;
> -	if ((void *)current->thread.per_user.start > (addr + len))
> +	if ((void *)current->thread.per_user.start > (addr + len - 1))
>  		return;
>  	if ((void *)current->thread.per_user.end < addr)
>  		return;

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
