Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BDE38DC75;
	Mon, 17 Aug 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952900; cv=none; b=obuPDAbC9sFNuE5F87J63nDt8PTqAofUZ6lniWFEi0j+W3eaArHWT9f9Eqr6w7e8JBHyDOgV63wnygLNJycNvv5lWm14K6cOOrBHfLKxnb9SiCR5Su4Gy7MIlRDg1tEZ/vO+TJaLv1eBFwi5aCPaL8GrES839QFWDrs/ESJsMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952900; c=relaxed/simple;
	bh=xHXMGt4TucL9+uiDKbE63/6/efVYXob3l5iK+D0oF0Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CeRqGY2kzVmnOD4271nf9EdzFFVvR6wwjJaFpUgq6j1Vz8glGXDZe2hvXY+l+NL08XeN/eQiYoKs5C8TpgUIbxGkjMezoKES+4yDNef2lElYSXZzLNQLZom4ss7T7hHYq5yWoyVtb8riMYB0i4++SqNUjw7pqOr8EikdmBbvveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mRSImmYz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mRSImmYz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVgEl3636077;
	Mon, 17 Aug 2026 07:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=smW3u6keRscsJ77PAuZruIiMO1IKBuZjk0hVhjzVgRo=; b=mRSImmYzIvyV
	UqGgsg3hrtBC1TZq4CIwIJ+o7JHsNr5rw7RaNsLCU2lNBPEy6RQVKFlbkJAY/8BE
	ooJ2RNZAy+maFNCIghf8TnAeXWD0opwLbuPhgOYTMuOuPA3EJGZm+ZM41KdTRMAo
	I3EGFWqXX4coYFEqA5WhDV9iWHeJm6OK+TXvdOYvH864vVqSNHkk2hdtt+AjyDTb
	DppaiFzr1xqVN+/SmgxxLLY9GikXMXG7PXu3kd2Q5ikB7m2qjwtGV7ccyqJexImW
	zey5MYtemJqUEQ+dLWAtFK5lyJDPIGgjB0ZJzApdGOcAdWS2ewdyHgHqxQhTuzY2
	4xhqk9pS9g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhks14y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 07:48:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H7fKHf018296;
	Mon, 17 Aug 2026 07:48:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y4ns3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 07:48:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H7mGD527656732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 07:48:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2662558058;
	Mon, 17 Aug 2026 07:48:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A86A58057;
	Mon, 17 Aug 2026 07:48:15 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 07:48:15 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 09:48:15 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.vom>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 2/3] s390/crypto: Fix missing scrub of temp buffers
 with AES ctr and gcm algorithm
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260814125043.A86161F000E9@smtp.kernel.org>
References: <20260814123711.61145-1-freude@linux.ibm.com>
 <20260814123711.61145-3-freude@linux.ibm.com>
 <20260814125043.A86161F000E9@smtp.kernel.org>
Message-ID: <c734db201d755643adfd357b5f70654c@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1NSBTYWx0ZWRfX2Xq4HsN4nR/k
 qrLsPDCmjvkj+LiPnnk570Tr3tXyhyyfty/+5w72IMdjepcY3LihefTWJKVXUJh9m2dNjbyXRRp
 nGBitzYVzqV/Qb3YHgoUCVh1Q9QTJZRcuqgx8pKWELg3XYLhYXLakmz8drGGu9yC6eT9SJgRZvj
 /EMs0C8Ddtbw8omVCouyVpU/T6JQKBTU643I9byWKumrA6TMCiYEczrmxzhD2wbGB8FEIdSQobE
 MJoBywz9Rv/CLyjtKVhRdP6sJfhlA0okdmhEojjTA+ZjfgFiz0w9F+ptpceUOVBuAZMbfYVvlz+
 iLA8BOsAb/WjKFcv8+G31mnLXi928UlSexWhmXV3UKrogRk+/jXjwPYtLGdd9bTSi+wfw4s2It1
 D698hVjRVVWqzbXToH20SpZCE6F5qQUwEg1bRVieE7z0EyZqjgCBXCtDrpE/tlIIp+WvEW55NDS
 ig+l0q/5cJmyRLK2EOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1NSBTYWx0ZWRfX89kjERkZ8tqU
 yY5Mu8EfexEomS3iL6jxdYip2zLvDAMoB//7qBxgpO5pBAv0OQ4oqBKno38t2yZINDWhf4L1Cx/
 J69sZci84ZTa1lw/oah6Xc1YCors5R0=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a82bcc1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3TNwCfqLLIOAKdXn5OkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: lANuY5j4U3Y8oWQnVHdDCno1GjM6RkV2
