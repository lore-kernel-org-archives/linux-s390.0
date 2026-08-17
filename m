Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857C4B04B9;
	Mon, 17 Aug 2026 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952986; cv=none; b=pTgcByRgfW9hqsJg4U2kBchv3MnSYLbUSCWP/PuORHHZUggrMUh/3CjmAhkABgrvqDSx+e+/9RXYgp/SYecNoGsqrNvVyN7ATY/TmK+PumWQ8iWUwFozxAKVe2Aw6dMqljPnqXk97I3kHl63M0GIx02gmOG6LhmQW7GRoFmWzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952986; c=relaxed/simple;
	bh=7qcGDS5qkmbpHU7bThYH9sD+ZrWFoyo4PsminicGzGk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TCbTRirhjnrrY2drZrxrvCRlKwb8/od9gv0pH4D9emcF4j0XxeHS6TQLTeHI3kB//jp0PJ8085keVgSFttLeSQMm+MazuLTDmlfTZUNUIuLTTNoXyCgmtJI0JCH+cOsTmVzbaRUWVhE9qlTDNITm/DYxfGg5yJJJoSEGUGoUHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qp8oKvgT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qp8oKvgT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVpBl1866195;
	Mon, 17 Aug 2026 07:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=GUQj8dYoIzDeUk6i9N5k4W9mUq7+70WfyjO33eMIvaI=; b=qp8oKvgT8rPz
	Mq3EAPdvefcbhvae3b9UUlD/2pmuo/jsyMe23JNXVS0QTdjcOVHmo28wzqYTsaFK
	1J+W4cBNlstGONCGBk0BNJtC5qKv4UD01Wy9K5Fq9yIwYss39pfbtl+abHRG6eUS
	UqSMGOKrFgFSWjUKbOgK/mUGoxzPWOTxEmB7NtzChgVYcptB7SuId8CktpbGOHHg
	7vHqAG413TaakfWchEK6WUsq9V1p+VbvbD66jNKHGRCBkOqeioPavcpjVVVKaFXU
	PdjonsQUgOEpY5U4DmUH1mYwEMNozhtb840hKLyNWDHk3c7P2Sc++15B1DUl+Pc/
	Xl8hZer4lA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqgy8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 07:49:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H7fKgE023593;
	Mon, 17 Aug 2026 07:49:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng4r30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 07:49:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H7n20X27329070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 07:49:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64DA058051;
	Mon, 17 Aug 2026 07:49:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A58265805A;
	Mon, 17 Aug 2026 07:49:40 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 07:49:40 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 09:49:40 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>
Subject: Re: [PATCH v4 1/3] s390/crypto: Fix skcipher_walk return code
 handling in aes_s390
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260814124717.518781F00A3A@smtp.kernel.org>
References: <20260814123711.61145-1-freude@linux.ibm.com>
 <20260814123711.61145-2-freude@linux.ibm.com>
 <20260814124717.518781F00A3A@smtp.kernel.org>
Message-ID: <d0b03b7e575d8b134a4757de628a4e27@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1NSBTYWx0ZWRfXwIgZjmobEFuI
 Qz2m0tJyEiUXxxaANFXkZgnn36sgyTZmc5yh6AryqfL9JUSGUNS/i1nEYawVeq9mkg/AaHBOhR6
 TLsNO9dnIkCV1La3mVBFwnSTGHw0SKf4c0+F4/5qDPNlQvOYhxOu2MtLNAQ+SpO35YPdEShKRQK
 n5M9Yyag88NiGmf+T9GnR+8Svr1dUmrmsZ/cRxH2ROdcDiWs+msS+7D50lL0CvIre9zluyGgQwR
 48+T0IRHJ6tg5hrQkAJCJE4D8o/Ce1uvOcuEiNMX3Imqzm8VtP43RQVsjrYFqoUvc4n3wYOjpW7
 8dzX1FDfi5O3NN/x8N8Rg6vSpE3E7mEhVGSVcH6q457yvPgWa2RdcDwy/ut7tUXe5NgHZGA8BiO
 KSkJD64FVn02RTFVCeB9XOUX6XJMuWHiuBGI5zX4UY+rUvlpklCdJRToGmqcRl8QmqfY60fvM2i
 8NH+R2XSmNzOJtkdmWg==
X-Proofpoint-ORIG-GUID: E2sFs1T1o9eDnG_R5zACLCoUqkn5qRF8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1NSBTYWx0ZWRfX3j1z6nYuTFhH
 duP49e+xexcci4a0oii0gEEc87ds+GSKuZFEa6aInmxfbOVwtrpX66kJ6eFmLQYCvoe9x28e7Y+
 82rjV1U1hIm1u5BF3/HBTokVczXBz+k=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a82bd18 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JOOUwx4Ohz2xeBYvp8oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: E2sFs1T1o9eDnG_R5zACLCoUqkn5qRF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170055

On 2026-08-14 14:47, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Using a mutex (`ctrblk_lock`) in `ctr_aes_crypt`, which can
> be executed in interrupt/softirq context.
> --
> 
> --- Patch [1]: [PATCH v4 1/3] s390/crypto: Fix skcipher_walk return
> code handling in aes_s390 ---
> commit 17298a26fe3f9b4cf4ce956d4ad5d1b5f20ca7ef
> Author: Harald Freudenberger <freude@linux.ibm.com>
> s390/crypto: Fix skcipher_walk return code handling in aes_s390
> 
> This patch adds proper return code checking from skcipher_walk_virt() 
> in
> the processing loops of several symmetric cipher modes to prevent 
> operating
> on an uninitialized walk structure if the initialization fails.
> 
>> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
>> index 62edc66d54788..366ce22d36237 100644
>> --- a/arch/s390/crypto/aes_s390.c
>> +++ b/arch/s390/crypto/aes_s390.c
> 
> [ ... ]
> 
>> @@ -577,7 +577,7 @@ static int ctr_aes_crypt(struct skcipher_request 
>> *req)
>>  	locked = mutex_trylock(&ctrblk_lock);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can using a mutex here
> corrupt the interrupted task's lock state?
> 
> Since ctr_aes_crypt() can be executed in softirq context (such as 
> during
> IPsec ESP receive processing via NET_RX_SOFTIRQ), calling 
> mutex_trylock()
> and later mutex_unlock() assigns ownership to the arbitrarily 
> interrupted
> task. Mutexes enforce strict task ownership and are explicitly 
> forbidden
> in interrupt context, even when using trylock.
> 
> Could this trigger lockdep splats, incorrect optimistic spinning 
> behavior,
> or hard panics on PREEMPT_RT kernels where mutexes are strictly 
> task-bound?
> 
>> 
>>  	ret = skcipher_walk_virt(&walk, req, false);
>> -	while ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE) {
>> +	while (!ret && ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE)) {
>>  		n = AES_BLOCK_SIZE;
>> 
>>  		if (nbytes >= 2*AES_BLOCK_SIZE && locked)

Exactly this is addressed in patch #3 of this series.
