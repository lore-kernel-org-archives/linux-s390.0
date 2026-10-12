Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99048D873;
	Mon, 12 Oct 2026 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815930; cv=none; b=l6OJdNch9ph6xWdIptgTimQP7FK8+xHasWfuUC9JzOICV/SJ+5T0y2gOOfxkcjgZ03dbjPor6LSqlna+Mm8wq2jx2wjDQI4mFu/RnasT14KBDtgTUC/iQUobPMV7euXF/PnzU2pACEAX1qNLPEIPeUUI7F/J5t8uQgzqy97QEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815930; c=relaxed/simple;
	bh=2NI+yhKRe262Uo+ZDYdQsH9AfVD94WLwmuVYOm0xTw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDVG74VAZCK/cnd+JOWgo7al/VHkm1N0x9dIf1QBuB/gV5tpDS7bnukS4l6AaA2Nz6ZhbAAcO7YJTRc8xNpGaV+2r583gDNoCwM361gQiDdR7hQadgEtg29Hg0IG6pqY28u0jzNG75jZQifLkBG8lKTAgjprX5lqyInCfdJQ75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p++npAin; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p++npAin"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEH9j316699;
	Mon, 12 Oct 2026 14:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8Zcz5K
	V5+D9PqL///wkxS12D4uBYAodMyAWdplOZk5c=; b=p++npAin+NyO9tOSfD87ra
	YTRb63y4rCYmKro083IcXPbljVD6it71X9BRiN2lz1Xw/aQqlMe9XiC2njaSyElo
	KOenoTelCffpQd7I/VbWlzFRSLsmAAj6eZXQ3yhIkMbpmWbIHPJmcbTWyWkd4yhp
	b8vYxMm8FJUReAQe8YVXP7PiI/pdmWnMSjNu7/fyVt6UiVswsIaLpdtTkPJl5J7r
	KSvYiF73zcqdsQ/O9IedqcHqXrimnHtk58VViOPtZz1dYUbC5LyWftJzwOh2lfd8
	tY8BGOLbF7gQgSJQgKHaOgnildWG9ZK5P1eHn+66MEL5asCDgdTa/eBuCMku05hg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug9dpv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:38:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4vqC1286256;
	Mon, 12 Oct 2026 14:38:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cydaxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:38:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEchqY49086750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:38:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0EE220043;
	Mon, 12 Oct 2026 14:38:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6097F20040;
	Mon, 12 Oct 2026 14:38:43 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:38:43 +0000 (GMT)
Message-ID: <3ef28ef7-8e21-49e3-bf2b-1af565eea322@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/32] s390/bpf: Simplify exception table entry handling
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-32-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-32-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6accf0f8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=UUIsaXF86_hs-IoztpQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WChPWQPQkLrBQ_kitt9RTZbtLKdOiqmA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX1MR7/0ksHPQf
 gJcglCeh3sUS07wS9NO9MbWL7tzxc0rduVp2low3Ez9AGMvIuIToem5ROguDHKYSWtzFh9jPdVm
 d0ijaygJW1xTuaWQxpdxn1Vklk9GqA84LOUGq0IEnW+fBJMaiRobOu3lqcVZS3607VJC1cRTaKQ
 1fBspj/s7AKiy6/WuU+gg4DnLwRFqWojlJsV3i7l+qZcLx3fI/sB1hlFoWsh3txKgHTFEfp482t
 K5lmHWhk2kSRlkCk4ud9/6hB2Ys1lN0O1za7KMZLZmaCyHCnTWWS720zt6x8cR7w76jXCTOVPVy
 5b9zN5ezjIeBvrwtYFR2wsD/HCurGJs4PGjL71LpPJ3/ONSi/+RhrAqs57NBcrKpLzUYnFkJSEW
 MangxUYiyhF1/A6bWgxNlGVB0ahi7LWK7kbsQ8GwBgMp8HfySpgtKK9uq7zkFX4CuRbput9gDoV
 Px+/qcGfMVWMZMaXo2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX7oKdmn9cbSU4
 0P2DFtCtdifzVGoBvCe5snpCt66LIMjhWvBM58ojgQ20+a/4UZEKdT+y+UN7NvgyFVo3EJ03Yhp
 9OJhydAtwXdY3Xq1Fh/Owjjz6GZ8b+4=
X-Proofpoint-ORIG-GUID: WChPWQPQkLrBQ_kitt9RTZbtLKdOiqmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> With exception table lookup always pointing to the faulting instruction,
> only a single exception table entry per probe instruction is needed.
> 
> Remove the second exception table entry, the extra nop instruction
> emitted between/after probe instructions, and simplify probe handling
> in the BPF JIT.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/net/bpf_jit_comp.c | 78 ++++++++++--------------------------
>   1 file changed, 21 insertions(+), 57 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


