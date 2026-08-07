Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333BF44A40B;
	Fri,  7 Aug 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093970; cv=none; b=RXylA5XWyzwag+QvJiopIG1jjP02D6MeGchEXtwGwWxenrGfYNM4vbbR3vZKnHKxOJTPOQtv+sUkKF6qTnU5CuLB6oFuLCjRw+RuFlMfUeu6xlidnrAAbW+ZiJ9NkrA36gyma5mrzNd+GzqaJf+Sq3SmYQVYFgGaMLTjQcGtLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093970; c=relaxed/simple;
	bh=fStG8wCeTEtx7N/xz4zqqDh7ixGfO5w2n8pDizUNGZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAxUvJxxaE+f6yTNlXQUlc2TRGrk/jeu0+rN4b3W7JFHYoIy1KFOtNjskbDnVeGsgPaKU+828CyQnuDxdfJbQeK8PZXPERAR9tc6Au2w4VLX2FuhYxKnzxkCkXZELis4zstinKwBM1feWuCmz/U8s9vNvfSi83gbuj4QXWtRVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C5gdKJm7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C5gdKJm7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770IJaj4135534;
	Fri, 7 Aug 2026 09:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fStG8w
	CeTEtx7N/xz4zqqDh7ixGfO5w2n8pDizUNGZ0=; b=C5gdKJm7IKQeY+GMzsrDlt
	6cb1e2sKwO3v8wbWrEV2lwUi6T4m7bFQ8zmLo1buhgmLPZ8E3U+EK/snyvyCChYt
	0XoXKm0wsCmWwu7iBuuqj1dCyVv92nQ+y4+ulWVuxMKfZ9kBMHZB7y/o6IWubQ9S
	JfN34KZkION8X/VGCXQ9/kwiR6rd/5S3pw+L501F2gj73kv2vTQGjlDLRLUTrWHD
	lP+XQvviArmvPkjJRN4Gsbu5ZWqt18xw69qkvEPdtTG6VjqmjHVA80glqmEVAxo6
	xYS04lNPzjQslhhTWApakjiIbPod9P4ycNtBMXqVGRBphCQfLmyL66yGFCYIMimA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0435j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:12:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779BH2V001259;
	Fri, 7 Aug 2026 09:12:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyxuct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:12:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6779CQ5l27656822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 09:12:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90F4B5805C;
	Fri,  7 Aug 2026 09:12:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 328995805A;
	Fri,  7 Aug 2026 09:12:21 +0000 (GMT)
Received: from [9.124.213.67] (unknown [9.124.213.67])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 09:12:20 +0000 (GMT)
Message-ID: <6e8e02fc-03f5-4790-863e-f5d45d8c26a4@linux.ibm.com>
Date: Fri, 7 Aug 2026 14:42:18 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/smc: fix clcsock and lgr/lnk races in smc_diag
 dump path
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NSBTYWx0ZWRfX0fRzhzT1WzkQ
 C4nuYOqugzYavz4sXSxp+SDlUXQqHW4v/+c6BSrOaI05E5ipdWLMcLbuBoR/rzwJLoLK0PIEbM7
 PQC8FyQa36Nkakk8k/p029HmiPD82IyJ8/cWLeRbklEzDQc8+feRgucWz8O36LxSWM21IvZKnML
 joOkLsL6qdtd48NSqonOfZM/8rLp7E5RDiRh8Yg4TDSaiMGEUnJDNbYNjVJQlsdCZZzvtUVcrjO
 Ny9wcrNp5ErP/WsZADs8otdw6dAfHOcwdPFbYMwAMAeX2C00Ca/If1DIotcNQJeXpZW73eEr3Zc
 UIcDEPwMFDSVMRD8RP/76XMgLjK92DUkdykwQ5cPmzNIvEI6QfImm8kwjO26ElnMq33s9r6uTnq
 l5m2ZSYyX9YSRE7y6B6gvDxzgck0d1pSSyATM5VBL4e+/wzfIIvk+0zh0zPBNuaxfhQNGjnUj7o
 wE27fJv9jthhWm1gWKA==
X-Proofpoint-ORIG-GUID: xfxd_WyA5ZHcqKkka3FlxQrl8-cNDo60
X-Proofpoint-GUID: enGPPuYxTz0LPl7x6iaQJYMW6Ekiy4Ku
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NSBTYWx0ZWRfX9K9GaB/pi5F7
 VLI47VPlSr9F2rZ6MdYZ9KyIepcNSB/P+5y+RznQQmlKg1djinH0jRIyXcYqDQIjdhPsKKzki1V
 urNGcokzajioyEZ/fhObAiwwC0zc3YI=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75a17d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VI0bH49URBRJcOTGMQgA:9
 a=QEXdDO2ut3YA:10 a=Qzt0FRFQUfIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070065

Apologies for the confusion.

This is a v1 patch. The v3 tag in the subject is a mistake. Please
consider this submission as v1.
