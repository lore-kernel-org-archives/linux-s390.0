Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696D3F0779
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319860; cv=none; b=HclBOUdQdC3ycf13xLunrO/r1HKRFzUmka/oU7Kx0RYFav9vvMX7+Xz3xvaHenRlA3gKifAn9ML/j6vEyYh2TWkwxrZDDtGQdhWDJZ+mCRD9qrvThZEk+bMATnrbCxUiNbWfUQPSxLRVZxHH/tdFvUhFdOF5PUEavA7DSQMevwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319860; c=relaxed/simple;
	bh=TSCQjvW9y9QsMEwus3LmeNj+6NljnpvdGe3hu70C6/M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EyOOXI78DfakFT+WKQw1Cil9bZVNg6engfrJZVf00iUg23CnKNGzbiIE67fQnN4uG6k8WZD1Ke/xmwbXjiLZBCR87THsE5i4T6rG+Qjy4yFVnPSP49Vw2/TDV1iDphjFNY/7iqJ48hU+BWfrHD9yU4aGP0Fn7gH4O4EMJtm2PRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NEO0N1C1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NEO0N1C1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7lt3D3506556
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=CRKT8qFHRL1cLyCa5ggB6fQTUK2/7WDZ/7nYAzEZVR4=; b=NEO0N1C1xlS9
	TKZN6fbEPEQNyIRws/zJNrycr2npz9nVVzcX3f481IIEH62JlEmRwl7pU5fMQghy
	O1TLgPtRmaRsZpZDq0zvGH0VHKLH7ph+uZQ04Bho6q4/qSDHpOwz7rpiRmU9F9Vn
	dLuidGFbiBicF9XkSEWswsnNvkeWoZrcgOslhT+jHSyCRFlzxYe6Z6LSWp2mNNZh
	wu+K4AZZrSzR8nMRZbZf0OMAfAVeFw+PERanH7+4/p2P/+OQdqoUmB02cVwn73Ts
	ZIWhnCQjaR4jSV6e0UeyJw6wY7tfUMxG5WcCfLw7zoNDq7fMzYHHHLqm6ZhdGZRv
	AyhvpGHuqQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj9a7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:10:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9uHkV015791
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:10:57 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk670m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:10:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TAAJox9568904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 10:10:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2016058060;
	Wed, 29 Jul 2026 10:10:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82BD058055;
	Wed, 29 Jul 2026 10:10:55 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 10:10:55 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 12:10:55 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, ifranzki@linux.ibm.com
Subject: Re: [PATCH v1 1/2] s390/zcrypt: Validate length for CCA AES cipher
 key requests
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729093616.4184642-2-dengler@linux.ibm.com>
References: <20260729093616.4184642-1-dengler@linux.ibm.com>
 <20260729093616.4184642-2-dengler@linux.ibm.com>
Message-ID: <c5a4def0a6cadeaf3f1d2c169765c8a2@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX60cqPj/eaG+p
 IVkEKX7iC/ztnz2KAa2iRjABVqu5KWIJxW/e+lxf9PaCL+WKlj9Z2HnuVyLTFtNSa6NNvUXtFGE
 g/lZm6EkPUik9fMZfR2c+6a6X6tskvY=
X-Proofpoint-GUID: 8t-08RkM8Z8xu_cKdI9DQL9PvNawfHbB
X-Proofpoint-ORIG-GUID: 8t-08RkM8Z8xu_cKdI9DQL9PvNawfHbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX6MAtcGYmg/ph
 UyCzKQso3+pax2uxr7roWO/wbfuDizkRv6O1CIOtX95nMSp3gpa9BUlaV2CygvGS+KVDHEDUM0c
 9MV4j5icGPDsGN8sB3aQB0/eYKXWwkcvUWOZ0fzqGFperi/iCINOV2rK0iVwle6EQ7JqoAJFNnm
 5aDLo6eAAJ+xMVMehw8Tsg70RP8lZmGVRIWyBxYwX8Cg/x4mFQ/k0tLp/npbMZi/bLd/cNpKKSu
 pWYKzkDn5Q0avTfDrLpa8qlOKNxFgDZ6TDRj1Zhg/WgjxwLe4emdN/mKSkGfgrtyg1W2jOltQye
 ZJ360ucIi7iiFlOrSmdvyNapw6G3w5QVTPIUTx7PydiGQkfZqiSZxkQirwxO691FKvnzUB4mHN3
 IljvrFBFDZElSI6WCOxx/Awqjkpk5syfMYUeFF/YDYcQsy3Pa9mf4KK7PNiVBczShiDTi54n/Uo
 squIojkuCLeqs4JGbVw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69d1b1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=J7XeZPgSbLuF6vBPFCgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290080

On 2026-07-29 11:36, Holger Dengler wrote:
> cca_cipher2protkey() derives the copy length for the CPRB parameter
> block directly from the length field in the key token. Reject the
> request early if the token length exceeds the available space in the
> parameter block.
> 
> Fixes: 4bc123b18ce6 ("s390/zcrypt: Add low level functions for CCA AES
> cipher keys")
> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
> Cc: stable@vger.kernel.org # 5.4+
> ---
>  drivers/s390/crypto/zcrypt_ccamisc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c
> b/drivers/s390/crypto/zcrypt_ccamisc.c
> index 84936a795b95..db6a4211a97e 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -1261,6 +1261,9 @@ int cca_cipher2protkey(u16 cardnr, u16 domain,
> const u8 *ckey,
>  	} __packed * prepparm;
>  	int keytoklen = ((struct cipherkeytoken *)ckey)->len;
> 
> +	if (keytoklen > PARMBSIZE - sizeof(struct aureqparm))
> +		return -EINVAL;
> +
>  	/* get already prepared memory for 2 cprbs with param block each */
>  	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
>  				    &preqcblk, &prepcblk, xflags);

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
