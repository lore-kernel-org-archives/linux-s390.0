Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655816;
	b=wKv6mZhKSSWZsw7GJmUwERjjXYKtNduSMaXAd/NqG6Cbf7MwWm/S7P+qXWwMfOD1fgf8
	 fz8OwWbAS4/2Ys78TDsoUVgg0F0Ge6HVwxXNcZfB8KauVbSQcl3sBeSPZ8/EryYcwbY5N
	 hpbm5XyX1RgQX1w7luox9WFzE+lPpR7Fx+mTt64m4GATjbBYXWB1hM3BzUo5ldLkGjN+g
	 mi+2+MgHGk3blcBgIavpcOAz53IZ/9RDvxQ4fDp/XeJRi1FNtVydrMwwrngtYRYqdLCNr
	 LXK42qcE+EOUmy97fzKYeX++KxSRAeQPjfIM2/v6sWfsFyH9LzZf/x9NjKv2VW8Au4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655816;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lZuPvHfcQCCINYKbPhFqyHUpZg95Ahi4/dqK/t3/A8w=;
	b=sRVz6jr8AMKSkUYScudY2AmixSX6+Fs0ltjEaOsivTllU/UzYEJTvrylvqdYiwPQTYeK
	 ab2GxdQ8YpdlfYZBJVwvZ6xHlzRxKz2kFEKceHKEbN/XqyHlG1IR5qVFPs3mNN6JWWdIl
	 oCeTNJfMRYGeRM33sKPDhriOeD760XILy5YiuWrMFiFRnKpWeAwjGz5vmvAvaSzqqgz3Z
	 J9FjrXZlVWQzyp/9ElhG7RFWFtx36wdWkrm8uRWzFG9IMoiqPEjsOTRUDuP1ReTYGYM3x
	 RLHHZX8wacqx3JysVn4V6e34FZh+LqwiHPHXhu6RKHGzMxCUFFBPmj0Uu9s1rA2nLSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V4QsO65o;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB7606A319;
	Thu, 22 Oct 2026 07:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AAB7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V4QsO65o
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M7E64R3560983;
	Thu, 22 Oct 2026 07:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lZuPvHfcQCCINYKbPhFqyHUpZg95Ah
	i4/dqK/t3/A8w=; b=V4QsO65o/inGZOaMQefLE6AvPkKh/sPSPakvixTgGxQS96
	xRvhwoflgwo9wlt3Tsh7nQSdwOYB7VK4oGS40u1bJGBJJDNmHbC5Uj981pfyNyDR
	O8YD1aEINxng5Ibn3slejbcv6ebdZu1+GTVvnnAi3OvXrXd8q75w/MopCBLZr0xA
	GAuxuW8XUooW3ZWEKePZlsV+PNPFVXvnZYLYKtrknIxxY6OR2KGMYiOwndftprID
	m+81ZQJ1c/c068cZNva5FT1eH8G9FeSVmQKFFZPMVAKRbOHyASNaoWG/1b7iFEQl
	oD2MSw/SxsAKRqafhKoksct1BYSgkZchU7JXMjPg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58wthc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 07:56:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69M74tIF089148;
	Thu, 22 Oct 2026 07:56:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs925d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 07:56:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69M7umD952429230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 07:56:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE8F12004B;
	Thu, 22 Oct 2026 07:56:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C421B20043;
	Thu, 22 Oct 2026 07:56:48 +0000 (GMT)
Received: from osiris (unknown [9.224.90.220])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 22 Oct 2026 07:56:48 +0000 (GMT)
Date: Thu, 22 Oct 2026 09:56:46 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [RFC PATCH] s390/syscall: Sign extend system call number
 retrieved via syscall_get_nr()
Message-ID: <20261022075646.11120A92-hca@linux.ibm.com>
References: <20261021125911.1550331-1-hca@linux.ibm.com>
 <sashiko-outbox-180303@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-180303@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y-roT4I9BUAtqE8rQaD99HkLX_z5xa7b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzMCBTYWx0ZWRfX2NkfHgfm4jiV
 q86brYIQ3/c5BTjOb4nB+Md7lCrQAjriFsbakKLwtYlLwbUzq2W4QKjsVufMtB34tFpI3zV07Vo
 k+p2ihZMzErUxI/OSOylzNYtdaKG/I8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzMCBTYWx0ZWRfX6KukPcWu7bz2
 aMxSVEnk/KlqFlBOE2KGzYZgjbpcvkxTOP2UswP8ella4ryvFWHsmb0D3EjspA9c+rnPfDYb0/0
 YAJ76V74kXYkT1felEakFVWf6CY/3EJE/s6jBm8LMeVmisf2MFsJFT8cND8LNFnowtCiCbE318T
 8EXj4o0xOhjBX6X/BwiISerkJJGGJssh//TrToBn2Q0pob6RE1box00IwDnn/VO+U3CUAQl0Sr2
 phLlWEwSIPmuH3Ho6yvqnITWtGEmbkw3i4rZaEoQBrHbMPdOP1dSmC031eu2wlr6QLaXhAozMYa
 T84YfpH93Q5wDaBtzN23SZ+qO9t5reTX2vctQpghOefnpwQRt5r7MSK/shYR1YOgoHqUKKem6jt
 5Gv4lGLnON4jZuLoW+avuMmdwBeO3e/IBgBFaphgwQzdJ24Qfo5qXB3RLLNZdZiFc9ercV6uodp
 +MLEKtyA28Ob8ejZi7w==
X-Proofpoint-ORIG-GUID: Y-roT4I9BUAtqE8rQaD99HkLX_z5xa7b
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ad9c1c6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=AGpjq-OJZXGNhh8UPtcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220030

On Wed, Oct 21, 2026 at 01:27:30PM +0000, sashiko-bot@kernel.org wrote:
> > @@ -20,7 +20,7 @@ static inline long syscall_get_nr(struct task_struct *task,
> >  				  struct pt_regs *regs)
> >  {
> >  	return test_pt_regs_flag(regs, PIF_SYSCALL) ?
> > -		(regs->int_code & 0xffff) : -1;
> > +		(s16)(regs->int_code & 0xffff) : -1;
> >  }
> 
> [Severity: High]
> When a system call is skipped under SECCOMP_RET_TRACE on s390, can this cause
> __do_syscall() to return the wrong value to userspace instead of -ENOSYS?
> 
> Previously, syscall_get_nr() returned an unsigned 16-bit value (65535 when nr
> was set to -1), so after PTRACE_EVENT_SECCOMP in
> kernel/seccomp.c:__seccomp_filter():
> 
> 	/* Check if the tracer forced the syscall to be skipped. */
> 	this_syscall = syscall_get_nr(current, current_pt_regs());
> 	if (this_syscall < 0)
> 		goto skip;

This is addressed with:
https://lore.kernel.org/all/20261021085643.2442949-1-hca@linux.ibm.com/

Read: should not happen anymore.

> [Severity: Medium]
> Should arch/s390/kernel/syscall.c:__do_syscall() and
> arch/s390/include/asm/syscall.h:syscall_set_nr() also be updated to keep the
> syscall number representation consistent with syscall_get_nr()?
> 
> In arch/s390/kernel/syscall.c:__do_syscall():
> 
> 	nr = regs->int_code & 0xffff;
> 	if (likely(!nr)) {
> 		nr = regs->gprs[1] & 0xffff;
> 		regs->int_code &= ~0xffffUL;
> 		regs->int_code |= nr;
> 	}
> 	regs->gprs[2] = nr;

This is valid - things should be consistent.
