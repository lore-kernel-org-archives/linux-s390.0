Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2121322B7D;
	Fri, 17 Apr 2026 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416427; cv=none; b=EDwUz/mEHAt09ZEuixJEoVe8nNdb5LShFvjjNB3H/Htr2y2MO6hPgKpQ+bBkUXVWAemmDen8K5G2jfscDmMwRstPq3A7VAQthN+kL0dNIvgQq0PQyl3FgVS6AKjwELLgNXVIChuInNRddFdpQrNpcJu9cUMHt2ykd4Svepcw3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416427; c=relaxed/simple;
	bh=wHjKPGFNQs3DIYWKejHA74odDRzFsllMyDGcscI+BD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YneJljwWZ68NAShHlTpKuiyMYj2oy2w/xpLP+0quetgPb8QKD2cPGPoYTC0Pg1YFeOoMdi+rJza+xuyYMLnRzI9qJFfFLjkICgI6j2jZjVDFChQ6ra7V3yVHbYZTFa3GaNjfmYNDeKRxtTINKU/C59DOpoIq10SBI87sX6wkU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HY/Veza2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HY/Veza2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GN6P3U1842955;
	Fri, 17 Apr 2026 09:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VPX++1
	MhTYPpirwh6G0cqp/1e/8iAFGBkuQkxIN6jK0=; b=HY/Veza2BjHtMEIJXssldZ
	K+uYxZ1ysO7ETbWxkyIyZ2XfPIMo0PAc9NGvASKEqZicLsKtJ0MeoI5pkRMJTPBs
	NydBHxQBynng/OaF15gjZ5znxEeVIEg/8BB5mjmHU/7VgyqCZhXIX4gZlHMu83aG
	sLhMhLAENODmN8WW0tsRNfKrXMyD+w6sAntW0w/PonsIGDW2Va+XXRoye46KgK/6
	8LXmv2H3i/7Ze4ZNGg7kvRrOTLINyujYp7k23xbe/fzx2Uvp3Pl8rTOnEAKaPesY
	8/Br2U9FoaNKmC7WvxizP7NHcoqyVgLEqNTOzCxR51WT42wt94KeltiDy2aStoNA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89n1px3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:00:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63H8pHVx004235;
	Fri, 17 Apr 2026 09:00:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kpe9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:00:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63H90Bor49021424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 09:00:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B87752004F;
	Fri, 17 Apr 2026 09:00:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B6902004D;
	Fri, 17 Apr 2026 09:00:11 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 09:00:11 +0000 (GMT)
Message-ID: <f92b3ea0-76d0-4393-8a82-18de3a7d3e08@linux.ibm.com>
Date: Fri, 17 Apr 2026 11:00:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] KVM: s390: move some facilities from
 FACILITIES_KVM_CPUMODEL to FACILITIES_KVM
To: KVM <kvm@vger.kernel.org>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20260401134254.259873-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260401134254.259873-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA4NyBTYWx0ZWRfX04HJFnF/KCNQ
 Wbw+c/WqzxAd+6WKHCXrubYziBXfBhgTXq3j4Y/YLh9/rpUSCeyd09C49f+tkbimZEo2HcWDCAL
 GOy2hdd80gOUGVdo6nY0aB5jJ5aN6n/Qgp/85rh0Q/mTglQAFCln2IaZ/OaRYlTOUF0SZ7fp+qA
 BavZvubxZCUNTiKc4Mwpoyz4CUpkyPdt/8mC2C1u0LuJacKhFACnhcq5la+PpvhlkJtzy592jfa
 RkSfjxhtjwU2hxyvsj3OexrvYjTd1GKAOFuFgGWBqV9fl/oIxJoMxEB6cFWpYXikygvtiu7uIWJ
 PJWcijd5THj3eNXA2ep0nAN7LGc3CAhsrdJQNtpJ/af+q67ZipRgWrtu/clFsizPucFDXABccUx
 3GTG8ocoEkXNZe/+kDjONucidSxnfxQGOHxj4frgznvzcUzVxBOWdN8Qd/6xA3JVpLR6GTHw0J2
 12+E0lNHik3HSEYrMkw==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e1f6a0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=2kHF2l_4nywtQCaYtJAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: p-NwlAA3sQbYGHRy1H2mRKxF5m3T_xM9
X-Proofpoint-ORIG-GUID: p-NwlAA3sQbYGHRy1H2mRKxF5m3T_xM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170087

Am 01.04.26 um 15:42 schrieb Christian Borntraeger:
> Some facilities have been put into FACILITIES_KVM_CPUMODEL to be on the
> safe side with older VMMs. Unfortunately this has some unwanted side
> effects for VMMs without a CPU model (like kvm unit test) and IBC/VAL is
> not used in that case.
> 
> Ideally the guest visible STFLE bits, the behaviour when running
> interpreted (HW supported) and the behaviour when running emulated (kvm
> or qemu) should be in sync.
> 
> For LPSWEY this was not the case. STFLE.193 was off, but interpretion
> did work, emulation did not. As emulation only happened in rare cases
> (e.g. deliver a machine check) the result was inconsistency for the
> guest.
> Move beareh to FACILITIES_KVM to fix the inconsistency.
> 
> NNPA (facility 165) has no fencing and no KVM emulation. The instruction
> will work, despite STFLE.165 being off in the guest. Move also to
> FACILITIES_KVM.
> 
> Facility 170 (ineffective-nonconstrained-transaction facility) is an
> anti facility and should be passed along as well as KVM cannot simulate
> the missing function.
> 
> KVM also does not implement trapping for guest RDP and there is no
> additional hypervisor control. Move 194 to FACILITIES_KVM as well.
> 
> Facilities 196 and 197 (PAI) also do not have a hypervisor control and
> need to be passed on as well.
> 
> The PFCR is also not intercepted by KVM and needs to be moved (stfle.201).
> 
> The other facilities are fine (stfle, emulation, interpretion in sync):
> Both AP related features (12 and 15) require a userspace added AP via vfio.
> 156 etoken facility is fenced off for interpretion via ECD_ETOKENF so
> everything is in sync
> 
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>


ping.  Any concerns?

> ---
>   arch/s390/tools/gen_facilities.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 2d28a569f793..32dd5a57240d 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -96,6 +96,13 @@ static struct facility_def facility_defs[] = {
>   			150, /* enhanced sort */
>   			151, /* deflate conversion */
>   			155, /* msa extension 9 */
> +			165, /* nnpa facility */
> +			170, /* ineffective-nonconstrained-transaction facility */
> +			193, /* bear enhancement facility */
> +			194, /* rdp enhancement facility */
> +			196, /* processor activity instrumentation facility */
> +			197, /* processor activity instrumentation extension 1 */
> +			201, /* concurrent-functions facility */
>   			-1  /* END */
>   		}
>   	},
> @@ -112,13 +119,6 @@ static struct facility_def facility_defs[] = {
>   			12, /* AP Query Configuration Information */
>   			15, /* AP Facilities Test */
>   			156, /* etoken facility */
> -			165, /* nnpa facility */
> -			170, /* ineffective-nonconstrained-transaction facility */
> -			193, /* bear enhancement facility */
> -			194, /* rdp enhancement facility */
> -			196, /* processor activity instrumentation facility */
> -			197, /* processor activity instrumentation extension 1 */
> -			201, /* concurrent-functions facility */
>   			-1  /* END */
>   		}
>   	},

