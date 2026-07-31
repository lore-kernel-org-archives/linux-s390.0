Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC536A36B;
	Fri, 31 Jul 2026 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491385; cv=none; b=Oe6mkRMpVfV6raiRg2E4FOgDEpGUzXDFInSYkBVDU09pOSD5CQcaOSY2JTcNpeLW9bI9ZNdHJdN4+piL8rKDz703lJTPOrTp3X8hNOKHun+O+rZw9BAc7o2uBxu8wcfl1AgmQ8tr9DrcIQBCFTAUa2qCmZFUMf1ExtCDWIu8xNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491385; c=relaxed/simple;
	bh=GSWdHZlRjIn/Wt5BK0wmEwxA9fF36hzyicnhIOmT5jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETW1xYEHX2ciQYPXCZCm9N/8yKgIqvZZgAqgeM9xaQ4Wg1SiENyyj/x2PamHeq6Po8JTiX4NLvu73+5sf2W3xWt4hMBiODLuZsmHQqPKEnJObv7hEnwsw2509Fyg1x3KcvEaokR9xMxVpdCmU3Po9XlnfP5AqTuAhZ2KqDuuJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YBsrYwtJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YBsrYwtJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8I7E41231924;
	Fri, 31 Jul 2026 09:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=itNp4R
	AjF6tyzVYz57YxBvySOrcrGmhu+4kn9i427qg=; b=YBsrYwtJy9n8j0R9Ml+BsO
	ZtWBL+dLdkgAJ0Y20xRj7Z+A9r+yBUhvRuTcKM23GN30hDjGDWsDDgmEE6+g5/6g
	rUMBdZsfASCrA6ycSfKA6HqIZNIEw9LgWigipKM2jOZxS8qV4l96l3FyjGu6h7+D
	Y/+4oLG7G1QOpcSkBxIamBV29ehWPe7TNdPQQdI5Vm4mss8d0ulh9VTEpIufoVGU
	zbWREBtKRuaHHOLBSCHHsKlXpfIO82U42kNJlwm2e7BlwPMw7VHokvLUDddzbem+
	FfuBb20xL87m8TAbLfTjxthkZtoLBfQ227jZj/Kkk5hZ9zN5ISBPZy+nVCz/UROA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p3c3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 09:49:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V9fJQJ015259;
	Fri, 31 Jul 2026 09:49:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkfd49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 09:49:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V9nb1u52167054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 09:49:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD6442004B;
	Fri, 31 Jul 2026 09:49:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79E1320040;
	Fri, 31 Jul 2026 09:49:37 +0000 (GMT)
