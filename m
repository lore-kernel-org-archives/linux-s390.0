Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5F381EB3;
	Thu, 30 Jul 2026 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397475; cv=none; b=CaNGHUEk83S6AOrnEWtgWrjdYjVG6RUPnjU4ljh2YXPNnr3LujNORZNy0YE9akhnG8eygAv2gkaH+q/jKKw9qUFKdBsr7ZSwAvaiG83ZcThlALz+W5JnZbSFrkvCXkOBeH2CwMrYG6dHBhgueCEWFTZVz+G3LRagSPkWykfBaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397475; c=relaxed/simple;
	bh=UozRMZfmsd14uD77wg6KqZTuCQ16EPXpZCVqT4jOkgE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M7NcDWdGB4YWnDWXBh7F6oBkj4B41VcPsgj9YoCL/SujU2/11C/4O40F0tKM3nnD9ZWENRoulB03HxM+vu0v4Xwua4mxroTb7jHcVWHG7b6r/DhJpMvcager4wu61P4S/zFMY4ELEnREySBu2QyU5J73lBNpNv8HdMxhZr8xKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ObTMllgL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ObTMllgL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6lZWB2267513;
	Thu, 30 Jul 2026 07:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=fe0CT4Aw83OGamnX9cNuYkS/c3C6S1F4EhaLI32z+Lg=; b=ObTMllgL5CdV
	R/XtNA8SwEtOM4tGF278p6tteP9Iw4HI8Y7SnyOZObbM55c+focAIFsdShahPC4a
	vVcnk/o4eMo+swzxDGiyNAqBtjgyvL34YkfLyhkqHwOsox81iihhMTpuNwCavZ1K
	VWmH9iLjcvRyfYJ2r101jvYG7J3nlVlijLgLYSRGleCAWpppxbpVR7qkHLCyfgi4
	dG+vEiC7SiFPRuToZZHIDjzKIIZkANuA7Zw+4HE0zjkr2Go8+CuuVDoOjYwm0CKT
	GiWaSuVZILEH7CGlC2zwlgSA3XfzLAbqsYuYxzABPtzpVW9nS9rTyDNTSo8l7JYC
	jVic6THB9g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7pm25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 07:44:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U7fJZB012890;
	Thu, 30 Jul 2026 07:44:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgj5ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 07:44:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U7iVWU4063948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 07:44:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 415F55805A;
	Thu, 30 Jul 2026 07:44:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E03A458051;
	Thu, 30 Jul 2026 07:44:30 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 07:44:30 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 09:44:30 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v9 5/5] s390/zcrypt: Pad trailing CCA or EP11 message with
 zeros
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729170739.C0FF11F000E9@smtp.kernel.org>
References: <20260729154458.195135-1-freude@linux.ibm.com>
 <20260729154458.195135-6-freude@linux.ibm.com>
 <20260729170739.C0FF11F000E9@smtp.kernel.org>
Message-ID: <4cb782c8746e264adcc03993b3c8ea40@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 49NjYj6hLL6gdhh497V2smG69FlWz5bX
X-Proofpoint-ORIG-GUID: 49NjYj6hLL6gdhh497V2smG69FlWz5bX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1MCBTYWx0ZWRfX0giPj0lh78jt
 T2UaJYKjzrWo7YILJ7oedalFnB6oiD62ZWj9OdUig5afOrBfZi04Dx/JO0XGOB0KbK11xfBgnmT
 5zVKgyF7Plf3obGNuy57ZpjLRv/DAYPsB0xAjl2GJqf2lkDzsyYEKX3l8DcIgUQpnCLqvaxK2NO
 VceeVe9i+D86Ml4zVCzpKO8yoUNnWVWe/J9MlyBpKtBD7kmm2r62iX52f//q+RmwEw/grUovMz8
 KMj88yW7ZDre9yYL4qUsNeRZEaV34p2PcadudMOPu5bufuSzLPSK85vtp6BDRmVpdUe3fNBs/0g
 OMdT7XjDiXF30ORzNLQEAYLPM6yWqdNJocS8RYdk1Kl6oYS6pjjFwISHa9LjxhoSULddj8Yg3l7
 8KxlxUMH5F9wH3poLH2uxW50j88KnrvDrb8ZO8S78uOAJM7CiJykpi/CXlWk3VDFJZKd3WeWhc6
 N8gX6nufxq0/3vM3Uqw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b00e1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mi8-e7BX9lkNH84z5iAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1MCBTYWx0ZWRfX1PslqfcmeCrf
 dU61+1YKCxn+qJVlZlxA0Ij+jWjPmZBQugF+oZ9rx87oK1dLZ1Tyknb7/tVApyi4ceNmn7/LMsF
 fwA0MozVbnfZ2LWDd2bFwLBm8P5vFvA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300050

On 2026-07-29 19:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but an integer
> overflow and incomplete bounds checking in hardware response parsing
> allows a massive out-of-bounds kernel memory leak to userspace.
> --
> 
> --- Patch [5]: [PATCH v9 5/5] s390/zcrypt: Pad trailing CCA or EP11
> message with zeros ---
> commit 0141bfa352999fc87f7b7c58c7c727f991c4b416
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Pad trailing CCA or EP11 message with zeros
> 
> This patch fixes an information leak to the crypto card firmware. It 
> zeroes
> out the gap between the user space copied message and the message 
> buffer
> length sent to the CCA or EP11 message processing.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index da7580933c6f2..4a60540b07003 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed an integer overflow and
> incomplete bounds checking in hardware response parsing that could 
> allow an
> out-of-bounds kernel memory leak to userspace.
> 
> In zcrypt_msgtype6_receive():
> 
>         if (t86r->fmt2.count2)
>             len = t86r->fmt2.offset2 + t86r->fmt2.count2;
>         else
>             len = t86r->fmt2.offset1 + t86r->fmt2.count1;
> 
> If a compromised or malicious crypto device firmware returns a response 
> where
> offset1 + count1 overflows 32-bit arithmetic, it might bypass the 
> buffer
> size check. Alternatively, if count2 is non-zero, the bounds check in
> zcrypt_msgtype6_receive() only validates offset2 + count2 and 
> completely
> ignores offset1 + count1.
> 
> Later in convert_type86_xcrb():
> 
>     if (z_copy_to_user(userspace, xcrb->reply_control_blk_addr,
>                data + msg->fmt2.offset1, msg->fmt2.count1))
>         return -EFAULT;
> 
> Since the bounds check can pass under those conditions, could offset1 
> be
> used as an unvalidated offset into kernel memory here, resulting in
> z_copy_to_user() copying out-of-bounds kernel memory into the 
> user-provided
> buffer?

maybe valid, will be covered with another patch series (bugzilla 220850 
opened)
