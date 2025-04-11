Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2721F5433
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385064; cv=none; b=suyoOSLCqqU1eG9o2gM5pN6TPxFqwFSgHFlE/IdtLie9NfuPdUHAn5V0d2xGzPoNtOzs2gRHk0ntJPzaTw/MpEcH1SZtoON2Sgo29rR6YUfFLmL44usFWjv/mzIvgDYuY+Yr3VpbA0RQMPgG030uQi1ix8eL6pf81QsAGM4K+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385064; c=relaxed/simple;
	bh=QmBly5iIZtpyRnOE0gTEnfN+U5QVH40JdxgjIt/bn1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hb1vifdne7YJPoeC52xUE6lQOAUlodiLSzwcFLWcodlz/ac5izfEsnM10xf1WcnOS7QcEYt3RvDb4L8mAAkY7u6lEiM+BiZMasYc4klaMCErBobdpitMBJa3XbW7PEDYzXgiIu0aAmFq198sGanF8g9O4FJng5ElgoPOv/1b+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pSPMo9Eg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pSPMo9Eg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5pBPt029149;
	Fri, 11 Apr 2025 15:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8o0KL4
	KufB7v10JfFw8Gqk9O+GBBMSU47mquPKBuCAo=; b=pSPMo9EghnUWaoy7BqRGM0
	cZlXxld76Hs0H8B4ysRa2vd/Wh+Pm6WrvuwESo/kBy/g1H13FMFKjpPSQoH5U/x7
	YlPXMeaiLIbuPTSe6ofFbhYttAwXDTaJ9/4cYPXUiAkx0Ysn8yFoM+rRgbyeciBv
	dFQ6pA6MoLiEmXRa3DExE8HZdt85+E/NweOwmE1x1QkFEUL3r6WNNV5VAm2my8EI
	16qNUlTfuCuxD/e6zW5CEqraKdpB/wlINaAVRrQJ6uJUETWmekmcrWsQmze+IXwW
	Xy1uVqLGOfMRHjpZhfsVDR/0qLXvrPPWom+lu2ztOwngK6+waBeKYKYDlfLsYa0A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xj5xnb8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 15:24:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BF592k013932;
	Fri, 11 Apr 2025 15:24:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup3h49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 15:24:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BFOFB837880120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 15:24:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 109742004B;
	Fri, 11 Apr 2025 15:24:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 861BA20040;
	Fri, 11 Apr 2025 15:24:14 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 15:24:14 +0000 (GMT)
Message-ID: <e30e1a7f-e02c-44f0-9548-29377c7fe01e@linux.ibm.com>
Date: Fri, 11 Apr 2025 17:24:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/24] s390/pkey: Use preallocated memory for retrieve
 of UV secret metadata
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-23-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-23-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -CSGm4Xv6-_iRxvJuJoO7PsQ3uBz_Lcc
X-Proofpoint-ORIG-GUID: -CSGm4Xv6-_iRxvJuJoO7PsQ3uBz_Lcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=804 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110095

On 09/04/2025 16:03, Harald Freudenberger wrote:
> The pkey uv functions may be called in a situation where memory
> allocations which trigger IO operations are not allowed. An example:
> decryption of the swap partition with protected key (PAES).
> 
> The pkey uv code takes care of this by holding one preallocated
> struct uv_secret_list to be used with the new UV function
> uv_find_secret(). The older function uv_get_secret_metadata()
> used before always allocates/frees an ephemeral memory buffer.
> The preallocated struct is concurrency protected by a mutex.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

