Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627160;
	b=VXv+KViDjEvboEVUnaXLdTXbWy81ZNBKncv/KmSL4ZSCYTw74+Q1eG8ismeo7XoVBYnr
	 OXuDOsM9Jo3kaeEhxqD6VK8Zt46E+xO+sjU4xRNvR8a4o4xdI3MhE+zOgAD2esrxfNCO1
	 nPkXn94PcCjpaD53zleDfXl9j3tvPfAnHBXNDwAi1Ryld5lemq/mOl/X5yiepnaW58zkA
	 EhlczEBVfT6CXa5SRiG4EXQziWdOWb4CVQCHU3MAvtPGVjBvakzNTJwGymPhQetGOidxR
	 JBYYk/YXThPCAs4NyYj4Lek6fwAILAowVuCvkX734xedFH+wV7HSq6wsj3isL+Ok6sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627160;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nZhmsjnBxJ+8r+QA6vO1iYcrgzf+pJHTtUwizal9m68=;
	b=3QhKrUzp7mByoEwYCDIO0GIn5Oh3w5N/ERUMSB26Zn5/zFY18CJO5MPNfGrFm1ta4grA
	 8kNXieuj1jrUK/+KDUw5D6Jx8QTFU3JjV0vRBgeaq1XJpF58VeWNUfv/KoaBFPa3dLOg9
	 p2TJ5oXIuzAvQxNV2OFCDSo+iV2Y/1IhFKrJ/+sTHfNVrqEi0ivx+P+l/cZEbjM3ZuAwe
	 FLcqgHK4UmZBH4l2B1OKsBXdo1Orj9FDotXwQ54u2grbxypNVzb92FCMJg+RufUfyOXfb
	 6xn+5boQTqtkp31hA203dcypYk1QBA4sUv3GTyYLh97zjnbQEVYQKCdcdh+PRAhzCGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XZkorKFa;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA77606A33F;
	Mon,  2 Nov 2026 13:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA77606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XZkorKFa
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DE7c42975966;
	Mon, 2 Nov 2026 13:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nZhmsj
	nBxJ+8r+QA6vO1iYcrgzf+pJHTtUwizal9m68=; b=XZkorKFah0vGIbfQ4uZWT4
	m+YGMQTlUT0cYrtvIArcj6bwCMhnHQm2IUR4NPZ49KudV7kuNX76HWwrfXN5KQLE
	Vbba2rKLWXyLFZkNq4U8XEZzGhCfYzZdqwURwvPYARDZmi3znf6OhDsHNiitMXs0
	z8D/lzzffwW14SrYGBNwmSKGVMXhdKCm4zKbrvO1ZkKSEv4BKiNOp+JvKOtVMQZk
	5P9WY0+GbnDmlMSmgjxU+6mEVB+oUtv7rwoDnDrS+uZtMNSolQqbr5mKKXw3kIvo
	05Y2zejIFbGkxZWLneZLzGOUekKOQE10UDw4W5iRy8o48t7ygwenuVxBiOtWAGuw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826gr02-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 13:45:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DJxto1031291;
	Mon, 2 Nov 2026 13:45:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gnxaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 13:45:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2DjndB26804822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 13:45:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6716620049;
	Mon,  2 Nov 2026 13:45:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF3C20040;
	Mon,  2 Nov 2026 13:45:49 +0000 (GMT)