Received: from [9.111.59.130] (unknown [9.111.59.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 09:49:37 +0000 (GMT)
Message-ID: <f42dd999-e35d-4897-934c-bfa2f75b5066@linux.ibm.com>
Date: Fri, 31 Jul 2026 11:49:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/5] s390/zcrypt: Improve CCA CPRB length and overflow
 checks
To: sashiko-reviews@lists.linux.dev
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-3-freude@linux.ibm.com>
 <20260730144848.AF66F1F000E9@smtp.kernel.org>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260730144848.AF66F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3MiBTYWx0ZWRfX4CA2bDegNLBG
 KlCDIy155mAU1bSISXWV0dEuuyepUMCuDmXa9XbLTEE6rm5es18bS+/JBn+mIkrbKPiISP5phLp
 iK+16/sXwOBxFZvLW8jsuXjpBiL+XyI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3MiBTYWx0ZWRfX5STJvWXZLXg9
 gLdj60Eb9byYb0cRy4vjlwNPGt1feBwJb8bFf8VKnEIX2XMujmNP8SKsTDYN4YMxNwgmTc5262N
 YfBo1nYudXhJ+jtXmCBaPwc5BQ2BaxO65uHyMy+5WN031ym7ksaf9urpot9SVUG85hk47qLZLT0
 JZr3fzdQOckowl41iaqC1581pTe04ZLLhRyvVZi38Tar6M/TVs431Ag26sKAOv9/H1YI50h40UN
 4XmMmOpqmpUeUGZK1XRcEpdmj/HZy8HO+1LJ8XzkAsvsLuSlSp73n4lN3T8A/t4FnxTlomBYBsu
 nasAQ8ZGcN5Gb4IZPGDxEmSw5+vaAEXpNrPvUWlB9wBpOodPevHd+7Rh2EVkgdrHmZzms5aTCHs
 RY8dBj1AoVCQC/Spf5L38AC0P4vdENnLbQawCb3vSWfKLoQPcJJepjcn5ExoFWWuyP/TaiDGo+8
 SsnI4gJQqPH7X+i1AQg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c6fb6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=A0xDiOKYln-bBx9XOqIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Rj0Qj39alSXK9Ophodc89alhkAzT9eJM
X-Proofpoint-ORIG-GUID: Rj0Qj39alSXK9Ophodc89alhkAzT9eJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310072

On 7/30/26 16:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Uninitialized alignment padding bytes may be read during function code extraction in `xcrb_msg_to_type6cprb_msgx`.

Valid finding, but already handled by patch 5/5 in this series.

> Pre-existing issues:
> - [Critical] A 64-bit integer overflow in `xcrb_msg_to_type6_ep11cprb_msgx` allows a massive `req_len` to bypass the buffer size check.
> - [High] The EP11 request path lacks minimum size validation, leading to uninitialized kernel memory access.
> - [High] A user can bypass administrative domain permission checks by setting the target domain to AUTOSEL_DOM (0xFFFF).

These pre-existing findings will be analyzed and - if valid - covered by
a separate series.

> --
> 
> --- Patch [2]: [PATCH v10 2/5] s390/zcrypt: Improve CCA CPRB length and overflow checks ---
> commit 168ea93b9d93d40b4d0625f5a9d932544117496a
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Improve CCA CPRB length and overflow checks
>     
> This patch improves input validation in the xcrb_msg_to_type6cprb_msgx
> function. It uses size_t for length calculations, adds bounds checks after
> alignment, validates the minimum control block size, and detects overflow
> in sum calculations.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> 
> [ ... ]
> 
>> @@ -404,8 +395,8 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
>>  			     xcrb->request_control_blk_addr,
>>  			     xcrb->request_control_blk_length))
>>  		return -EFAULT;
>> -	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
>> -	    xcrb->request_control_blk_length)
>> +	/* copy subfunction code into AP msg type 6 function code field */
>> +	if (msg->cprbx.cprb_len > req_cblen - sizeof(msg->hdr.function_code))
> 
> [Severity: Medium]
> Can this relaxed bounds check result in reading uninitialized alignment
> padding?
> 
> If a userspace caller sends a CCA ioctl where
> xcrb->request_control_blk_length is not a multiple of 4 (for example, 21),
> the z_copy_from_user() call copies exactly 21 bytes. Up to 3 bytes of
> padding might be left uninitialized.
> 
> Because the check now compares against req_cblen instead of
> xcrb->request_control_blk_length, could a crafted cprbx.cprb_len (e.g., 22)
> pass this validation and point into the uninitialized padding area, allowing
> the subsequent memcpy() to read uninitialized kernel heap memory into
> msg->hdr.function_code?
> 
>>  		return -EINVAL;
>>  	function_code = ((unsigned char *)&msg->cprbx) + msg->cprbx.cprb_len;
>>  	memcpy(msg->hdr.function_code, function_code,
> 
> [ ... ]
> 
> 
> While reviewing these length check improvements, I also noticed a few
> pre-existing issues in related code:
> 
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but does
> xcrb_msg_to_type6_ep11cprb_msgx() suffer from a similar 64-bit integer
> overflow?
> 
> In drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx():
> 
>     ap_msg->len = sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
>     if (ap_msg->len > ap_msg->bufsize)
>         return -EINVAL;
> 
> If a userspace caller passes an ioctl with req_len equal to U64_MAX - 79,
> CEIL4(req_len) evaluates to U64_MAX - 79. Adding sizeof(struct type6_hdr)
> wraps the 64-bit value to 8, completely bypassing the buffer bounds check.
> 
> Would the subsequent copy_from_user() then zero-fill the kernel heap on
> failure and cause memory corruption?
> 
> 
> [Severity: High]
> This is a pre-existing issue, but the EP11 request path seems to lack the
> minimum size validation that this patch adds to the CCA path.
> 
> In drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx():
> 
>     if (z_copy_from_user(userspace, msg->userdata,
>                          (char __force __user *)xcrb->req, xcrb->req_len)) {
> 
> If an attacker submits an EP11 ioctl with a small req_len (e.g., 4 bytes),
> the kernel copies only 4 bytes. Could the function then read EP11 structure
> fields such as msg->pld_lenfmt and msg->cprbx.flags from uninitialized
> memory to determine function codes and domains?
> 
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at the domain
> permissions, is there a way to bypass administrative checks?
> 
> In drivers/s390/crypto/zcrypt_api.c:_zcrypt_send_cprb():
> 
>     if (perms != &ap_perms && domain < AP_DOMAINS) {
>         if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
>             if (!test_bit_inv(domain, perms->adm)) {
> 
> And similarly in _zcrypt_send_ep11_cprb():
> 
>     if (perms != &ap_perms && domain < AUTOSEL_DOM) {
>         if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
>             if (!test_bit_inv(domain, perms->adm)) {
> 
> If a user submits a CPRBX or EP11 request containing an administrative
> command and sets the embedded domain field to 0xFFFF (AUTOSEL_DOM), the
> condition domain < AP_DOMAINS evaluates to false.
> 
> Does this cause the administrative permission check to be completely skipped,
> allowing a user with only usage privileges to execute administrative
> commands on that domain?
> 

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

