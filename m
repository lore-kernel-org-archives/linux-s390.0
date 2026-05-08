Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43688378D95;
	Fri,  8 May 2026 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236088; cv=none; b=WI70FnOBy26agFgoDejfQPY/MbIB6fWBvgUlznG1mN5zyZkhq+lxp1raTn0NV0IkxLQp17D0EBJV/hNCzqdYsvXiTx8aKaovmPDzEwzmhMJyY4MLpR60iBwTy1Lb+2kcf9b/BoJX7KHwJIBZkMgMc377Vmj1Zdw5MyrVnGhZg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236088; c=relaxed/simple;
	bh=t1hzmM3jCB9miqFA0IDt8hPEmgku6h236SJop9q36No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeaTYZyAgM5+0RtLJaaYkkpVa8gOOB6PubvptVH/nS29zdDwprdpQQyG42qqTVJg/2dqrh+NXW8nkNJwB82yvW7lcSZymTExPqwd8dVeVtj4Ym3bvQ/yWlFRTci4sHJGgvlCJK4z5HvxIbWIpp8gjMDikuPe4sJMIOPbsH13OhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f/mAB+c/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f/mAB+c/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647LD2hv2498184;
	Fri, 8 May 2026 10:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wMJ0/jkUILTuBwnfwHXBDz7TGOJB31
	qs1SBfxSo9b8o=; b=f/mAB+c/9ZZ2p1LUoRRqz84RCz2osdYG0BrlTkwAeNQN2t
	uP/LSrcBrLdddqWgbbySaoLHYk2G0g9CvHRoNAZOcpIfdfGIvmKixpfnYEMYRkYJ
	A3UU8qvi7AI8RD11SXgHVNxrT/sMgxAQScny2wVYetxiJPPjsb5Zr51i4boSZ3Kn
	YKMxbeMkGE+ihJEXMswzxL5HpEKX7SAfpeiosWssXpEOkNAP75S5VfKpeNfCvnrZ
	c1FbC4g3gtBR472+DZcBA8BKI8kwoKg3pyTgaM4YWPrzQ6YC4s7SzcTVb8T0Kfng
	o2pKMYWjMPA830U7QueHWMSpsCgsZBxrnBbJIxWQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1u5pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:27:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648AOVV3009419;
	Fri, 8 May 2026 10:27:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgqkgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:27:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648ARpe713762856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 10:27:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4FBB20043;
	Fri,  8 May 2026 10:27:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28F042004B;
	Fri,  8 May 2026 10:27:50 +0000 (GMT)
Received: from osiris (unknown [9.87.147.123])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 May 2026 10:27:50 +0000 (GMT)
Date: Fri, 8 May 2026 12:27:48 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Douglas Freimuth <freimuth@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/4] KVM: s390: Change the fi->lock to a raw_spinlock
 for RT case
Message-ID: <20260508102748.21624A65-hca@linux.ibm.com>
References: <20260505173728.160562-1-freimuth@linux.ibm.com>
 <20260505173728.160562-4-freimuth@linux.ibm.com>
 <20260506045734.11230A02-hca@linux.ibm.com>
 <d39c54bc-1984-490c-9457-5eff63edef56@linux.ibm.com>
 <20260507095630.10395Aa0-hca@linux.ibm.com>
 <191a1272-1f8c-4a67-a01d-abfdb89fcaf5@linux.ibm.com>
 <20260507144549.10395C64-hca@linux.ibm.com>
 <a2a8205a-18b0-46d2-8334-c59d08bad61e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a8205a-18b0-46d2-8334-c59d08bad61e@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NEZ2joHhWGGGb8TqKABxmfmWpUkvu3Av
X-Proofpoint-GUID: NEZ2joHhWGGGb8TqKABxmfmWpUkvu3Av
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNCBTYWx0ZWRfXyhr2sS3La7pl
 MfLeg3Y3fyV6575zJMnen3vllOVioL6YY+4g2sOsXY1HG8IhoNt8RXtzBfB/qYRRxr7OX3gMVRL
 mQL5ho/VPke07So08wMQvwRdIDWYLUGtfWOvM38hzEtTfgm9OvglY9jtmXGtbwBPHbofNJwgRV1
 KzoiO8phOZoZ4cy2PrnaeeqrSo1OtZHXZR/1MXrFCIE7ukP7ifzQws9RP2RLDT9fhw+f8SzCksf
 B5BU4lukhs/kzbZlYnw9RfUh3WrhSzgl1bAiP9p1HHIfNo8yZzAPbk7kdRbiyCu8msjnUrxRZYO
 RpodS2Y4+GYXSJx4LQk3yrKgE4eF/Q6rurj/hTcj22WRRVVxpZaDIOPi56zLAvkOEV8Kn0jhTIg
 5qLo4zgsW/gjXPtlILy/i5ZjGO69eZukZEjaQnsUdB201KlzlPZ+azCKH8v6YRQKzt2NxYgtYsB
 umz0krHzF7secR43zrA==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fdbaab cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=PwENQrBhXHabj0ayDJEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080104

On Thu, May 07, 2026 at 10:46:44PM -0400, Douglas Freimuth wrote:
> > Rationale: even though it is not relevant for s390, we also change common
> > code; and by ignoring PROVE_RAW_LOCK_NESTING we might cause problems for
> > other architectures by introducing incorrect nesting of locks in common
> > code. So yes, your thinking is correct.
> 
> Heiko, to be complete, I went through the exercise of enabling
> PROVE_RAW_LOCK_NESTING. I created a small hack to generate a
> __deliver_machine_check to trap the nested locking issue. The requested
> splat is below. Here the floating interrupt lock is a raw_spin_lock and the
> nested call to local interrupt lock is a spin_lock thus the nesting issue.
> No other nesting issues were found.
> 
> Now we need to arrive at, do we keep the raw_spin_locks to cover the
> possibility of future RT support or common code? In that case I also make
> the li->lock a raw_spin_lock. OR should I drop this raw_spin_lock patch and
> back out any other raw_spin_locks since we dont currently support RT on
> s390? And end either choice by testing again with PROVE_RAW_LOCK_NESTING.

Doug, we are going to enable PROVE_RAW_LOCK_NESTING in our debug_defconfig for
the reasons I tried to outline above.

Or in other words: you need to convert li->lock too, since we want our code in
a way that it doesn't trigger any lockdep splats, regardless if s390 will or
will not support RT.
