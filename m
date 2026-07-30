Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608E2E6116;
	Thu, 30 Jul 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417199; cv=none; b=Z3ovGlzCA5YfeNmPn9dabZRmzcZ+3/LEPD9YFpg+gAssLsfjDkdRz0YPJF4h1uDmhv97IiGJa/mTRotv9g382Qiw6IYDiKR5M/8AgwwSwfZA6qxH+eOQDT6SBMct22kJJjW5PfUqiLu4bSQ3XiY4KwSr0qREIUXFg24rBwaBZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417199; c=relaxed/simple;
	bh=af6MZ42rEvDFzQ1XbWqDbD3XG/1zrKu/cFUbWO20M8M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jAfvhySVlksS6VfjWQfJJwY7vZ5x+GmV5cRDg8wT9Iuqx7k/Nq5GQbM/UQVAqC/sZtEjWM/M7My+N2F8zrN67YAJtKZuY77gj4xn1CIhDMZ4K1SsSF6ri+l5bJ8zt6+jQ3YL7Ovns23E8uZpnDkPuFdQD77emcjJnRHcBj3uCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LT6m778q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LT6m778q"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHUq52741732;
	Thu, 30 Jul 2026 13:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=QZXWpkbtPnEr7mfLXK6ifA5AWtIIN8pgIyBnVCq8uJE=; b=LT6m778qZM9g
	dxJILe5xLfjE68/zplnNPXCPUK/Cef5/sKSzphmio7Waqg8vAk2pRgXyhL6Wn6fg
	cVCRFVv0dhby/BtzuD2y2lYpIF+h+HJD+cjgaXMhNAdiuQBaWOHWuM2DnpgEWDA7
	hjsofCX2k5qTs6ocBy74QL9t1fHk67l1qQGz31p5A90rFCDJTGXcuAMSsSsrs51F
	MMcrnEol8jg/k42vne/SKhC8d9hMU5AgcFMVS4by4cOCV+B83uH43tOCaJBqwSwE
	OGr2nV4SRglCrcICGlVeuLcpe4KhpIRZIeUuJh/ksO49sWofXD6C5Tf6OCggBnbh
	M6EO7kK/Ig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xyvsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:13:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UCuHHh015906;
	Thu, 30 Jul 2026 13:13:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yb65s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:13:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UDDF1I35455254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:13:15 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1819E58062;
	Thu, 30 Jul 2026 13:13:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7902A58060;
	Thu, 30 Jul 2026 13:13:14 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 13:13:14 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 15:13:14 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v9 2/5] s390/zcrypt: Improve CCA CPRB length and overflow
 checks
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729161950.8DC9A1F000E9@smtp.kernel.org>
References: <20260729154458.195135-1-freude@linux.ibm.com>
 <20260729154458.195135-3-freude@linux.ibm.com>
 <20260729161950.8DC9A1F000E9@smtp.kernel.org>
Message-ID: <5e17ad4109d5a5d5184ab2054ceef910@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LZzdc3kIMsfvSEkDGdIsy2e2smevo3ul
X-Proofpoint-ORIG-GUID: LZzdc3kIMsfvSEkDGdIsy2e2smevo3ul
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX9HkMREf1mdxA
 PE1IDqWUhKbWtDvpqXhRbrBMKs7eeeHkkE+OklW5RjgTK2yNPyZXFsVMZOUhDr9jCba+0Rgckmc
 Yrz5JrafJJ6udypzpslQkDopzeYH+Ao=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6b4ded cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xTzqvJMi7Hylla0zxxgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX3uWlTnEQAw5O
 LpClzqQgMwS3h/nMElBbXsPWqn6Ty/iz8gyp/pBhrmARNFSDd4NCE9tul+qTsLXEsSzhpSjCb6G
 zUFYVi49kuxLaMOXR+frmX/aDvUuGzK/xVmPccmQq4yAKt/lFza95cXmVA0VHRhlAcWRLOg3aHG
 H0hD/rydgGnE92uS90kE5Tq6jaCRuZIUbyGgsM7B4qtWvq+9Bi9ZpyJ2d6og9oD/sGBhgWBvOtW
 wAo7mAYuHNjd+64y0MUNQIyvgQNA+B2Gs/SgtMB6Ss2jBjqBNLXwCoK8dV+yIeBuBx/3pKphIa0
 JJqvZXCGOoVojHbYWkWdy8erh1K7eUBD6EmjvDCTH7bOAU1gMe3D01s356hPcxkCdoJ9QqLl80P
 LnuTuX79BmHBh1jxBo/qv2w+kF+PtzEdqua0RCx9cs+MjR7H3vB2D/UwyMc1ckcAtYhHfkVsSJ8
 tR9Hk1khFS7jIJ9WFHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300096

