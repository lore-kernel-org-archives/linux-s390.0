Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0493430CD4;
	Tue, 28 Jul 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240376; cv=none; b=fbLUXAlHgliFNmXqjSeqmF4moKnGm8nLY5pANq4fOFeZV7hYZISyrTpx+pCCNSWlQ5iEXzSdRoXDiSjNnhq5YkByGSE8QPTvguDKhUHgTu1tVpemxq+FUSqw186cPUcC2rMtEPZxtyx7K1KqdwlM9uqGsebbqg0wWIjVFFdFU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240376; c=relaxed/simple;
	bh=p8dc1w/LvrLf0/T1cnXyGaiMKWrDz6+qUGGLJx+spgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IroD8NUejUUDx0JemuwxE5f8bwgBB4DP8QfpxY2z3cqhcGrUpjedSl7OpAAnh/J3xyCYZdy0MeKHB6BqEMOWSH/b18N0ovqlDdW7FrkjThLJmPAOsq0OUvpSf4EtLBF3maFdZIBoFEMHIyV/OlEmprToQ9lZn+7kxAFvhVnlWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QDeeFRWw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QDeeFRWw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBI6Cu852634;
	Tue, 28 Jul 2026 12:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ozAkP+IH3spFzVNw2CaGxpCYcRg3ds
	OBWUBBP9KtCC0=; b=QDeeFRWwcP+2Wh7PmkrtYQiYEhfoUIyeHDLPJbva/h/z/y
	o793Otpd+ppscuP70FP7r8rVGa+memFru5jmA/wwrnGWr4PhdKmdh0s5HfKiv0wT
	9m24pjHVc8mc78ZO3qLXpfNNk5kGgA7J+6/YQPM/61xtKAdXopn+U5eJK3NvuDE+
	Zp+8cxISwJHSoRz+si1PhkaddObtNwSGA+rZ+9gaIaYn8aRqJbXe9m9QcHHXqdSp
	vdBh9Cq5sS22DM16GzSDi93zM1aJnxJE6Lmvpe+wEByEj/EzmhBtynqasNS63k7v
	X3l600RDqosuTnimpZBsel/RilGFX9c/P/69Mnbg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj4dwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 12:06:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SBuFg5018488;
	Tue, 28 Jul 2026 12:06:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg9f8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 12:06:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SC63dA34668988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 12:06:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76C6B20043;
	Tue, 28 Jul 2026 12:06:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F03F620040;
	Tue, 28 Jul 2026 12:06:02 +0000 (GMT)
Received: from osiris (unknown [9.87.141.62])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jul 2026 12:06:02 +0000 (GMT)
Date: Tue, 28 Jul 2026 14:06:01 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] s390/crypto: Replace cond_resched() with schedule()
Message-ID: <20260728120601.16874Adc-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-2-hca@linux.ibm.com>
 <f88846b24b1250f89b503b6ddfda318c@linux.ibm.com>
 <20260728082948.13361Ab7-hca@linux.ibm.com>
 <09e9a0f4-48c7-4e63-a6f3-dae61c1f94e1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e9a0f4-48c7-4e63-a6f3-dae61c1f94e1@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEwNCBTYWx0ZWRfXxIX64NF2U5YI
 ayXxFKbVh/crEefIMHp2CDm5YzFTZi9pOM+03ZQr62fqyWpz0hS3rzJx9STRwGhJ2vrIk5qNjqn
 5xf5K2OiK4f4FJtdXJnrJmujcHZ7H9I=
X-Proofpoint-GUID: GuIypXCHLib1U4HWKz3qHUnTw_3Ww0qi
X-Proofpoint-ORIG-GUID: GuIypXCHLib1U4HWKz3qHUnTw_3Ww0qi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEwNCBTYWx0ZWRfXz3mfNcgsIA7A
 sMKZQGu0Qqe6Ba1pHjz1MYQqO6GwMEFn3/tClvuWKuEEdWvRrWjK6mQDeOCQgZ3do/9HH8ebXJ/
 EslLOp7INNjMnxSdYGuUB6bSp/9iMXMkL8dVAPTkPWwqNMf8m+tF0eB/bk0xzrzAEuR5Wv+j9zJ
 3GIhX4+UtlZHU13t9i9J3Lf5Ehna3paFQOWMMiI1BN+InHhXFuwCiZJvTuoEeJSL4qwxVHV5w1/
 Q85ZTn3McliLm+Ic/xx+36B2EkjVPahuvcr6L1pgaHx+E8v/wqaX5D037ZUmNowY1685EyYt/nx
 SpC3+Zuzebzkb9UDDn3LdCvpQjIYC0i5cmmprSlK6jefrpHd1e1Pz6TMUY4Cu0rsnGUg4jTxh7F
 L9LqYkf7lNCU3cEGqN/mN3TxUmY0BZYHHO2iwwg2hnfi4HIT8M22reWUW3kpuAwcio+Z1ebcNc1
 /0DoTM+6/7/9qnL4iIQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a689b30 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=-ysk5xASyYTtaF61dkEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280104

On Tue, Jul 28, 2026 at 11:51:04AM +0200, Holger Dengler wrote:
> On 7/28/26 10:29, Heiko Carstens wrote:
> > Well, the main question still remains: why did the code use cond_resched()?
> > 
> > This doesn't make sense to me, at least when reading the comment. So to me
> > even the schedule() approach I proposed is questionable. Why didn't the code
> > use msleep() instead? Or can we just remove cond_resched() entirely without
> > any replacement?
> 
> As the comment says, if possible, the scheduler should run any other
> workload in case of a -EKEYEXPIRED, as the re-creation of the protected key
> is in progress.
> 
> My current understanding was (and still is), that cond_resched() (or even
> schedule()) is doing exactly that: give back the control to the scheduler.

This is not the case, and never was (maybe it was for schedule() before CFS,
but that's history). See also Peter's reply.

> If this is not the case, but msleep() is doing the trick, I would vote for
> msleep().

Ok, then I change cond_resched() to msleep(1).
