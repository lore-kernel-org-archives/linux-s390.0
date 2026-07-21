Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95FF3C063A;
	Tue, 21 Jul 2026 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629729; cv=none; b=rGQ3TJozUPDaqoyl4B6jIzsNc7SQ5N3oeycb7BqewvaByZ0rqFmoG9O8jSwaKH+QXlTbTBhr7A0mP0tN5vZb8FamstGNkLiUFIZDbFccK03BL0u4lPjsS33qA/LrUBmQhz9lGLDlET09ILjTiN8Wbtbl4kDmcVj+W55yG4+1Nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629729; c=relaxed/simple;
	bh=uKbArLOvJ0yoBD2XKCMXEoj4aZzhkpHUSKaB4eSh7tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfPgQvbha8r72X9Ma5KC1mcfreUtJVQj7CgcWnXaZfgLrM+5puFh4U/iiFGFwnzjf4+DsxoqS/Vx6I808RyJIqFTOEt+xBwgdKnUfZXz8A13qD4TMiLObOPi01tjGGDaQxYmKdKEoGCnjWoYeyKvpyXQeqmlyv6oQWqq0E9IC0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qVeEGzS8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qVeEGzS8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDh9n3560330;
	Tue, 21 Jul 2026 10:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4KQ6VOug7KNU+mTEpx2lyl9Nlzs4tV
	I364aNteSdGlE=; b=qVeEGzS8316MgDyGSR0KJiIbCbQOd2Sz+ehTpRnBpk/IEo
	pPghQhv877mCDIarl8y85zYjKKsPFOOX9q2nKtiXX9GZpKSDq6x+qp3aSu3g9JJD
	BWRywT+MhCuWNzh3cMzMl4/7sgDbJ+SybYH9LXkUYugPQ+i7RNzszUgHgy8xcLzG
	JiKrac91e1sbj7UhEs0ARok0tFWUDknj1vLJqNnu8rPn5ldXtSw/CivOVhHXOPoh
	JVrFI6SORL77ZJvAtxwdnouUF0nXrn84iKadXktOCVeHHmjamMxJQcoFVugHyVwV
	zt/YmFch8RdsZFj7kGzGNisQjnoyAXrFN/575KnA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah3npv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 10:28:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LAJcnL022758;
	Tue, 21 Jul 2026 10:28:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah1smf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 10:28:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66LASbE745285642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 10:28:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58AA92004B;
	Tue, 21 Jul 2026 10:28:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CB1D20040;
	Tue, 21 Jul 2026 10:28:37 +0000 (GMT)
Received: from localhost (unknown [9.87.154.205])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Jul 2026 10:28:37 +0000 (GMT)
Date: Tue, 21 Jul 2026 12:28:35 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/maccess: use proper PTE accessors for copying old
 memory
Message-ID: <ttiit3n@ub.hpns>
References: <20260720144734.1003497-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720144734.1003497-1-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UD3gw3hh5fmUSmjawUGgUIEFC2KV6Ue-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX/25WZIgE2h9q
 X35Ts9otS5aSZfkcQfihC0WKxfoYuMfypHyPu4N0FI7kDSOd6y6OeVAFiCJC3tvpn23C/nNhRvh
 ItKvP+nRim0wd95bPaXdBkxbLuC+5VFvYsHWBgoXiCAlg6XX8GUvnmwDKyN2X8NOwrf9uQmWIfY
 79Fh88aKdbFdMj87RZ5R5uE5iqUNc4m3AyE4Z03g5pRw4RfFknMsTaFDvtWKoOQCmDs1l1r5btW
 J+mPbnO+4CidaA9ZCdovKUQh+9lZaMqT8P1URHc7kNupA5SnUjMbGIZ01x8q/U0OPCTJXQkVv6L
 FvbwJmzzYiTtizZ4D3jMPQ0DOo8KMaYhUXWy4fQadNGWyj+gFa7muFwQ4rFD2wG02veeTMf9VyL
 CjtHb9abg8xCkDL5nQ7OSF5Fm3bHYN96qTgHCvjnTNltkRKzJbLHG9u5CvZ6uiH0qJJVeOinEWO
 xhwebwjGW9pmxIpy7nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX7h8PG4MjUXYa
 M+fBBsoGMJ8h5DMyL43qb+EFYl0MNVGe528T9TyEC76KfauZnsJBGw4g1i4U4cg9hU8TfP2wLEE
 O2IwWK/lzl4V7cv5MPUyUUm17evc/a0=
X-Proofpoint-GUID: UD3gw3hh5fmUSmjawUGgUIEFC2KV6Ue-
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5f49d9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=RGM47z_RLjzLivI8PxAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210108

On Mon, Jul 20, 2026 at 04:47:34PM +0200, Alexander Gordeev wrote:
> Follow the pattern established by commit c33c794828f2 ("mm:
> ptep_get() conversion") and use proper PTE accessors instead
> of a direct pointer dereference in memcpy_real_iter().
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/mm/maccess.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thank you!
