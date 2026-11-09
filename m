Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236804;
	b=Fo7ut3B9M6324YSDeQnlM+5KEyvr0/EO6xd3EAKMHobes3meswKs5fgE+jGDUZJx+Xoq
	 g3DNtiA12fikCyl9AhBwjmhKFmz7DmW7y11utelSNcMzhfijT+vRheIRU9oOie1P6iZ75
	 WTzZJYuEv97LHctEz4lXlWuPfCljbv7A3VhpxPDpq9/uLH6RkK9n26lqHKLWy+E8PbZpD
	 ohWNE37un9tNceHKWsKqU7VdNBdbBcbQNPbzeYva3dssnGVvR6BeniM75sJyqLcalJYKJ
	 ZQuwTqkiipaH6p+SKtdSwyp3+zo3hYgNi0+w2yCVU5GVIHXPLf2Y/l64WNSkCM5FXxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236804;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jTHe77+js4csoDDC1RWv6JXtv+K4S/obgszatXkEwoA=;
	b=py2jlWTqnXhLfrjY7cHUVVORa4qKhqXvYxPmUWNN7CXgceO8di8s65JrpOrPOzNUJ3al
	 OI1g4JhuBi2y0X6uEcPLMS+pk3XE3xgsr56Jne95lg1jdbARZR/uD1W1WJalGqF+QXA7N
	 raHzfGBY15l86QawO8IBBlf7KHsIk+GxCCpxwQw7oaKwMhYIeG07I8E1yJE+1qTDs7l76
	 2TT1gikD7q2vSwglj5wBXQ0tevvhMsbS75cwN/6jifsgZSM0mlhFSZJ8z+TrhiyEVLcfy
	 C749LWfb6iG3EaMIIw4rAPI3ABaoCQn1Tr/ng0PEAV+nLIvg6MHNUesAmIzHVKXTpBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ir37RE60;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632E606A322;
	Mon,  9 Nov 2026 15:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8632E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ir37RE60
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DF4bv3443059;
	Mon, 9 Nov 2026 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jTHe77
	+js4csoDDC1RWv6JXtv+K4S/obgszatXkEwoA=; b=ir37RE60ewVs3RxFycf9g8
	eK8vxlUeh5tYEOHPdPqN/9RMXHSAVY6BrDIcURZp4hV5gY+XGD2jdAj4sy241VIe
	3Ir0kO96x2h3P+S14+H101euuAC4Fh+b96zDV0unL6oG0nUDciDMzzpm3iYA1yb7
	gIfipUiV8uZ5TME9maQc3zkMJHvi7ig62gtzI4UO6dx9+uYF1T5YQ+pEUHLjMHxm
	C8K+OHnB4Mdvsxj44YJ9Sq9fKeA1KxGCEBu7FIIXh/BNAu5lTcX5oIKJgPd8lR38
	dZ5HUamRbxkcJRV6pHDbU/4h7bfi9y8cSmArA9+ulLMq2+eKBkWgUui3jFA4mfag
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkefwn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 15:06:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DJwoC131322;
	Mon, 9 Nov 2026 15:06:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y08gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 15:06:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9F6d0t18023080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 15:06:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E40B58057;
	Mon,  9 Nov 2026 15:06:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B9E058061;
	Mon,  9 Nov 2026 15:06:38 +0000 (GMT)
Received: from [9.61.0.181] (unknown [9.61.0.181])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 15:06:38 +0000 (GMT)
Message-ID: <e597eb85-6c80-416d-bee6-2498ac06de5b@linux.ibm.com>
Date: Mon, 9 Nov 2026 10:06:37 -0500
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
Subject: Re: s390/vfio-ap: NIB unpin when the IR bit does not clear
To: Yuho Choi <oss.patchbox@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
References: <20261106190401.468289-2-oss.patchbox@gmail.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20261106190401.468289-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af1e182 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=LbCdKHQln8Rw6zpRR74A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX886+4GOnf0Di
 hNXZS4rbNBscMt1t61P75TCysd3vF03DXxs7yBIg6B97BpOGDqlajhvpc0IHE8SnBZWSTPmvUsD
 /jkP749xjOS5ktfoKCvUCs/D3LSrCBr4w8RG2ISLZuNn3VodrsocGP43KZLTT2W+T05Bk45msqr
 BTQkGYslw2gHuDdp3oVZmmwa1BPEiSeAahLUn7LVlC5fTio/IYRqaDEuyzFpA9amFS/YT/utDIM
 Un2nwIh6GAytX+npnWG/YgYrz/0KhQsSgbWVHf3e+JLBqTCdRBdaeiigfciVobu7mbM2pTCs4Ik
 8w6uQ2WIsT791j880q8lN3cEMzlsf0AXSvCB9V5l3dRIDV37mqR5X+cWrB4Np4EYOZ2NMYSusXn
 O8enxR5mG3HvZWHRxT7qJxe+TIEPaFwoh6ipIrLl3hIShsKqheT6VB9YVwTB+gAenlNh+JzKUZE
 ZQ+AKZydiANky/JGt/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX11KvkOz0oIM5
 T5w4tva+yFuqqch6cp2J8TI9TvrfTwWYs2YsaGKqHMI9043nTBA4SEYr97kdfMdqN1QmqHU5zBJ
 6TGsVbAhpl2zs0Jxz4+ePWJbXKGVI4U=
X-Proofpoint-ORIG-GUID: vCF8aXNcTBWuHnppijxHM06Igrk9RVYa
X-Proofpoint-GUID: Ro8m54IBKzHWID11lrI3JUb5Mwq9H-go
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090058



On 11/6/26 2:03 PM, Yuho Choi wrote:
> Hi Tony, Halil, Jason,
>
> I have a question about how vfio_ap turns off AP interrupts before it
> unpins the guest page that holds the NIB
> (drivers/s390/crypto/vfio_ap_ops.c, v7.4-rc1).
>
> vfio_ap_irq_disable() issues PQAP(AQIC) to disable interrupts and then
> calls vfio_ap_wait_for_irqclear(), which checks the IR bit with TAPQ
> five times, 20ms apart. If the bit is still set after that, or if AQIC
> keeps returning BUSY or RESET_IN_PROGRESS, the code only warns and
> unpins the page anyway:
>
> 	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
> 		  __func__, status.response_code, apqn);
> 	...
> end_free:
> 	vfio_ap_free_aqic_resources(q);
>
> This path is reached both when the guest turns interrupts off with
> PQAP(AQIC) (handle_pqap()) and when user space unmaps the IOVA that
> holds the NIB (vfio_ap_mdev_dma_unmap()). In the second case, user
> space may free the page right after the unmap.
>
> My questions are:
>
> 1. While TAPQ still reports the IR bit as set, can the adapter still
>     store into the NIB?
>
> 2. Can that state last longer than about 100ms on working hardware,
>     for example while long-running requests are still outstanding on
>     the queue? Or does it only happen when something is broken?
>
> If both are possible, the adapter could write into a page that is no
> longer pinned.
>
> I found this by reading the code and have not reproduced it.
>
> Thanks,
> Yuho

Hi Yuho,
This has already been reported via an AI bot patch review. There are a
series of fix patches that includes a fix for this. Short story is,
the AQIC resources will either be leaked to avoid the wild DMA
write - which could occur in this scenario - or they will be freed to 
avoid a
kernel crash under certain circumstances.

Tony Krowiak

>

