Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46E43551D
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132878; cv=none; b=gFz1mF3/NiFCsxO4GH9Jf4Y9jddHQtRdLm76bDLnI+TSiWI16on9459W902ujeKgP3p7McMx1rwKs6lwI++nX1FTThw011NipDLRzf9j2RF1snfGnXZHTuQ8Ea5UsIOVO3OjX+sqISI7sKFYj+sth9ci0BRA4ATcsrS0kxRmb8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132878; c=relaxed/simple;
	bh=cc6TCbfwqYiQA4tSozPzqYOY4RHq0x2Xqxmzp8iKp50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2JVzvzLso014Gb2KDDGMs8UYc3+KzUbZLZ28+VIho4tuin8rTh8kbQczxxAyotpdsUllH7BNb55oYqZRIvFnFzzpFp8hT3IEg8HMGbfVB3tNu9+tTc+N0y35H4RFT4Ki6Wj+rxHcq9F77GOmVmJPn4nMwPcUisihQqsP8KPWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JftqnJVL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JftqnJVL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WFdj2558303
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wjyFmm
	w24FYJ3RamzzBzTmQSMWUjphds1jroUHoh934=; b=JftqnJVLoA6rcHQqyOg7F+
	OLSwNEFB1cg0Z7noIbhAd7Csu/S4mTRA/oNyVcuj6fGN1ucXlXjpkg3i15smWk9P
	oL3UuvX/IYVcAtWSVKl/YucfoCF53XFTuyI4879byreWqR/axGpuZnN+yb3cnZ8N
	eco5KhXrTUJURhbJzVGRUuU8IKMNctxxwhXqEv6ZAVshf/TxJA445eYwesiut5ln
	SmnzA246yVkHaNF4ls1OpspVFAdCGpj75ZNffuUMrFtpgGRsUICFhupAIZFakAEc
	P7eLwW6Bj526ooJVf5HYRAg+DvOFRFyibwQ9FmSXO/lChpRPoLLfejg1b6/aWFpA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu42tva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:47:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9fK9t018087
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:47:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq8d44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:47:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9lnTJ39518654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:47:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A73D2004D;
	Wed, 19 Aug 2026 09:47:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4028120043;
	Wed, 19 Aug 2026 09:47:49 +0000 (GMT)
Received: from [9.111.82.93] (unknown [9.111.82.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:47:49 +0000 (GMT)
Message-ID: <779d7ca1-e15c-4eef-921c-c563fba0cc02@linux.ibm.com>
Date: Wed, 19 Aug 2026 11:47:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] s390/crypto: Fix handling of EBUSY in PAES when
 req is pushed to crypto engine
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-6-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260819091734.7331-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfXxW84FT9x2Gyd
 N1HDrhbu2zlYf6TFzz0U4rdjpToCkUf7Q+E75Fdgo2yPDsEP9Ile71DGolboLqBTndgtKbbwrCe
 AC7li5lC9HcdJVIpA2+nBLqpiQtXlgs=
X-Proofpoint-GUID: VdZ6JHi7yrAapvW-EhMOmgeCFPNqfW9d
X-Proofpoint-ORIG-GUID: VdZ6JHi7yrAapvW-EhMOmgeCFPNqfW9d
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a857bca cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=toKluCks-quyBxXNV50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX0HvMFALvDuhN
 zPtIzXYGvA0S7fo8BLea9g2lEFolBhI0pZmNhJP15qhryN4p9X5limxOGeyIiNd/Rm2JwNGc6ZT
 MWYGzOCAHdxDVRXsdWMIc/MuO6+sN9wQgbXnwewUiAPhb5S0aOC9cyaMcNRDBxc3l/5paCUCoG9
 DS/CBWqoN8JwzJldRhWvBYG8kKNUZoYF65O6NMNSZTAfiseW/mN+UdAQkeG070OXqkGOvzh/T9F
 PjzgUt0WBBIyR4Y9WS+UCbTURI63xmEFZG/A4R2W8Mw7JQe1ggvB244CK+Ng6CtY8nFmNOKEF6T
 Xe+Jgrw3WPPQHIsMhPGQ76IYTrU1r5cDOHRT+Z5Q2br8fFim3ZkFkI8zeZjdNe9s1FUD0gd5tzm
 eJoiYXCLNBh+LakPbdAi8TSSV/g0dve8idTJNV2Vbd3MNSaKM6nzwD8wd7W9RaG+ui5jYx4sH9E
 6e/goWCmLJlk42Tv3jQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190072

On 8/19/26 11:17, Harald Freudenberger wrote:
> When a request is transferred to the engine via
> crypto_transfer_skcipher_request_to_engine() there are two return
> codes signaling a successful transfer: EINPROGRESS and EBUSY. However
> the correct handling of EBUSY was missing and has been added as a
> return code indicating a successful transfer to the crypto engine.
> 
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org # 6.16+

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

