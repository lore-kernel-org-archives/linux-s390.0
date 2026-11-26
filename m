Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696559;
	b=0v5yjzepj1WsMixlm5YS45QB4h68vIVieSZ0VPgtoazclP9MTpNOKavnyU8rIvNj0UBK
	 uXywd2JmTKRVviZrQZHm/fBciZLn1B4FXNPAGOYjlps0M/ffxT1rXSZ14HgEz6VM4/QZm
	 V4DPMal1/IVo+1LVxlkn+du20GlsHxJ4+9o+WdEvJEQuIrHoKYzvOH/Xjic/3uv54uvUd
	 6yeJ+q47TDR93cigZlm/oc1W6XLQuXmCJqJnNlS3/VXAInKkIWjOUm8e8bbjVvOxWcL0N
	 xH+jHQPXjMXO52AddR2ja71OmWStHkgbMiwhJiQ9FfCbNbU8XL0uUE4KBcXYcAxRpoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696559;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GKT9oowf0TD/M9Bia3/lD8JP3I0qK2S18DL6sTON+k0=;
	b=R8BzWEZEW1IGlU0Pvlx1uv4C63UkgRtNogaO9sD52Sy0iAfQm/7CRXjM3hj8MgJBXlAe
	 uc4XMUjzBQMDPSkjq5TEcZVD4PeU9pnxRV9u0pgKtINWiWbf0MbehxAhz0siVTtEZk0Jh
	 aiF7zArCnY3gMGrH95G5JjizWzuaYtkXptzc1BEnykaQeeZLemCvHEH0CFcEer3KoXICJ
	 fM2Mylxm+VxydyKxENDz051qK6NmMlciYTBpssSChBbuA+OpOIkkTH42gIL/cy5zHO0NY
	 JdmH9F+oQyl+YW/c0nglG5TZ7kQJv6zsGEsKJvQTwaJD/sL/ucsfnugjKczv3QWEtrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DyuuPeiK;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193A606A323;
	Thu, 26 Nov 2026 12:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6193A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DyuuPeiK
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBYqPj009898;
	Thu, 26 Nov 2026 12:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GKT9oo
	wf0TD/M9Bia3/lD8JP3I0qK2S18DL6sTON+k0=; b=DyuuPeiKNB1rFvXi1YQIVe
	79CvB7Nkue9NtbXfOlWbKp5buY/Rx0ut5Qss8JvM9AQ/3iP95z45jL8M8iZoz+uV
	eMNZvfFJu9KdEEyi9fuFSYyvqDAHlgF9rdtPXW8jMWGO1DxgCU7d/vN5msrnfqkf
	y8g/ej9cA7UnJByvdKbtKmFNmDoy6BTuPU6462zSBtR373SSynfKQE1TyFBAiMTv
	j8xP5Vvfh6XjryT9AVkrM5mN/8FdI+YXaIOPqHhURl8vku8THfQi4br8MszDw6Sr
	n+RrDGbwpaacPSEM+SM2IF13rULBaovfGGS/V2CLSp17Hu1hacHgIkrLyki09+Sw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fks9a4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 12:35:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBYMRQ2180327;
	Thu, 26 Nov 2026 12:35:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkyybq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 12:35:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQCZhAP42795436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 12:35:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D93C20040;
	Thu, 26 Nov 2026 12:35:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20CFE2004D;
	Thu, 26 Nov 2026 12:35:43 +0000 (GMT)
Received: from [9.68.23.45] (unknown [9.68.23.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 12:35:43 +0000 (GMT)
Message-ID: <5d2e50f3-ca65-4090-87e5-03819441da48@linux.ibm.com>
Date: Thu, 26 Nov 2026 13:35:42 +0100
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
Subject: Re: [PATCH v2 1/2] KVM: s390: vsie: Rewind the PSW of ESA mode guests
 in the right format
To: Yvan Janssens <yvanj@cyber.gent>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, Eric Farman <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261125165604.3074595-1-yvanj@cyber.gent>
 <20261125165604.3074595-2-yvanj@cyber.gent>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20261125165604.3074595-2-yvanj@cyber.gent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0OSBTYWx0ZWRfX5U9LdZFmOGQz
 xna26zpgNnaAxhKMnEVmxN4jF1pZ4ZmStsDo+aEEiayOrNl+TVaH3zsIscVY1wh81SRBvN622S3
 1+WbUU/i/WXsSrZcifrWlCkHSKbT4PoTIqYRMk+KvLdMO9/7/ZdDmcu50v4/rC7QRpVVk9luZvO
 dWquXOLd3oTH/WIqW9LQHcfdNtiYw8NgKD+PnHC1xKPhr8Vg4+/3GI6fF5+v5Lob64myOnCNwnz
 FdjjTaDqc6alO7smoGDiADy+AoX5oUFPWEvTQNgObZkcZFuykiPOtzHSsRwQZl7D/PvSuz2Cr6z
 SRotzQVI1f/8LX1XJhx8JKmXEfG7Syc4TxZp5f2oRLGU9XOINeriZvFaEb0EBb/X2FpyErOISMt
 /T79TmTe+sP4+pQYigg9nwuUoXisnTzLaFlP1rCTMUM4POKtNeWM4vpKI/8pMM4UNjbXUDLHlxo
 TFRsAg3+Ip1RiJijXsA==
X-Proofpoint-ORIG-GUID: JU94GMs746ql91RjW2H9gv_ElVJ7tPLd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0OSBTYWx0ZWRfXx2GzR2r4IjMg
 fe0EkhVrGUF/KALty2vYH4UF/0fgkxG3ifDCFMckCCAIo2wok8kbCMQbbTJJwSVyxI73j46yUV6
 TkX3d3RExgNJZjanp151+zO0bX0xvA8=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b0827a4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=l9r1cnm4-fEY1RtK:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=cyxkdFWmLbpH1sDcVnIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cGh7yxMDTOI-Y9kVGVp1WIDyfqnURdp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260049

On 11/25/26 5:56 PM, Yvan Janssens wrote:
> ESA-mode guests in vsie have existed since commit b0ad874d9852 ("KVM:
> s390: vsie: Allow non-zarch guests"); they use the 8-byte short PSW -
> the mask and instruction address share one doubleword.
> 
> vsie's PSW rewind originally still changed the second doubleword, which
> is unused in ESA mode, so the instruction is skipped instead of
> repeated. The visible effect is that the first STFLE after entering SIE
> does nothing in a nested guest.
> 
> This patch adds a vsie-specific rewind function that handles both
> formats; no short-PSW type is introduced - for ESA guests mask and
> address are written into the mask field.
> 
> Fixes: b0ad874d9852 ("KVM: s390: vsie: Allow non-zarch guests")
> Cc: stable@vger.kernel.org # 7.1+
> Signed-off-by: Yvan Janssens <yvanj@cyber.gent>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
