Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A2282F24;
	Thu, 28 May 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976662; cv=none; b=L93ttAnIErQ7JWAOtuya+1L045XPwoxIngbTX6a428i8cQK84WUfN5uMehACaR2t97XCPM0WLS3/xGHV7dK3egxhiIak3PnxOIlcNFjYdK00I+b3A86uqycTeYNwe6Xx2jl/rhM7Cx7YvH9nt2pJjpMjDrxBbCKXqpCsrBEvo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976662; c=relaxed/simple;
	bh=N9yrfBQ3KVJO9i3uwNEz/J6ea+yaqAFF9md+/3Z2aik=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HoeLIpQaZ5mDtvd46as9OH2eav9LGhS8kVvg1LatnafbVZuRXo6IUEnoUUpjASO/RBj/pkySuAKRHMbfMBBb3LN+3UwdNWoa3ifThTEV/UPQ4q3VOAiypsEJTmPqkAe/VmAgHX56xd+An3PuGlZgjYQUT51l2jJYjhqQrxJFg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RcVbgjCB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RcVbgjCB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SDAx1a035943;
	Thu, 28 May 2026 13:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2QsCyu
	XWUMad2spc+jD9qGAw0sMJCrDvnu4waPyEMnY=; b=RcVbgjCBuYG7povsFSei+Z
	fpqNhKMCbXsSxVryQnNqQCtQhQyd6jPrKkr7Xv9gqJdS74jqB4I2XJavempTnp7L
	FhYJJr9rQKGGH0sETG/xIsZd+rlWWau89m1ZqecX0LQ8nynhFH3SnHYcCLdQ2zoO
	4333Y5+WrqpGETFont2iKERD6rFEMzd0Ek+lisCMg7gG6QZr597HfKATHqyA9TQF
	1bK7Rfo79IjG/vVbi0EBkz2bXKicBLzMq3g12Y2KsFuTW9nF1MtMUioiPWaKBPlS
	Sc/hu9WFTX7JVJF8yf8LS1esDGoSUigAxsz5lw/ebEUetv/gv6TmptiBJsUbktNw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bb5a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 13:57:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SDs6hh018664;
	Thu, 28 May 2026 13:57:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc0b5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 13:57:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SDvUJo47251872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 13:57:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F68958058;
	Thu, 28 May 2026 13:57:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00D7158059;
	Thu, 28 May 2026 13:57:29 +0000 (GMT)
Received: from [9.61.144.185] (unknown [9.61.144.185])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 13:57:28 +0000 (GMT)
Message-ID: <0b3282c6-cdc5-469e-9aec-1a2b9d22ce08@linux.ibm.com>
Date: Thu, 28 May 2026 09:57:28 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] KVM: s390: Enable adapter_indicators_set to use
 mapped pages
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260526015323.207343-1-freimuth@linux.ibm.com>
 <20260526015323.207343-3-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260526015323.207343-3-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzOCBTYWx0ZWRfX78V7mkm8WNsa
 FdWIYE7Ujg2fN2m/y5b8uPXdoMw5AYxcExUX8wBPdEsB0ZbKWxxNNlWmFdTFvZ8XHQ2FMQJFOCZ
 71/uoOG4VFOQR1ldrZhFulww+4l8wN4R7pUAVPCMVGVCSmfXC+3JKSfQvMEJbVXKCy6EnXBhboW
 aIBmfe43nVX/bO3/c/xyt0k77XEd+TKPpYJL7T7PjcO/XFwocoBeS5+Tw5h38KQH8pRhqceooz3
 8bgtX71Uwtjc3ApwyxVbOBT0CZqayIV9H8EEQYRJzYFlFg0kWtR0DsoAis8Ncgk2x+fJq00FXwR
 Gx8Zaasi8/C0fV9/LOL/ohc7jZbnBWoeAOhcals6Z062ZewByxsW/UZivvEcWTU0tQ3Hj2z7Sta
 bUw5OMhhVR2S4LPK/I/4omYmBb04HWD9APvNdMRYMxwj0Kb+sX2rGXRLT4Z40hn6D0gVnZI2W48
 GHB61FkO4gTYRg068cQ==
X-Proofpoint-ORIG-GUID: dZ8kwBjkFAijiXyEw2vNGUiujqtCp3w3
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a1849cc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=YjX8BNTOaeBdKTrvYLMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dZ8kwBjkFAijiXyEw2vNGUiujqtCp3w3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280138

On 5/25/26 9:53 PM, Douglas Freimuth wrote:
> The s390 adapter_indicators_set function can now be optimized to use
> long-term mapped pages when available so that work can be
> processed on a fast path when interrupts are disabled.
> If adapter indicator pages are not mapped then local mapping is
> done on a slow path as it is prior to this patch. For example, Secure
> Execution environments will take the local mapping path as it does prior to
> this patch.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>

Review tag was given in v7, please include for v9.
