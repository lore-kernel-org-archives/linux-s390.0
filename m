Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E01F4C8B
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381101; cv=none; b=fHVEpi6KpcptNkYVBQ+vYzYir0F3K5g0VVuoSCei9EyUn8gWaUJb9Oe6y1lgqofLl9R6ErVz4BvOnXdnAgO+BwUzxlREzEkBqfXvIyMh9xRvCA9QyIa3YfLrcAPRnlow2Vs7eY+7j544Sl5yUFTnEZMnGHKfQeJcjmbNBjy98+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381101; c=relaxed/simple;
	bh=5V/bA/QWcw4sBDHpvgpJlekFWn/wv9F4udC3+69ohVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jS4P0fEVxa9VLac0qxzqXL3fwomysol6JgA1JClKxDqGWtvWbxYUSD1BYZpBl1hrWwgaVZkbi7qDw0A04waocDnNhDWBZzRu/ZEV+IDevZI0DEjhUfAiF/c1OaXblTHQC1MdwJrfsfPUMqPLM+NKrQwjosa7NQV28ssMy2YF6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q8VWPXSv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q8VWPXSv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BCSUxl026473;
	Fri, 11 Apr 2025 14:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/dEpQB
	Y3rBKM5H6HphjkrCAMwGUV7Pxdu1wy8+BPHzY=; b=q8VWPXSvGiD473aO+bHIB0
	2LWSw+wiu1uY9WsPGlYfuYuRbZtdMH5jswOXVfikIu72+2MzxvCSHVqdYX/lrBst
	ELoawStyqtdqkQ66d8Lq/KzlFVQ6/abtrkj9DVkZFo9JKlnj/opXWxr1fbfBgfjL
	aj3G1zvk96wOzJbKE/87y3rGfnXn2zRnGVp6jgKc6ZRoXhHzkrZUlksbaBOT9nkS
	itNEpGtoVLbtrY8PI+FdXYVH7IkGLcTgT6UCS4pS9rrbvq9+g3fYHxn3s+nYFbWz
	jj8TkoZ4pzI2OPSY+w0ReVNJSBxSUH3YdAghtLZtMbCSbkUj5ypCngTk5ZIqRRxg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y343rhpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:18:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BAl9mB013932;
	Fri, 11 Apr 2025 14:18:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup39n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:18:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BEID3U42140044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 14:18:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11CEC20049;
	Fri, 11 Apr 2025 14:18:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C85E20040;
	Fri, 11 Apr 2025 14:18:12 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 14:18:12 +0000 (GMT)
Message-ID: <e9b208f4-f399-4ace-be0b-12d840afd0e7@linux.ibm.com>
Date: Fri, 11 Apr 2025 16:18:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/24] s390/zcrypt/pkey: Rework ep11 findcard()
 implementation and callers
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-15-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-15-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZPdP4jyZThs_kwzgnj6Hja4beiHkvmn8
X-Proofpoint-ORIG-GUID: ZPdP4jyZThs_kwzgnj6Hja4beiHkvmn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=941
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110089

On 09/04/2025 16:02, Harald Freudenberger wrote:
> Rework the memory usage of the ep11 findcard() implementation:
> - findcard does not allocate memory for the list of apqns
>   any more.
> - the callers are now responsible to provide an array of
>   apqns to store the matching apqns into.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Same as in the previous patch. Please change the component in the first line of the commit message to "s390/zcrypt:".
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

