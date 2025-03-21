Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F28BEE
	for <linux-s390@vger.kernel.org>; Fri, 21 Mar 2025 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547957; cv=none; b=rQQv+xTtHK8qK4JswE6ZY1yitPYpOoKVJBeJyoVk+wUGKFEV5s+pZCknjAX6yelkIPHxTBe99bHqGzpGCubEWj3T+OYgqHkTCAt2R5/2zsHncOqeDcGmyk0m0OzD8lPnZkFk3sNKL0JZcHpxNpCOMzUR6d1WFtJUvSKjof3w/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547957; c=relaxed/simple;
	bh=Xc2MvqoINSmEqjtU/S1u3pl4SdniTX60ViaClD+uxe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhJi/OEnX+7AK+VTtp+k87WAoowJDj/UMpNRJtakFEVCFNR+KOjGetwdNTeoOpZK9Xk54SOUcXYw01BqHtnGRUCQ9BrbjqgqLG0JWFzm79hk7HNta3XVN2FhyTlN2gxUr+lXZSWzCjUz0wiBXJGfD9lYZO+GzbRmL1CZIUAeu6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OYNyULVE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OYNyULVE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L3jpSk032082;
	Fri, 21 Mar 2025 09:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YRrTyX
	Xske8dja/21LjwlTcjeIo1ScvT7vcVuSN7naM=; b=OYNyULVE8PVZHsXOEvES2m
	IeoOzOFSKPxrsmtiZfWeYVVk1LMB/hXzMD5iD40bZ87YxAIzQhR3mumYCwg46NMh
	0/F/gWh8kxEqscE2hMu1KfY28cPo6/uW+a5ptGXU2vF9WUIkZaNsUxJQVxU/Z7Z6
	2FHgau3pD20PPjNgaCS/jNw0bXhKmfHWBYKaRy6rDy9fv9HZSgu/en/NZqMntzmm
	l66QeuzC4glK4RrAmcDwE5HtaXEu3aDGl78sHdMOzcJAyEeFB9MnaIVjjiHApJGe
	qbZU4EcRqY8H+IcfufHOfScWQi8KOKjlehphAtt9/oTftbwcxKvJhjuldHZIRVhw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45h0g9s88v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 09:05:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52L6MrGv019596;
	Fri, 21 Mar 2025 09:05:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvpchxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 09:05:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52L95mo553084502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 09:05:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 267FD2004B;
	Fri, 21 Mar 2025 09:05:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF6B52004D;
	Fri, 21 Mar 2025 09:05:47 +0000 (GMT)
Received: from [9.171.68.130] (unknown [9.171.68.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Mar 2025 09:05:47 +0000 (GMT)
Message-ID: <dd66ea53-23a2-48d5-a8d1-df40d52a5dd8@linux.ibm.com>
Date: Fri, 21 Mar 2025 10:05:47 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/20] s390/pkey: Rework CCA pkey handler to use stack
 for small memory allocs
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-18-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-18-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kM5UpMbjXKY3_bMUcRB6T8o9gM0wH-u0
X-Proofpoint-GUID: kM5UpMbjXKY3_bMUcRB6T8o9gM0wH-u0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=972 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503210065

On 04/03/2025 18:21, Harald Freudenberger wrote:
> There have been some places in the CCA handler code where relatively
> small amounts of memory have been allocated an freed at the end
> of the function. This code has been reworked to use the stack instead.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