X-Proofpoint-GUID: lANuY5j4U3Y8oWQnVHdDCno1GjM6RkV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170055

On 2026-08-14 14:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] Missing scrub of sensitive temporary buffer in
> `ctr_paes_do_crypt()` when handling remaining bytes < AES_BLOCK_SIZE.
> --
> 
> --- Patch [2]: [PATCH v4 2/3] s390/crypto: Fix missing scrub of temp
> buffers with AES ctr and gcm algorithm ---
> commit 3d2b9adbb3df3417589c4d42aa1add6ac98dbf33
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm 
> algorithm
> 
> In function ctr_aes_crypt() there is a buffer used to process
> remaining bytes < AES_BLOCK_SIZE. This buffer was not scrubbed and
> thus could lead to expose of unwanted data. When the buffer is used
> explicitly scrub it at the end of the code block to avoid exposure of
> maybe sensitive data.
> 
> In a similar way the function gcm_aes_crypt() hat an error path where
> the CPACF param block was not scrubbed. Instead of return early now
> these error paths go to end of function where explicit scrubbing is
> done. Similar with the buffers which are part of the gcm_sg_walk
> structs from the variables gw_in and gw_out.
> 
> Cc: stable@vger.kernel.org # 6.8+
> 
>> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
>> index 62edc66d54788..10561aa687c78 100644
>> --- a/arch/s390/crypto/aes_s390.c
>> +++ b/arch/s390/crypto/aes_s390.c
> 
> [ ... ]
> 
>> @@ -596,7 +596,7 @@ static int ctr_aes_crypt(struct skcipher_request 
>> *req)
>>  	/*
>>  	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
>>  	 */
>> -	if (nbytes) {
>> +	if (!ret && nbytes) {
>>  		memset(buf, 0, AES_BLOCK_SIZE);
>>  		memcpy(buf, walk.src.virt.addr, nbytes);
>>  		cpacf_kmctr(sctx->fc, sctx->key, buf, buf,
>> @@ -604,6 +604,7 @@ static int ctr_aes_crypt(struct skcipher_request 
>> *req)
>>  		memcpy(walk.dst.virt.addr, buf, nbytes);
>>  		crypto_inc(walk.iv, AES_BLOCK_SIZE);
>>  		ret = skcipher_walk_done(&walk, 0);
>> +		memzero_explicit(buf, sizeof(buf));
>>  	}
>> 
>>  	return ret;
> 
> [Severity: Medium]
> This is a pre-existing issue, but while you are patching 
> ctr_aes_crypt(),
> could the same missing scrub vulnerability be present in the PAES 
> equivalent?
> 
> Looking at ctr_paes_do_crypt() in arch/s390/crypto/paes_s390.c, when 
> the
> remaining bytes are less than AES_BLOCK_SIZE, it uses a local buf array 
> in an
> almost identical manner but never explicitly scrubs it before 
> returning:
> 
> arch/s390/crypto/paes_s390.c:ctr_paes_do_crypt() {
> ...
> 	/* final block may be < AES_BLOCK_SIZE, copy only nbytes */
> 	if (nbytes) {
> 		memset(buf, 0, AES_BLOCK_SIZE);
> 		memcpy(buf, walk->src.virt.addr, nbytes);
> 		while (1) {
> 			if (cpacf_kmctr(ctx->fc, param, buf,
> 					buf, AES_BLOCK_SIZE,
> 					walk->iv) == AES_BLOCK_SIZE)
> 				break;
> ...
> 		}
> 		memcpy(walk->dst.virt.addr, buf, nbytes);
> 		crypto_inc(walk->iv, AES_BLOCK_SIZE);
> 		rc = skcipher_walk_done(walk, 0);
> 	}
> 
> out:
> 	pr_debug("rc=%d\n", rc);
> 	return rc;
> }
> 
> Can this leak plaintext or ciphertext to the kernel stack where it 
> might be
> subsequently exposed to user space via uninitialized stack padding?

This is addressed with another patch series for paes_s390.c
