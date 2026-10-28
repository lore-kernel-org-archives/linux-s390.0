Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190213;
	b=HSAouBFcoBH2uzkrh66XQo5Uy1H+S0VgCOJs/4zx4kFYyHJ9V/jrtnvZZPBOsK6pH+GA
	 7ZChdg7m3asmjw7Se1Q4miFQBSho3NBPqjBFPrX7ZoYo37yDeg6OL9l/P8DNBzk8alpfX
	 W7iQQyRBgk4FXMa47cNpnAre4EXtQrpuvtHhMVfxLJ4xVwqxJy4Srju3WfBsROQMaq8Q8
	 M39XmI+pzkf+6dds8kL2Wne/k2r3oMTrZjucfD+GhMWE8JKvNYjRvXdUroxvYPKOaT6An
	 q1yZflHM1roqTXgHkwe9m/QxcvXhrHgFTVEpfLvvZ7eEiM2A0FGqrG0vN0ci0jaU86w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190213;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+5WKr4dpUQrbKQkQfg+TPq6rjgjwzQ/77mIIZewsFhc=;
	b=wfDGXnbVfifVSpOyFd0DGQlDGIgzkqtY5EsOITzJv8jmOaW84eAbIaG74rSCGlKQeKba
	 mtbg2ZFllBi2RakYbkdoNkZQefDmlKHYDNcaRJqmV2CX932EQj8LEPOJerdxsh3LQ/z0r
	 ION4cgABHX9rYpfra8+8Q4Cn6LqmOoL9yOZghYNXr3IEVphhVLKgXUOuQ1wjF+VCAS9Et
	 v2Jg0gH/ww2A/+rDbMCzN/5q4nmspfgc4zhtmO9VRLJ7iEO/hk9IhDEPBhaXatnd72RQE
	 w9a0DaumJjzFTCbO9sZBFnyYGu+/IYrtRkGAZYusOigG55sjM28n9CYMdciL+hyi3kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CZWg2TZk;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD14606A31C;
	Wed, 28 Oct 2026 12:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADD14606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CZWg2TZk
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBiJJ61078949;
	Wed, 28 Oct 2026 12:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+5WKr4
	dpUQrbKQkQfg+TPq6rjgjwzQ/77mIIZewsFhc=; b=CZWg2TZkMCR2mq6UOTfSgP
	c3PzYhxv4xjbmyUN8N59bmMTUNjVAz7o4T4VuD2c6sXnOYgZv1igNiSgSlpoOVth
	2YXsIhPYyD6ln0+dFieMjTso6YVQg/866NFEPkWeO+voXS+WPunon7GvGvD5cxmb
	RCANcExEy8/OlSkcgGQ576lDYaWvBZRFf63yQG5F7YgHn/Edff3KlkgDdcZzNtu0
	pC7ucr5fDdjnleXpyjU00Jxci+MIqs0vRAj54FK5Ztb/Emr9POwTsXWZlUIahRKC
	GmhiUzAjgRw0SztahbLty894ILOeYc2WQKar//jO5OO0kp1ojnWFSaq/OhwQ2NKA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mcqne-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:23:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBnx4R1501927;
	Wed, 28 Oct 2026 12:23:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7w4a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:23:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SCNRnM36897234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 12:23:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1835220043;
	Wed, 28 Oct 2026 12:23:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF97720040;
	Wed, 28 Oct 2026 12:23:26 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 12:23:26 +0000 (GMT)
Message-ID: <145b04ac-6115-4c8b-b942-347854b0567d@linux.ibm.com>
Date: Wed, 28 Oct 2026 13:23:26 +0100
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
Subject: Re: [PATCH v2 06/10] s390/stackprotector: Serialize text patching
 with text_mutex
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-7-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX32f1o46puQ5c
 24JkmdwtRDHqJ9n/1hbnHaelOshTZ82HFIhQZptsRlbpRTTbeW4VHtX55qOXU0/AQbejte1xbBs
 wfegD7JSHo/07+Mm4wDv//B39lrlZ/U=
X-Proofpoint-ORIG-GUID: KY3nDaxql7BPxsV84iDvqrc7ra6xXY_2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX+Pv0XAXDKx4D
 l5Y4cC1Jk5gGw/3Gcw3gfBbl+h9DlsdGhxD/ex54PNmmjgk1pWz6laXaBTWxWScMlEGArXr8wfL
 M0R91FS8B/0E+8ve5RZ3F12NwDpgs2owsXzteP9YZ3MVMGIqtmPkSWCH26SBYTuL3YmW8mqsMJq
 HYJ/HPk+jtRnYGPAApcZuEKtCTXD30Q9hVlEHX7PUSrVCvWGZxEfk+jOMX9gbIrH5hvvBrE3uG2
 0bkSgkPINTy0KE6wfFiKZ0RXO5oF5LFaMMBTSBhks/f3CGL+5Gw8JllmEIJY43vjnbqGk7oz+4l
 iWaMaRczcqRh0AMcxVDBp5ZHG1sH90xx6O39LB7vk2w6mrIImA5jciE275Zc/oWEzVgIBEMWOl7
 050Q4IdclU4OXefh1tDiLzcs7oe9nU1+20Whbkt0RK0e4YMPWIb2apw8l9Tc+rYsLVft/2TgC4q
 A8xoAskshZ2xflsx4Dg==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae1e943 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=kMqweQCj9uxs_qz7cW8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: KY3nDaxql7BPxsV84iDvqrc7ra6xXY_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280048



On 10/27/26 15:30, Heiko Carstens wrote:
> Acquire text_mutex inside __stack_protector_apply() to serialize text
> patching.
> 
> Serialization is not required for __stack_protector_apply(), however this
> is part of larger series where at the end s390_kernel_write() requires
> that callers hold text_mutex.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/stackprotector.c | 4 ++++
>   1 file changed, 4 insertions(+)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

