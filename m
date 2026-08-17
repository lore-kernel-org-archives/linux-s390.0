Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82A3BBFCC
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954595; cv=none; b=IZLAAod7Pinnr8QoiwKY/5jTjHJTa8Vx1dlPqrVsW38AKwuaUWd4m6SldHtxfGRJ5vDzAeMi8/w7TUk05+5S//mEtGjnT9HCZjLT9zUIUdKYOA8pR7HKHergckDTD+78e7hbFgfR5jC+TSS9OSTiLlAcrli0OrFdY6ywXyU8QP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954595; c=relaxed/simple;
	bh=CPwK2Rs7jXqC+uBv+wRVRPdxKgJjsR2FkhFEcLMlEuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fbyo0fCxjVhMgjAxgTU6HRAbywK+8S3yAH6ncHngdzAvQPXHp+bphdvmHNdi0y+SyArRRgawMs3r9IqZglN4ST7nZUNCVj+jQp7vY4LbUpRv7fl+jISodGhdj3nvppVrHTXxvI9lBHePGncfPWpagjwVAJ8bAaVYaNxqOig7MDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aQ13v4Cl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aQ13v4Cl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVxIv3780637;
	Mon, 17 Aug 2026 08:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VOPG44
	O4HIMjWntSuBKTQO3ZgNAFXwqxTHdfBCBQvcI=; b=aQ13v4ClFdYFgbsNWWsmXk
	n/dkkAp3IRw6fObZaKDNPbemQdkygUCrXbtVbXyAqVUCWTqb6wh9zK/gze5FJUvm
	YqQOi8Wu+09FXVPN1lPwpXKevSAawYahJPkypREUrhAiOvTTcNPrXOzqYH8pPBXP
	pnNMsGc5Acoaehw6QtOuNwUFdPumve9XbKM1g8KVCfPA4pJArmYinvNCqEBduZn1
	uizvg43lLE0lC50nSwp639Rgb39nmaUjeX9mcqgtbJh4Gm4z/qyr+mps0ZMBxhyB
	BSLlggAVcg32gJxfx/2Imn1OctvCn82DszyLuSSCggTgG1PJORXDEWnGTS5o9Y9w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt0tw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 08:16:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8BMw0015616;
	Mon, 17 Aug 2026 08:16:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejw3b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 08:16:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H8GKuu50594272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 08:16:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B0CD2004B;
	Mon, 17 Aug 2026 08:16:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 881B020040;
	Mon, 17 Aug 2026 08:16:19 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 08:16:19 +0000 (GMT)
Message-ID: <6a798449-ad89-479c-8ae4-f20890c80e6b@linux.ibm.com>
Date: Mon, 17 Aug 2026 10:16:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 10/19] target/s390x: Minimal AES XTS support for cpacf
 pcc instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-11-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-11-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a82c358 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=A987XOehK6aIy2cMV7AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfXwi07+7MMRJTo
 wyRpBNlmTLXc1ufGNu8ee7Gg61Se4dcjw9PDuniCSls5M20DUm41Gi641y5iecDPkyIXTJq6HdC
 hvL20HEynqazbSJI3OReCWUBv95UiWc=
X-Proofpoint-GUID: VNmrpsZUy7ULOqaUp9D2T7BtrFYTA4oP
X-Proofpoint-ORIG-GUID: VNmrpsZUy7ULOqaUp9D2T7BtrFYTA4oP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX25DfgmSunp6y
 Vk3msBxTcEZMyFTV++a2FsitWB0yd5wpnJZ/AVv7b1Mlsj0KMbHYE/ftjckB5ZmIPRaoL22qSkm
 aQvHf/g8MHIF8oRBoR3aPOlPapPfs+qafnC2CmOuH15t/k73J9rMCZkIK6BkNw8x1v5q3vGRPLC
 h0+qq9uqZaR7axxQML2qxNnVUcDTNehnANqYYftsZTL/kGm4JeAPx0GlWl1qt6kf9bmYE6WOQLt
 VFZCj81CdgXmhulLy6RkcMUOdGDwHTBfLDlgz35vGBgSAMeviNpAPWocKN7UUhYIsYCh2XT/SPE
 BsoxgMuSo+j67Suo7loSDvPj+8QzPsMMGUHgvO4ggHC3WtYdZQdvr7anZHEGQniBUdVJgICfPrl
 sx4ZYRnk2RdtEXVgEJ9rk9GRn1HQ7PJEBD2R/O7/QViuaFBLUtK+YcI9auezKSFnFlri5wxaXDE
 LI2kA0dQkZLke/vnxFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170059



On 8/6/26 17:12, Harald Freudenberger wrote:
> Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-AES-128
> and PCC-Compute-XTS-Parameter-AES-245 but only for the special
> case block sequential number is 0. However, this covers the s390
> AES XTS implementation in the Linux kernel and Libica and thus
> also Opencryptoki clear key via Libica.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  2 ++
>   target/s390x/tcg/cpacf.h         |  2 ++
>   target/s390x/tcg/cpacf_aes.c     | 54 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 20 ++++++++++++
>   4 files changed, 78 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