On 2026-07-29 18:19, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> 
> New issues:
> - [High] Uninitialized memory read due to incorrect bounds check when
> copying subfunction code.
> - [Low] Redundant and mathematically impossible integer overflow
> checks on 64-bit sum calculations.
> 
> Pre-existing issues:
> - [High] Missing minimum size validation for EP11 CPRB messages allows
> reading uninitialized memory.
> --
> 
> --- Patch [2]: [PATCH v9 2/5] s390/zcrypt: Improve CCA CPRB length and
> overflow checks ---
> commit 93cf9dfadb28a27fc37f0252a7721661ccec467d
> Author: Harald Freudenberger <freude@linux.ibm.com>
> s390/zcrypt: Improve CCA CPRB length and overflow checks
> 
> This commit addresses integer overflow and missing bounds checks in the
> xcrb_msg_to_type6cprb_msgx function during CCA CPRB processing. It 
> introduces
> 64-bit size_t variables for length arithmetic and explicitly bounds the
> calculated lengths to U32_MAX. Minimum control block sizes are also 
> validated
> prior to copying data from userspace.
> 
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> 
> [ ... ]
> 
>> @@ -342,49 +342,40 @@ static int xcrb_msg_to_type6cprb_msgx(bool 
>> userspace, struct ap_message *ap_msg,
>> +	req_sumlen = req_cblen + xcrb->request_data_length;
>> +	if (req_sumlen > U32_MAX)
>> +		return -EINVAL;
>> +	if (req_cblen <= xcrb->request_data_length ?
>>  	    req_sumlen < xcrb->request_data_length :
>> -	    req_sumlen < CEIL4(xcrb->request_control_blk_length)) {
>> +	    req_sumlen < req_cblen) {
>>  		return -EINVAL;
>>  	}
> 
> [Severity: Low]
> Does this ternary check provide any value now that the lengths are 
> using
> 64-bit size_t?
> 
> Since req_cblen and req_sumlen are bounded to U32_MAX, their sum cannot
> overflow a 64-bit variable, making this condition impossible to reach.
> 
> [ ... ]
> 
>> @@ -404,8 +395,8 @@ static int xcrb_msg_to_type6cprb_msgx(bool 
>> userspace, struct ap_message *ap_msg,
>>  			     xcrb->request_control_blk_addr,
>>  			     xcrb->request_control_blk_length))
>>  		return -EFAULT;
>> -	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
>> -	    xcrb->request_control_blk_length)
>> +	/* copy subfunction code into AP msg type 6 function code field */
>> +	if (msg->cprbx.cprb_len > req_cblen - 
>> sizeof(msg->hdr.function_code))
>>  		return -EINVAL;
>>  	function_code = ((unsigned char *)&msg->cprbx) + 
>> msg->cprbx.cprb_len;
>>  	memcpy(msg->hdr.function_code, function_code,
> 
> [Severity: High]
> Can this modification lead to an uninitialized memory read?
> 
> If an attacker passes a CPRB request where 
> xcrb->request_control_blk_length
> is 13 bytes, the aligned req_cblen becomes 16. If they also set
> cprbx.cprb_len to 14, z_copy_from_user() will copy only 13 bytes, 
> leaving
> the padding uninitialized.
> 
> The new bounds check allows cprb_len = 14 (since 14 is not greater than
> 16 - 2), and the code then copies 2 uninitialized bytes starting at 
> offset 14
> into msg->hdr.function_code. This could leak kernel heap memory to the
> crypto device and influence routing decisions.

already addressed with patch #5 of this series.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed a similar 
> missing
> minimum size validation in xcrb_msg_to_type6_ep11cprb_msgx().
> 
> drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx() 
> {
> ...
> 	/* Import CPRB data from the ioctl input parameter */
> 	if (z_copy_from_user(userspace, msg->userdata,
> 			     (char __force __user *)xcrb->req, xcrb->req_len)) {
> 		return -EFAULT;
> 	}
> 
> 	if ((msg->pld_lenfmt & 0x80) == 0x80) {
> ...
> }
> 
> Does this function also need a minimum size validation?
> 
> If a user issues the ZSENDEP11CPRB ioctl with an EP11 user request 
> block
> where req_len is extremely small (e.g., 0), z_copy_from_user() will 
> succeed
> by copying 0 bytes. The kernel then evaluates fields like 
> msg->pld_lenfmt,
> msg->cprbx.flags, and msg->cprbx.target_id from uninitialized kernel 
> heap
> memory, potentially allowing bypasses of authorization boundaries.

already addressed with patch #3 of this series.
