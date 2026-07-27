Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E636A341;
	Mon, 27 Jul 2026 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161840; cv=none; b=Vnrq0eDdq4J5v1l/OJCPOP3K1b3vS2SHcG/AGWnDlh4ynFzkvE1gfaWSAN33SOkqqBbgCLWOd6B5xMc+FpAnr6dL0sn/xWU6xGc34Z90ZTj92nv4IBmQQUBS6jHS2weX59cf9yt6gFGMUWY4PMIvAP33FKrhh//J4fvve7ULk2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161840; c=relaxed/simple;
	bh=W0LDqCKA179puVTQiKIqtNzvTFEEQSbPg55/HvmXFT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWB5mqCmFD7y/1ggvSYzaJ8xOrDn1DOiax+ba2qwgD4hUcci3ioDC853L4TjV/l3/ed1BFbymj4KTWJr2o6gAwk9ktyq42D/JAf3XLxPGkSExQvtzZqqSHh6yNWKKP1IV7K//SX8s81daOD1pah/j0iNMC32XlK0S0dTAYb2n3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kI5tk6Xb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kI5tk6Xb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnD4Q2291893;
	Mon, 27 Jul 2026 14:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FvFzWMfRLP+PxVN7zAgIg/nKJWi907
	i0oZ9/ENeqpA0=; b=kI5tk6XbtF1oDWm1Nv0ncKPi54rcgN5499BpStgpxjsdPd
	n44xfP/3G2RlW7os9WKFGmtxYf8rAONqJnWFwknn3SuZOSZVyNCInt0Kd8vaBk7e
	axCASKuHx4ZDwyMEMjLGCYssIXo2Eu4TQ9XjSE9EJ1qs0BScs8NvpluHQTV9v81A
	uYlNJbtHQVm/E/S6i7UNZVwEDrZWIQ6yvqwNyVsnSWejC9O8i0yfVEiPpGxYFnJv
	iduTC486B00e9ctAQQOSMxXrZQENwY2C1xqx5PMrh4yAHvPA0bMfcLMhI2hEi1X7
	rEw4g5m+8QAYjSBsatScSPAEHmosdnoUpvyoITmQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ng0cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:17:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REBEMY020472;
	Mon, 27 Jul 2026 14:17:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xwdw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:17:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66REGwgX30540240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:16:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E57452011C;
	Mon, 27 Jul 2026 13:52:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 316462011B;
	Mon, 27 Jul 2026 13:52:31 +0000 (GMT)
Received: from osiris (unknown [9.111.92.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Jul 2026 13:52:31 +0000 (GMT)
Date: Mon, 27 Jul 2026 15:52:29 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, llvm@lists.linux.dev,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] s390/Kconfig: Select ARCH_SUPPORTS_CFI
Message-ID: <20260727135229.11274A39-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
 <20260724141318.1037434-6-hca@linux.ibm.com>
 <20260725010004.GA1686739@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725010004.GA1686739@ax162>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfXybABj6qeuKlq
 shpLduYRncpd2UDnOjgFrADssQ01ntj3sIQNao7HJyYKjPSF2/KJFtFdxwkhIm/nTN+B6Iz5Xt5
 eGrLSZTrtZ97u92pbyAuA4jR1WP/rA8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX/xmonw2aZNvm
 sWViXLldaOrWPftEAlEa1UxHcnVk1skOzfGuxSSKAcPS8v4Y3RcwEm7PgD3vngC/1q9xYjW87RM
 jHkI9lETLEBuPVVNI7PgSrePCv4w8oggHJiUScCXg4Yjwl8YZtMcIImn2cFHdTV6GOuoaO3un57
 ozYUJiiiQiRIq3S0uG8O5SKlvZPexBeSJ6w/mC2wZp/F9ty87QRqgQseEeREsZKutxnSSiZqbMN
 nzGKYnJuZ+aY1zbI4wXeKx7Yx34Lcaj1Tbp+hgqgLcaG3toBHmpKo79ynmSWkbcbhQFevyGAX9E
 Cgh95LNUo+ZiWmEva+IDYITwR7RiRtOkTGiUHCbbfn44V3hs5dI31EIFD3rkzB67iFkmigixGd4
 M48phmsXV2dnVmgC4BGwPcfGgiVHrd881cbUw8w9fqgBMxDeBtoceBI5+F6/4/0VbxpF6bh9y6g
 SeJweFeE927OAqcNxZw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a67685f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=QUYGkz1GEY4_jyd1gQUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: vMhr7Ox03rhvdv6QrXTkbcxHn9IpPdex
X-Proofpoint-ORIG-GUID: nuXJq4p0HBEtzkdiDKBObrq_O90kCWkP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270132

On Fri, Jul 24, 2026 at 06:00:04PM -0700, Nathan Chancellor wrote:
> Hi Heiko,
> 
> On Fri, Jul 24, 2026 at 04:13:17PM +0200, Heiko Carstens wrote:
> > With all prerequisites in place select ARCH_SUPPORTS_CFI.
> > 
> > Note that this support is supposed to work with the generic kcfi support
> > which is provided by clang. This comes with a couple of limitations:
> 
> Consider adding
> 
>   select ARCH_USES_CFI_GENERIC_LLVM_PASS if CC_IS_CLANG
> 
> to this change in case there are problems such as the one worked around
> by commit c57f5fee54df ("libeth: xdp: Disable generic kCFI pass for
> libeth_xdp_tx_xmit_bulk()"). Whenever clang grows an s390 backend
> expansion for kCFI, that can be version gated pretty easily.

Thanks, I'll add that.

> I will test this series fully next week.

Highly appreciated!

I'm going to send a v2 soon, which addresses your feedback, and
hopefully all AI findings too.
