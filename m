Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198245D5FE;
	Fri, 21 Aug 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302919; cv=none; b=Etd80hgNCa0Crope7AIbgsY5wLj+nu0k57M8+lS5Tc9eWsZx148F5oD7fp59jcwdCI67Rbx/mPMONXlnR/1qxpxfEGZt8ZXsB7vYxBe9B1S1k80hZ+Wh6bkKNqKCxoNKvcP7CHLBOKi35zxfFQmj6Cs+pYevoJMyg2Kz4YicmbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302919; c=relaxed/simple;
	bh=zINNmn2/lX9uijtz3TjWlun7DkqU3QFWydCDlX7vauY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sywqZgKs9Kw/Zh3G4uqu3/eYnPUNa3s3r8n1A2EiU7wA+S5RTU2LSVsecFeQVQ0HAAnIpeSp/ZgVzyb6OJFx7pVx64GxbF+FvvGR69Zhr64IZjB6Vvzrvdrsi30I0AiU687hmJrISMun+YOeUArePyvXIiIztAeIsfgQdwsr/Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FZcUBZzM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FZcUBZzM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8WXVd999179;
	Fri, 21 Aug 2026 09:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=JuRlX2uodXrOgJ1brV7hYmXgp4e0frap+2yQqbjAJa0=; b=FZcUBZzMPWke
	8hPzOq80UJ2yz+nmr65U0WwFE8OZHqjHQa25ZLMH6prwleOkH7MmONsZheWtTaIa
	FS6EqTlELk38cjJvzyBTYMC8SCOGb4vx3dUbnBSZ1otxUVYPaxMf7W75E5Zpllgr
	Aug1rAptZrbh0xV6seCAdm79qPooWg3ONLZ6IC4Ygcmb6qaz0TNd/BLW0haklS8B
	Gt+xBnlRTWIwG55EfRaAwtFMcf714lLR98BDLjWnWytfClXyVBeGm5JlzIzYOVEd
	nSe0SIL8NVxRIW8DY1g3TZAOXCfYymrcn8qESsIL+3L443XUmw+g7sMqHOP0xscp
	xfyn4dweVg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4g3c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 09:01:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8uV28006889;
	Fri, 21 Aug 2026 09:01:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngues7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 09:01:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L91iXP62128440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 09:01:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E5485805F;
	Fri, 21 Aug 2026 09:01:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1116158043;
	Fri, 21 Aug 2026 09:01:44 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 09:01:43 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Aug 2026 11:01:43 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v6 3/9] s390/crypto: Fix use of mutex in atomic context in
 PAES
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260821085635.D6BC61F000E9@smtp.kernel.org>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-4-freude@linux.ibm.com>
 <20260821085635.D6BC61F000E9@smtp.kernel.org>
Message-ID: <5f077680b9797530ea64aef75ff56f8f@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a8813fb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=6YwGb265LKlJqqV16GsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: qBiX0V6rdCf54tm9RMEvq2SUD8LzzSoo
X-Proofpoint-GUID: qBiX0V6rdCf54tm9RMEvq2SUD8LzzSoo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2NiBTYWx0ZWRfXyMKrx+RTYTQm
 aqe/5Xnom9Gn7r2nGtsZeulz4DCQSc7UT9e1kVBeN+NqCkYZK56E2i2r7+ou6pqCS5nhMfbOOp2
 ZOCLDgTS2G+yNZoihU2VMhcuOWOLDnA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2NiBTYWx0ZWRfXz4e1rl/gxUUW
 FSJKpSXFhQREG3ezY+Pl+jYLH8KI5oz39xyRoxtdhwAcFm/328mdcaJajP9hrLy+cbMORQ7mRqn
 dBdF/BI6YohsBmglt2krgfHKYo06nzjg2NXJR5xP7No0a9WM/G5wFjbwfYC0w/7ynCfCneownvU
 CNTm9h7tOEXNcpawfL8ZeMFVA9SWdPC6Wv2ZjmjxI8OSIOQpcWXFjQRCnFo1XU5NNkOwlndHGya
 kmGm1Y3TGB1Cp7+zSaDbi8x/r2O55lStyLKDO4RwBtgQXpuD8f8QDASoa+4KC+FGAMeppBBq66N
 IADMRuQ1LhWcxAm5qKlvjv1PQfXnyvmXXLA/uIXo6gqXdIbUMHy+K6b1fDGtuTE8KCeawpEXAAc
 VbL5DkaRPbjW3bfif9l09aduYl4TbUIOEmVnrAPKqcnEWYlSpi0+DriTpfoyu8z1nWcPD/NlHYa
 sg74LKpX1uRD6kvm0iQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210066

On 2026-08-21 10:56, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `aes_s390.c` module contains the exact same locking bug
> in atomic context that this patch fixes in `paes_s390.c`. The
> `ctr_aes_crypt()` function uses `mutex_trylock(&ctrblk_lock)` and
> subsequently calls `mutex_unlock(&ctrblk_lock)`. As the patch's commit
> message notes, mutexes are not safe to use in atomic or interrupt
> context. Synchronous skcipher algorithms like `ctr-aes-s390` can be
> invoked directly from `softirq` context (e.g., by the IPsec stack).
> Calling `mutex_unlock()` in `softirq` is a strict violation of kernel
> locking rules.
> --
> 
> --- Patch [3]: [PATCH v6 3/9] s390/crypto: Fix use of mutex in atomic
> context in PAES ---
> commit 425e8f1d3532a176433992d286f917e0fd14ff9e
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/crypto: Fix use of mutex in atomic context in PAES
> 
> This commit fixes a locking issue in the PAES CTR implementation where 
> a
> mutex was used in atomic or interrupt context. It replaces the mutex 
> with
> a binary semaphore which is safe to use in such environments.
> 
>> diff --git a/arch/s390/crypto/paes_s390.c 
>> b/arch/s390/crypto/paes_s390.c
>> --- a/arch/s390/crypto/paes_s390.c
>> +++ b/arch/s390/crypto/paes_s390.c
> [ ... ]
>> @@ -45,7 +45,7 @@ module_param_named(clrkey, pkey_clrkey_allowed, 
>> bool, 0444);
>>  MODULE_PARM_DESC(clrkey, "Allow clear key material (default N)");
>> 
>>  static u8 *ctrblk;
>> -static DEFINE_MUTEX(ctrblk_lock);
>> +static DEFINE_SEMAPHORE(ctrblk_sem, 1);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but 
> arch/s390/crypto/aes_s390.c
> appears to have the exact same bug that this patch is fixing here.
> 
> Looking at ctr_aes_crypt() in aes_s390.c:
> 
> 	locked = mutex_trylock(&ctrblk_lock);
> 
> 	ret = skcipher_walk_virt(&walk, req, false);
> 	while ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE) {
> 		...
> 	}
> 	if (locked)
> 		mutex_unlock(&ctrblk_lock);
> 
> Since synchronous skcipher algorithms like ctr-aes-s390 can be invoked 
> from
> softirq context (such as by the IPsec stack), would calling 
> mutex_unlock()
> here trigger a lockdep splat or crash, especially on PREEMPT_RT where
> mutex_unlock() must be called from process context?
> 
> Does aes_s390.c also need to be converted to use a binary semaphore?

Allready addressed and fixed with the aes_s390 patch series.
