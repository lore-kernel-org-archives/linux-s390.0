Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE61177111
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643095; cv=none; b=LCBHHNsPoiI4KQ73sO2ITjUxcy0lzqT1dQsr85J4tAuKOORC72z4YvAvl6G6sv/ZZFiNUNxYsVv+K/GHsCbnYqc4lnnjoiej1MIKJQe9ihdjUNzsbBYTCMKYD6xpcsGVT0W9S0i+OLrwYflmSbpi4+wyII8l0daK2XpILMa27JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643095; c=relaxed/simple;
	bh=thyI3pzh1fBIdPWxgeRFYIqk3mIm2vCqoKWf2KZuPFU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=P0Hw2wOFeejN66VkHp5ElxHNhtdq2iVW+d05Lh1Z54pFKqknXUBXhDXp2AniGmqaW/KUU583G+9qTScDf4yD+UUqV8UfZOdIhoo6NR6tXmNfBzqm+/WGvxHTYPcCbry0Zg8XlgOKHQBHU1M1GSmsMG4SU7hdQnxmDkyVDBhZl88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TOrfU6Wj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TOrfU6Wj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ECBQ9u018095;
	Mon, 14 Apr 2025 15:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=3h3MT+N3Ik2mWOP0dabsaDADAIRlRHPIYqHz7CECHbU=; b=TOrfU6WjJ9cc
	v6byoaS63RIiau0jvb1rCLkHRnCZnZCqO96lkksLeo4yfrTW9mrJITm1pld9VT9J
	dtjWDdkHDIdtasvVoeYixV9WJQfV+YUawOeRB5OFM8PV8oq5i2JKTdS6hR+aO1Ve
	GrpNELWSvEtjVFJeEdgh6gnFw74YCNXP7zD0xOlSqQeoLwpmJAgQxQ2C9SN5J7Av
	WcdlzUzy6eIZqyzHvg9RFzrEfHf/ymvB8vliyWkuCG8JZwGzV9V+LoYuXw5Q8roq
	y/t/4iRxag/c52TYLnH9ZQDcGTjQpCYWXD+DhK2uu3W/n8+cLE5JQp6D6D/9vY/q
	wC/E3K8S8A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460q7x3j72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 15:04:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EDoUKl010392;
	Mon, 14 Apr 2025 15:04:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qjxfd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 15:04:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EF4nCP33882630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 15:04:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0859258056;
	Mon, 14 Apr 2025 15:04:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 843185803F;
	Mon, 14 Apr 2025 15:04:48 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 15:04:48 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 17:04:48 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v4 16/24] s390/zcrypt: Propagate xflags argument with
 cca_get_info()
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <00904381-9386-4cca-80be-29ccce2d85ec@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-17-freude@linux.ibm.com>
 <00904381-9386-4cca-80be-29ccce2d85ec@linux.ibm.com>
Message-ID: <98e0a908b8b49adfb003de664d83a90d@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AoQ-j_9SD2e6bADX0gNp34VYVo67grW2
X-Proofpoint-GUID: AoQ-j_9SD2e6bADX0gNp34VYVo67grW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=593 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504140109

On 2025-04-11 16:25, Holger Dengler wrote:
> On 09/04/2025 16:02, Harald Freudenberger wrote:
>> Propagate the xflags argument from the cca_get_info()
>> caller down to the lower level functions for proper
>> memory allocation hints.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> This patch will be affected by a rename of fetch_cca_info() to 
> cca_get_info().

Needed some adaptions.

> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
