Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD473597B
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957219; cv=none; b=q5akBTU3MNcrRQYl7/cAWf0LrPDJvWfyQb+OV7Usek+cVeCEiVaTC6nAYUElZc9Lnr/De2FuZlamV4uJ9a1gr3W7i9yLhS148AOdcsmsgAfOdYB2TMXJdyXOiozHgbHqda2c+onm7lmruBHOk60stThHllZS11G5HCyfCVydLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957219; c=relaxed/simple;
	bh=X/fJicKLCOuTZe/XXCScqEGYIyJnHJI0TWJpFii58vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYCgcA8tRnUoNgVLL8kr+Bt4mraRYzek+hhzXVHZTEigImnqPPhAhjGaB+C1hPv2Pzd6JmeVRW4/cLKDLsgbGaGFsLfXDP5dO1u7Ikp705AKfr77XBfTvdIqygqi00ezgVuyCPbS48/oROeSEfiRIf+mIXxDVYulPKCb4+sDd2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l/NkzAQ0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l/NkzAQ0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLWLlF3781469;
	Mon, 17 Aug 2026 09:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+epRt/
	qT6hNL9RHH1FIo2Qx4P+Hdz55gC/aQpn47SoI=; b=l/NkzAQ0CvbxkP2Q0BT0pI
	tCbPPGe32FvC3rDbvqICCnDL61xTEB8KyZZX4TpHUWOdk2Pggh6gyGw7zHjruZy5
	WcIp/CI1V4SqnJ27INJpd0n4D9Xv1sQ5Xphbqh79WzT+s0WkctJiAjvqtqFmalrk
	dDpOl5oefHRoHH9plj5h5OE6BIl6DyHPTKi3/rYBeALSQ9Hzyd+Rs3VpnWhquq7h
	qGZNJw/8xiNAqBk5z8R5uiWR3+DMjlKnBMh3NgRDIxyos0d+e5bmLoJVTxmGKbBX
	1w16ZTj5rZB7gQwtYRBtWn7UyrmyI/mI/t/3xJ7Zg13Cdqau8rxE3mR5rYAiZylw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt11dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 09:00:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8uRln016330;
	Mon, 17 Aug 2026 09:00:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y50fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 09:00:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H9057n41746770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 09:00:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26F4B2004B;
	Mon, 17 Aug 2026 09:00:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9277420040;
	Mon, 17 Aug 2026 09:00:04 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 09:00:04 +0000 (GMT)
Message-ID: <e42723bd-84b5-4543-a1eb-5668d836f16d@linux.ibm.com>
Date: Mon, 17 Aug 2026 11:00:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 17/19] target/s390x: Support protected key AES XTS for
 cpacf km instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-18-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-18-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a82cd99 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=fyHvZGQlsBxjgjT89q4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2MyBTYWx0ZWRfX8OSB2uaY+K5Z
 XaCOWT00vzYtno0JCJVbON7QeTGEkiFq++1aROzJA/DeWiVTh375ePm3lxQAtQ6N43ms/Ib7iBa
 V1WjBCdVyAIc4USchOJagitGT2wwW1c=
X-Proofpoint-GUID: sAHlVmODxxd962wLRphRiqhqOZWrfEZN
X-Proofpoint-ORIG-GUID: sAHlVmODxxd962wLRphRiqhqOZWrfEZN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2MyBTYWx0ZWRfX1/zi/Q+QEE0V
 Bvc3b9F42R2HObEJYSmunIJxSTuQzUBRXzDoaMzGfrDFJDtiy7BhYj9XAXwNo41a4gTZcdVYzhQ
 c3KGpteCKy3oc5bpayx2KEuZArHA41EhagqLKkxIlEBaNBBiNA9cazuagoBCkyOAhrXqru/H71c
 i4tctgUUhser5IHs+v0DKHRebuhXZbEsNakj9uRJEhyf+ati61YnbkrNr2WTcVc0Pp+nC0cqAcr
 GbwghXInwkn19XbJ02GIl8tthhzSKojynE4EE1/4P65uqK5KggmQl0x6O+BQvDeqhJt84J6OE3f
 DC8pxejh5po/USmAEIcwPmG8bVjnS39GRWebpPBi7KYO+CbLzMgIpLYb7xcsx+u5zjkGFS7YTUG
 EW37+qmUSNT2FsSzkUZGB17OZFgHrvDfSQ0Bd0jJWtLgCcaZ+H20ozADVf6+r0uDIKmaxTsrfBP
 XkW2rvHCQ9bjpteZp9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170063



On 8/6/26 17:12, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_PXTS_128 and CPACF_KM_PXTS_256
> for the cpacf km instruction.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  2 +
>   target/s390x/tcg/cpacf.h         |  4 ++
>   target/s390x/tcg/cpacf_aes.c     | 93 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  6 +++
>   4 files changed, 105 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


