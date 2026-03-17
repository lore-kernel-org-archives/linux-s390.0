Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDACD39B94E;
	Tue, 17 Mar 2026 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736156; cv=none; b=O9tVQoI6tar5fZ9uDIrQAKenXu4KMh8tXXPf6SxlVqZ8Gx9MH+e0TkHjLU9Vv9plvEOwFljq2i/1NCxZh6CCjFoT9l7hC7ZeScrZtXOacGXg2bSnnCdz1C2wCzpXWWu+DG39l7FLh3ip82f6qe36MJPmzpvpOKVWoB7+iURDpw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736156; c=relaxed/simple;
	bh=1ieHWsMaIxD4b+EktW0b0BipghRH1ORgUZZieR7RsDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndT0/t2hBYoUGc1TgYIEU3B51B9lPevGwBs7PipOWJxBno8TmQYrXJBm/Ov6XXevky5enhpeltCcHESjGcblcCeDaDsUdo+LuztIMVvnooKE4V75WfLVroT2xnTwevS1hAs6XOg7OeyjNsahyM/T0R4i33Z5rRedhWY+VhD/6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X9/1uTAx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X9/1uTAx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GHfdZV1346844;
	Tue, 17 Mar 2026 08:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RONOb9
	VRHkNo5D1SuBUO+VKAg03UMxKkLpwFI8vdyt4=; b=X9/1uTAx1Z4K7JhN52YwEZ
	DdQiWv0WVlpmTeiAu7m6QvC/Lr3GZeuDDNudQEo7o6wGFM/3LxWd2JLzpLQK4LWH
	SnJgNGis3PONik/xvB8Y65UcCvo+uZtV/QuR84CYkwtIp6WP1WHUOJBuRcSn08Ub
	WhbgFax0hWBV0vnga8h1kScenDFFukgqZbRXRPF9s1xB6EH+URqpqV/ddDk+9NzB
	VFt7zoh+m3DQzlXeri3MY/22j7O10celf5lqPMAiCKD7lEYtuPZmnGIjgVydlIs0
	BNMnQSFZzrBPRyCOCvle346marmmKDCljOWpwI6MhcJ90/UhqTGSQuI+kpUwVT8w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfe0pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 08:29:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H6dCdn014011;
	Tue, 17 Mar 2026 08:29:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy0bd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 08:29:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62H8T49a58327298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 08:29:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A5BE2004E;
	Tue, 17 Mar 2026 08:29:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6ED72004B;
	Tue, 17 Mar 2026 08:29:03 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 08:29:03 +0000 (GMT)
Message-ID: <ac352953-c618-40e9-9102-f7158ae6a60f@linux.ibm.com>
Date: Tue, 17 Mar 2026 09:29:03 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: only deliver service interrupt with payload
To: Eric Farman <farman@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260225152013.1108842-1-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260225152013.1108842-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pr2qlyRd6YJ7Epz5uYdRtAzjxje-VQkT
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b910d5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=2bCnhEZlU0XF9r1STAIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA3MSBTYWx0ZWRfX1KiFjpzAJijN
 KmCRjM+NFPa126Q8P+5Kkkdfxng15v32oiRyM8PrRK6tgIlnqNIAFTRlgLdd2/7GX2fqplaDxAu
 781L87kiEBEUD3FStRffytDcQ3i2qRLcwN792RjQ0nHqZoU7/6hCoet6xPcWSUJE6Aa4KiRCweS
 jeHp7f4w4Au7M2/qfu375mBhAyE0r+fHYq4nQjCq6dwzCdSz7DVq0ahP3SkzGNC8OSX0szvWaoB
 x+DGsHv0/aUIxwvZ132Dx3Oc17OBy+EhtQ6IrU9c5dg/0uAY5TO7UH87La766PHba0MSm0GfG7f
 kWRbKlJMAo7K8KanKmzMoXwYLKZ6RZ2Drdswnfcri0x60R2cVA94qwb9Ax6rtX8+rax/mBem4a9
 D17QR+noRz4TXdzgp+zKpo58qzVG5l9t4YbpOpNd+BCIwlYn+apRCRTR0uqhU6Rt8H4gUhzbsuF
 t/C/QQy+ASPJy4V8y9g==
X-Proofpoint-GUID: Pr2qlyRd6YJ7Epz5uYdRtAzjxje-VQkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170071

Am 25.02.26 um 16:20 schrieb Eric Farman:
> Routine __inject_service() may set both the SERVICE and SERVICE_EV
> pending bits, and in the case of a pure service event the corresponding
> trip through __deliver_service_ev() will clear the SERVICE_EV bit only.
> This necessitates an additional trip through __deliver_service() for
> the other pending interrupt bit, however it is possible that the
> external interrupt parameters are zero and there is nothing to be
> delivered to the guest.
> 
> To avoid sending empty data to the guest, let's only write out the SCLP
> data when there is something for the guest to do, otherwise bail out.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

applied.

