Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7E1624C0
	for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471138; cv=none; b=Wsdkfa5SHqMlVoL3if0ZPC1uUUutp+1KdspnmaQ73gJ6PU76Za96hGWfmEx0EAkmWPjkHn5HraN2zSw3T9a4WGDd4jRPd32C4OrAZ1HurzSXtxbnr4PdqWWQ5+GrfXU3GZjG+wmaqe+YUQ700bWS3ZlZ3trYxZQqWqGxubo4+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471138; c=relaxed/simple;
	bh=J2KmVhHgbRd4ipUdfn/i+p/EeXsqvi+jYyedHfYj824=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZntsaIi60zJvk9hFEdOU3yP5pr23yXvYEmyWY2DM/HjjGSGxkEmWNUl3MZMKveJ20nWr+jM7Pa/AbUbembPYu2mckbKfMHeeMkNv4Tk6irElEBk+wzqREXwKTbV2MaBHAJ7HLVC2sRmk8EgqSFew91XNBzI22kiWgqfHJg+xFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k8sgrFBB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k8sgrFBB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OMnWh9013148;
	Tue, 25 Feb 2025 08:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m1zZms
	FYPQBCC1Cs5haidOOFA9JsAklvBQw+T1EnKAg=; b=k8sgrFBBSlykf+qoKzV0Yw
	DccqA/K+n0HGiigZsLTY1l2r/+Ofc7xa/1DGMrGPnaAcx6q9zNe04wc3FoWp9eim
	xHH4eUqF34UtULUBq7iPJLCFR5dzbZJ9xoGh+ylW9EOF7zWeK95KUejwTpdNiSIq
	CotMOo2YmBZC2N+Uqb1iWoZqIYQbn8kxIQe5BsqngjjGp7h56URc4QDp1++6KM3C
	pRUZt3+l3edxoEA1+v5CV9cO+xg6nnGqwemZmguypeGMMhd38y0KuM26jCUJTCKy
	lFYZra7wyUhouw9Fhl55rw8Uu5iipKehonFHiMAop/y1perMQi0GFaifJAQaF/XA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4511wa9w4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 08:12:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51P4SKFk002570;
	Tue, 25 Feb 2025 08:12:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jkdvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 08:12:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51P8C7UY35520980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 08:12:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D20D220040;
	Tue, 25 Feb 2025 08:12:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85C2620043;
	Tue, 25 Feb 2025 08:12:07 +0000 (GMT)
Received: from [9.171.13.48] (unknown [9.171.13.48])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 08:12:07 +0000 (GMT)
Message-ID: <c8767137-51da-4e87-ab69-5f7f03a07835@linux.ibm.com>
Date: Tue, 25 Feb 2025 09:12:07 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/20] s390/ap/zcrypt: Rework AP message buffer
 allocation
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250223095459.43058-1-freude@linux.ibm.com>
 <20250223095459.43058-3-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250223095459.43058-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ls8UXVonBp6giDgsS2Zv2E81IbBtRraD
X-Proofpoint-ORIG-GUID: Ls8UXVonBp6giDgsS2Zv2E81IbBtRraD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250053

On 23/02/2025 10:54, Harald Freudenberger wrote:
> Slight rework on the way how AP message buffers are allocated.
> Instead of having multiple places with kmalloc() calls all
> the AP message buffers are now allocated and freed on exactyl
> one place ap_init_apmsg() allocates the current AP bus max
> limit of ap_max_msg_size (defaults to 12KB). The preparation
> functions only check for their payload to fit in. The AP
> message buffer is freed in ap_release_apmsg().

This patch reverts some non-neccessary changes from the previous one. Please clean this up.

Beside that,
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_bus.c           | 30 ++++++++++++++++
>  drivers/s390/crypto/ap_bus.h           | 21 ++---------
>  drivers/s390/crypto/zcrypt_api.c       | 49 +++++++++++++++-----------
>  drivers/s390/crypto/zcrypt_msgtype50.c | 22 ++++++------
>  drivers/s390/crypto/zcrypt_msgtype6.c  | 46 ++++++++++++------------
>  5 files changed, 96 insertions(+), 72 deletions(-)

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

