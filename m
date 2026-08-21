Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68444AB86;
	Fri, 21 Aug 2026 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303064; cv=none; b=aDRCl5CuTrpjTgC7lM0Yxvyh3v177NYbbpCdTFXl6ZB8+ik6EVH9U9dZK6QrZl3yVeAOiO3kq3GqK7yG2Nu4ZjwDh+i6si9v5AhyQZs9Wi7wQ1kpdtLamM/ot6uzvyDPLesRO/S6MPj5pgiV2/ROnXSzFGuP7UiVpFaGv5x4PwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303064; c=relaxed/simple;
	bh=KRq/ZEdtr4foAT42/RN5eRYTQW96hDxBN5qyU6sUgVg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iTSz+z0yJJQxNIMb5o2l0OBxTi+uaBTZo9nj9Q/RNJdyQYJp5uFFi1EyKS++Yd9d7fPMGS0OwTedtT+Hy+bL32l49O4L71DdaAy6V6CgIp6XV46VgLe+EDha2Leqyq77/7P6XVY+ufaO+WmplZWW5ORPvspUKvs3Oksz3hImL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZvIhCZvn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZvIhCZvn"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8Ww0G865126;
	Fri, 21 Aug 2026 09:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=XaB0zDCpeiTp1aeqZzXf5tCGKxjG3pGw7RYwZki0a+U=; b=ZvIhCZvnnA8o
	GbF52sO/vUAb//JmXUQFYfPE574TGGWSFmEyYGDlXojZKW3nGgX4fzFTOibveV2S
	sY16adBrak0IxkB2/3AoKiHcCugXnh8ickuJ58eaCngnaUk0YShF8Dng7cTbW27c
	OxCP39V3l0tsQfXI+BQf1FUvw0qu2qJTHIhZ6W866AzM8vHa413wWrY6mpjHTrn+
	6m37ZpjChhxeOioYjxvOGP2oeEBRg/9X6AEjn1Z61CMlDMTuxKbSkStEBbyCiRnX
	zieQLysfhsDfSFJfx/KEcwyuRhA9FFGLHO0DrwSu0pChuSFkhbVd+jl45IDICqFL
	z4iLS4gNGA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4g6av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 09:04:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8uR15021577;
	Fri, 21 Aug 2026 09:04:02 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekknm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 09:04:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L941Kl26149388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 09:04:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5436658054;
	Fri, 21 Aug 2026 09:04:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7959A58045;
	Fri, 21 Aug 2026 09:04:00 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 09:04:00 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Aug 2026 11:04:00 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v6 2/9] s390/crypto: Fix missing scrub of temp buffers
 with PAES algorithm
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260821085838.72BF31F000E9@smtp.kernel.org>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-3-freude@linux.ibm.com>
 <20260821085838.72BF31F000E9@smtp.kernel.org>
Message-ID: <d199b84f91223e029ca485daf67e75db@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2NiBTYWx0ZWRfX0FRMIXCHTBTC
 dy0jXQp1bpHVU5k88KUpY+bZddea+H771sfYH34hyX6OvWp90asRPJdzHEpb7ALaAyDDzAJMfq3
 gsGOVexaIVeVGs6IUs4Sbcxau5nNpl4=
X-Proofpoint-GUID: 76i4dY28iup1j97ahWzqkfJBiS0U4fv6
X-Proofpoint-ORIG-GUID: 76i4dY28iup1j97ahWzqkfJBiS0U4fv6
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a881483 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4yp_TtUT6I-ZBWVuuD4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2NiBTYWx0ZWRfX1APX1rat0Xy7
 9Wm3dLOVSpEFkLF1bx/XR30Om3jhUniP4Vw+YfpsRPD5SJiWEpLDqg22vTUJV6Y/aY0HXw98QL1
 dxUoEwe9aE0FQX+vZfOaPfmrjCpgRKhRy+FaZrxtjqLs+NSje0MsUZ0xeusLVmFukFOBET/2hkL
 Qt+V6YWipuZJ6XL0uruBKqFhV0j02bDa9l85MByIXYoL8kcObT5EDlfRHwLhOm+VQxCH6q41+i3
 0QCW3bL1ywrwyer01qdE44HWhDaS+RaY6ZFROR9HMMDs7JmkarfkKTvF5aF9qiAAtKyzsuwkvNv
 uMmiQt67AeuDs3E774APf/owsvWkb32VdAHcj3+bViFKtKh5QVBx5Ua0T9NPmf1yYz3tmPlt1cs
 ZvFQDzAfdttK9msgXy1rWp2wCK1E6Rbq11Ez/lwuYDTajDLWkBl1TR6jUUNZ4NYBZIGA/eBPxmv
 n9zFJawQUIZkZXkUfYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210066

