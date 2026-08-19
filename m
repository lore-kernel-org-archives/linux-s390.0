Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02B2E736E
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133640; cv=none; b=Hpg7dWZORwWyoUgQPYpTNsjBs7swvH0D9M/lejUw8Q+vq33jvC1hMrKgblobsY2yVdxXCn1dlA61GMRlsGzuWjMyaVBetRrop7XPWeukUh71UXH88CBaGeLRk26WJ7oLiFDLfYb26u5WBDOhFh/TbHliAbW85wYyPLweCIqwk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133640; c=relaxed/simple;
	bh=JKiXvbBfKdk/n1blwRHd3Am93FpLG1R+w7wHrAXsAxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQ+V6UDZJMJGWJUsoOswc+aDoS5eSKpC5Q3UIKLldF4Qav3AeW/pj6Jk6N/e3uGoPlf2ZUlfNlVQ7Lk2D9BYHBcjv5n6hBqo1o5jzkW5QR/uN3oPNDZYaRpqpNFGu2RAWuEWRDZxBCs2P8UZZi1WP80vX5P8VJ5jX92Gr8zzpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LfzQ2kfv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LfzQ2kfv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6ViFc2621722
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 10:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QVgX1z
	0LqWUBb0CLEj3KugquOIhqCMIRdqY3RckJlW4=; b=LfzQ2kfve31ufi9pfv86jD
	1lAZ8zbQlmtqq2s4WRu77UDwnAteq4M2/h6tpZ8b89aRaC4YGU1ydk3goTWHT0IR
	aJ8ApaXeA383GhMt3iCvj0BzEncp8pNu07D2OHMz2F3iz1fOaI7cyAUnQR68E/6H
	CiiH+m1DtG87UFxPxQTpWpsMS+oFD2zHGZrsWQx1zK4GTNxiRzlHErXCxFwQxlFK
	IaYScumA9Frux3y21ZwnEyi/skAQr7s5CVRRGmRbgZ6Lie5lZTSgBFx3fD7E9EEB
	qQ1kdWTsrS6X7WcD4A3FtNdLG+4DElIGgPXN8476F8QlNcAOVMIyTefGOK1SYj6w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1axat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 10:00:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9uR7m024683
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 10:00:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw8d8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 10:00:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JA0XBe42467752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 10:00:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1420D20043;
	Wed, 19 Aug 2026 10:00:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC06820040;
	Wed, 19 Aug 2026 10:00:32 +0000 (GMT)
Received: from [9.111.82.93] (unknown [9.111.82.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 10:00:32 +0000 (GMT)
Message-ID: <05e44aa8-a1f5-40d2-9346-4a044049a50b@linux.ibm.com>
Date: Wed, 19 Aug 2026 12:00:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] s390/crypto: Fix wrong return code to engine in
 asynch callbacks
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-8-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260819091734.7331-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a857ec6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=zxQtlMrsC6MOSSzF3psA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mcdqIVLoGdqLinKo4wngCInfbV1-13Iv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfXyF+6vrs0fOlh
 76+j5hec6PRmib4pDYiMA5/999esUD5/t/AnC5NPqqwVHUzLVUJ25PDuRf6cd1C55Rqc6TODLG5
 QcMfsIbpNERzqVN8C4vC9pkYFbyK0ag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX+58NbP2jTsgC
 cbCl+ZiwYt1XjaXs5vqWFSJULynwXD99TFPBDrUxlRFtFMbB8I8Sul6oqqdn9A3DJTVquwLHT48
 z4ouRHbsHfCpqzBqYkz2N1UxafauT7MNaGdDMFujmF9UkXNAEaGJqam4XhfiHwyr9wIIbHbB+y3
 rtFqvOcObBpaf8nMmMAQPyk6nX2bfUU8ZDzHzWoxC1JLjGY+34aXfW8KowTtTsVxFdq4TyawiDb
 6uaWgg90q5QpfFhquuzHAuUxwNhf7poQR7fTkEyOmwpGcVyLVWedij6gkH5QspCgNySFIBthESr
 k/s/XkaYCaYhAPzpF3zN+BC/CCv6BuPsk4KJl/5JB+uu+P6s3YJNHulI5l9k8NA71Vpmgp9LRUQ
 nOrFsglCbjfunj7Vffl0S2EHnnTSC5y/+vxXSJ8ype0alYtbfaUQD3dnUeOREmhY3nklBLFGYd+
 /InLJaR9hRJuKC2YYJw==
X-Proofpoint-ORIG-GUID: mcdqIVLoGdqLinKo4wngCInfbV1-13Iv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190072

On 8/19/26 11:17, Harald Freudenberger wrote:
> When crypto_finalize_hash_request() or
> crypto_finalize_skcipher_request() explicitly completes a request, the
> do_one_request callback must return 0 to indicate successful
> handling. Returning a negative error code causes the crypto engine to
> assume the driver failed to take ownership and triggers a second
> completion via crypto_request_complete(), resulting in a double
> completion. This pattern occurs in paes_s390.c 4 times and once in
> phmac_s390.c.
> 
> Fixed in phmac_do_one_request() and all four paes do_one_request
> callbacks (ecb, cbc, ctr, xts) by returning 0 after explicit
> finalization instead of propagating the error code.
> 
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org # 6.16+

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

