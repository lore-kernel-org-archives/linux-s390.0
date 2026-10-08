Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB174C10F4
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470943; cv=none; b=F5d2RSCgLx1lL2H7H7RYl+PeS29Kcj+BJvm/tDgz/gFBk6IjDNIpVlQwGtDzI6axZ7KfmtUqpc9o9Qjj7O3ItJhcM7E49RfE0rc1omo4xAuX22u+gOPWji3PIHS5qbPhnz9rAWsiiK+ob9wT0OtQQdHcOkK3ue9QlF9gqEFJWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470943; c=relaxed/simple;
	bh=7SrsDdCQbV7W7vj1ixULtxfMek5udUH749sYo87gpms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snsygs22DI0MyPeSivzBQKpAXOVT1DH5oA0UDOoRImSt947uK4nWPZGUjukf3iO8K8c7fkiTarvXe1esiqX7NQOPhBFtAxwWWOChUruN4E3HKsclJlq4QD4nHauWW3aFzWAu3NBKQrxwfDjw50JlruWM7fnO0xJcaTUekQZW11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d9zpWAdV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d9zpWAdV"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EZejX1614890
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 14:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mMdIZu
	t53m8u5FRCUadarEY2Z4rBfjh9wsXvjyiAYv0=; b=d9zpWAdVtibNg0tvCcWjZE
	4w/FTa50ZkbI9wHTqHNVVMKMCZuILU2J41PsKLWEX8CuLFI7Yut1+a+y1vtBI4lK
	YAS2+fH4kHZAoG1xfDV5COt1bzFAr2vp6dpBmL7UYie7HWyydzTigVwWwKXAL+9k
	X6xoVML/Lz3Y+Ym1IVZxjR5Efj5c4O40uwww1/0W3ZTf+U6QkFSYShry6PLIdEOI
	neeYWby+DF2oRo4zGrXpiyecRxNNSRcERu+E5W6N8qqThd8snbhsjaQj/VuwfPr0
	39RkOipDya/w4rxV0sbJDvoke473lnrYkKCX14P0KumEH/O3V8q7ffwQnPe37ZBA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvm3u3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 14:48:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698EXf6G3632381
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 14:48:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dqjde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 14:48:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698Emp3e42729754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 14:48:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13DCF2004B;
	Thu,  8 Oct 2026 14:48:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFCFA20043;
	Thu,  8 Oct 2026 14:48:50 +0000 (GMT)
Received: from [9.111.29.144] (unknown [9.111.29.144])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 14:48:50 +0000 (GMT)
Message-ID: <7c624474-ffd4-4899-90c8-3d3cbf9997ee@linux.ibm.com>
Date: Thu, 8 Oct 2026 16:48:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] s390/zcrypt: Fix out-of-bounds ptr advance in
 cca_query_crypto_facility()
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20261006154603.9699-1-freude@linux.ibm.com>
 <20261006154603.9699-3-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20261006154603.9699-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zg44YOiUFvCfOcpNAfZ_wGPdDZpulq76
X-Proofpoint-ORIG-GUID: zg44YOiUFvCfOcpNAfZ_wGPdDZpulq76
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac7ad57 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=cu8Mba4-gXWWDQXYuWAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1OCBTYWx0ZWRfX4wEe4f0mrhl0
 l+f3DuxjF4CVGbMaE2nAzGDvrlV6FpVp7GbrIug2Cba95LRKBfzBXGAbo5WCkRXdo42tTXnzuA+
 bzkgPKJxBh6Eo1ZbpP64UfY2hZJKim4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1OCBTYWx0ZWRfX71sDIokS/6rv
 9Yg+oxAX2cFEOgBJaFywrXu/xuLcdzwPGkHW+03IJ6jmehEJocmiSXi3V5x4VLlcIM/CTVvY/lk
 uz4YWbuUu6ZoBlrTf71m1GYCoNltqaKMrxn63JUwqiTR9I946fY8cfT0yt34N/kwkiQuR1cE8/+
 U7cGiL0wBpwSxoOAxleI1tpFfxvaQXs0mrkSZ90GGUimLMHeExkr8zu/xD89Bl27Hy/cvsxMGWQ
 X0E4RQf7HX3iuTmPycof/9iBdy97gXXfsWHP/yqlz/f3owI1YvKRrTccw1ODeDCGeXI8LKaE2/8
 LmKMfdxRjBKQXMY2TgZKFg/YeSbkhYqwcR6HP340URQIMVtIqFclcFVUGMsSZ9Gzj3XRqMUCIvV
 ZIZpw/xB87X1mhLAqYKrVe2zw214pvNgNc51YKjywCSbVUkMUwgGDI/oaMRR+7qpRHqZtIC+CrL
 M6oH9/FqM/7iMWT2qIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080058

On 10/6/26 17:46, Harald Freudenberger wrote:
> The FQ reply parser code blindly advanced the walk pointer by a length
> value read directly from the hardware reply payload without checking
> that the advance stayed within the allocated reply buffer. A corrupt
> or malicious device response could push ptr beyond the cprbmem region,
> causing an out-of-bounds dereference or kernel memory exposure via the
> subsequent memcpy().
> 
> Fix this by tracking the remaining reply buffer space in a variable
> and validating each device-supplied length field against it before
> advancing or dereferencing the pointer.
> 
> Fixes: 2004b57cde6b ("s390/zcrypt: code cleanup")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

