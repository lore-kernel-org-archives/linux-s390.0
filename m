Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F01DD0EF
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 04:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787718861; cv=none; b=Wr/GybETWfIyWZAvbRcPZnPe2UDzhvOfalPjxtCRrUs/5P9PqwIpIj1qvEXszCkJNnN1o2Go8oOqTSURc3Uh5K1TFmwuOhq+hSXerRo51CcIKf2tiFuw3xEZw6zByFh8N5E0Ue/WNc8y/kE4T06SYacCgRNByLsGmRL8pubyndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787718861; c=relaxed/simple;
	bh=eGEIrcXfY/Ig1gWpVwy60MPqePGAipNln8XvdSpjH1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW0pvWO+jbEHurChnVBspjFJ293pXHfRIRKcooqA/JHqOmCBt1T5wjx+MvGKgne3SaTo9ogKCB52nIrSLS5JNMC4Aig+CMiPlWb6l+VZ8mDNAsnI/NODY7bRj0s6kEwwbmD7n3PS6xqgJ96uuWCxMAjSbfwhyGnpcsmKUwVOJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aTqaJR5h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aTqaJR5h"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q3Vgwn2880665
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 04:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9o5bmj
	KJOObrdhPUgDwN0V/4GE6kA98aehsjpKX1THE=; b=aTqaJR5h0XIho3yPSZXH1l
	qVIi/pprq2oLwd5JiqW0DpLi0YOoZ3HTUFoiJueINSYGY+Y2nHO18lOZtncQBKuM
	shEkhH62evr8FXuX0Nr8wzVlxHf4ISSV0zg9q3DiNL0ifIP2RcfPDCNt5XJuysOE
	hUfOjBubfMQEpQDG5WoL5TWxjMTpWZ+gUmAp2DMfJM7IGDq88NKSmRFgfG4WYn0k
	q7fXmH0a6YCcFanBorpRiiYfigkdQSomFVejQuA5BB7TRMne4hMBsWuXBTBzBQFO
	xhpeTVwKw5005l5nO+mHVMEyPuJdQWq+4RUhtJzcA5uakGhtTCb/DSNw2u9s7hLg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxc66m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 04:34:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q4Qa3I004310
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 04:34:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q890q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 04:34:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67Q4YEtf49676544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 04:34:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C2F720043;
	Wed, 26 Aug 2026 04:34:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28AC620040;
	Wed, 26 Aug 2026 04:34:14 +0000 (GMT)
Received: from [9.111.197.19] (unknown [9.111.197.19])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 04:34:14 +0000 (GMT)
Message-ID: <fade6367-b9ce-4944-932c-a1b19cb84a73@linux.ibm.com>
Date: Wed, 26 Aug 2026 06:34:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] s390/zcrypt: Fix uninitialized padding in CRT key
 structure
To: Harald Freudenberger <freude@linux.ibm.com>, dengler@linux.ibm.com,
        ifranzki@linux.ibm.com
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260825160154.106501-1-freude@linux.ibm.com>
 <20260825160154.106501-2-freude@linux.ibm.com>
Content-Language: en-GB
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260825160154.106501-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDAzNSBTYWx0ZWRfX3MbAOAPBrlhq
 gHHNU/JdnkUzv7pxbY/7uCFDpavSbqL5w4jb2/V/mkZEyb40FvZmLAKAbrW/iywykH0HAIKIqvl
 GnNAi+ppPp6TBS325J8f86QeuGpjZq4=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8e6ccb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=OE3vSN5JEnyG5930fgIA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: IG_iM72Cy5yOLsP-fsmzrmxUOMWQe50N
X-Proofpoint-GUID: IG_iM72Cy5yOLsP-fsmzrmxUOMWQe50N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDAzNSBTYWx0ZWRfX1UR1Fw9k+vTq
 8ICmAVSwQLzrBg+9H9S+N1ami6Yd2dFtkjAXBvsE+fIZwnfLh0NkAppM6AkkmUiuEqGLO1VpMNm
 J74tFkVEXpGt9U8KDwo8VxDlseprNoNESUuJBLavt2bzobQHmLe0EFDo2F8jRtT3wA3dnExXzd3
 FmKcnShLTzpUwKN60rc2T8uxUmkyFKQPoyzKBmc0H/fNC/ILO+wcAWzMYzPIPhxVcNmCeEGT3p2
 CcE70n5Yh/LW7LuPqpPeiRcjK8zORfu2u8LGeQqO6+nHuvjGoCXElx+QGNynJjHWbcnWsAsJb3d
 YqL9HlmPwavKKhMnqMKBSGR0xpLd2Pa6wFBODWVaIgqpHwVU6XpsRfFUYGQH7TlsBn66PiZPToQ
 8ec8tfoYw42KchdsKh/2Yc4Gl7B0LIN7UoDhrbVZYfcxNgVoYbYXwnV6Hqh95FDwkyi3zTppaa7
 tHPFXzBa5Pat/bzZJDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260035



On 25.08.26 18:01, Harald Freudenberger wrote:
> The zcrypt_type6_crt_key() function leaves padding bytes uninitialized
> between key components and the modulus in the CCA CRT key token. These
> padding bytes are sent to the crypto card, potentially leaking kernel
> memory contents.
> 
> The initial memset() only zeros fixed structure fields, not the
> flexible array member key_parts[] where the padding resides. While key
> components are properly copied from userspace, the calculated pad_len
> bytes between them remain uninitialized.
> 
> Fix by explicitly zeroing the padding bytes after copying the CRT key
> components.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   drivers/s390/crypto/zcrypt_cca_key.h | 1 +
>   1 file changed, 1 insertion(+)
> 

[ snip ]

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

