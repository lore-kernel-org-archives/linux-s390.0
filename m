Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E61AF0D7
	for <linux-s390@vger.kernel.org>; Wed, 19 Mar 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407354; cv=none; b=VKhgnvp3yKsSe7Z3NknGmnnAZRrpgiQactZdsxajhKJ/mW0Xp5Y6/pZfpjKY65R0ymfQk0lCifOA6Q4lHl1bSR7c4ayc/TF1vtklfoYX/dCwdEoqkMNPh6vA8EGg/33J8FYc/MpTxazF+CrTHiEjF9UUwl/r7wpDEK1CnNe8AEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407354; c=relaxed/simple;
	bh=cvQnwO6uOKueE609Zq/9tcU74pn3v3UPRAFupd5089U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0KTb4ijQq7P88Rn91Z73buPaC0ymKvtN/WAEi5kRl0ZUinCHsV4VWJZSz9GoM5ApQCwdn7TEmcvsy2ZLtraSyjJe8TZqVNj1Muordthp6lmzT772jn3MQmbcCXSlJeQz21vwvMcT70ciOVtn1uxGmgisXQxvh/nU2fR6nAvDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=slyq8/hG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="slyq8/hG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JHlawt007914;
	Wed, 19 Mar 2025 18:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9RQT4E
	MXZirO9ec873pKEf0P6qSWr4Qwq4LQV8upaHo=; b=slyq8/hGKcJjbqMB+5oK74
	hkKQLq8y6x4XS27OOUBuf76awuy3Ryq2LC3sAwfxoO9DdhbXXLnD/r68XqcNIxYq
	1r5EDJ1vPNd0tvlC/SzvN3JaiPe09pp5iycYEruO2DL3aZSqOZEQ6TWX4/K/2M8a
	yA0IHxOnl99qwLnbu+y5vIaz2fwiBQs850iMSG7f179N6XQEwdKoTFIZE7f18s30
	n/U0SR0xyK2gUrS2RuC/uzzxx6OtDcXPYpYoIE0UJ67DE6rqh1hPtc7dWYj+dOLm
	5r309icZLBNoYSgOLQpka6/0iwsBvQNf+GJ5X2LYc4LnVG2uXM45V5D0IzO4DHTQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg1yne45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 18:02:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JEu6su005628;
	Wed, 19 Mar 2025 18:02:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm90360d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 18:02:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JI2Ohh19792240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 18:02:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0075B20040;
	Wed, 19 Mar 2025 18:02:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88EB920043;
	Wed, 19 Mar 2025 18:02:23 +0000 (GMT)
Received: from [9.171.26.40] (unknown [9.171.26.40])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 18:02:23 +0000 (GMT)
Message-ID: <6a88fd00-3997-4930-a6dc-11ece42a6c72@linux.ibm.com>
Date: Wed, 19 Mar 2025 19:02:23 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/20] s390/zcrypt: Introduce pre-allocated device
 status array for ep11 misc
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-10-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-10-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MpFFo1LCqj3My9Z_ZD2jaul-un0_20jK
X-Proofpoint-ORIG-GUID: MpFFo1LCqj3My9Z_ZD2jaul-un0_20jK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190121

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Introduce a pre-allocated device status array memory together with
> a mutex controlling the occupation to be used by the findcard()
> function. Limit the device status array to max 128 cards and max
> 128 domains to reduce the size of this pre-allocated memory to 64 KB.

I have the same concerns as for patch 8/20. Please think about an alternative to the dev_status_mem sharing, because it synchronizes all findcard() calls.

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 46 +++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 10 deletions(-)

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

