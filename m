Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8E32EDD58
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214676; cv=none; b=Zg3a+lmas7ereIx/f1TEFATbjAfaaKjDTxX79zaFFN/hEjDrBISNGog2leoUeoOLL0fbIhkQI6ojo7p5HKdwyQOXxttg//8mHh1MMhZc2Cd2t+pyD09Ka72r9CJijUmPFhgqPdIR3OplV3w2vIe+Ow0T+OAukTEvkhXpbJILAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214676; c=relaxed/simple;
	bh=6M5wzARLxlzbP2yLhkYYAYKXq6dwZAACUzY+UnBbico=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gl1VFeNF6QcNm07/OhewLLzcYFhjdq5TyfcVhtEpDTwbTCd5/hD1zSU1qvRyDiRjcc7I6TLd0CQu4iaFmHjGxx8RR0QYJwztOSf2g5mvC7ygV8klRb0Q3abOv1wrHQsgOlyE3x7iokzos9CaKg3Rx8V2zXuE/OYOq1E5lXxGbQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tA63EgAw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tA63EgAw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLVlwB504070
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 08:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eEfxrZ
	puW3ah0jcAOt7ZaWoUGwfocYF+UCxAGLurzXM=; b=tA63EgAwz6rWNmzEILxbjc
	UVJFjnd7DmCvdoGHRcgra78fLYGS1t7POM6pyqps3mhinmqf9w1kOEX/Y3fNBjb5
	UNajlKQsp9xCj3b+mZwMgKquAGdoqryMw23LjoXSZIDmugsQyjB6mMxgT/mQq4dK
	KW0G3gw7QFspixCUzZQ34yS1SP9EVhi2tJNe1r/IwxERJXeVfM2i45sdO+cDKk+j
	TOZoLisxjngyctgVUwq35+6IWmZTgeHUBUl0ZEB+oeVaqu8sM7fruRPDueyfQW1X
	0YKQI+dq3hEXfBA7Ns4LcjwX7WoTvsTRwWsYqQWr8v/P/sKAApjpZq+JcHOiaffA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu48w21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 08:31:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K8QNKn031410
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 08:31:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twdj78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 08:31:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K8V9RA12648898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 08:31:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D2E120049;
	Thu, 20 Aug 2026 08:31:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3542F20040;
	Thu, 20 Aug 2026 08:31:09 +0000 (GMT)
Received: from [9.224.91.220] (unknown [9.224.91.220])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 08:31:09 +0000 (GMT)
Message-ID: <65e5a882-3c93-4a27-8d69-1335b800763b@linux.ibm.com>
Date: Thu, 20 Aug 2026 10:31:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] s390/crypto: Fix handling of EBUSY in PHMAC when
 req is pushed to crypto engine
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-7-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260819091734.7331-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a86bb52 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=JfLAazOnlRC4zFYqdaEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: z-R5oQt7YYchJuF1ZPRoC6kLKedWz6Zd
X-Proofpoint-GUID: z-R5oQt7YYchJuF1ZPRoC6kLKedWz6Zd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1NyBTYWx0ZWRfX4B1YXX5km5/U
 H0/F/2yN7QtQVDZ50Gtlwh+OzV8IuDd05Jl8bpGw8ZViiC24EovdbBu6INfmpTXjWc23JQA8IHe
 QOgfgbWvXn/K0/4qousitcKhMFvTFKM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1NyBTYWx0ZWRfX8O0EHAto08t8
 cicqowK4DMrwZtlvbWwecdFf8AQhZHQsmuyr3bjYonqU8dQwNqnNjjWR/Xn9+qQNyMCfv5428zD
 Z5Yu07ftu658tq8et3wTqtP5qSjGyN+PdJaSnNdCv8Qz3A/WjnJzDk73BTrcWPj1QwjMSuaRYLq
 UIzFgK/a5qdxkQoH1LBnOP5r7qH5Qw9fw5EyZVSz/K+UdZY/sxv0jBIC3ZvzLRDk2OuFOi5Bkcs
 OCia9t5nr8IvuFIBuIv7iFrdSxmyqSUcIjoefC15t/oFjRJ2lhTIy4Ir/YO2pyh6ZZThi6IhSri
 BF3o4JMSsCNqY8O8Bg3PQOTdCnWl4FpKGQkgLptYQ8oQIm1wXlQTFZfX+suEUSBu0nkQQnlPD8g
 rjlcqWkL5kVo9Hj1w5ilyc27ki8MccK/pGZHG0xyVagcvNuhugUR/Twey1f4rt/pBTk858zWPLb
 3+9u4mKJ2mr77r3LHFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200057

On 8/19/26 11:17, Harald Freudenberger wrote:
> When a request is transferred to the engine via
> crypto_transfer_hash_request_to_engine() there are two return codes
> signaling a successful transfer: EINPROGRESS and EBUSY. However the
> correct handling of EBUSY was missing and has been added as a return
> code indicating a successful transfer to the crypto engine.
> 
> Fixes: cbbc675506cc ("crypto: s390 - New s390 specific protected key hash phmac")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org # 6.17+

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

