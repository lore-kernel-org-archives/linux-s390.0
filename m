Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5C3CEB9E;
	Tue,  2 Jun 2026 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394916; cv=none; b=KhLUksoyROAAxg/NVWpyhbLGwPwx0eYCF+ngjpEQxyr2Wow5ErYVN04TUgfeEqPYxPSCMprqcLpf3g1Cat59kfaZbEn00H5wcOpCSo7taKqomZ/+pnbRxjXhx+f/alm8UGQ29AZspjiaKyBi/q0wacHTx4QhSl2Tt6W/HJyvL2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394916; c=relaxed/simple;
	bh=YxZm49TIERiiRXB4x8BFP433V9LWSt/gq6WGEUGiL/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFYtgxyh0+2Wl5NVI2fEV9h6GE9rDePwfGyrABARfkWraoOgyYcuu7vcG0KgbrEccBucGwsjN97HAdQKSkVFAqyrHWsSWcW0yOdOTK3EnAu4v6YANPijUIe09kUhVgjB4o0Lb/G1UwEbZd689KCrMYcNefjciZy1wPAb6SFCXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ponG0qqr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ponG0qqr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6528fYQU2548014;
	Tue, 2 Jun 2026 10:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+zWA5XI0/5cmhr5ihHfQ471+VBcWYS
	pNujFMPohVsNc=; b=ponG0qqrsK5n1cZ4aGaKDHhX9AzqD7Ht5PP+JOhBFZpM+N
	+M++U1oii0AnLq66V5aFdrqzkw+QKs5thF0OYsYKQRMBuzDIBrPW1MMAj7lmJ5MM
	uxIrRkQ+CEyG1sjvQINOspzIlb3mREq9eY/hCATZ8z0UDjPQCUpfZyJGywONa/aa
	j4rY5wUu9vCDcAfO/n2nOpGIQsECsj0b6hXlnNlm6qL7NLNt04wGCE9+12fNN/E7
	EhLvgU1CbOr5UxOhcJKIlmJ+XPFBs8AuoBscN/Ul81SNYh0Tp9QuIcSlP7hLbdzy
	1wmeACuKLJ9A4v7WKJQiENCN3aV+wMvvsCpEc0qw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahn3n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 10:08:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6529sCls011366;
	Tue, 2 Jun 2026 10:08:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhajv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 10:08:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652A8SSb49414614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 10:08:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C93F42004B;
	Tue,  2 Jun 2026 10:08:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 486DC2004D;
	Tue,  2 Jun 2026 10:08:28 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.22.2])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 10:08:28 +0000 (GMT)
Date: Tue, 2 Jun 2026 12:08:26 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/7] s390/percpu: Infrastructure for more efficient
 this_cpu operations
Message-ID: <23cce29b-3ba0-4ac3-9cb6-57a6f4b7bf45-agordeev@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526055702.1429061-2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA5NiBTYWx0ZWRfXyTYpzUudbfqu
 4T0DBiCOqFrwrIAjihQl7svr+k6AKKLmFo3mcajcV61iy9ImyWZ6H+rci5Af6bHPlQ0NYLjm4ei
 pM7BCuzrSxhCrWE38/H7HSK56eYiEI2ADcKZUzr7f6K0cNbIiKwLMzRUUxj1tcHWNHuQQvcxhxb
 1H9CBu4TKeOulOA6W66VphSSGmwGeGFG/N1PfgcTBSuW2LKhslEXWFYkt+HTYvL+KWhx/gk1Wk5
 5o4rsWEynHTNtcpkyi8nqhShVSWzHSZa7s7RS6cF4fKqkC/xjSKBMXcxnadDQbnvwfMZFQQeLLN
 WbZTTwa/BahPUA3JpEiCh1jyWX3rmiqJUcxc+S5medj1MutAExNDIkZ9Z9K4gBXkVcLutL+bBW6
 ftLyGJouc67hbZelc9fnuN/VUndUDVmidN3AYXYV7P0OSKPCoZuqCCAH8q4HBRaruSHX7/1Ao0w
 kXj9zxN+mkEA2UXm2wg==
X-Proofpoint-ORIG-GUID: ThHC4AX5JKtjx6NSDIuKSbcqMCKrYpBu
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1eaba1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=fa718S75ilCNgVvGbR0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ThHC4AX5JKtjx6NSDIuKSbcqMCKrYpBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020096

On Tue, May 26, 2026 at 07:56:56AM +0200, Heiko Carstens wrote:
> With the intended removal of PREEMPT_NONE this_cpu operations based on
> atomic instructions, guarded with preempt_disable()/preempt_enable() pairs
> become more expensive: the preempt_disable() / preempt_enable() pairs are
> not optimized away anymore during compile time.
> 
> In particular the conditional call to preempt_schedule_notrace() after
> preempt_enable() adds additional code and register pressure.
...
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/entry-percpu.h | 80 ++++++++++++++++++++++++++++
>  arch/s390/include/asm/lowcore.h      |  3 +-
>  arch/s390/include/asm/percpu.h       | 62 +++++++++++++++++++++
>  arch/s390/include/asm/ptrace.h       |  2 +
>  arch/s390/kernel/irq.c               | 24 ++++++---
>  arch/s390/kernel/nmi.c               |  5 ++
>  arch/s390/kernel/traps.c             |  5 ++
>  7 files changed, 173 insertions(+), 8 deletions(-)
>  create mode 100644 arch/s390/include/asm/entry-percpu.h

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
