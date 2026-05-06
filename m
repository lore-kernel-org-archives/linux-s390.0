Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338F78F2E;
	Wed,  6 May 2026 04:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778043464; cv=none; b=FjEVk0HG+gQiHwYV4SBKiAVk0vAs3jzO7dYHzUZJnZL7Dbu+ozBAo/zlUJsgVgSgWnUKa70/xsX/lxQ2nrPX2aXQC4hMitvJIrmKAgNTk6chpBh8fySDRoJNcq9LcHuexiAuaZM0MWrcY+PdGkXVWjlnyYPBjp+Q2DChevO4Rm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778043464; c=relaxed/simple;
	bh=juU0I79it44AO2vpgUR6yrH4LZfYtlHzQZ6EFxh5C3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUbu/O2WTTtA/SVlwPVYwSswma2zXnjJy0QjyXkcHWw+EpvZGufo7jmdZHv54kpsKLTaNzIgN65LzBVE5rd7vJB5Nrj/VQy6u6bOenqI8/wJ3md2iOyAuyP/sBX3faEHP3fASUUAc1Rv/6Zn2n6RqV7BHGlZoSTCcXQz8JaFCig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y2VmOlwp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y2VmOlwp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645E64Cv1944676;
	Wed, 6 May 2026 04:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vaYk4sjlQ9z1mrbToKyoqOJSMnirYT
	WmjGrMSCZ4jpg=; b=Y2VmOlwpLWjQd2GhB7cCjWv56JxqGWskMDupopU1z6VwQ6
	DcY5UqiCTiKwYsml3nuFoYjK4RGho2GvFtG9bb8pa1OQ4/RP4KpyWVUpHkioap9S
	0YFnuncZr3uf/jGEKE1xm4hDXKyYdFVONOIcjZkIcZoQh5mFzaHeG4yG/OPDGxV6
	vhzJ371BJRwUHqqm6ZeTul8mbOQCPkBJbVCK/VWVzpnaDni+gyvQDCUoR6cDqlfZ
	Kw6iE+0Q8+a4tjyR/7QOuYbSA4lXoBLX8KfPPdJvOPihRpHSnNpa7eyAD6zQA1oo
	Rh2XM+nJ2IXGVuFGGwiQcgmdOBcJTCKAJp8H2bkQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6ee59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 04:57:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6464sR5l028819;
	Wed, 6 May 2026 04:57:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h4nhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 04:57:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6464vZdh15991152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 04:57:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B2452004B;
	Wed,  6 May 2026 04:57:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 470BA20040;
	Wed,  6 May 2026 04:57:35 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 May 2026 04:57:35 +0000 (GMT)
Date: Wed, 6 May 2026 06:57:34 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Douglas Freimuth <freimuth@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v5 3/4] KVM: s390: Change the fi->lock to a raw_spinlock
 for RT case
Message-ID: <20260506045734.11230A02-hca@linux.ibm.com>
References: <20260505173728.160562-1-freimuth@linux.ibm.com>
 <20260505173728.160562-4-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505173728.160562-4-freimuth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69faca43 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ymQ7mPXCrkQ1VZPLqxAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: BAzQ6tc44Eh1GnTEB_l6ma4PFz7LKN-1
X-Proofpoint-GUID: BAzQ6tc44Eh1GnTEB_l6ma4PFz7LKN-1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA0MiBTYWx0ZWRfX/B4iAH6fWS6N
 lbg7tkDc7dBOflX9YE/SgWnwEfJ/XcXnVjf9sBV9dvSm7+cXTpD61wPXAjHDQVS+JQwrdK5nR6T
 E2TcxOoVUA+gXu4t+5g5AeJb0EDX8Pmzc8pFhG3rq1hotXz2u1+nE25NWc3OCKndunx0xWSjE3j
 v51v+frJsvBWLJFrMQuFqGHvvcDUfgjNvhT2oJptfUomtOwLoTaAcS9BDQjhktOp7RwWTJWv6h/
 XRfqJ1lx0hovAyicJUbfIedyORzlyto70rAdW24dXx9HfUawbVdkF6UdYGiTl/Oe23LSdKsMIpB
 zref8gXi58bktQ/5QPyJN3XKG0+KSi2pQyyWI4Snzsmql+Z3rWALyM7yMZqb0FLbQseIMCDbURV
 7Z7bd/pYp20JlyJdKIfmWVvckOO6qbOZ5Y4aX8I6pMXX6CAlECMSAMXije+yFFZA92S66NrV7t5
 DDB+DnQXlevP+JF7YNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060042

On Tue, May 05, 2026 at 07:37:27PM +0200, Douglas Freimuth wrote:
> s390 needs to maintain support for an RT kernel. This requires the
> floating interrupt lock, fi->lock to be changed to a raw spin lock 
> since the fi->lock maybe called with interrupts disabled in __inject_io.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  2 +-
>  arch/s390/kvm/intercept.c        |  4 +-
>  arch/s390/kvm/interrupt.c        | 68 ++++++++++++++++----------------
>  arch/s390/kvm/kvm-s390.c         |  2 +-
>  4 files changed, 38 insertions(+), 38 deletions(-)

s390 does not support RT, but I guess you are referring to a lockdep splat
which you would see without doing this change, similar like we have seen at
other places.

Can you include the relevant parts of the splat for reference, please?
