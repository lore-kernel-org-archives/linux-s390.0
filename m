Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089040A926
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319835; cv=none; b=KqMsQ0vyBXo012B76oyXT+qgAV1E00fxYGbEXF2G560VKzBJGW7MVGAM0Jwm+vpBlgdycZKbIod58mdxjmJqVEmd6AQbwHCRn9rxsWPiksqMxyZbhiPyoYGVrGTb82MhD0Uuly0SAQBFJXgsdGVakJXujaJdiwrGyJMoH9GJoR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319835; c=relaxed/simple;
	bh=qDwHArMw9yREsj20hmSF5ZsnnpkwByrJFAxnl7jUjCU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YJh/yjrELHF73atfHlaO5ObUETaOtE3j8GE7badAXtINoiqDDRPjuFaowJ4gy2URFlIerjPbWyIiVkC+DSmaJpTeHOfJ3N09ifzDUwot3auDZwRwf1posztEBt9qRmJ0ve3ntDcMFO1Ox2gDL3UYCI/MeKVmTpAht9fJIJydtjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uapza/87; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uapza/87"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7mHis3634537
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=f2k2XL2F5bqjcuKOweSM29awNo5zLyd/F8/m4jNgs7Y=; b=Uapza/87X05t
	9W/WeXmX+pL+ZBwC8n/NAZaz1Q8mPTKEeBUEY3SnhcIHa2eJxv+o9SFwfh69xjEQ
	fDU7jk6Zx04+LZpK6HyFO2T6Vap7m925iLwGATvpwShD13CFdJutZfKIN+Wu3Px8
	w1vfPh6qFlZkqAT5S9ZX5gxGil9GBWPHR7ImKB0cFt8/qu/TGVf+eg1m0zF5Ut1L
	dFSUavWb6/pQBxyVztQ0ba1rO5aufMiN7VHIoyiQKla5UA8yucLeGl8UFFnbs/Sx
	piCwSMw4l2pionW7wLk4g18MjRXeOekljIjIstfLW4iqjEEj6jUMkrgzxNuMBlgn
	sBPJ8yPDaQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd1ba5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:10:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9uHp2026989
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:10:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhe3tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:10:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TAAUYZ5767704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 10:10:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB3015805E;
	Wed, 29 Jul 2026 10:10:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65D2D58063;
	Wed, 29 Jul 2026 10:10:30 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 10:10:30 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 12:10:30 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, ifranzki@linux.ibm.com
Subject: Re: [PATCH v1 2/2] s390/zcrypt: Validate length for CCA ECC private
 key requests
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729093616.4184642-3-dengler@linux.ibm.com>
References: <20260729093616.4184642-1-dengler@linux.ibm.com>
 <20260729093616.4184642-3-dengler@linux.ibm.com>
Message-ID: <7d09036eee4adc2f8b0d3d5e6a55cc09@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ixVgse1SD7VW6LYVMxNuiNB9OATx9scS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX0t0ndXZk2YC2
 Yt9qkvqn2A7sp8qqSbD9tudIKAk0h4wDsuF4QwAtGAN4SwUrpjRSb9S89loSIzI8xtOkIjn2Wge
 IOfXy7Abr49ECqOK/wP/G8BoqDw1sbY=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a69d198 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=BIPCGI_ErTR_zndWCXMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfXzoWbLi2YwA8s
 rAIMlkR2f43oyMS71MA/KSLxSy+kwg6Q8Mf7giXRv4ZrlEb8g5JgInu8tfPOM78Xe6k3WvTQLbF
 vZ/L77tnU4RiNGKaHp7Rj01EzYsHYzdcNnP4iNzO9lipez/5jJEkwRRbxqnLiipGUWl9Q67mrMq
 5GthnXG6zBMF43WxADoJQP5LFELrC/Krjs76smqVGLxVWpTlB7MG9PbcJ4NuaM/xXXdz3I6uI/d
 uh9sC9Sg/c6f+5COlW0kr60mVHqC7WZJPOM4cfBxaubk1ckmn1Aa6TiEqtSZXwzpyd2McpG0nRt
 PjktRNqUtVfcYh8peHY8Y1kE7DCiulwGDU/9i9thdM7wJ4UKltBjr4sxDojo8TKtGGcvfg6DZ9J
 Osds4IK8YqDqWJy4vuWIaG2OQQIM30KgZDQcX1jDxbWMeychgNQjCaSFVRh6ZF9dXpbsf2A0hCm
 mppV3/8dq5FU7uV8BHg==
X-Proofpoint-GUID: ixVgse1SD7VW6LYVMxNuiNB9OATx9scS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290080

On 2026-07-29 11:36, Holger Dengler wrote:
> cca_ecc2protkey() derives the copy length for the CPRB parameter
> block directly from the length field in the key token. Reject the
> request early if the token length exceeds the available space in the
> parameter block.
> 
> Fixes: fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC 
> private keys")
> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
> Cc: stable@vger.kernel.org # 5.10+
> ---
>  drivers/s390/crypto/zcrypt_ccamisc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c
> b/drivers/s390/crypto/zcrypt_ccamisc.c
> index db6a4211a97e..322677a8d320 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -1428,6 +1428,9 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const 
> u8 *key,
>  	} __packed * prepparm;
>  	int keylen = ((struct eccprivkeytoken *)key)->len;
> 
> +	if (keylen > PARMBSIZE - sizeof(struct aureqparm))
> +		return -EINVAL;
> +
>  	/* get already prepared memory for 2 cprbs with param block each */
>  	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
>  				    &preqcblk, &prepcblk, xflags);

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
