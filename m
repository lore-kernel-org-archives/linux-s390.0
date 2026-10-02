Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C649BD7B
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947788; cv=none; b=CLH6HnkQ7s5xRDeMAAH99JDu6Goz72xMD1+joThJNtDme0CjaMiJ4Em/paTIX+aRcCwXE3WPLzrB0ZKSWl8c4V6W2TiNu+30SKaJG4qzI7406SLrhE3Wbc2JMhN5wThd8YecPMaMc49ifjPU6S6vpmbYJfrVJbTZ8z9fbvgdkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947788; c=relaxed/simple;
	bh=CNseHMfVL3JGFtulj99V+WtNYOX6bija/uI99uu1394=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAefeuLtm/hn72cxmOLCnz6O6HASSgTuTB2RxjQbpjIzxxbuE8IWT0BTiLqLoc967hHagEdVyTMbCX3CcpCMzq3kD0v/I21Eo7dhRSmEbcmml8RpuyShDpkx8HQnMQ3cmuVPjTg6uX0NseY2mJ9lNeiU4Ln+4YX1eY0DNxqpfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XmvofQRp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XmvofQRp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692A6AER205135
	for <linux-s390@vger.kernel.org>; Fri, 2 Oct 2026 13:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sIVJ22
	hQHnNG1++br016BSsFcP4FdOT7FYi+eJlD2Nc=; b=XmvofQRpeK3L57AEmoxpe2
	VGVND2Lky+yOrpxfKoSLZBlwCxb0PryX2DJYkO7z2DDWIJwrETzi5pEucIZNtBcM
	ckd0BugGN8pIy3JbL2MVrs2L9ob/aUn1Vj93Tl8oGSQuPyIzZf9GdXO0Pco1V3S2
	n38LraDYM40+GwyNO7F98jyJ4O4/5j2tRPQuldNH9qu9DZLLfOI9lQST3HrPbKpV
	qTSUFwYAb/X/9EoGO4nMHKHnugsicUasVV2oa5GyMRn5Aa7WrJidYyS2j98S/uZw
	D0rfBVA0Rby2hdSW9NLNk8n89aziA+w/d7vrqQknC0tXZ/QDL+ZRCWOB8uJjJvkA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptqyp5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 02 Oct 2026 13:29:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692DHaL62575955
	for <linux-s390@vger.kernel.org>; Fri, 2 Oct 2026 13:29:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h21nu28ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 02 Oct 2026 13:29:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692DTYDb40698332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 13:29:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3FA520043;
	Fri,  2 Oct 2026 13:29:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B78520040;
	Fri,  2 Oct 2026 13:29:34 +0000 (GMT)
Received: from [9.111.8.112] (unknown [9.111.8.112])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 13:29:34 +0000 (GMT)
Message-ID: <38566762-c0f4-456c-bceb-cdaa15610f70@linux.ibm.com>
Date: Fri, 2 Oct 2026 15:29:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] s390/zcrypt: Fix and improve zcrypt reply message
 verification checks
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20261002105236.52049-1-freude@linux.ibm.com>
 <20261002105236.52049-2-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20261002105236.52049-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Aqcki3PwZJf1nEuL2TmZOQ2yQz3CXrwp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1MiBTYWx0ZWRfX+F+QTGE0SADJ
 xHwH3f6nY1O0GP7q9RRMaJ1noH5Red/4uzwubiEzbd5sG1thulqFW7dxoXImiC70zbj1SDDp9KT
 0H0E1KXxcUfzTgwcqFaOCFAQ0kyNWTFWnuLtMMJaFlpzzfHnADplICUdO2DufjLq1wvZskmb8X5
 HpeMJRfDoJulCKyTz8F/K+x1gt8B9U/HEICeZO/Qkw0dcrFQI4wrUQoJllWuYkL7R3WxWWDg6A9
 FtmeXKficJm/7bg7QYWkt6FOy4mIoy+29eRV4tyWdJMCgwdazxmAtsUJe0JNKihVVQTy34hoqfv
 Z5mMslR/wJHhcFz5VVDBm6sITkL3QBJMur44LC+/WsYPCFvP93nwaD318/pyr6ke20+FaqoE3OE
 YSWSIEYzlN+na1sb3wICivlAMGnPpU+7sU5lRUyqGd7poEiF9wgi57PIsS11Xr7g9nv15ZvwtEK
 i3BMPVvzb4l9nYcdvFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1MiBTYWx0ZWRfX1qi6ExNbZaWy
 P6/qUOD6OLAvJjVcCjDWjt1Sqrz8eRDS9T5ZL59X0EiFMURoHbJbLN2Q9jC77N0vplw13HGgre5
 8fRbuT4xMOVHM5fKnFHNYsEJaraDdDs=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abfb1c3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=zpjXwKxMKkLYiEg-dpMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Aqcki3PwZJf1nEuL2TmZOQ2yQz3CXrwp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020052

On 10/2/26 12:52, Harald Freudenberger wrote:
> Add or improve checks related to buffer sizes and reply sizes to the
> handling of replies from the crypto cards for CCA, EP11 (AP message
> type 6) and ICA (AP type 50) messages. The verification code related
> to reply field length was not designed well and thus firmware
> deficiencies could lead to unexpected behavior in the zcrypt device
> driver. Thus improve the code to more closely inspect especially
> length fields at message replies.
> 
> Add length validation before accessing reply message structures in
> zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11(), and
> zcrypt_msgtype50_receive() to prevent out-of-bounds reads and
> potential kernel memory disclosure.
> 
> Also rework these three functions to validate reply lengths more
> carefully before copying data back into the request buffer. Use size_t
> for length calculations, reject inconsistent reply sizes, and add
> defensive handling for short invalid replies. For XCRB replies,
> validate both reply segments and derive the effective message length
> from the covered range instead of trusting only the second segment.
> 
> Additional improve some of the later invoked evaluation functions
> which further check the payload. Add comments about length assumptions
> and for the type50 processing rework the payload processing completely
> with removing a misplaced BUG_ON().
> 
> Fixes: 3b6245fd303f ("s390/zcrypt: Separate msgtype implementation from card modules.")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

