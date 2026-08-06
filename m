Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC5363096
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037738; cv=none; b=SP2jSUfLd1eFRIBaezhIsxTomjfEvI1Dr3Vebs2iJW3/ODY+8NIto7AjTOO3WhMHp51/rvXJ+dvBf/YnwGpRfBqQXDF/EDIy3OO19jM72psLt9Yo94sM/r6X1nKrjZWzy4yrCXbfKuzCdS2TDRtMs8QZfW4quowAMrmJZIffZ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037738; c=relaxed/simple;
	bh=wfM/bnMKqxvF0FGHcdbqHe36h8NkZLMggQpLVB2ageo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1pPNkJoepnTFtG1vtwdElZ0NzCalzQeAL1NfkZ3cM8BhgZZFMNHL/e40xqTUQ/5Pmvc73YUU/i/fRcRwKoal2qO1Vz3YX5CYd5EN2Xo3DpMcuScu83pIZJ9Ei0j4LLVfp9fFM3HAKxJm9NtZFBjtepMq8oeQTPVHkZleB4PqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BkqUJzMz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BkqUJzMz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HIEZu3341001
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 17:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y8/B2N
	WLE51WJrWesZUy7fCSF7K5WJ8v85QOjlYiGBc=; b=BkqUJzMzzUfPJTrJ5PtGPU
	2DE/aWPTbTSBdTKREtcZjknCXsuF7rGYvrs1mFhlQdpYt/qkJn7X3E0WlZ7SUTI5
	J+utLngGPv72p17E/EUMM3KgizoyzjS9xcxcLmi8wT1uy3R6LSJD2q2sjavzE2KR
	krziQeP38L/48j1VeRfFoCpjiPy4O1xUjOqEQczHmQJxXzCmfpeQz0bVQDmnfHSl
	ZPNZkvZgLO2OdsXgNqAsQnZMP1I2T4Cg7Xtt7fKNNlZl5cmMPAQpMZM+DMUvQwqM
	llvDuGttsdy5h8QOSEWrjb8/V8jQdmKyI/LDLxZlpxpBpeEBOYsT3ZalwqK/iLdg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8ev0x9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 17:35:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HQfol013801
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 17:35:35 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwcaxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 17:35:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HZXFC4194960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:35:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A9495805A;
	Thu,  6 Aug 2026 17:35:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3F7958054;
	Thu,  6 Aug 2026 17:35:32 +0000 (GMT)
Received: from [9.61.13.162] (unknown [9.61.13.162])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:35:32 +0000 (GMT)
Message-ID: <bdeb221a-0eae-45a4-9c52-e1814e1c0804@linux.ibm.com>
Date: Thu, 6 Aug 2026 13:35:32 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] s390/virtio: Enable CONTEXT_ANALYSIS
To: Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman
 <farman@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <20260806153849.2622576-1-hca@linux.ibm.com>
 <20260806153849.2622576-4-hca@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260806153849.2622576-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: seZ2m3nz2lNMSkL-i1O0qnTtNIQrqzIv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX/dimUl4obUD5
 CF0OqRTf0mydOYZy86Sx/8i0nsScUg3uWjSz0KQfK3V/epXeu5AwmADQ93cJPmYvEwg93a5wEgW
 VxV1zr8dZ+qA9jQTb6o0LhDb8yLKCQo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX5Hfiz1od9+4A
 U//vtQOE0l4LmLX1kAM+fF5HoJvIdcxp9SlLVzyJ8eGXYcx7AwyztjPjXofu5Adh+PZ0B6hMM3m
 vfLHH0QFJ2st5Un0r8Af/qHquuus3fEOP8GQynV6jXcCHKeDbvBl/9Sc8cAHHkclRkpVr3pWm91
 gOaOEPow/sNO22MVZWZ6kvR7SKl7Whw/jKJS4XI06r9//pLOgO3qh4+Rmi6NVUxrnT7UEoelVwm
 lcZEfgjUdWqhowvFHyzUPULl/nHKkp2z8P4r7WX8ZDTQpJBy/s67MDt79Fb8FAOkHvmPcIG0pHl
 XDREXmbIau5YhpMBH8WKZmov3WkZ10bwzolTkNUOGUtNTn/EzKWa2fVqC6Zt0B9pGoNjv08qbfZ
 YOjROch3x3UUek3Oa7bAREEYdxy24qlY+MIbos3FH3mZZTeoGTaECe5ZJDiAlEe+LRrGBJ5d4Ks
 SM96vCcFxZlw6ogx+Kw==
X-Proofpoint-GUID: seZ2m3nz2lNMSkL-i1O0qnTtNIQrqzIv
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a74c5e7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=vvlvHtVZmiFCKA25_WMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060135

On 8/6/26 11:38 AM, Heiko Carstens wrote:
> All virtio code passes clang's compile time context analysis.
> Therefore enable CONTEXT_ANALYSIS.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>