Received: from [9.111.82.55] (unknown [9.111.82.55])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 13:45:49 +0000 (GMT)
Message-ID: <73347a6b-1224-415d-905a-aec1a62dd13a@linux.ibm.com>
Date: Mon, 2 Nov 2026 14:45:48 +0100
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
Subject: Re: [PATCH v4 1/7] KVM: s390: Fix UCONTROL inconsistencies
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, david@kernel.org,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-2-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 xsFNBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6
 qLqYr+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv
 15mH49iKSmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZe
 zuMRBivJQQI1esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzb
 lDbbTlEeyBACeED7DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoL
 Esb8Y4avOYIgYDhgkCh0nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk
 0m3WJwvwd1s878HrQNK0orWd8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0S
 cITWU9Rxb04XyigY4XmZ8dywaxwi2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsU
 Z+/ldjToHnq21MNa1wx0lCEipCCyE/8K9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNj
 HTOLb2g2UT65AjZEQE95U2AY9iYm5usMqaWD39pAHfhC09/7NQARAQABzSVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+wsF3BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUI
 CQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQALjkdj5euJVI2nNT3/IAxAhQSmRhPEt0
 AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxTdSNSAN/5Z7qmOR9JySvDOf4d3mS
 bMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmjGhe2YUhJLR1v1LguME+YseT
 eXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwhfPCCUK0850o1fUAYq5p
 CNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEjOxu3dqgIKbHbjza
 EXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprAY94hY3F4trT
 rQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJVrweMub
 UscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK15k/
 RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNq
 dq2v0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPL
 jJbazsFNBFubpD4BEADAcUTRqXF/aY53OSH7IwIK9lFKxIm0IoFkOEh7LMfp7FGzaP7ANrZd
 cIzhZi38xyOkcaFY+npGEWvko7rlIAn0JpBO4x3hfhmhBD/WSY8LQIFQNNjEm3vzrMo7b9Jb
 JAqQxfbURY3Dql3GUzeWTG9uaJ00u+EEPlY8zcVShDltIl5PLih20e8xgTnNzx5c110lQSu0
 iZv2lAE6DM+2bJQTsMSYiwKlwTuv9LI9Chnoo6+tsN55NqyMxYqJgElk3VzlTXSr3+rtSCwf
 tq2cinETbzxc1XuhIX6pu/aCGnNfuEkM34b7G1D6CPzDMqokNFbyoO6DQ1+fW6c5gctXg/lZ
 602iEl4C4rgcr3+EpfoPUWzKeM8JXv5Kpq4YDxhvbitr8Dm8gr38+UKFZKlWLlwhQ56r/zAU
 v6LIsm11GmFs2/cmgD1bqBTNHHcTWwWtRTLgmnqJbVisMJuYJt4KNPqphTWsPY8SEtbufIlY
 HXOJ2lqUzOReTrie2u0qcSvGAbSfec9apTFl2Xko/ddqPcZMpKhBiXmY8tJzSPk3+G4tqur4
 6TYAm5ouitJsgAR61Cu7s+PNuq/pTLDhK+6/Njmc94NGBcRA4qTuysEGE79vYWP2oIAU4Fv6
 gqaWHZ4MEI2XTqH8wiwzPdCQPYsSE0fXWiYu7ObeErT6iLSTZGx4rQARAQABwsFfBBgBCAAJ
 BQJbm6Q+AhsMAAoJEONU5rjiOLn4DDEP/RuyckW65SZcPG4cMfNgWxZF8rVjeVl/9PBfy01K
 8R0hajU40bWtXSMiby7j0/dMjz99jN6L+AJHJvrLz4qYRzn2Ys843W+RfXj62Zde4YNBE5SL
 jJweRCbMWKaJLj6499fctxTyeb9+AMLQS4yRSwHuAZLmAb5AyCW1gBcTWZb8ON5BmWnRqeGm
 IgC1EvCnHy++aBnHTn0m+zV89BhTLTUal35tcjUFwluBY39R2ux/HNlBO1GY3Z+WYXhBvq7q
 katThLjaQSmnOrMhzqYmdShP1leFTVbzXUUIYv/GbynO/YrL2gaQpaP1bEUEi8lUAfXJbEWG
 dnHFkciryi092E8/9j89DJg4mmZqOau7TtUxjRMlBcIliXkzSLUk+QvD4LK1kWievJse4mte
 FBdkWHfP4BH/+8DxapRcG1UAheSnSRQ5LiO50annOB7oXF+vgKIaie2TBfZxQNGAs3RQ+bga
 DchCqFm5adiSP5+OT4NjkKUeGpBe/aRyQSle/RropTgCi85pje/juYEn2P9UAgkfBJrOHvQ9
 Z+2Sva8FRd61NJLkCJ4LFumRn9wQlX2icFbi8UDV3do0hXJRRYTWCxrHscMhkrFWLhYiPF4i
 phX7UNdOWBQ90qpHyAxHmDazdo27gEjfvsgYMdveKknEOTEb5phwxWgg7BcIDoJf9UMC
