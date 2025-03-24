Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23525D919
	for <linux-s390@vger.kernel.org>; Mon, 24 Mar 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826872; cv=none; b=PrI6oDI+77NcHEtY1nksdB3D8eECqCC78t7IzAFSiJUyeTweXcfbxwawQoxjN7449E5iRTL2yVAHp/nB37UwL9fVNNqy6Bk/2ysO4Janz099M6xD5DbpRdn1baT1igOr2nFfMplNYIHR46Hts9Jz0Ig1fjGg9es1B6vqB5THlyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826872; c=relaxed/simple;
	bh=y4t0Sh14NYXqKYj4lbEuFGORPembszozZTfTsDn4Lhg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fLXCd6L5XKLnrPQaw4OJjRZXkAq/PYFcU6My92fi66FVoqS5ZaagIb64GHtXP2UxCVvhD95mV1H0zOxIGt9klZ1rO6XL2NSaZVw6xCPaoamn7boVq912T4oHsETtJZX79txaMuQjhWqWDe84hheVC3zAJN1AkF9MaJX8FWz6Wog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sQ7pL9ch; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sQ7pL9ch"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OA6pbR022369;
	Mon, 24 Mar 2025 14:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=1aYqEDIku0Cc6Kim7OPdw8HEAz8xTwbv1l3YHyC5ZsE=; b=sQ7pL9chQ0CE
	MJgxIw7l4h3mGGm6RVastb7EZnYZTYvhcRshWF4vd6KdsD2Yw1g1iXy3yh4RIcPw
	3ziLOlovx0K+V5BLg1NMhNdfnyHY5NAwChdOxM/VRx0CMCssaahCb06WJsRqIl+c
	SoEYPcWqLu6IZhGroKQIVrLpBvACJwFdNuDPxRi+TakC8rpnZ2dL26frSPHyW4vJ
	hk8QXaMR5NVJNgJEStNIE5esPtYlQP8IaL+6y2YrlcDM9bQFQo1eqT34gnA9AdD2
	ss6tOdyj4uFZ19akiNfXin4l4APEkNrxdVQlxALs94ajsEzypw9zkn3Jb4sG/bDP
	lXGxsKaqyg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsfpc397-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 14:34:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52OBQNpU030418;
	Mon, 24 Mar 2025 14:34:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7ht6thg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 14:34:24 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52OEYMoD21824046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 14:34:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7EF15805E;
	Mon, 24 Mar 2025 14:34:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FB915805C;
	Mon, 24 Mar 2025 14:34:22 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 14:34:22 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 15:34:22 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH v2 01/20] s390/ap: Move response_type struct into ap_msg
 struct
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <e8bc8844-7aa9-4c8d-8538-5896436573dd@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-2-freude@linux.ibm.com>
 <e8bc8844-7aa9-4c8d-8538-5896436573dd@linux.ibm.com>
Message-ID: <859eb14f5454e075166f8cc56982510a@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HCnBjUUmD74jMwAa4aN69zS0jm5a02pX
X-Proofpoint-GUID: HCnBjUUmD74jMwAa4aN69zS0jm5a02pX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240105

On 2025-03-17 10:38, Holger Dengler wrote:
> On 04/03/2025 18:20, Harald Freudenberger wrote:
>> Move the very small response_type struct into struct ap_msg.
>> So there is no need to kmalloc this tiny struct with each
>> ap message preparation.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> See my comment below. Beside that
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
>> ---
>>  drivers/s390/crypto/ap_bus.h           |  8 ++-
>>  drivers/s390/crypto/zcrypt_msgtype50.c | 16 ++----
>>  drivers/s390/crypto/zcrypt_msgtype6.c  | 74 
>> ++++++++++----------------
>>  3 files changed, 38 insertions(+), 60 deletions(-)
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index b64c9d9fc613..521cc0b39990 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>> @@ -31,10 +31,7 @@
>> 
>>  #define CEIL4(x) ((((x) + 3) / 4) * 4)
>> 
>> -struct response_type {
>> -	struct completion work;
>> -	int type;
>> -};
>> +struct response_type;
> 
> This struct is only defined, but not used. Remove it.
> 

done -> see v3 (coming soon)

>> 
>>  #define CEXXC_RESPONSE_TYPE_ICA  0
>>  #define CEXXC_RESPONSE_TYPE_XCRB 1
> [...]
