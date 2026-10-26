Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010710;
	b=G7uWvgqCEV5gmDR7aKYuBBLUFKlEfR+eszcdV+/P+HuI5fSgQdmOWNde/weepc6TVAJR
	 tdxQnfoyMIoChgPkCUEMOARXsVAk/4lxv9CNNQPbLxFPR3fLXXkmRsSOyvrJmVW64qNkD
	 OCuF4XRCT+sc9721iHCWEa6LSRiOIASni0v1tiMY/QrBot+/2eYoY/E4WkTG+wBrVipEl
	 k2TfayoI9Wd0e1ktTUl3CBFwBwE6Asb7b5dvk8PB+nFtL2dFMeTNPKzu9M1Z8zrcEFBTl
	 z9r+no/J21z/GuMw+x57wDjk2u0kpyTpMp6j2ND8BqzYbtECasyOxNpXcVpgscZCOFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010710;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QM0x2JqNzlTb/sAjKOLzMvcbS0AaFuCDePwmS3U8LkQ=;
	b=rVy82+IBZDwWtMOqatlT5LkXZ3PEkaB3gO8f1Kuc+t2xZolzHBF1Ypia36yuBIwDU13s
	 gmIjd0KrIQiZnUe9uebkYxLqggWbwQorRzHwv7vUHC5JLWJucWaTfmPSbc2Xzqy35giik
	 4GG9FAdE/NRJWr1OHedqL14L01cjzHbwOH6bDAC6mJYKx5zAPY4/M9H46JlTCYVAdcDel
	 vscAFQ5TfHHG2JB8X4kboGIArRWk3AIQ9tYN1C0JGUcPU1uz3DU4lnghrzlYGwX2MWneP
	 8/HQd3yQGo39I/9ondmVeeaIgQj/ZZMnK+x9B9br43Zdgkz4Mtevaqvv8bzd6ZTbV5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=de.ibm.com;
	spf=pass smtp.mailfrom=de.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WcRYubmn;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54FD606A329;
	Mon, 26 Oct 2026 10:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D54FD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WcRYubmn
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2ickM1917696;
	Mon, 26 Oct 2026 10:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QM0x2J
	qNzlTb/sAjKOLzMvcbS0AaFuCDePwmS3U8LkQ=; b=WcRYubmn4+Jg1JybBmtyze
	3dfvnlRX/nwpldhW8bsqEhhFy0w4mWLXZiRyFGPcZisRxJHRrSQjCrrLsjoqIfuV
	B0tOmJE8GGvmhyX1VMkPiLEW8iWo/MA0PWCAeMR7XJQmjGe3Ld/E28OTf/3ToydQ
	yv6dGkvOzyN2cUNHAcFzkTJoNkj5T8Gjw1gBxyuBfSNzCzwurbKQ9CGLoDkm5+bA
	vvWlLmxUGsE97X1jgZOn8xVuTGYwIY+tR8pBu/+Jo51aLJP3mCs1Ha2OkHOCYcmC
	rQo4qaMvP4van5KtLdpOirjvUmH93jxDppVzKlyCcEO5EiI+k6gKdTIjxZank0VA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3m1g4q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 10:31:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q7GYRS1882841;
	Mon, 26 Oct 2026 10:31:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh70pnhdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 10:31:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QAVg4m30277934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 10:31:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC82120043;
	Mon, 26 Oct 2026 10:31:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0A220040;
	Mon, 26 Oct 2026 10:31:42 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 10:31:42 +0000 (GMT)
Message-ID: <ee4583c4-7bea-4414-9407-258a0f5f78b1@de.ibm.com>
Date: Mon, 26 Oct 2026 11:31:42 +0100
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
Subject: Re: [PATCH v2 10/10] KVM: s390: Enable 1M pages by default
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-11-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20261023155531.206113-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX0egyZrRl13Vd
 VD3+5afzvxRgk5tLVOwuxiZb7L7hELu1cwaAJ7muZHm51DR+q9xBs7L8/Gt1ONTKvirg7ZB6EsG
 HpcKhV4jiUz4NDJz/UpJS0aAAMZmQek=
X-Proofpoint-ORIG-GUID: U93YaoEdnxludGSluhlZqtYB1yBnOxQu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX12EbSS3jTMqW
 ZcdxzwXGscegmeMie8utWzCOCHFixe+3bkHm9GwWJ4c8At2G+BmSzuvfM7M9rvN5O9taJtbvz9x
 +JIPsw9/2padRsJwKSdBcoNoUeiUVq3TW0YsEyCVmiMn+ov49ioCsTDUPGbLhGk5pVsf8YUvf0F
 R/xFjOKSH24NZMYdJeNbYY6lK2uMa4jqdHb4K/J0a08EQC0K1oIclojhuQJmggHxZApqvyIj1hC
 Q6EoE1y4HfYpfLgfMKCUfaD5btTLaZe+YVpBCyUuzx9kQODfxZTxikkiI6WloQwV4f5lCFr+DEs
 65k6X+hJ1a5xIhBC1TwWw0Knu3xDsiE/oD4R5CdeBOc2MUHP3SEpZ1HBXzSuAiKwm8aHNVLokdV
 0bySv0vhjp/l+LjIqtlv+9U9xQvicEdowoXJXkRevEpdz/hJdzhHnkZHmfQWrigfiPZrKoT8HJd
 JrkU8vVRGCdzzcyCB9A==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6adf2c13 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=5uqVOZusAv4ek4C7huYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: U93YaoEdnxludGSluhlZqtYB1yBnOxQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260040

Am 23.10.26 um 17:55 schrieb Claudio Imbrenda:
> When userspace uses hugepages (e.g. hugetlbfs or THP), use hugepages
> for the guest mapping by default. Until now the hpage parameter had to
> be set manually when loading kvm.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/s390/s390.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index 280310870dac..71d79b4437ac 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
> @@ -212,7 +212,7 @@ module_param(nested, int, S_IRUGO);
>   MODULE_PARM_DESC(nested, "Nested virtualization support");
>   
>   /* allow 1m huge page guest backing */
> -static int hpage;
> +static int hpage = 1;
>   module_param(hpage, int, 0444);
>   MODULE_PARM_DESC(hpage, "1m huge page backing support");
>   