On 2026-08-21 10:58, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing explicit scrub of local stack buffer `buf` in
> `ctr_aes_crypt()` (standard AES algorithm).
> - [High] Missing explicit scrub of temp buffers in `gcm_sg_walk`
> structures and AES keys in `gcm_aes_crypt()`.
> --
> 
> --- Patch [2]: [PATCH v6 2/9] s390/crypto: Fix missing scrub of temp
> buffers with PAES algorithm ---
> commit 0f77835bffb943e6b87472b41b755be562bb23c4
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/crypto: Fix missing scrub of temp buffers with PAES algorithm
> 
> This commit explicitly zeroizes temporary stack buffers used for 
> partial
> block processing in the paes algorithm. It also updates the scrubbing
> logic in the xts parameter preparation function to clear the entire
> parameter block rather than just the key field.
> 
>> diff --git a/arch/s390/crypto/paes_s390.c 
>> b/arch/s390/crypto/paes_s390.c
>> index ccc7da106c3a0..d075b0241f1f5 100644
>> --- a/arch/s390/crypto/paes_s390.c
>> +++ b/arch/s390/crypto/paes_s390.c
>> @@ -1044,6 +1044,7 @@ static int ctr_paes_do_crypt(struct 
>> s390_paes_ctx *ctx,
>>  	}
>> 
>>  out:
>> +	memzero_explicit(buf, sizeof(buf));
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while you are fixing the 
> missing
> scrub of buf here, there appears to be an identical pre-existing issue 
> in the
> standard aes implementation.
> 
> In arch/s390/crypto/aes_s390.c:ctr_aes_crypt(), the local stack buffer 
> buf
> is populated with cryptographic data when processing a final partial 
> block,
> but it returns without scrubbing the buffer:
> 
> 		ret = skcipher_walk_done(&walk, 0);
> 	}
> 
> 	return ret;
> }
> 
> Since this path is reachable by unprivileged users invoking the 
> ctr(aes)
> algorithm with unaligned lengths, does ctr_aes_crypt() need a similar
> memzero_explicit() call before returning to avoid leaving sensitive 
> data on
> the kernel stack?
> 
> [Severity: High]
> This is another pre-existing issue in the same subsystem, but looking 
> at
> gcm_aes_crypt() in arch/s390/crypto/aes_s390.c, there are error paths 
> that
> bypass the existing memzero_explicit() cleanup completely:
> 
> 			return -ENOMEM;
> 		if (gcm_out_walk_done(&gw_out, n) != n)
> 			return -ENOMEM;
> 
> If these error paths are taken when processing fragmented input data, 
> does this
> leave the aes key and hash subkey on the kernel stack?
> 
> Additionally, the normal exit path cleans the param block but doesn't 
> appear
> to clean the buf fields in the gcm_sg_walk structures (gw_in and 
> gw_out):
> 
> 	memzero_explicit(&param, sizeof(param));
> 	return ret;
> }
> 
> Should these temporary buffers and early return paths also be scrubbed?
> 
>>  	pr_debug("rc=%d\n", rc);
>>  	return rc;
>>  }
>> @@ -1377,7 +1378,7 @@ static inline int __xts_2keys_prep_param(struct 
>> s390_pxts_ctx *ctx,
>>  		memcpy(param->init, pcc_param.xts, 16);
>>  	}
>> 
>> -	memzero_explicit(pcc_param.key, sizeof(pcc_param.key));
>> +	memzero_explicit(&pcc_param, sizeof(pcc_param));
>>  	return rc;
>>  }

already addressed and fixed in the aes_s390 patch series.
