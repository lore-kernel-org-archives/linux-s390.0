Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BF37E316
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072710; cv=none; b=qLiIsNWcaiW8vkNWXdXBX+b6+6HuZ0mlUJLZc44rQLK4H3bMXEhV15sQwB6rCWIoHesq0K5/+XkHNzRok1PI2GoIi3jvh6jV7spD+3H1CQFf16ltn7obxUftiAgxh+pJ083OP+PD1Li3/ke4oAl7xKDclSofKxktCIIZMzjuL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072710; c=relaxed/simple;
	bh=rKkgHRJMPCi3YOx/3HLNpNmOjNkf1JNOb9L0cwarU/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1FxJHdDTCOYB2SCy5pQdjLJ333SYq0fA+5zaxAGRaTZyEJwxAh7rVMzExii56MbBBipGEGD5D+t+WR5jPFvkrFE61Noy8c/nqQU2pPLHyGlQr03xMvDifJ+z7XydtmTZTzI/C1LpV0R4yKPcedabDJps1zpuuApXcWqluHwfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ULYBw1rz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ULYBw1rz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IBQu2062816;
	Fri, 3 Jul 2026 09:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lXv1Vo2nxJsBSpudLmltg2gM5qH+0H
	Xqibw8UhjFmfA=; b=ULYBw1rzgTHtBV4e8bd8v8U/C+uiWlxXZ0pV8D2JVHqZDJ
	8tyElwYWo2q27GHNEt+S+Op4/fZTV3HkyvZtfjEH7JbUSZCOzvJRmXH2yeAtcwFX
	jPJbANXHPBMtWBwfIjwsthbos78f3NJdFbF/nPTckQJ1K5iqcNVb60oxes2Exr7j
	dt4zpOl6Uqd5OGg8IRZEAoZyl+JJXkFyd5qA9/hXFemak4sbbgLdVS5SSwUNP9lJ
	30fBT3gkGNcnhc9GyyP2x06oRTTsGSQDbu+wVtAcXXxIl8WrXEd/W2g6+aWShWbm
	zd5aib2KwtnO6g42FdRUE0oDZ4WuBkdmyG1CQKmw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgehv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:58:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6639ncLa027366;
	Fri, 3 Jul 2026 09:58:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqrf99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:58:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6639wHMR50987298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:58:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B995820043;
	Fri,  3 Jul 2026 09:58:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7524520040;
	Fri,  3 Jul 2026 09:58:17 +0000 (GMT)
Received: from localhost (unknown [9.111.9.151])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jul 2026 09:58:17 +0000 (GMT)
Date: Fri, 3 Jul 2026 11:58:16 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Rongguang Wei <clementwei90@163.com>
Cc: linux-s390@vger.kernel.org, freude@linux.ibm.com, hca@linux.ibm.com,
        dengler@linux.ibm.com, svens@linux.ibm.com,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v1] s390/zcrypt: Remove the empty file
Message-ID: <t@ub.hpns>
References: <20260626055820.376212-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626055820.376212-1-clementwei90@163.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4787be cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=OxPPU11sa_40hDLK8BoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5NCBTYWx0ZWRfX+wUlN3CmaZXl
 coGv//0aUdZLZIyWLscbRH/hCIk7KiDBPFGP8mT8brDmj4AQvP1nECgqsUwN7ebkYsImWmy0PpU
 a62yFOk1Re01QrvyB1NnFMQ9prlNTYU=
X-Proofpoint-GUID: TyR80LwPDRYeJLBcO9BhIiIKgV4099Uk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5NCBTYWx0ZWRfX4SRhiczRXmpg
 XLRUwApSdNgU7TFo9S62xeo3Nxm9HnAdzKm8ccttZWdc1JPvOTUAe6a0WSN75AI1VnoLBp+bwIH
 2ZKEz3AkYWV2JDq+jhun5kn30RV0CLxN/vu55gbazC+Bpg9zy1Dl52YfyXwvz9jFw9ZWdPOHIMT
 aY+HRCNMQPThG5TGSyC/25nMDQ8pKpM3WUYptcc8E7yOaq6ZoIrA8t9hS5Qbdb3Q747yzLH7cPY
 8kR7OcxUMv1pUe237P8Uc3BrKT6+Z6tXoC7Bb7SoPSe9FYVsS2hJtBYnAyPbU4oQb3IM8X+qVvz
 OYJGdBSjAdBirnRlsi80QfmrrHIFfUQWrWZbC5v5skJkNaXArT+l/YKIpjMxU91mKqz5d+pfc+P
 03JnyZoX6eYGSjsIGCNeMti6OXA8F5ugDUOd97zIbRZQmEQtjGTSAc9gEwpPeKe5F+yTAR6ttSB
 ARtgwXQxx1mKDixVuiQ==
X-Proofpoint-ORIG-GUID: 9fRuSpWkzNWcpH4wZmkytmY84qPx0Rjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030094
Message-ID: <20260703095816.bFi7F_1IKOb0ZyjW0oV2OCB33AdUpjmt9oonBfXJSPM@z>

On Fri, Jun 26, 2026 at 01:58:20PM +0800, Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> The files has no real user because CEX2 and CEX3 device drivers
> are removed, also remove these empty files.
> 
> Fixes: 5ac8c72462cd ("s390/zcrypt: remove CEX2 and CEX3 device drivers")
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> ---
>  drivers/s390/crypto/zcrypt_cex2a.c | 0
>  drivers/s390/crypto/zcrypt_cex2a.h | 0
>  drivers/s390/crypto/zcrypt_cex2c.c | 0
>  drivers/s390/crypto/zcrypt_cex2c.h | 0
>  4 files changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 drivers/s390/crypto/zcrypt_cex2a.c
>  delete mode 100644 drivers/s390/crypto/zcrypt_cex2a.h
>  delete mode 100644 drivers/s390/crypto/zcrypt_cex2c.c
>  delete mode 100644 drivers/s390/crypto/zcrypt_cex2c.h

Applied, thank you!
