Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3740BCBC
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769398; cv=none; b=F+x/e6dKAxFaECZJK7fFuZ89IhuihUJSVQva8JgnS9TRGSJINSGtqaIojM/WEAHY2pggCu+GnTplaXuWddCzUgd8zL+dkwYZE7PGGYyTfjcf9+5zPs0Zh2ubL6iXUXLESVzgG/MAqbdrnXJh99C4i15ivrURSBVY+UgKJTcJvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769398; c=relaxed/simple;
	bh=noFa4+xGUOPRr1aTNdmcM3p81KFiAiw/HGViMlAwKNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjTsZjmxUt6g/PouJaQAfXXcZ7UTFfmmBWi66odbW5AA0BZ89jslkTCkozDlvc9PlQeIMAtgUW9oC5vDK40n9aNgRQRZnCxXOsXNlVNa+Gy/vDiJ3HMsKLnMp2PL2T+zU9k9PRLe52Ki3+h0URK+boi5KFG5Qlq0AOMkvt339X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QE701v6L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QE701v6L"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EIM162203559
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 15:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r6o3sW
	y/oqNWAMTbGehaBNjOSamZFTquo+yFzy1aGus=; b=QE701v6L/FuWbDI26FlYrS
	gWFVkKzAcBU8EE69/3UmKxLd0iMR5V8a/Ildp5+Xcsf+WWKEroOkcfbwluJE8kTm
	+WRZxktO0NbA9rE4h2JP2V20uM4v+KLPVnOQqDO8hfVHghbp4v1URhEH4kVa/Jrc
	z/zm2t8kM7io4FCC9b4Pwz///4wJdnLrvkKPsmCgHdnFUo7GR/qtzTea3qFKnq4f
	M0GFl8Tbcso1hrjZq1Rs/zEHXId3SSAE9uyPC+vRIS8PTm0ZqkjHu86t+8fLWR1W
	OhQpS7kbGC77osMRj4D1ehbJKqW3+x6uWPKtOwmRS7HBrwmEZ6wvxZYEHEro9hsQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhcpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 15:03:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EuEWU018870
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 15:03:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qe2pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 15:03:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673F3Ami38600974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:03:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A969620043;
	Mon,  3 Aug 2026 15:03:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6139720040;
	Mon,  3 Aug 2026 15:03:10 +0000 (GMT)
Received: from [9.87.137.8] (unknown [9.87.137.8])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 15:03:10 +0000 (GMT)
Message-ID: <03190e3f-a781-40ee-8c6f-48a01f722d10@linux.ibm.com>
Date: Mon, 3 Aug 2026 17:03:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/5] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260803083339.212885-1-freude@linux.ibm.com>
 <20260803083339.212885-4-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260803083339.212885-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX/diP9m+KXUjr
 KGNaqUUk2HN2bVli7v6sWKsV6yTG8NMKOVFLB3vikGShjsPABEJ8dXdD0fEurf2BJNtN2voXJGG
 zOPbtmOWGosK/OwmUoxtwdD4KysfnF4=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70adb3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=LXxHhldPrCqfEDQW6rsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX2xubf/MLzL18
 7WABHVJePm9sioV7cotiJkc/CIIqZn5nJocsnvYKbSKp/VoYjK9OaNp8rFD8Vc2qRMYB8OMuqKJ
 c9E7lKTxY25pIjmmKj9XmQWJvXvzuFBdpr7OzgrEh9eWZxn7rh88kDhxFoHg5t9/+pu8r8W/dYv
 EE8lTQ9NCjtIpAevsR/84gz2PIUu9x3AzimspWVyBcEu2Vc6wNX/lEaPCfecKvicAbvZaGcEE8A
 3L5lNqD+DvPRmWI/AQqPGO4J5lEQrzHvZFjassAiwGsDSL5VVpxmVeU9vUA8ywt9L7p/JU95P00
 sShLptotULLXp11GOFdSD0DqlpKvzJqTsRGH2ztISNHxz6lPdqWDBJjQDZgAzCDYTVtR8oAq2Ix
 u+p5Io3QkJdyQKZMYNmF/xPtityBH5sdfPdzdlOSSZMNTBvM2l2sLG+htImvxtFB4nNulDDjvKV
 h3gUcTwt0XVejuEbiXw==
X-Proofpoint-ORIG-GUID: zRJV5h04umwo8DuPh7BhWET_QIEy5ZSq
X-Proofpoint-GUID: zRJV5h04umwo8DuPh7BhWET_QIEy5ZSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030133

On 8/3/26 10:33, Harald Freudenberger wrote:
> The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
> validation, creating security vulnerabilities:
> 1. Missing minimum size validation: The ep11_cprb structure and
>    subsequent payload fields (pld_tag, pld_lenfmt) are copied from
>    userspace without verifying sufficient buffer length.
> 2. Arithmetic overflow in length calculations: CEIL4 alignment could
>    overflow, bypassing size checks and enabling buffer overflows.
> 3. The payload is asn1 encoded but the function just uses a simple c
>    struct overlay to access some fields of the payload.
> 
> Fix by using size_t for length calculations, adding U32_MAX boundary
> checks after alignment, and validating minimum request size and
> minimum reply size before copying from userspace. Do a very simple
> asn1 parsing of the payload up to the function value field.
> 
> Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within zcrypt device driver")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org # 7.1+

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

