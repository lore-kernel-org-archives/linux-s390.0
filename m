Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE153DDB13;
	Tue,  4 Aug 2026 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847968; cv=none; b=IX+oNWmZxHJhei99FOc9sz4vkop7JsHBpr2DhNqp+ECbyFpmN40WqwNWu59b6ay9/+qX7iw9/ZbO51J3BH2NcfyCDpren+Q+SYx/yKj2NvztYJQGn7oTzfbGwp8YxOd3CmITrz6aju8jerb+cprYQjIUwVMy4uOeUAPEwNQBLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847968; c=relaxed/simple;
	bh=Ypk8BUFe3BWIIE7JQ+O7cMpfypxrP0A+3K/6EccH/30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWfcADaerzIGGwE0HIlnfXsUJ2A0dPpmV0id3Q35+G53NlepK/trV0Qzo7hwj6PcGDZ3/AXsFcAAis23N8I22cq4MuxX06NvUX9qdREGQ14Bp6jYIWRyxIghdCJ79E40sHzaLzUr/sUSF+xxhcO3hKceFaGDyaBygY6Dy6ZXFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XhDcZ2+x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XhDcZ2+x"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Cn97g952150;
	Tue, 4 Aug 2026 12:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w3U6aW
	yxIZOlujHkBb/HpJT2QI2cVcSnpXrBuTFZGDA=; b=XhDcZ2+xsA9bqCfuD15TpN
	kcBspSOg0BbeKiJnO3O0DPOuOhXDEsJOFDv0R2wQTG0+toAdmpengnVl90OVuevn
	2UkAiw43yTJgq6njMg0if1LCqOJMP7f1omsAbbMueEJLZG2f5649ZqVyqJRONdHW
	Od9nL5I2O2uDBD807D0eF2JgXcpzcp8p+UuSrag9tbmXU0I9FmscomRUw5KIJKMN
	yaB8dHsuL+14uf9Rla+2wUlYVzmphTCc8LIeWsvJsK01SM3GYy7vdG2j+J0S9YEQ
	fqdksc76pyz4kXqBDCGLlU0Ncgxap7ve7Crk2Xb95Ho/7c55Bq2XlFoP7fnir1sA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eundyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:52:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674CfaKZ014623;
	Tue, 4 Aug 2026 12:52:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyhr10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:52:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674CqNZ632113150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 12:52:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D13A02004B;
	Tue,  4 Aug 2026 12:52:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FA5D2005A;
	Tue,  4 Aug 2026 12:52:20 +0000 (GMT)
Received: from [9.124.214.89] (unknown [9.124.214.89])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 12:52:19 +0000 (GMT)
Message-ID: <029629de-ee55-4b3e-a7fb-a693c2b1261d@linux.ibm.com>
Date: Tue, 4 Aug 2026 18:22:18 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/iucv: fix UAF in afiucv_netdev_event()
To: Alexandra Winter <wintera@linux.ibm.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        twinkler@linux.ibm.com, heiko.carstens@de.ibm.com,
        hidayath@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
References: <20260803182053.2355882-1-nagamani@linux.ibm.com>
 <9cda0e57-ce4b-428b-9385-743fdef02789@linux.ibm.com>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <9cda0e57-ce4b-428b-9385-743fdef02789@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: B75oRElk46vFajdQGBHKVyZjSST2ztD5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEwMiBTYWx0ZWRfX28TkqHgaUA1d
 uSePaIrKu4gg8VS5ZmOoe46B0g0zJn+Z13Vbjv9RzYR0DRnEW83E6FQklX3nxOtREPJ8b7pmnLq
 Mb3vF9pbOHwiFZR2C9a8pGk2FVBboZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEwMiBTYWx0ZWRfXxxohXtv7ajPJ
 GBsNKQSdoXJFO7YRuyf4KvR0BHU+UgrveFlYt7pfKn8Luq7cdoBGTgA4vVMzT4y7zwHnEkoQ+NM
 ymRTHekQzNwoR4H0rk0Ch9cjgOUT7Ks94O28crNg0TBFSA4p/qx39SkrBsaizmQkDTM4y7tQZff
 5PXlIG4MzfqacWDDUjkOMsjkfu9Ae6DEPWaA0Ly20Uv95VHLL4cEO1gxVHbukVPGKs1jejqXp58
 tkuXb2/szZyqboM7E+f2xBcOmccYaUAuDuq7CrE8gPH9NYVXedIG5yglOob1eiVozxN1Qy4Bi9S
 rmMgbMy5kasemNPLKeETuG58D2dXpubCwMkWJQC6shDQdBK8+LRgS2o3+IliHd8rgyM1QpGUGI+
 yR4sfNkhZDtPWpj9oJy39Sfv5FVCmuf+VWMTQhSSQ0wLLzHgTaTxVXnsCHB1hB9t8mlBDWaXrDZ
 YWPV6CbvbXrtNvIfYOA==
X-Proofpoint-GUID: 1kzK7zB352UAW6YmPDmvz5_soVC5FMnV
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a71e08c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=aTw0WEhGGRQSsMFM7H4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040102



On 04/08/26 2:03 PM, Alexandra Winter wrote:
> 
> As this is a fix, it should have been prefixed with net and not net-next.
> 

Apologies for that — you had already corrected this in the internal
review. v2 will use [PATCH net] and include your Reviewed-by.

> 
> See the discussions with Bryam Vargas [1]:
> It is correct that afiucv_netdev_event() is missing lock protection.
> 
> However for a complete solution it should call lock_sock()
> (because netdev events are called in process context) and handle
> owned_by_user and a backlog queue.
> 
> So this patch improves the situation, but is not the complete solution.
> I'd rather continue to work on a more complete fix than take this one,
> but both ways are possible.
> 

Understood. This patch addresses the UAF on iucv_sk_list traversal
specifically. The lock_sock() concern is at a different level and
could be a follow-up.

Could you clarify your preference — take this as an incremental fix
with a follow-up for lock_sock(), or hold and work toward a combined
solution?

Thanks,
Nagamani

> Kind regards
> Alexandra
> 
> [1] https://lore.kernel.org/netdev/20260724222917.134769-1-hexlabsecurity@proton.me/
> 
> 
> 
> 

