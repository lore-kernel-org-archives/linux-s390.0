Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52526ED41;
	Thu,  6 Aug 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026046; cv=none; b=EzZUDXPWJWL0XXIGvBHK5LjBctCK/be9fLclk2pBujAqUQ2QOqIszYv5jZakiqjSRhDxkgMltNejq6r2IeOsZeH5LYrh2dgoNXZVlTtgMOuwN9UnDz/jWPXVVc6grW5mCs4hOqQyugK1Pd2iiuDEQd9s2H5Z9PMS6HWWi4dmKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026046; c=relaxed/simple;
	bh=cwo+XfXTMp8Vp8goaC/CvZC/oCawJ+bK/4EMDmEh0ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmOJHnq5D82bslKW45NHo6AE/muaK3HBwivI5C247jVEc8Le7hTJRXzshtFmbRuxLQUuLCvoBbnZS2vPvC2IQpMEOwxvXg16cXu11BhAju6Qb7A7vj5BTezQNTVhnCrvtRS/oI4UZMynHMMRzMf66p7/kq982/Rrqold3dsWd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IU7s8ppG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IU7s8ppG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Do7Y31092931;
	Thu, 6 Aug 2026 14:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+3hLOyyIYllLKq3fwT9UK4DRilTLms
	9J3bUd5JwUABw=; b=IU7s8ppG6eAh/MR/5ZyYmVoIMCXrs66DUdBip+S9J2ztpW
	sTAz3OSw5UvglgvCwhkaeQ5mR/UlJMeTsj8PuRmXS2+EaGV+OKk/tkXKvcyrw3nL
	d0W2yeMit63O/xyLHDxbpN3SeDNrodqylZzwPQv/+kRwg7dhMgw/k2IdT3sLjm9c
	drxSkhfAnCz35I7kgaU6NucU9NRRed1VsBTn7QB7WpGWL8ajkozx/dgEbw3K+oWj
	nsfsarwjWYGuTFP/6EWbH5VxMsnoyzCOyag0zUXEaeEweikhYx7GRRwySmYr0uKb
	O2mxoKzjJkGN5mbG3pDASyjl0oPkk8KBJGiH1HCA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h58psy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:20:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676EBJNI024568;
	Thu, 6 Aug 2026 14:20:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qun03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:20:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676EKcQ952298120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 14:20:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71C0820043;
	Thu,  6 Aug 2026 14:20:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 178A920040;
	Thu,  6 Aug 2026 14:20:38 +0000 (GMT)
Received: from osiris (unknown [9.111.55.125])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 14:20:38 +0000 (GMT)
Date: Thu, 6 Aug 2026 16:20:36 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, KVM <kvm@vger.kernel.org>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 1/1] KVM: s390: Fix memory corruption by not reinjecting
 CK machine checks
Message-ID: <20260806142036.15764Eaf-hca@linux.ibm.com>
References: <20260806125241.210170-1-borntraeger@linux.ibm.com>
 <20260806125241.210170-2-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806125241.210170-2-borntraeger@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExMiBTYWx0ZWRfX3xCCU+Tm8iep
 DxpAoPjJ0+nXIsMK96pVWCySYpmu9xRQx/3IZjtGZFMzPiNJ5XqAcccONb0GtTn470OVDiYY/CK
 dig5blXA+4lFz+GLLQ8c8/qr2D43zK8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExMiBTYWx0ZWRfX9tTZYrr0ATu1
 YPzDdjWAe523p+lIYrUUb5j0uS5i60b6RARt8BekxRJ9iPi5UDn1t6iNgSKPdeWG24W1zuJnmHG
 WYVnnO+hGGOtr+lzJ2ATxqSD4JL0uO9t8/VFDrU1tVDmtnxpCho+dNOnBCAxSzdMNgKqYgDte6A
 lZhDmIfLvScPCwYrfYRLI/D3cU/f0b+Emtr9YQEhD2uHbTo/LOpd/CnEZmeG4cL8yN0jvEGhLOS
 v3uh2RkGZ78kvrVz4ouBSnztpw7YMBP4qovlM7t6tF+4FtSGCDNdY2Suj0JXBJoKbY7XJ1Hn0TK
 1XzP6ccueSYdJQk0JamW8zSEruT25jRzwEUA6eawi4X7Cnu0McV6PhiOqaO7qnVL8wOZLn2kEBS
 yDBbQmoKZEmzYoXYqBZnmM4OpTxrl2fIQbg7GsyDmr71i5EFMIJ+X+qZ4YXmKRTObRprcAzYcYV
 rzaC86hLXlAZpXhYBWA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74983b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WOMeMtZcLbvEFOhP14wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: w8yY2Ph_y1Ru6d1aVrvE7GDbZj6ULh9K
X-Proofpoint-GUID: w8yY2Ph_y1Ru6d1aVrvE7GDbZj6ULh9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060112

On Thu, Aug 06, 2026 at 02:52:41PM +0200, Christian Borntraeger wrote:
> Channel-subsystem damage machine checks are for the host channel
> subsystem. The guest channel subsystem is emulated in the userspace VMM.
> There is no point in forwarding such machine checks into the guest.
> 
> This also simplifies the machine check reinjection and avoids kfree of a
> stack variable as reported by sashiko.  There might be still machine
> checks that have the ck bit set with another bit (like instruction
> damage), mask out the CK bit in s390_backup_mcck_info(), like the CP and
> ED bits already are.
> 
> Fixes: 4d62fcc0b692 ("KVM: s390: Inject machine check into the guest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  arch/s390/include/asm/nmi.h |  1 +
>  arch/s390/kernel/nmi.c      |  4 ++--
>  arch/s390/kvm/interrupt.c   | 24 ++++++++----------------
>  3 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
> index 6454c1531854..dd26c20bd231 100644
> --- a/arch/s390/include/asm/nmi.h
> +++ b/arch/s390/include/asm/nmi.h
> @@ -22,6 +22,7 @@
>  #define MCCK_CODE_SYSTEM_DAMAGE		BIT(63)
>  #define MCCK_CODE_EXT_DAMAGE		BIT(63 - 5)
>  #define MCCK_CODE_CP			BIT(63 - 9)
> +#define MCCK_CODE_CK			BIT(63 - 11)
>  #define MCCK_CODE_STG_ERROR		BIT(63 - 16)
>  #define MCCK_CODE_STG_KEY_ERROR		BIT(63 - 18)
>  #define MCCK_CODE_STG_DEGRAD		BIT(63 - 19)
> diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
> index e17a59d4d5a4..652b98795243 100644
> --- a/arch/s390/kernel/nmi.c
> +++ b/arch/s390/kernel/nmi.c
> @@ -345,7 +345,7 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
>  	sie_page = container_of(sie_block, struct sie_page, sie_block);
>  	mcck_backup = &sie_page->mcck_info;
>  	mcck_backup->mcic = get_lowcore()->mcck_interruption_code &
> -				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
> +			~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK);
>  	mcck_backup->ext_damage_code = get_lowcore()->external_damage_code;
>  	mcck_backup->failing_storage_address = get_lowcore()->failing_storage_address;
>  }
> @@ -357,7 +357,7 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
>  #define ED_STP_ISLAND	6	/* External damage STP island check */
>  #define ED_STP_SYNC	7	/* External damage STP sync check */
>  
> -#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE)
> +#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK)

So what you proposed in the cover-letter is to change the above to:

	mcck_backup->mcic = get_lowcore()->mcck_interruption_code & ~MCCK_CODE_NO_GUEST;

Right? Yes, pleae do that! And this can also go via kvm.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
