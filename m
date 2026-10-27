Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102007;
	b=Tx8Tr4Cmvy4kog9+g6srH1wrDmt2fLruolTe6g00Sc2DDk6o0IYHJVKHppQZ0ZtEZVhE
	 GPZWlcXkjITU6wfG2sJLYT66L0sC6sqfd2/hjnZv0eRW8kgx5q17LWjceRB5COzMS0Pg4
	 fUi4hbWuawonD06/ak0OjSfw2t1K6TOJb9bNg6efWC5RrvXkS3DMIzELYDJ17E3NnnHRU
	 yCW6Pv3JbyTy15EZJNDXjv30SlvMGdVC0aXeaxngOkkZwCav+D68/ahHLc8iSRZwwiUFM
	 1jeu2+2oBsEcRRUl+tBYZl/4zgexbgh9nBMBcqVKYy9wYCLexz4eqfsA+Zf/+vYL8Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102007;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=W6uTpIYshNweJ7YFkJhdH+51Z4aVRdTJpTeNqiflV4E=;
	b=oxw7iAx1XH8cViIvKbMtZFoEz+iWpDKFi5rRoGjWTXwmz7kzcQDZnXOnw3wirCdGivT8
	 rdHFBvFZTHjnPb+R2oh+IHImSVqFpTuyS9CmmIkPStB8wxYIf+oFLSJDSf5VAnxJf2M6W
	 OHDCylspEHC/Wm7T5xjMFLwMhxjX/9P+ZCTGltjt2ApuB0WSHZaVzgF1NUJP/iMA7h2xv
	 i+SOQgvIFO349+nVKGx8jsU06PH5QkgBuxvnWgDBPT6MaQ3D6VFxDxZDPH8cOHLfPRNuJ
	 TPimvoaWacn/SWvWccyt+ksQEtCpxRjD/AD4na5aoCRH7vYanR062IrTv6UGFK+MjAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NEBe5hMC;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF65606A31D
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF65606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NEBe5hMC
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5igOg1623780
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W6uTpI
	YshNweJ7YFkJhdH+51Z4aVRdTJpTeNqiflV4E=; b=NEBe5hMCT3QrXXjtopVExh
	4PuE454UCzv8+6qfeR0wnHqX/4GWEJERUQK6Ct2YTaie+A+JObapBfxP+1jLCQTS
	1vUTXf4VqizBFKLXQmJxEqIFbvHjrHCjmdiYJ0uSBEyhI61sI+koRWiM4tmTM/NI
	ko4Vnlb8PLFrtRdUN/wIZBLjhxCBs8Q/85RDxa5DG+VR1gMyxnaMZLsWM20WqCr3
	pqb3uqdogBKRP8Wyo36uiMU0rOSmKFYGuN5SmDLl0wk+PhtkCoDXq0fYVs/ow5A3
	EqSCV9TY1aMrF8XO8jwBHLciYe8dYfYVCYSBliUzDfsdxjYkPsWZwD6i6hbYooxw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm63y6r0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:53:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAvUbC3997011
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:53:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnn85q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:53:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RBrM2241484650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:53:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E156320063
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:53:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9BDE2004B
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:53:22 +0000 (GMT)
Received: from [9.68.17.252] (unknown [9.68.17.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:53:22 +0000 (GMT)
Message-ID: <777a0294-2729-4389-a98e-b07fe0f4ae2c@linux.ibm.com>
Date: Tue, 27 Oct 2026 12:53:22 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/diag204: Introduce diag204 rework
To: linux-s390@vger.kernel.org
References: <20261027-diag204ioctl-v4-1-d5e90b56112b@linux.ibm.com>
 <20261027113242.11789A2c-hca@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20261027113242.11789A2c-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX4MBHN12EB2bS
 GcS5pIHFZaVwugo3lNKFt7LmeRlzmQ4Df8ShyKiMwphMO/4D72gGNuVYyVhl8H+XLzJLW7R/ALW
 Vfj0vJhZ7g5msa5EycrElAhvbW5qxFw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfXzeHvH+nyvP4A
 rCrcLE4vzCQumm6Btg6vkz69x+rRQ8EEBxix3605PZcMkT0muRPTkx/ZNO6yeWwYgv/gCPGj8S5
 rTRYrZYketf8YJcaCIeanE/bPQtm6la1Q6RBf2cUuL4QQslQ/kxCCTCMCjZAZ6buCYO6vhplhKE
 OXqP8ltMJm/FtVIoIp0oYb0xSZDYGFTIG4VVoCdNgrOx2CMhRTXTXSNfvILVB2Yea28T+QEbn/P
 jEZabEAVpCYss9c+fDaNAEf97OtTb1RLR+uHgOwA63dhfwGiTPMbYjhF9u7kYTJSRz2062MGlhL
 r/iuh0+mQ3IxnTWqPhk4jqKVnEJEaRuftTgKcDZoYP+AFBmM8O/MxKJRnIPu5YAHFCdb5rk2XZ6
 o/A9RAGPk8vxe2NkIot/z/zOk9BDRC+sxdAtTOGp2KCzKUyG46gPA7NPhxCcR6rZCPLvQVcrLiU
 /aQXR2k8lRsdK0clt8g==
X-Proofpoint-ORIG-GUID: KnLQG1zrYlnST3gNqitvgXh8uwfxlIqj
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae090b6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=xBf0xs4nkxneeIIYNNoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KnLQG1zrYlnST3gNqitvgXh8uwfxlIqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270046

On 27/10/2026 12:32, Heiko Carstens wrote:
> On Tue, Oct 27, 2026 at 11:40:25AM +0100, Mete Durlu wrote:
>> +static struct diag204_cache g_cache;
> 
> Before you send yet another version: what is "g_cache"? That seems to
> be a horrible name for a global variable. What does that even stand
> for? Please change the name to something more descriptive.

Just global cache, but you are right there is nothing to associate
it with diag204. I'll replace it.

>> +/*
>> + * diag204_store() provides users data retrieved from the diag204 facility.
>> + * Since diag204 is an expensive call to make, it is limited to a call per
>> + * second for now.
>> + * diag204_store() first checks if diag204 cache is present and valid. If the
>> + * cache is valid, it copies the contents to the users buffer.
>> + * If the cache is expired, it first updates the cache and then proceeds with
>> + * the same copy operation.
>> + *
>> + * @buf: Users have to manage their own buffers by using
>> + * diag204_allocate_buffer() and diag204_free_buffer().
>> + *
>> + * @allow_busy: If diag204 supports busy indication facility(bif), users can
>> + * specify diag204 to  return BUSY instead of blocking until data becomes ready.
>> + *
>> + * @allow_busy_wait: If users allow diag204 to use bif, they would also get
>> + * the option to specify an interruptible wait behavior by allowing busy wait.
>> + * This enables users to interrupt diag204 waiting period via signals.
>> + */
> 
> Is that AI generated text? That doesn't read like normal kernel documentation.

No, AI would probably make a better job out of it :D

> And since this looks close to kernel-doc format you could also make that
> kernel-doc. But make it shorter and don't describe the implementation details.

I wrote this without knowing kernel-doc format tbh. When I first
started writing this series there was also a patch series in
discussion targeting s390/uv. I saw the function comments there
and wanted to have something similar here too.

I will just properly read kernel-doc format before making changes.

>> + * diag204_init() has to find out, which type of diagnose 204 implementation
>> + * we have on the machine. Currently there are three possible scanarios:
>> + *   - subcode 4   + simple data format (only one page)
>> + *   - subcode 4-6 + extended data format
>> + *   - subcode 4-7 + extended data format
>> + *
>> + * Subcode 5 is used to retrieve the size of the data, provided by subcodes
>> + * 6 and 7. Subcode 7 basically has the same function as subcode 6. In addition
>> + * to subcode 6 it provides also information about secondary cpus.
>> + * In order to get as much information as possible, we first try
>> + * subcode 7, then 6 and if both fail, we use subcode 4.
>> + */
> 
> This looks like it was copied from the old code: please fix the documentation
> convert to use imperative mood when you move it.

Will do! Should it retain the details about which subcodes and
data formats can exist together?

Thank you!
