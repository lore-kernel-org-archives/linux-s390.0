Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84341F461D
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383236; cv=none; b=CfUCMJUMbxbEEVeAz/F2ri6dIjxNV59dnFLWVtVdYwXio327Xd7HfkqvjsvCpov7wtDfMpz1jmie4VjQwc8riGtZetV7Z6EIJIkiyJ7vDjuZXpQLyjiSbZK74RNfFC66rJ9iG34g8O+uGGPG0zua5ewUMS2ZtvY93L+/hsGanhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383236; c=relaxed/simple;
	bh=e1BKjVfkmwJH3/NkW3smLmE3wvfexOpa5t2N7UVkVjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fP9mNLpsNJtaZwefeS1T1OTHMtib5IC99f+Fq/mMjOnq0IHB3RAg1A119gQGmzDx/nFNFM+ehuMVg5NxAieTFZFhbKIM4hnercGVCq6NRhzPESbIzpH0oLpv7YnbvgK39PxO4qs2PVxS0EygHt2L46IMd8/vcf/SfMFLZ7AetIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bLz8sqj4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bLz8sqj4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9H013012575;
	Fri, 11 Apr 2025 14:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iuDF4I
	keIP7/5xzRc+djA7o6cf5jaD8kGpnF38sv9uM=; b=bLz8sqj4OBYhotrUMkQ4E7
	esqH3oQXsCtJSyKltkp/AuSA2wPRf/IVvULnCzP1jg565rGcxC5Hs+dcdK+njATS
	2UH8YRKJqUc3sN7KN9GGwswZyFOv6Dq6ZAKkLV+hn/XyaqSxpm3MpcZh4K64zMPc
	9gAUlGtco4HrXZtnyqwlxI9lhSCXt1jgyWdwvNjuA9mun4PyY8shz9DLr0ElZjVM
	xLThxzjgq3o1rICr3NgzDD8B2Yf+NM0xWd5x+XE0iQUzPd43H3kwseEWokRuN0AI
	XGhXfecN3g4LpSfUnKXalxjMVX0iaOSNUfLxyzXq+UYenV6W2zUaoLTNuQ03nlSQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xn71c4q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:53:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BAlXMO013858;
	Fri, 11 Apr 2025 14:53:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup3e51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:53:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BErlTX51970482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 14:53:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 128E820049;
	Fri, 11 Apr 2025 14:53:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 879CB20040;
	Fri, 11 Apr 2025 14:53:46 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 14:53:46 +0000 (GMT)
Message-ID: <cf204cf6-0b90-4da5-bf86-9f7ebeed4e21@linux.ibm.com>
Date: Fri, 11 Apr 2025 16:53:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/24] s390/uv: Rename find_secret() to
 uv_find_secret() and publish
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-22-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-22-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v4HAJ-86jo1mo5JmYjlJt6d0FjZu_mZu
X-Proofpoint-GUID: v4HAJ-86jo1mo5JmYjlJt6d0FjZu_mZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=806 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110091

On 09/04/2025 16:03, Harald Freudenberger wrote:
> Rename the internal UV function find_secret() to uv_find_secret()
> and publish it as new UV API in-kernel function.
> 
> The pkey uv handler may be called in a do-not-allocate memory
> situation where sleeping is allowed but allocating memory which
> may cause IO operations is not. For example when an encrypted
> swap file is used and the encryption is done via UV retrievable
> secrets with protected keys.
> 
> The UV API function uv_get_secret_metadata() allocates memory
> and then calls the find_secret() function. By exposing the
> find_secret() function as a new UV API function uv_find_secret()
> it is possible to retrieve UV secret meta data without any
> memory allocations from the UV when the caller offers space
> for one struct uv_secret_list.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Acked-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

