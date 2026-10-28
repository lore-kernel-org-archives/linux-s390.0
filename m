Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190411;
	b=BrkLwWZsD8y2e2o+J5yfT20CdUfmKxCP6MBU35k3mbSCpOOG227Mto0GVA7ObqppUaAO
	 bYeY859Lio0CFep5v+S4Gh9wln0fHKXUnDtw+VCJwg3Y+dxLmWxUvOmNXDyAG8UpuMHGA
	 tmFl0Lc5sVGld2qSszef8Til1MWNIsDtzL3UujYWY6OsRu4aqefO3JhdvsuBi52LtsIL0
	 QchVRqWvShO+FGmbrfyAc++jBetUky7e50HPuqujtL+f1UPco0y/+M+Wh9DHwSDjHliRD
	 sfqWhXKG+QWB4FC/3NuTkkbNYmAe3fsOOhChQ7PCCJ4pc3cxUa2jwhQwDhpQqj/k0Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190411;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6fFsoWZl/hQgO2KEWWTSORqh///dhnSFc0KzuvLF+Ig=;
	b=OUgAlIHqQRZ2UQseb0pAaEs6MnIb6bQi717nrtOC6IxtpQv5d2DRlEAoH5PC7fczhmWC
	 hQ1G9ScgjW7l3kCbK8/GJeHlJdeli5WLXfSyhnpH7lKzBJZ/Ktizdn6vVqZXVUpVCH6oM
	 mE2Tbvr2Xn3hv6Gqwxr1vWjY1u7i22Htri1AvcT9oaU5XfrQXdQ72JR2BUThvDj00jZ3U
	 StSPPmAMIULqI35T3MVWruoTVHPw2pBaHwdWoLQeegxAUxwE6pfIwmlRvN3kv1sb9c/RL
	 qxOmVGEOue7yxBqySgdQfdy+MQFVnhnIonUXFHwdxh9vsRGFbihJ3iBBxzqWjzNyepw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P8PguemO;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E27606A31F;
	Wed, 28 Oct 2026 12:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5E27606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P8PguemO
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBibqM1159946;
	Wed, 28 Oct 2026 12:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6fFsoW
	Zl/hQgO2KEWWTSORqh///dhnSFc0KzuvLF+Ig=; b=P8PguemO6wBWUQfE8vl3Lk
	6c2SEga+Apw86s6/RiP1AGMX5WvuosctjDdGREnyJaBtWdv9QEht0VZHQ1uJlzTH
	kuhHp+UJqY7kKjGZLFIwCyKbgIGj8rynRbGV6Eaf4trX/ERbRpcCPlPE2fViHX8y
	dU/mfY0SHX262ejcGLd4LsmaL33pf+nGurm3216LVt17+Z+JhZ2p5vpoVvJtEZdy
	WCOJfaiLgjSVrCZh6YzFgGSK0xgmvQqpA4qVlxKQxI7G3TGT9xxwUg0FMf5YevCg
	NJmFBpgWCnVYRbFCFWNqOx4Wy6VFdLaUcVCQKVpK/GwKMNH7hJDP+7lihyJwk1/Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavm536-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:26:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBo67b1550075;
	Wed, 28 Oct 2026 12:26:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh785x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:26:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SCQjdQ48496952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 12:26:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB7C62004B;
	Wed, 28 Oct 2026 12:26:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFF8820040;
	Wed, 28 Oct 2026 12:26:44 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 12:26:44 +0000 (GMT)
Message-ID: <eb9b4dd0-730d-4efe-8317-0934a84c9492@linux.ibm.com>
Date: Wed, 28 Oct 2026 13:26:44 +0100
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
Subject: Re: [PATCH v2 09/10] s390/uaccess: Move s390_kernel_write() to
 asm/text-patching.h
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-10-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-10-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae1ea09 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ifOuXc17KlXt5XTgyocA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: Ztlw3DyrTiseLCtb4J5xlY_ZML6PZidf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX2611g5nkJEXw
 UVVL6vjEd0GJnHoHVtcM5MhALdqxf+31jHci5ffyX0Od23CilslMDq3njI8jkhbWnzfMnfjCqIn
 oc8t+45UhIOCUPJ+n0RJxH4DhrYoZPA=
X-Proofpoint-ORIG-GUID: Ztlw3DyrTiseLCtb4J5xlY_ZML6PZidf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX7m25THRd2pbR
 bQTgNOCWpQfUqOrny47nvkRYsaU0gHusDgJebcSWuZJfWBDQRiE8lueiZY757h/eNbH2DrKgszs
 V+2nWumDLHfjNt2gaAI69xviRPgqHJuO02nki7kbKEbxVetyZ/H87uNh71LkdDirh5ECdNVXSAx
 Kor32QSJHMgUG+CwpdVWCEvfHGUql6746UXCdsFRuA/QlhW0PdFayswOd+P3TNZ62oDditG/IBm
 P/bJ1w7ywTGEzh+gUcLapUUKayWodHIqFeCaTPTtRsSjtL+1g6tjkscrXjYufKLmwuffwDu722v
 qbNOlfA6n3I7ZsWpBHwuOkOcsBHcFs1qsGk/3/JjpxvvJxLyQvHXEDoWducp4YvvEUqJ2VRZJxv
 4kOyiEAFgaOwGgApqKAZ8Jd68u4hl1I6yFLu93AgUfTiaRSl6iahwx/VKzo0dacz02FPHsno5jr
 6wRn2W2fcPVfycRFT9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280048



On 10/27/26 15:30, Heiko Carstens wrote:
> s390_kernel_write() is a text-patching primitive, not a user access
> function. Move its declaration and the inline wrapper from uaccess.h
> to text-patching.h.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/runtime-const.h |  2 +-
>   arch/s390/include/asm/text-patching.h | 11 +++++++++++
>   arch/s390/include/asm/uaccess.h       |  9 ---------
>   arch/s390/kernel/alternative.c        |  2 +-
>   arch/s390/kernel/jump_label.c         |  1 -
>   arch/s390/kernel/module.c             |  1 +
>   arch/s390/kernel/nospec-branch.c      |  2 ++
>   arch/s390/kernel/stackprotector.c     |  2 +-
>   arch/s390/mm/maccess.c                |  1 +
>   9 files changed, 18 insertions(+), 13 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


