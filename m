Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798433A1A23
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880532; cv=none; b=pOSBaTln7OHKjnxFH1Ctp65vI3stKkRj7Kb9+r79t8XTNpPQbxIxY9UR/s7Fh0C/8Blbr0HSKiDNrRNN0GMJt6HdrNSIe9HE0jhSJhhjtwHCDjbd5cjdcQ0+n46Jqz3ijv8mPXS9Q15PxnLqoKCoZTSITdh3KkUbevvwoectdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880532; c=relaxed/simple;
	bh=oxkoMDL8xp0/ghASG05w4F1m0d+LnMvCfUeepDdMDk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKB+nFulFoUIUegohCCeN87R20QmTmUuP9lbDSyDNdwIpwoct0jkaiPyQcnDy+5AQPcqXFXDNs2eqH2EWps6CkaiS1+gCFLD1914LvRksjrFZx6IoSiP5TScw1WhMRRDL/GZbK1F1WhpaoYjohY37Ki6PNDj1irLb9Nbg1GqT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tqRLZZOQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tqRLZZOQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JnJjH4117986;
	Tue, 4 Aug 2026 21:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z2PRr+
	ebiDNPFCRFsxDhHwssp8h/2KdJvtnlzWvxUfc=; b=tqRLZZOQ5r7CvlIGmrQkJL
	WeIR+BTmxKAv2DHwLpyJSid1jmc+WLFJHGGvnizQxcyAeF6LFeTpEplyNbR+TIM6
	Jr3+ZcnS8Q405E2JoYoLnuoBCpTow74byY+7QvFPiIZfY/TbPu0KoP3IKiHLkuaP
	Q+E9EUqfDDEn1UXuXf56fKLeFak0lWRG56umRVy3WqBaX7vuAwT3MoBtMD6/QynY
	4GKXW5UwmGRjf2rwh/Mrpbe203iyrK/BzfKahxWRcVMxcToCV/ZsmYEZC1r7WPbi
	gvqvW2fagOeNxY9AXNAd31T/XLP2zh0amDTYDJhAvHI2Vy5SYhX3Z2BixG93vJVA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqr2sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 21:55:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674LfMHE015894;
	Tue, 4 Aug 2026 21:55:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qm1jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 21:55:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674LtGph30409162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 21:55:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6CA820043;
	Tue,  4 Aug 2026 21:55:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1878F20040;
	Tue,  4 Aug 2026 21:55:16 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.144.71])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 21:55:15 +0000 (GMT)
Message-ID: <93c0ca90-dc4d-4739-ab95-abb9237a8b7c@linux.ibm.com>
Date: Tue, 4 Aug 2026 23:55:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/18] target/s390x: Add helper functions for copy
 memory to and from guest
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260803161235.228704-1-freude@linux.ibm.com>
 <20260803161235.228704-5-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260803161235.228704-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qMExwnLBjRKhbWGo7O7lHvh1JIxUJ-s-
X-Proofpoint-ORIG-GUID: qMExwnLBjRKhbWGo7O7lHvh1JIxUJ-s-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NiBTYWx0ZWRfX9ZR74rx6QbRQ
 4sgAU21sI83BtQWzWMLG0B1mQKhyXZiYBpw1scVOyrOCTBUWf8+EUzybSTQCaJGMjNwizD0+aF5
 iCt1kQhVwXkiXAE+JoJzMeENGihg474=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a725fc9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=StHepGPFupVIGor_3S8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NiBTYWx0ZWRfX4MuLbm9Fg7Dn
 5UFpioEAlX7qmACmWnTfCkLZNYLasJmT1elGVSgIyyBIaKyI4LE6XKCezHnzixzevucdFZjL0/p
 VAvli0ad0a/IWlSvzGPbmBWBPbqtglptwKR2hy4YeGRg/2/4p7eVluXVITYLK0QQs14S3/LSsrD
 4ASwMk9rcg+1L0lFEN/pHcJm07pCZxUYAuG+EI5o05VCpBqu6ynCWwg1jFDDQomSu8eYCcwXv1M
 8CrQMob/Z+SFvhgt+N7DfFeJUTUA9GNK3UxcZjVxSJmAiQl1xplQa+zwrThhOX4VvDyfZsclF7E
 2XmzxKmowPG1U7TazcwJjbaF9pOwxqQTuCjufYkx8XIfVGtz1cw34tvCNWCRmu0DRgJuDnzw9Yx
 mhenzi4I0uGdTnuMH5HQ+1sTfthZayo4tP1w2eljRaWgbzGrdq1qN9Sd4C1xfzeqqtT2xFHjJDB
 VtY+DGHTUNLElfkTV6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040176



On 8/3/26 18:12, Harald Freudenberger wrote:
> Add some simple helper functions to copy memory from guest to a local
> buffer and the other way around:
> 
> - read_guest_wrap_u8()
> - write_guest_wrap_u8()
> - read_guest_wrap_u32()
> - write_guest_wrap_u32()
> - read_guest_wrap_u64()
> - write_guest_wrap_u64()
> 
> The reader functions read from guest memory into an array of
> u8/u32/u64 with BE conversion. Similar the writer functions write an
> array of u8/u32/u64 into guest memory with BE conversion.
> 
> All these functions are intended to be used for the crypto
> implementations thus are located in crypto_helper.h.
> 
> Rework and simplify the sha 256 and sha 512 implementations to use
> these helper functions.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf_sha256.c  |  63 ++++---------------
>   target/s390x/tcg/cpacf_sha512.c  |  63 ++++---------------
>   target/s390x/tcg/crypto_helper.c |   1 +
>   target/s390x/tcg/crypto_helper.h | 100 +++++++++++++++++++++++++++++++
>   4 files changed, 123 insertions(+), 104 deletions(-)
>   create mode 100644 target/s390x/tcg/crypto_helper.h

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


