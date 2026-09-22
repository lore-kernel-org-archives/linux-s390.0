Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE45275AB;
	Tue, 22 Sep 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077772; cv=none; b=MZBbZNrR7vALmgJhnXb2pmZirTuHrYV3V5M26F8AsQ3y9+SqZ5DUqqiG46q0zuFjJSP3eroPmFqwEApxwXSVOIvmznEEeu9bCyZkeSOBVvca+NGA3f/01dJKuGdNCWTmdjUImsfuZz7RITfLVNHQaVnL0BwGGfbjfHNlX5UUGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077772; c=relaxed/simple;
	bh=kPZbvQJojUz56uz5x2Xkq5TaowtSZU433spfKSmwdZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1+xIlOKwva5XefvONzc5y4P8iyWZxukSlT4RHrK/eZFrh6RUbcDKjln2i6//btQ45h8rbi6LXA7QRlVyULZzCpCIqxxzpSsDo2Nekb7yfrUnWZ96i/5XYtl5JvAlb/Wdwvki9+AwUnL/s3uDG3eT0OU1HngSQv6mY6g5lq/x78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qgyzve1n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qgyzve1n"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBZWdI343496;
	Tue, 22 Sep 2026 11:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OlQdGT
	d5/teWfKx6IZe2I3T2vvhzZmjui1+3FOLy4RE=; b=qgyzve1nZ4OJJTgOkt/EXP
	fXMWkC3pQ4Z4h53l5pKyj4BauY0fwWyhEhZ41JgB4q2x1AJDOmQ9gCKmZpX6CrMp
	wrlbXf6GpEqC7KQE5J10y9JCZ6nXiS0UqfrXeq7EQUTxg6vkB1ySMoZAVlw9n33c
	vhys3HRuDnoIvaHKkyy/MNrOKRCGbXUlR3aLZ9pZKIbuvsu6Au1cXnUCLRSU8xGi
	b6UxW2ngmRgU+pDQE2TobrNzr5mU+yDyr6G1RrJeU6WGDv4Gqwgc5/seVU6t7OOB
	BBxZH6V5o7KThN39FWXBh3I2BOMbjgU5ny6lT2sP7JnK5vApKDIiPjaUmEf5pYWQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv57kx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 11:49:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBWZD62794786;
	Tue, 22 Sep 2026 11:49:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gsjp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 11:49:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MBnHTa64422350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 11:49:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FC0758055;
	Tue, 22 Sep 2026 11:49:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A508E5804B;
	Tue, 22 Sep 2026 11:49:15 +0000 (GMT)
Received: from [9.61.66.235] (unknown [9.61.66.235])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 11:49:15 +0000 (GMT)
Message-ID: <2569f9f9-451d-4e66-be71-d0514fa93864@linux.ibm.com>
Date: Tue, 22 Sep 2026 07:49:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Add missing KVM s390 crypto attributes
To: Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260918145151.2116991-1-farman@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260918145151.2116991-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pZmCBxNtzt_PIldQCJigl5ttS2hPmwyI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE2NyBTYWx0ZWRfX8DW9ITZNVezP
 q4LE6GVXLQ/DRyXj+sVq/vF5llbWNSgnuQCwytMXz5HAsFWkM+9lg1xW9KeO3v+JN+nQvdrb1j4
 doqLtzmUgdrhO9XuAwRHDAcTqKQg79o=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab26b3f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=d3y8_kawna_tOOV282gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UkMdUKLfUJwX3wPyHW6TAwvMXBT0ukNh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE2NyBTYWx0ZWRfXz9FcZ1yqGTgH
 qT6RfenlnCywdM8WwbzcbS461Euz4Womypp/AYna76GMSo3EaPnHB/lEPMRlrocmtfoHdMKvkO+
 PQpcnQL6zipczIXc/91n0BmtvlyjoGMfXHYGCSTLhydMZd1MxonYeexjG8RoClhDayC50isFJPU
 cpYdKgw01Zznl1ePZb+VB/x+cM5s6XVBIxZSuIhG5Uh/RF4HRyvQreNeS4VHN7E9xgj1zbwI+u5
 2ENzTRYttsA0DA0vtEj8+KNpK2UlCBzsu3alUR41laCeq2yvYBM5/8wxQ/aPheU/jr41kai7U9E
 zdoyZ4eK2nt1gq/q1iHTT5IX+N1/iaFsbdvI/zjj3ExB4M8r9QrTVYt+rP3S/HmrQau/xKaPjNw
 orIONwDWuOV/Dy2oHIe7DULKZnyq/Ak/JcG2KIFr9IUwE/Cv2qLyrIvjEM29cIlvIYS0p3RrtNY
 0jPcPsHXba0t+cw6Kvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220167



On 9/18/26 10:51 AM, Eric Farman wrote:
> Device attributes to enable/disable the AP interpretive execution
> support for crypto were added to KVM several years ago, but they
> weren't added to the documentation itself.
>
> Fixes: 37940fb0b6a2 ("KVM: s390: device attrs to enable/disable AP interpretation")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> ---
>   Documentation/virt/kvm/devices/vm.rst | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/virt/kvm/devices/vm.rst b/Documentation/virt/kvm/devices/vm.rst
> index a4d39fa1b083..78e63eb9994e 100644
> --- a/Documentation/virt/kvm/devices/vm.rst
> +++ b/Documentation/virt/kvm/devices/vm.rst
> @@ -280,6 +280,24 @@ Allows user space to disable dea key wrapping, clearing the wrapping key.
>   :Parameters: none
>   :Returns:    0
>   
> +4.5. ATTRIBUTE: KVM_S390_VM_CRYPTO_ENABLE_APIE (w/o)
> +-------------------------------------------------------
> +
> +Allows user space to enable AP interpretive execution.
> +
> +:Parameters: none
> +:Returns:    0 for success
> +	     -EOPNOTSUPP if AP instructions not available for guest
> +
> +4.6. ATTRIBUTE: KVM_S390_VM_CRYPTO_DISABLE_APIE (w/o)
> +-------------------------------------------------------
> +
> +Allows user space to disable AP interpretive execution.
> +
> +:Parameters: none
> +:Returns:    0 for success
> +	     -EOPNOTSUPP if AP instructions not available for guest
> +
>   5. GROUP: KVM_S390_VM_MIGRATION
>   ===============================
>   

