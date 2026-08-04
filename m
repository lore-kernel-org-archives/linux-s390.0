Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492483AAF69
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845373; cv=none; b=bR687VoxV+aX0AqjtoEjyuVO6eqxJ02PA/YHdX24a+AUAWxr87drM/OLh4oFrgH0UfE+o2n6wnAuGxOyDYl24yZrtGZPZmLtx3+Fktmoqmc7/6zHy/u25GiRBGLCRTa3C36FqAi6bDkdGw70aet7vb3RiK276CryVha12zHUvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845373; c=relaxed/simple;
	bh=9i9kvBHv8MSrjXJprL0ZRJUeU6GYBbxDGMw6oHevf7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foxxmnFQiveR63Orcemt+S85yHT+5u9H2m+XrRGC1GxchbgWfIgNzQ1sTi+3kscPhWKJ2S8F/uTCgv8lEnNza331gFajVuymILHBaK3v6XbT/OiNW0Aenc0plL6z4bdaVki51NxLuKIGhietVKOpH8b6ZVcPfMVaePESu56PmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f/UUTWZN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f/UUTWZN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HwDo296421
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 12:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XgcJDKncoySsEVgnHRetH39XFTrVQ8
	/a/0Mu0N1ET/g=; b=f/UUTWZNfpZW5FPsn4UK2H693YzXE7j1hpwL2q3mOHb+go
	M/xGrfqij76I1hiLTOq27AFDUIhNhydsjiEqwLMANCuXA02MsCWI53ExDeLXeSgQ
	cwcsDO0/j9sQHgKpbdOJeaG5guv+wZDpi4LNqzKG3SCTvFcHlYHJt55RIFh4n1xV
	8GkewhvKVcPdSFPmc/V2O0pv1rpvYof9Pyod1INm8e54dDdxGeOa+m/FqPY30ERu
	Sh24l8A76MTMNdiTZjbWiwbBguBqM/D9J0zPuHnNeThsit/V7ReEeUSgeiSQZV/P
	ySEnCGF8yEGbDdOijuprJoTOz5jKOrmpxiuuPSdA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3wpw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 12:09:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674BuuWl031021
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 12:09:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k1u24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 12:09:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674C9NRM28901780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 12:09:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D141E2004E;
	Tue,  4 Aug 2026 12:09:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 932BE20043;
	Tue,  4 Aug 2026 12:09:23 +0000 (GMT)
Received: from osiris (unknown [9.87.143.152])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 12:09:23 +0000 (GMT)
Date: Tue, 4 Aug 2026 14:09:22 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        freude@linux.ibm.com
Subject: Re: [PATCH v1 1/1] s390/ap: Fix MAPML computation
Message-ID: <20260804120922.12261A2a-hca@linux.ibm.com>
References: <20260804105811.17744-1-fcallies@linux.ibm.com>
 <20260804105811.17744-2-fcallies@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804105811.17744-2-fcallies@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a71d679 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=DaNe_YizA6IbIVO5ObkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: s1ASm1-_yR1H2toItPQ6Kw21xoHz0VgK
X-Proofpoint-GUID: s1ASm1-_yR1H2toItPQ6Kw21xoHz0VgK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX9SBuxCGEOiYZ
 hdYb2I4f9X5W1lEJdOpsfwN8w+quwZBIfTornN4u/WDAzTfsf3kNUN0nfwXHOGg0iQAbHc7E9kK
 ygKNZnCtbPHE6jac9IggSr/y26E5Heg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX0K+JunvSNdCf
 gdjAzq8ctmKpHlqj1AaG9rNnkNcs5T5sf19EstSvcE1ix+Bp2JPcXhAtVXYed/v/2du1AibM9ZF
 fqSPHwILiDuVpU8jMk/oEl9RA/SwB7hCwE9WGGY657/DXpkdYKg2Is3Dcq3lcaM2pEz1hJCQRo+
 naVrScziOyjSWm22TThpylUtBsPpoQWD7xf37l2U7S0CdT5P9toIy65vpic7A0CWM+LdmkMdOLw
 JORvhbqWZv5/rG8HECSK/hrNSun4Fh4PU+jjXmzseNqfE1xIw31WIsm2fPccJqSkTCtyOTKuG3h
 QuJaAN3vpPAm8sZvimwAiXYTmhgTT4P94G805s9UOtlT39qnUbFAel4gcT5u7SQit9NI9jzUUqR
 1CBTp5PTuF10piyJkm6wuEQLAGJ0bdgnYSRlOzhgdQJEt5XyHG9uI5c8nyK5stirH1ZhFo8j41X
 deqS0vyaZCdlmitVmUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040094

On Tue, Aug 04, 2026 at 12:58:11PM +0200, Finn Callies wrote:
> When the TAPQ subfunction of PQAP returns a value between 0 and 3 in the
> ml field the Principles of Operation states that the MAPML size is to be
> 12k bytes.

What is "MAPML"?

> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why is this fix required? What does this fix?
Are there user observable bugs fixed with this?
If so, which ones?
Is a Fixes: and/or stable tag required?