In-Reply-To: <20261028185422.272146-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pNHWYOw7n9uv1daxksidSM_yctJiXE7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfXwAUJ76ZEqoy7
 uT4J4nHtZGYqmUI7B01Ynpu+C6f0CehE+FpYvv8TT/noo/55I8ZQfz9xaGSTaYBX8InISRI0WLM
 BsXBbKZJGheVaQwvbijtd/YyfECSBUNa5ShQ3t4sjxMitPir004BFL0yAtUCaaVJjZEeLl8xcOM
 +9q48hOhgAIYx1aPhOPnLSgWVns/emv7kcpGTiE+Ql8qVKRVVVcFR4zYqgW83ULksAv2Rz2TZVp
 L+T6R5ZIXtI5vZxATu8qt5lgJHCdTjSE56LUloKsQpfvt/LnXDVXErEIhx4PdrSHIRwXUBSSxD9
 PTos2/tbZMSzTBPFzZV6uMSgxxswv7IQe0CWKScci05Etq8dnhzKMV1MsYeorJh6nCMRNkRQZJ9
 VCCPyTTU4RfAAZfFc2yKNzxobJGIs1XUnSmBBS5OnUP3AuHIkkv7NT6PbR1y4TI3HtqCEgnILnq
 CwZJLFiUBEh5agIJcTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX69S7UrUUqcWp
 o4AvYKxFf1d1ghsGEqWX8Tp3gH5lR19LNJWKjwQBuAXMJv/aQYdndgb6si2xmR/2AtVqMKIjPDl
 AmUUwgtbgfF5sFgiDDieJznsBc89wZU=
X-Proofpoint-GUID: pNHWYOw7n9uv1daxksidSM_yctJiXE7G
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae89414 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=AO8tPHvIc8Hd2HLRh-MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020054

On 10/28/26 7:54 PM, Claudio Imbrenda wrote:
> For UCONTROL VMs, when a vCPU segment entry is mapped but unallocated,
> the tl field was set to 1. This collides with the present bit, which
> means that other parts of gmap would mistake the entry for a present
> one.
> 
> Refactor the code to use a different combination of flags to indicate a
> mapped but unallocated segment.
> 
> The new flags combination will result in several functions returning
> -EFAULT when used on UCONTROL guests. This is fine, since those
> interfaces should not be used for UCONTROL guests to begin with.
> 
> Proper fencing of the interfaces that are not allowed for UCONTROL
> guests is outside the scope of this patch.
> 
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: stable@vger.kernel.org # 7.0+
> ---
>   arch/s390/kvm/gmap/dat.h  | 16 +++++++++++-
>   arch/s390/kvm/gmap/gmap.c | 54 +++++++++++++++++++--------------------
>   2 files changed, 41 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> index 90389d47ba4e..4665c1112bb9 100644
> --- a/arch/s390/kvm/gmap/dat.h
> +++ b/arch/s390/kvm/gmap/dat.h
> @@ -109,6 +109,8 @@ union pte {
>   #define _REGION3_FR_MASK	(_REGION3_MASK >> PAGE_SHIFT)
>   #define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
>   #define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
> +#define _UCAS_ENTRY_LENGTH	0
> +#define _UCAS_ENTRY_OFFSET	3

Both of these together in combination with tt=segment are essentially a 
flag for a ucontrol mapping that's mapped but not allocated?

>   
>   /* Soft dirty, needed as macro for atomic operations on ptes */
>   #define _PAGE_SD 0x002
> @@ -421,6 +423,17 @@ static inline union crste _crste_fc0(kvm_pfn_t pfn, int tt)
>   	return res;
>   }
>   
> +static inline union crste _crste_ucas(kvm_pfn_t pfn)
> +{
> +	union crste res = { .val = PFN_PHYS(pfn) };
> +
> +	res.h.i = 1;
> +	res.h.tt = TABLE_TYPE_SEGMENT;
> +	res.h.fc0.tl = _UCAS_ENTRY_LENGTH;
> +	res.h.fc0.tf = _UCAS_ENTRY_OFFSET;

You're missusing this field in order to get to bits 57 and 58 which 
aren't actually the tf field for a segment, right?

If so, then this might be easier on the eyes since you don't use a 
bitmask but it's horrible for the brains of anyone other than yourself. 
Especially since there's no comment explaining the shenanigans.

> +	return res;
> +}
> +
>   /**
>    * _crste() - Useful constructor for union crste with FC=1
>    * @pfn: the pfn this pte should point to.
> @@ -985,7 +998,8 @@ static inline int dat_create_slot(struct kvm_s390_mmu_cache *mc, union asce asce
>   
>   static inline bool crste_is_ucas(union crste crste)
>   {
> -	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
> +	return is_pmd(crste) && crste.h.i && !crste.h.fc &&
> +	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
>   }
>   
