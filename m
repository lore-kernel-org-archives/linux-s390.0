Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932801;
	b=BtTZq6LkuvURbvvkJskdtU/InJg20o8LYyOYsVvWFWRob948uDRV8Fjw4/9TGmcsd2Jd
	 UvypypDJhYxucbi5xA+o6HXx/xqwiyzrisUUa3fs6Scw2ymlnFxQhVbhWeqWESrL0+o6b
	 vNc1YJ8BDp+SlKaDXaaVZ/15NFhTioe9yL9nhdL+LkuESqCz4jmEdP+AsPWL1Ag2gwmgl
	 qrAImMCCvTvH8EKzPQc4bKdWlCCPRAf+ipsJRAng0+wKHOOtXuh//necRn1gRJ3E/aI4K
	 BzF+xDYADl295uIU42c0MDjtH3meq+mjOVbuG8ho2gLIiyWPaZ2pHfxUt2AweEPxc0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932801;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MvR5i+YwLh+wUVrt989Prtc0SoP8qalZaeDZoqy9GAw=;
	b=nqvn1AaTtovD/aALmIphtMT6oOhN6ZKNZI08BLpny4mCsq4QQ7R/JsrAVVbjC/OFAw48
	 LumoI0BG30Qt/wgVnWDvGB5VRNJG+7+GRgepWc9FnnGrhS+dS3cW+/Yj9rkwJLucNmLPo
	 J3p9GHfqrAddARWWJDeO1VFuybMIW1lfoRf08mlQsZ7Z/sgijUC81rkzTXb0Mut+1nVYw
	 NZ+fWsWoXZPcroRYCPQMhG3tAX96Ehe76ZFwoAlCbcQstW15xYw6wM+E/PcF2f2FhVsed
	 MEDlj5w72B/0FHWK2/taYoHk97Tm6QaxiHLtgLFZzlUSnrZAqYUmuQWfRn1utA8JiRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="E3RZr4X/";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9B606A31C
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E9B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E3RZr4X/
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQdrW2746714
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MvR5i+
	YwLh+wUVrt989Prtc0SoP8qalZaeDZoqy9GAw=; b=E3RZr4X/EJ3XC1f9a/h2k7
	yDqr8R3sB6TpkKeeHhYZFe3k4zPzbvAwYOFnt/tNexFRQX7y7P8aiev4BSDE2Ig8
	MxLDPx14OO5Mq4p1k+3nKgKaIFoH2KqtTa91hjNi6RocO1Wt3T+2jteOBhpiNgXk
	Hbs1xE/J7XzCp+xysVx9U02BbcXrg0k5keUOJp722OtWfDSYrOKfpA7lnbZt2xcF
	UeuVszhpNvwckbrthaQ9aKyAvWwvagIZ5ML7nQDYyhswh3UdwbgH9p2/R6PbV0IG
	79EPicWuQWnxytdkHzWDxmAzcLF3XL1GuJU7/FBZzBf+MKuC2Ehrhr1y59QSWHZw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf9vkk8c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:26:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFYvFi2047135
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:26:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt51cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:26:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHGPIlt28967188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 16:25:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64E802004F;
	Tue, 17 Nov 2026 16:25:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30AB920043;
	Tue, 17 Nov 2026 16:25:18 +0000 (GMT)
Received: from [9.68.31.53] (unknown [9.68.31.53])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 16:25:18 +0000 (GMT)
Message-ID: <2744e420-8b2e-4ec5-b631-8518b8019d81@linux.ibm.com>
Date: Tue, 17 Nov 2026 17:25:18 +0100
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
From: Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH 4/4] dibs: introduce dibs block device peer device driver
To: Julian Ruess <julianr@linux.ibm.com>, schnelle@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
 <20261008-console_server-v1-4-636b11ebf191@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261008-console_server-v1-4-636b11ebf191@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hSIYuEn62savjP3UBS6FRmGXAI4QM783
X-Authority-Analysis: v=2.4 cv=dtxOmFg4 c=1 sm=1 tr=0 ts=6afc803f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=yzsglldkUaS2O2tM4mcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2NSBTYWx0ZWRfX3w3Pvw3yxLgU
 +ziYUvWyAFtwUxAoc2Vk/MyCIiCw9xVdhgbscQygFdPShntI8dukPGkCSppxjlwt0Qi9nQA2oge
 qs3JcS/DiM3/kW+g4vF9lLgyNBV6QMD69cG3Ixy208yb05OL2gnOpVuPaqA0olxcf5Qw2KBJMGg
 sx7i7UmH5FH9H5/Ty1zI1urbEithORwtl6DCyk1xtYnTGOurpNNHV0xG2jzSmqI7pvXIWIympmH
 //cpSrEMYYWUdPoFSjRlgtDNJGUr+L89cx6ebbZEhv8ZN2hWyqy202wLe/U4COTZFFnwYXaMC8T
 CUfRyrnEuRZu6NIisezrRGZN65EbW+PZ+jZ8AjqOUwrp5Ag45p5WNp9P0VYHYioaE+SDJ+vCyFT
 Fm8UXP7nrt/5Xm2Jgq5M/uaCqNvvF3dj6LlP51qbpqsGmbWhbPRfg6Ex7kUYRcRyhcXSjTjlwOW
 tOV4w2RsCsXlGgkUxiw==
X-Proofpoint-ORIG-GUID: hSIYuEn62savjP3UBS6FRmGXAI4QM783
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2NSBTYWx0ZWRfX6Y46re1pjyAf
 +5ozvsGamvksjLCHkIuoJluPT1ej7D4Z1hX0hvICJqfcv2+8DsEYdXviI0aJFes12fdfQ2mf3GR
 xhhfAt7hIOBBbGOj/4/CFFGHDKWCEv0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170065

Just one question, I noticed. I will continue the review at a later
point in time or a future version.

On 08.10.26 10:08, Julian Ruess wrote:


[...]
> --- /dev/null
> +++ b/drivers/dibs/dibs_blk.c
[...]
> +};
> +
> +static void dibs_blk_peer_dev_disconnect(struct dibs_peer_device *dpd)
> +{
> +	struct dibs_blk_peer_dev *blkpd = dpd->drv_priv;
> +
> +	if (blkpd->blk.gd && !blkpd->blk.quiesced) {
> +		blk_mq_quiesce_queue(blkpd->blk.gd->queue);
> +		blkpd->blk.quiesced = true;
> +	}
> +
> +	if (blkpd->ring_registered) {
> +		if (dibs_pbd_unregister_ring_buffer(blkpd->dpd))
> +			pr_err("%s: dibs_pbd_unregister_ring_buffer() returned with error\n",
> +			       __func__);
> +		blkpd->ring_registered = false;
> +	}
> +

Can an ongoing recv still read from the ring buffer after it has been
freed by dibs_blk_peer_dev_disconnect() ?

