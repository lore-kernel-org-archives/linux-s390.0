Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B743DC85B
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295498; cv=none; b=oeBDNW1gKbfSszM0lRGTDUCgHuxMnkuSpUzryhGlda3Wm5b6ZtJQGK8qF4ZzksJdE22U8kfQwfXdurS6/Wba8XxFIPgYx1gDj5SXKCCYuY3+sZ6PHhyEgD0qc2RGCqEOQL3eHArr/kO/v2UZsZ0V1Aa/aJ4Jiv60dyWXfBkXOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295498; c=relaxed/simple;
	bh=K0lG9yrqAi33H7TaIbfqshtzVH/Z5qzpEDm15/ihNPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uagH/bP96+tguP8ksHoDNFsjgm113oOLCM6vQ8Loysy92mg93PpyEZszBarEXMIdpf3x0vLp1AG+nA1YQmuLsKsoeCduny6W4m+qyx+nYrtdp/7ZkuZnQ/ZGXssl0l569a5/tVbd2kHBseq3cLnOSlHQGkizMavuL75bD3etFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tTDAkzTZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tTDAkzTZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696DZRRc2651155
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=t1OpUakN+gnQ5ijYu7/YHo9M/gp3QJ
	NlieCvMKYC2io=; b=tTDAkzTZnQVwBtvXjRdz2Ky9h7C8t/tDkqY5xqFcNAOV+0
	JG30I5pivRGUq4tuxckNk9A4L2b5rdMSr7JOgYmuA60+nUtaaAicFbD1TW6x8JNS
	0Ons/F0Qn4ZrWNMJmXjlXIrBa3/8vuUHpSeF5NLQbv+67n6GMS/OrToXdLkcA+CO
	Fyfm1z/ohVFqBcrl54PICly52rsiL8yneEyC15uXvrDlz1pX8FDCQsJg5leQyf+i
	vDdg8sNaWWiKmDDBMzb0PpyE/SqnzeNp/XU2XTtEV496R42zGI0tzgV5h14fnCrr
	2qBwk8ptaPQwplrVbGx6H+ZbL5gfhEi6Pt88YaNg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fykmw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:04:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696DlXY1355032
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:04:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvt9x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:04:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696E4nSB56557974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:04:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF4EE2004F;
	Tue,  6 Oct 2026 14:04:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8671120063;
	Tue,  6 Oct 2026 14:04:49 +0000 (GMT)
Received: from osiris (unknown [9.111.2.28])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 14:04:49 +0000 (GMT)
Date: Tue, 6 Oct 2026 16:04:48 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jan Polensky <japo@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 0/2] s390/cpum_cf: Check session cpu mask during hotplug
Message-ID: <20261006140448.17402F87-hca@linux.ibm.com>
References: <20261006111304.4023017-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006111304.4023017-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac50007 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=DXTpHQnePCYUjPM-eFMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX371CxI+DWwvX
 7tnr7lG58VvCn2nV+JnpgA61HAmGME0itQ2H5ZX+xyAP3cmzoKhRlIFJKCC5J9DCL86lMU4+sbd
 M69Wltvztt3B5vh82tGhYO96Lr8dz3Xdn9UUwttPJ2+dwvF399ohYzx2KV17XF8e5oG9RBQ/XEf
 riSNC+QIWSilWruAB8IVwavqxahGRUMN8mp0BPvKTyVVMy7tXsp1CUqmmk7Y4gDsLLT4hHP5+VW
 z73HHR/78FrHhCLXjwaoY2fVDBSVhBKY+FqrkWMG42becl6/JtBmkzbAcxPrK8MzNoGfEgA3m9k
 s60EdnBbHi06WQHLr0IqpdG0pCKdib/ZlI0bS8i01YQqm4KZfdJl2b4VhjVfEjbNM1LRSiDXirz
 g2F7Zt5EqPv4lE33RM3VqMXyTg2eFQQu6ri7OwWokmzb5LfUFeyCWKhjed69LxT7IoDfQvnOWSt
 kz98k0tTVUQZZbm4O8A==
X-Proofpoint-GUID: 0KN_yjIY1JPBLwqZgoHe4hPy-wcmFDJg
X-Proofpoint-ORIG-GUID: 0KN_yjIY1JPBLwqZgoHe4hPy-wcmFDJg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX0hSbTI1mEl5z
 gxcAHzFN4qgzHHuo6OLgxpqTLKcdTGuibdgA5mqKtMwtplSDiJg9gkj4NX5D//EtpXLw18962mh
 ZW1/gP0HhPCJ55dbQ/qR+e42fm+zoK8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060054

On Tue, Oct 06, 2026 at 01:13:02PM +0200, Sumanth Korikkar wrote:
> The cpu hotplug callbacks start and stop counter sets for every active
> hwctr session without checking the session cpu mask. This causes a
> reference count underflow when an unrelated cpu goes offline, and
> silently adds cpus to a session when they come online.
> 
> Patch 1 fixes the reference count underflow in cfset_offline_cpu() and
> is suitable for stable kernels. It does not change the online behavior,
> so no matching lshwc change is required.
> 
> Patch 2 extends the mask check to cfset_online_cpu() and keeps the
> userspace provided cpu mask unchanged across hotplug events. It requires
> a matching lshwc change and is therefore kept separate from patch 1.
> 
> Sumanth Korikkar (2):
>   s390/cpum_cf: Check session mask before cpu offline
>   s390/cpum_cf: Honor hwctr session cpu mask during hotplug
> 
>  arch/s390/kernel/perf_cpum_cf.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Series applied. Thanks!
