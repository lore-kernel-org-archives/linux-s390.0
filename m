Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD531E828
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781761867; cv=none; b=s8gLHkettJWk/apbCDgDHS7Z5WM/5tsj/+oLlEicue6RrJ+SjkMbjIvFXZNhqZdw8GHvUDk6ZgPaGKeyszompUL8Bp709jqYcfEaIDw+tu763OR0pc9KFG4cKIQzvEDUPsMgc2y66PrKiynpFjb6IqcZO1QxZP1J1soySX45wYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781761867; c=relaxed/simple;
	bh=Kr70ooazNGyYi3PAIKEpKcvlcJyFH5d7EpoU/eIN2+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVrG4YpjubDCau6liLEldkP+Mg6I6wRmh04r3ApEiyh9NyJk+YF5gwV8bwIf2iz0+BMWJmxD+z1cVi10bqdMST+5oNQqBXKrQpSYzmRYzqUJ1Nx2ArG392I6U+xmLC5fyfv1OTR0btqSOIg7pMPV6DDiLGam9Iwt7172fenEW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D6kPcObo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D6kPcObo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmHdA1000291;
	Thu, 18 Jun 2026 05:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SgYAs0
	ekkZn45c0V1aI2EvC3bRH8ip4owCVCSt8CtkU=; b=D6kPcOboTo3zARMJ/vY4CS
	4iq/c7DzEOHr+en2jz/tAPZloQw+gkieP7/r5oOsjCbTGk2D2z+mW1mkXMzAqV1g
	BUNoFK56GkXDG3GGmIgFE4Hs/OYvT+wcgWH3gW60mlKEC99bVcOC87TFHDvdvym9
	3LT4Pfvc2KD98r6SX0sGT/D/1g+IIymSLqPqjqv+BRCk0LHTFVoj8HZrHU+px7zk
	5pJ3VUqusxGklHXkHI5f1v6HXaTW0NbTLVzaYXxqHI23gkQ3Xnok4G8MdFYMBqpd
	EsuwlRCiuJHabVX/jJxJyNcwbru3xYJSCap4rSLxl0uAKhUjFlNrp3OFmG+5bfoQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6f3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:50:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I5ndon002834;
	Thu, 18 Jun 2026 05:50:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1722755-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:50:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I5oqPZ45023734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 05:50:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 831A020043;
	Thu, 18 Jun 2026 05:50:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F9BC20040;
	Thu, 18 Jun 2026 05:50:52 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 05:50:52 +0000 (GMT)
Message-ID: <d0678c75-68b1-48da-aaf6-c846b48c02e3@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:50:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/17] target/s390x: Support pckmo encrypt AES
 subfunctions
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-10-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-10-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX15wrnC5qcmIu
 0OtcJm/s0+/FiPP6NObjNBnARJLezkG11GysR8B1WwRZVa0F4z1jEimQA7WpwHQHPBy9hZ5y7kh
 dj5lZHkWDDWF8XUswSBMQSt7nE+fecfgWGSD69/WOT6eVvgyi7uTykIcMIqNfI8MI7TSdzCyF/O
 UuNxS8+e2BPKEpUma4GqTVDw5m0nuGDHydTKRe3BGRfjXxQCVSX8k4VdbYKpUyu6vepZ0Kow8lx
 eAxCeUehMbFYBSnQ3RuThzPpPl9cgkpkhTm73VY9Bq06W5iQhIxv5/xMPulkyxFNDSN/x7PX9FO
 N/HQEdE3a+62TdX2CqcrEhg8OFjhbH8tBx1eu33tWkL0suvUvVdiISdvyQ13fTrLKkPH0DB0VRS
 IQgNg6EAo38SwATsIxRicOz6XQW8dT8N3S37RF8MjOEZ4xCD5c0PvBNynQ4sfZFOHSLDGa5qr66
 Z/yctVrVq5lfljtyBrA==
X-Proofpoint-GUID: UfuhwgKYXUlRC-PSLwiLtKjriKkMoVha
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX/tOOhAjK7sqE
 FoH8HU+maoZjCWvb3LcWWPnq+f/ZDgLyLxVc8Tiid8ctrYUmJyKLY0jxWCk0saIq6T8icI0quzk
 QopYN6Gu35SOJUCygowEp58QjvWtxzc=
X-Proofpoint-ORIG-GUID: UfuhwgKYXUlRC-PSLwiLtKjriKkMoVha
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a338741 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=4y9iHYcLADgxcy7P2XAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180051



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfuctions PCKMO-Encrypt-AES-128-Key,
> PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key.
> 
> These subfunctions derive a protected key from an AES clear key
> by encrypting it with an internal AES wrapping key. More
> details can be found in the "z/Architecture Prinziples of
> Operation" document.
> 
> The qemu version provided here is only a fake indented to make

typo: indeted -> intended

> protected key available for developing and testing purpose:
> * The protected key is 'derived' from the clear key by xoring
>    the fixed pattern 0xAAAA... onto the key value.
> * The AES Wrapping Key Verification Pattern is a fixed
>    value of 32 bytes 0xFACEFACE...
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the typo fixed and the other comments at least considered:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  2 +
>   target/s390x/tcg/cpacf_aes.c     | 66 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 21 ++++++++++
>   4 files changed, 92 insertions(+)

[ snip ]

> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> index 0312436c43..5a0a3473d5 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -467,3 +467,69 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   
>       return !len ? 0 : 3;
>   }
> +
> +/*
> + * Hard coded pattern xored with the AES clear key
> + * to 'produce' the protected key.
> + */
> +static const uint8_t protkey_xor_pattern[32] = {

the wrapping key for protected keys is called virtual server master key 
if I recall correctly. Maybe name this accordingly or at least something 
with master or wrapping key in it as this describes the purpose better I 
think.

> +    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
> +    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
> +    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
> +    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA };
> +
> +/*
> + * Hard coded wkvp ("Wrapping Key Verification Pattern")
> + */
> +static const uint8_t protkey_wkvp[32] = {

Since you call this protkey_wkvp you could call the wrapping key protkey_wk.

> +    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
> +    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
> +    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
> +    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E };

[ snip ]

