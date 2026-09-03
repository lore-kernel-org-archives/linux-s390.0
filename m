Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9F50AC0C
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464018; cv=none; b=bkAGFffDOi0BhaiE8JAQoc2QWx+7poSALxWUE1RESzd4ZMjPLR48fF+JskR2B+YWGnHUdSiFXIB7nYhkxW909pL9HZNyoNDiamSkgEUUGdIVbo9JroGRoUFJ1oDw03wepcdAT0HKbH1KB9GJBJcHaV8Zelv4Gb3meO0fCw1T61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464018; c=relaxed/simple;
	bh=0APDkVz7iIFYA6JzBEdWClKZUxguXcw4Qk88DC4YfpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNZmicjsUz1zHiMMbxzZn0YxldKS1tePNiv5Irl4UuylJVAsZKBdH2Q+t6AIProXdYSbvGRo9LEM61b69LoNaRXEnyUTOXPgGpjgVeMSdURBEzKaNiUCyzVXKLqQougSDXEEDGxLFcv4FGoW88z3/aLDe8VVRgqJuA/k4M4tulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CkiF2lAb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CkiF2lAb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G2mUg3425647
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 19:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jq3qCL0mh7Iz31I2d594BRli8uqNZJ
	i7fHm49iat5eM=; b=CkiF2lAb+zFCL8D7WadMdvSZs1IeJcM7xiNaSV89B7vEei
	Ah/6dwYK0xd+x689EEpK2kGoCHGoq5Xl9lBLBi70/Qpx6OWCUMHTFaRabFOj2Hhy
	fncV56GKprM2yrIFsN/R1iJCQ2/4cjtQgazyxWMupsdAJI/S9FX8dBVIe78xlsdL
	tyXwR5Np1Dk6n9EWHpX2m0JbRHibgIDEI8vR4FxPs3ZnMpDd4L2/qZD+mZuprQqk
	bWPEQT0uyevKu+akldZwRGr2ncnPOT7ckOo8DV+1KnHKGGnwTVWI94xlUe72r24p
	fTWx5Wdg0/U6qD1uTl6v62gWrAD5tHUvsjbIozAA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5xqj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 19:33:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683JQGIP015216
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 19:33:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hs5ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 19:33:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683JXIEB47645018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 19:33:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B395F20043;
	Thu,  3 Sep 2026 19:33:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72C3120040;
	Thu,  3 Sep 2026 19:33:18 +0000 (GMT)
Received: from osiris (unknown [9.87.144.233])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  3 Sep 2026 19:33:18 +0000 (GMT)
Date: Thu, 3 Sep 2026 21:33:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] s390/debug: Fix several s390dbf issues reported
 by AI scan
Message-ID: <20260903193316.12158C50-hca@linux.ibm.com>
References: <20260903130733.709001-1-zaslonko@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903130733.709001-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a99cb83 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=rN-HmBqhx0egcxoRvvMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Ots6Wh2h_-Y1QjY90ckks3gd6zr3L4Fz
X-Proofpoint-ORIG-GUID: Ots6Wh2h_-Y1QjY90ckks3gd6zr3L4Fz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX3JInCyKhK0Dy
 paZW1Dy5A0O0oQR6x/4IMPTzRj4cQfUBFLCuDWVpuBhUPX3v+gKyR65CUGWd+ePoeHsLPXeL2ah
 Qpbo0f2EKhPtXhL3Od5exlvAVrwDqxE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX+ozaQttpQO4P
 PyPmgMiL1NBp3bwclKc/EM1zXAylDRzMEZzeU/YLyr979XQSNM28RsRCUYdHsfsvzQEcuL5M0Mr
 AE6u08k6RMrF14IS1n4zcHLPxadpXjPcm8Vhj0hSS0z4tlubJxxXXu6H5qhAalXRSh4+z64ZxL7
 6GMcaRujG5JgT2a2lNTnsVL138eMFFLNLRuLeclkKN3b/vNbykDdrqF9Jng3npB6+B0tqfOW9RW
 815vV7d4C0ziVUxQkGj7lLh1wkkzQc9PobyEkr4FgtNMayn+QFPdPvLcrtNJ5MRoq+u7eVauKUj
 RCP5Zt0w7tb0jCYR/ru0d5EVv10W7+i1IRpgbXrKL30yJQ5cWaJ8umXSKM+FPVwkAOvkbYhfUIh
 eS8WvD4EMtR4zMLLjX+lZ3l4caokaUvYr8IEggxeZx6DerFXBweO0WwLMJJ86zu0Hqn1m75w+zj
 BFox8gjNBTdn+FohZhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030170

On Thu, Sep 03, 2026 at 03:07:30PM +0200, Mikhail Zaslonko wrote:
> The s390dbf kernel parameter was added in commit a2cec6863709
> ("s390/debug: Add s390dbf kernel parameter"). This series fixes
> three issues found in the surrounding code.
...
> Mikhail Zaslonko (3):
>   s390/debug: Fix NULL pointer dereference in debug_set_level()
>   s390/debug: Do not repeat parameter override notice on
>     debug_set_level()
>   s390/debug: Fix race between debug area resize and event logging
> 
>  arch/s390/kernel/debug.c | 54 ++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 18 deletions(-)

Applied, thanks!
