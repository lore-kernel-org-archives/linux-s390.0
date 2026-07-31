Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F539A4DF
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489315; cv=none; b=Tr7DLQVGD5LHuZYLxyELsecMEvM4955+7f/SVgqKiWUq3YYZNfgmZS+oPolWZ/8tbGX+vUZBbdd2VleyjER71s/oaNbAVR2mFXPA8Wj5iZ+uxnzBO7AChwsebj2EosAyjco6c/4PNZZcIyt4yLJu5HvCRkz6KZ1+k9fdXIqjHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489315; c=relaxed/simple;
	bh=8qzF1kZedtI1+NirfvmaWsk9zm0yEHOiLDW+8XVYHTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkP30CQDQ+nHw4eVgefBC5mLH+ejawEgm6RaQSh1/SyJyPuFKmmAXpJvO+Z2L0hyMPHtJwcBUAYIh4DOt8XmjtCS0TBaGrZSPKSy0tUXurSG6oOuWK/QnTUbMAuef0aTOYYqKArMiCxg37Pp/mWHOKH+neoTAwmdfNVPe+Y+jyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PDX/mPws; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PDX/mPws"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8HoCH1230293
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 09:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+VOn7K
	Pu7xDlB9k8b3oE0utuJC5LqNtAL69zvkCs6+o=; b=PDX/mPwsGUhD4uLdqRBMTl
	1fqlf1YKTjHcPq1jvPhUZ1RSxsRvhLrbKq/4h4cfKuAW6DB48NUZepfYIgiYIZzS
	5bL8BCzqOlbPVMz1fM7o5Scomq4q7p3Axu0DXXNq1l0L5YUrfpnwdI26TCTEMuAZ
	ah3VVeOTUs9zX9ePHr2lWQKxTTmCf6IPIb0eURfeHtk4ux+iiZJzCcSnfCCddXYN
	jGpEH0L9D5bhmoYI1YJGwlQSc1fHZ/xoAGbpG83kmynjT/sjW5K5V02NblqmVJIz
	SAuS1fxY3hjVZ/kLVDDBBKrbaiWAo7u/8pwze+En/JVmHdOFWpcVoeWidstnSXPw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjk90m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 09:15:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V9BLGL025266
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 09:15:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yf18t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 09:15:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V9F8eL35324256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 09:15:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14F7120043;
	Fri, 31 Jul 2026 09:15:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE88720040;
	Fri, 31 Jul 2026 09:15:07 +0000 (GMT)
Received: from [9.111.59.130] (unknown [9.111.59.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 09:15:07 +0000 (GMT)
Message-ID: <4ea8733f-aa48-4b49-b5ae-669d99727364@linux.ibm.com>
Date: Fri, 31 Jul 2026 11:15:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/5] s390/zcrypt: Pad trailing CCA or EP11 message
 with zeros
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-6-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260730141509.205970-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MyBTYWx0ZWRfXwD3BlnOZwAY/
 fRZGFjeJtmaEeN6ebP/mqm6rCb34l3POkmGUNmOxoHjuVRC9jvGo0juwvyKPnZccEwQokyRw/YM
 fDbRa6Y8ZyE4l3JJWlcUhlKW+/A2Zgk=
X-Proofpoint-GUID: AnP2fZ_P_KIjnjBsjQrerWb_5fQZytYA
X-Proofpoint-ORIG-GUID: AnP2fZ_P_KIjnjBsjQrerWb_5fQZytYA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MyBTYWx0ZWRfX6bYp9r3LhJIp
 M4JWvxuPTwJmZvjMiod9fsXHPHaSe0aDoliSv4gBE8/NozQPvD6bsKPnBHmmnc6h9QO5XNcL8pE
 Byo5ARpN7x9qqPGMFdF/d0p9l2PwWe/NaJL1iCxhaxgrXYrDYFHtI3z2Rz2zBoNllhy59a+OGsj
 jPoXzqUg8teo0k4hS4wmv6rZxWbyd3CEIaeDxUjMmKEht3OMXfV8desTCDK8VOa6TR07FFhbbXU
 iHgzKIyfCUojHUiLAbeGP+UivV6FiLv4ooXM8GMuuGybhvDs1d21lqb0JYv5XDIEGUQz33STT4v
 n1v4QVwOiYn6xyV+Qo/+jZ9TDpOOX7KCrmn+8Arz9uksB5W7GkxlAjx0mcggMzEkcixkcHhA0rg
 tP1macVbcyeVC2rVpQwlIbjWi1iOHi0UM1XA1P/+ouCPqU1QTYwolESz91F3PZ0InCL1WBpYsr/
 Yr/eas1khBkOtLVzv1w==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6c67a0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=quz0ULUTkAQQxmccuaYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310063

On 7/30/26 16:15, Harald Freudenberger wrote:
> The both functions xcrb_msg_to_type6cprb_msgx() and
> xcrb_msg_to_type6_ep11cprb_msgx() copy the user space message into a
> kernel buffer based on the message length. But on further processing
> the message is supposed to be 4 byte length adjusted. Thus up to 3
> bytes of uninitialized kernel memory are forwarded to further
> processing steps and may unwanted expose kernel memory to the crypto
> card firmware.
> 
> This patch contains code to pad the gap between user space copied
> message and message buffer length sent down to further processing of
> the CCA or EP11 message to zeros.
> 
> Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within zcrypt device driver")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org # 7.1+

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

