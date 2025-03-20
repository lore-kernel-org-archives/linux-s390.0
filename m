Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D51DED5A
	for <linux-s390@vger.kernel.org>; Thu, 20 Mar 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483918; cv=none; b=YYpCSmFGUGVHpoS3PwNmlpax1XufBNEeP249NrkDUtReLuf+cBqTcqoHLvmY4zWnbbSfwgzM4F+Py26flIblQl4kWw2ngjfgIuL2GJ14OqtP/KtJo+aOOgnFwGF+bkY97PVZ00vxTw2HCZVPi9l6vuUF7RCT9NbP58mOfSEOhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483918; c=relaxed/simple;
	bh=wTnZ2GRd8W43AnlMSo7+YtCi6LR9xr12yQYkPX4FFtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHOuGdT1XyE2F16dyfo5v0JWVYIyuEIUv0iOjsWINFmDAa0tyU+dSPLDuMRn5BK/ympfg34SIiAb8rcIXgFdgPyPCEwAa71jtk66u3KRtTXYxPbcMCH2skL1DAgx3JNDixZjaAnJbGDdG6I0WBd3nYBy28QWhJ9bwZsgVrUJ968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AmhW+Ty1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AmhW+Ty1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KE6nfP020677;
	Thu, 20 Mar 2025 15:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ohkyiv
	b2JntPxi2f6tVRC4s5nTv6Vkx/CpTzuwGGtCs=; b=AmhW+Ty132a0+6jVM46dDx
	zOuw3Q3PCMXR/r9hgAaQH4KASSEobzFsZrXkBkbIR9zn92+6G1K/M9X4TkCjwZPE
	ccw7uRLeVO3L9OdLFpDnPjGT5DsDv4fRkyY/hCaBPem/p7TsXG7Tppv542IXCcaB
	QzaXrRqgAktwA1HwVNJ5PdUJ0FOpBhNhr0NqNW1OXPO3+AOV4SiAovLpxFTRA2Bf
	n5m2QAoYdy/XHvx0CGwmbLbb88+J7uviGtxzfTK6Tg/NjoqzBFCLT8N2Oujjsl8C
	ewTeggmHMJg/mV/2Q6XRHejVV0W7J7fKN6IFB+NxxKQRH8xgRT59lRFDtnYUe/HQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g23ve028-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 15:18:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KEf7ul032337;
	Thu, 20 Mar 2025 15:18:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvtrvjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 15:18:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KFISOD46399864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 15:18:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C517B2004D;
	Thu, 20 Mar 2025 15:18:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6814320043;
	Thu, 20 Mar 2025 15:18:28 +0000 (GMT)
Received: from [9.179.0.254] (unknown [9.179.0.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 15:18:28 +0000 (GMT)
Message-ID: <88ab3eba-5e37-4edf-aed3-0d0e3a282031@linux.ibm.com>
Date: Thu, 20 Mar 2025 16:18:27 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/20] s390/zcrypt: Rework ep11 misc functions to use
 cprb mempool
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-16-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-16-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v-ipwKzjxv3H2rynxGs7rcYWyYf0brCw
X-Proofpoint-GUID: v-ipwKzjxv3H2rynxGs7rcYWyYf0brCw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=912
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200093

On 04/03/2025 18:21, Harald Freudenberger wrote:
> There are two places in the ep11 misc code where a short term
> memory buffer is needed. Rework this code to use the cprb mempool
> to satisfy this ephemeral memory requirements.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/pkey_ep11.c       |   3 +-
>  drivers/s390/crypto/zcrypt_cex4.c     |  12 +--
>  drivers/s390/crypto/zcrypt_ep11misc.c | 104 ++++++++++++++++----------
>  drivers/s390/crypto/zcrypt_ep11misc.h |   8 +-
>  4 files changed, 78 insertions(+), 49 deletions(-)

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

