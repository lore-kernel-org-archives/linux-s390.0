Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F504AF9F4;
	Mon, 12 Oct 2026 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821527; cv=none; b=u4IjRpJpPuMhKdFupC93aWnK4T9ZZVNQvxX526SYnfvUK7K5SDlPcWLcYPkE+FFgq3NqAjFEnVF99OiSC5Vxpqss401sy49rfIElXmKvFyeaLlQeIPmhh3X5S76GiCZkbCYDwEU27F6d4Z98TavcGiFL+Cgiaf2jSAQ8aWHQKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821527; c=relaxed/simple;
	bh=6KG5GqkVN0/N39llxjQbcOPdDMA6/lh69O831lynHJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMybfO+2FtavFThWMhtMyG5SixMg8IXQ+a8dB1ZA0dUSt9jYXYVyVsNxCWawHYpl93giy17Vwi2FQIjhDap3+lNgP73AXtZydqHTNYVNnoghN7lRW8i53Sd2+pQ6YC+UPj9iO7SIX8NRwGvG4YlwjilZM7fHAyPx8DC9pOw5SJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uk7wczFZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uk7wczFZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFiE1I508090;
	Mon, 12 Oct 2026 16:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6ckf4qC+ayWDrfXIO/9VJe5jaIuVMp
	D7AWyo7szpAwM=; b=Uk7wczFZ2t2VIG74gJI9O7H8pyC4BIUoGHm6eIeVyHn46b
	tXxCROS1/vaK9afogqrV7pUlonlI7cUvBKDers/63IJToudHQMkE7Ag6Og5gKFFm
	LYSWw8SLA51Wt6sxbVvgw9DXpEfu/XU70AYfoa/CuPp4HiEl0iGhVv2vFUU9arWN
	Z8EUQwTKjnkioBL45liB/voDLyO3ZtmvfRTUKfDd3eob45InYNHLj2z9d3sURpXF
	P+q/RrLWLdrJBOqgHz8Amv5KzzA+cgfBa4B9BP5sbcCh92phaPxEXG8okvzNrpRQ
	MB3lnu0A24T3QSqEzvHXmERSPW9owG5RytGmH78Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhsh3u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 16:12:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CG54jm1565005;
	Mon, 12 Oct 2026 16:12:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vp1vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 16:12:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CGBwkF45220126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:11:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 848DA2004B;
	Mon, 12 Oct 2026 16:11:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A1B620043;
	Mon, 12 Oct 2026 16:11:58 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 16:11:58 +0000 (GMT)
Date: Mon, 12 Oct 2026 18:11:56 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390/signal: Fix incorrect return address in signal frame
Message-ID: <20261012161156.19350K88-hca@linux.ibm.com>
References: <20261012153355.1529314-1-hca@linux.ibm.com>
 <sashiko-outbox-168354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-168354@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX/gZN2l8PXZKt
 yJKq5aC7iNft658PzlgobmrhTNZ/QZhvENOyBicFYdjCBlBOf3Wmshtocq9PTq7RJI7ZeGiPqTv
 4hBe1V8SEDQor/CoUlLM2cQnpFnjCUD9FW0FH26tH/vJpcN0155AE3F/ltlbFt+oyhEPg/3tanf
 g9uha0yjBNlAEXDKAnLWIkwomV+oS4UhxxNNkiwSyNdU0/ugA7QMM5CnihaLBD9iyJDIcwfWBcx
 p6lLBzuM4QmyU3PxWxW+VyiyS7EKpj0p87FRTZ2CemGT0Uai6LesnE1G4Uzj+PG9zd/bTgQ/SLB
 5dTvfxMO3S1kkRlqabSlilYPTw5MoPfIqbQ3O0ct319sI+QgFQ1ocyFma9E4s7XrK0+qgUYXY/T
 nNgcGuiTquEVBv/ZbPzuAYnBoo12crOeWjCdXqnggCJEemcn9tJlH3fxtVpJZyuL1by7QXY3oDP
 5oLgPqfneyajL8VbiCQ==
X-Proofpoint-GUID: DrY3Pw0yHgPyIThlDyNqcd27VnLuM_N4
X-Proofpoint-ORIG-GUID: DrY3Pw0yHgPyIThlDyNqcd27VnLuM_N4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfXyfJ+nPAokhUU
 IAAzhBuetMoX5wZMwCGtuft77dXtAn/tcYr2smzMK1bLCeJ//SX3ihFmxKCcQ39VLp8yredbsg0
 eHIkwT9UmhrkzlsFdP6h7rEkdc7AqVE=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acd06d3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=g2SWN7dJKy1LKwUrSOwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120062

On Mon, Oct 12, 2026 at 03:50:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] s390/signal: patch breaks -EINTR for -ERESTART_RESTARTBLOCK
> --
> 
> commit 158e48eb13e787b0b5c2f432c9056345d015870e
> Author: Heiko Carstens <hca@linux.ibm.com>
> 
> s390/signal: Fix incorrect return address in signal frame
> 
> This commit fixes an issue in arch_do_signal_or_restart() where a second call
> builds a signal frame with the wrong return address if the first call set up a
> vDSO system call restart. It addresses this by restoring psw.addr from
> arch_data before building the signal frame.
> 
> > diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
> > index 4874de5edea0a..25781d4a0ad0c 100644
> > --- a/arch/s390/kernel/signal.c
> > +++ b/arch/s390/kernel/signal.c
> > @@ -475,7 +475,10 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
> >  		}
> >  		/* No longer in a system call */
> >  		clear_pt_regs_flag(regs, PIF_SYSCALL);
> > -
> > +		if (!(current->restart_block.arch_data & 1)) {
> > +			regs->psw.addr = current->restart_block.arch_data;
> > +			current->restart_block.arch_data = 1;
> > +		}
...
> The newly added code restores regs->psw.addr to the original return address,
> bypassing the vDSO stub. Without the vDSO stub executing sys_restart_syscall
> (which would return -EINTR), the syscall instead returns orig_gpr2.
> 
> Could this lead to system calls like nanosleep returning their first argument
> instead of -EINTR, breaking userspace error handling and POSIX compliance?

Correct. The whole point of this patch was to return -EINTR instead of
(incorrectly) restarting the system call, which is the most likely of the
unlikely scenarios. One could construct more obscure scenarios where user
space would end up with a SIGILL, but that's extremely unlikely.

Anyway, the -EINTR return code handling is broken with this patch.
