Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DB4C9012;
	Wed, 29 Jul 2026 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336598; cv=none; b=PUsgwg8qgcnEhHHkcAoBBAfJHjsJibnsvmy6Rq7Lq+AIfvWMSe3NBG4zTWRjZ3RgPULSKvgq2cDaahKOonMwQIEUveJ/zuWP+cfJKSpIdFT+5/jXbjLM1ZZZK+skZU90T32EkX4u+lVIjAuXI43EMV9bw2C06e0t2yZ668KQuc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336598; c=relaxed/simple;
	bh=TfDdYKKT9Di6BeQgvEqGIajK/at884WM3EaGvApE9mA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gBT17Rmyx+LF7mHH4EeoaezDYgnMH+JAuWaZjzWHEb/QHYoxdNMCJn6622f752dQzqvpFgNaO30HblV9Qiaea+9oXhRNtmzrqvPDIUQkZ4KpH5Rcv1/R1enZkvk5AYLDRVFGutvLb3au9NpMYrvGirC1Rq3StsnRebalVi7850M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CnbHQfkr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CnbHQfkr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TElnHb322437;
	Wed, 29 Jul 2026 14:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=fh1OsNVlhU3GjwgDCuLr+GMbR5usS8tj0WUHP43pCzU=; b=CnbHQfkrVUlc
	KFnVyjjGVNiHxdYrYecq3MOD5iKxuoFQeZMSmC2TlGA1FYqyBK8utYzkNv0JJMnL
	MO3ps2SH+wODJlyw6MLe1HITFQ78mp+MoTO4Rcc9Z+dNpxmDO+4klAxtX3Ex8/d5
	xFLWv/5FpucSFUMtKJihiZP452K8h22fn8IagyJuOUYNDXiRr9Q9/Ng8qlYoUrcg
	AsIxpky4Al/x3mwSV6Q25udEU1EqQ7yIRTd38Z2hxsU0yzlFj6Qbz1Qz+T2t0+AC
	781Y/d158rIvoQis68sBtxrtLR2ZPiXfvXhNG4LCeIbNBaqjO83P11LFOJcMz3nM
	TcHW11NN7Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xu8me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 14:49:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEfMs6009259;
	Wed, 29 Jul 2026 14:49:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y6ur5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 14:49:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TEnsOo26477236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:49:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 352D05805F;
	Wed, 29 Jul 2026 14:49:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FE4D5805D;
	Wed, 29 Jul 2026 14:49:53 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:49:53 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 16:49:53 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] s390/zcrypt: Fix missing mem scrub at clear key
 import in cca_clr2cipherkey()
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729141220.E28071F000E9@smtp.kernel.org>
References: <20260729140134.191448-1-freude@linux.ibm.com>
 <20260729140134.191448-2-freude@linux.ibm.com>
 <20260729141220.E28071F000E9@smtp.kernel.org>
Message-ID: <6c3731e778b0882cf7f6c356d71fac83@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8IZEZIKWzAUuL6_Q_4LZC7uOChFAmGdJ
X-Proofpoint-ORIG-GUID: 8IZEZIKWzAUuL6_Q_4LZC7uOChFAmGdJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX4FNPSRjfXCEx
 XF7XKJTq74DNr6U1SDMFo66926qtgG9ta1CwGZ83XRZIF3DXfB2crFCxQ8+KdM+gH8g0qGtIQOx
 JMc0ebXeXv0z4h87eId6kV2rxxMJQtg=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6a1314 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=5OT_ED_vbPaHr4bv3HIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX9uLNsCTxrz9T
 oe4yEk+7ccWTVo/zUtCVra1hQ1p83PKMIc62rThUvyWCCgDtR5XFjt8QoxHPziyy29CJKuJWaLZ
 bh04EWkXl7hxTRNW2B6OYeYnpbDpU0SzyXd24ilNE+K2kI2vxXaT85uKBdhPuH4F6hRo2PnvYKL
 jiIrnhXYfyc2oY95kVtDZsinKSFhLNSacH3aEfw2h5l1homcIUsFHeW5AINsXVBEWHDhdbIFsWe
 6stmROs0Z/6wfWtv5OxamZazZIF8wjqBZQyDx0GuX8ElNYHVBhtW9Fi0GjHGSjV022FGrvauAZo
 iy5YeCYlKf7Tawu0Ps/0bnF3m2KBX7+Ysvj5bd6KmX9kBG3VqgTnDb8ly1QRGWPMK3HsvbFteEO
 YqYv2ihXJ+o7Qdt+EiibeeuaPqzrigB8Fspn/1vQ0S49Kje+qzCBITeROGoalwpTXI5/tU4qEPf
 KYH7ZgKEFfdKI4l96iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290120

On 2026-07-29 16:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unvalidated length field `t->len` from an untrusted hardware
> response leads to severe out-of-bounds memory accesses during
> `memcpy()`.
> --
> 
> --- Patch [1]: [PATCH v2 1/1] s390/zcrypt: Fix missing mem scrub at
> clear key import in cca_clr2cipherkey() ---
> commit 0678dd664c1b50d9a38dff946d27b4823de1e205
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Fix missing mem scrub at clear key import in 
> cca_clr2cipherkey()
> 
> This commit adds a parameter to _ip_cprb_helper() to scrub the CPRB 
> buffer
> after processing clear key material. It also adds explicit zeroing of 
> the
> buffers before freeing them in cca_clr2cipherkey() to prevent sensitive
> data exposure.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index 84936a795b956..9cf268efd4abf 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> [ ... ]
>> @@ -1111,7 +1112,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 
>> domain,
>>  	*key_token_size = t->len;
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for a compromised or
> malfunctioning hardware device to return a maliciously crafted response
> length in t->len?
> 
> In _ip_cprb_helper(), the unvalidated t->len from the hardware response 
> is
> directly used as the length for copying just before this line:
> 
> 	t = (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
> 	memcpy(key_token, t, t->len);
> 	*key_token_size = t->len;
> 
> Without bounds checking against the actual buffer size, could this lead 
> to an
> out-of-bounds read from the device response buffer and an out-of-bounds 
> write
> into the key_token buffer?
> 
> Also, on subsequent iterations in cca_clr2cipherkey(), the poisoned
> *key_token_size is used to construct the next request:
> 
> 	preq_key_block->tlv1.len = sizeof(preq_key_block->tlv1) + n;
> 	preq_key_block->tlv1.flag = 0x0030;
> 	memcpy(preq_key_block->tlv1.key_token, key_token, *key_token_size);
> 
> Does this cause another unbounded copy into the smaller parameter 
> buffer during
> the next loop iteration?
> 
>> 
>>  out:
>> -	free_cprbmem(mem, PARMBSIZE, false, xflags);
>> +	free_cprbmem(mem, PARMBSIZE, scrub, xflags);
>>  	return rc;
>>  }

This is a valid finding but will be addressed with another patch series.
