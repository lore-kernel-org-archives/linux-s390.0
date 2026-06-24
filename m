Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84263C109D
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311993; cv=none; b=DqfdPKu3dMzUhY1ICrqQeiG4YmFFxDB4d1vgbtXjMGkgTzXUeA9NrIh5M+W03i18ne9SALErUOpVEI3YyHHP4L4S7H/10sk1vYK66mkU+QHCDQAUcCvmwHvAUtN1SK6QbYHGnaWB2SGesXP1/mrDTEVfEbtyWiWcXMFzG1oJVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311993; c=relaxed/simple;
	bh=rLgPGqLpVUGWILqInNUJktvp2k3/91lqFGQ1s6OBOz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBZJH2+Q7y4lE0Lrh86As7XJE3+eUd/02GfpeVf1DBnX/HsR/EHhCEApVODNEo6tXXX1o3RTF71wwWICxrN31PFMoLPbO75wTwsa5TEcAwiHh/TNNUTXCRbw0HqMjTFgj89dG/wLqzur5qg7T5axiplO1RAk22VER8dIW9bAZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hnTYTbaq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hnTYTbaq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmhCW718393;
	Wed, 24 Jun 2026 14:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+Ft7Pp
	kjN5pKGFDHK6GMtcKuVmn6gXqBIT6M4oiH0Ww=; b=hnTYTbaqJgffzPOkiTHD2y
	2EZ27uzO6+mdOAZYRqDeVCD/1cRY5NjK+74mtF4sGsZUiEt/PCFRU2HPgh6POHK0
	KBSpXSNM4cAlzQBSLIQG+scfqgFPme7qvxd8IO/rUc9u9Zip3Vq6W2gz2K+9lpKh
	hqRRYRPaJ/UIF5LJxnFeT0ftNpkTvX2EnOFDjlp2xA0A1N0y1Mau/117XYmAacWM
	2QqL0O5a37hyInol0yuuOdQU95IR8sEqsew7JN7rzdznvCDUV1tatzs1XFltgiat
	Lcb0pQwvcDH2agfo8/LKVAasfS54FDREQbbtHbBjrkca+XOiEwOihHGdkvWkbG5g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3mt0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 14:39:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OEYoDX023220;
	Wed, 24 Jun 2026 14:39:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyrswm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 14:39:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OEddHO42533286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 14:39:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 331FB20043;
	Wed, 24 Jun 2026 14:39:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC09F20040;
	Wed, 24 Jun 2026 14:39:38 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.104])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 14:39:38 +0000 (GMT)
Message-ID: <8bbe6ff3-624f-4466-bf67-246a84c1809a@linux.ibm.com>
Date: Wed, 24 Jun 2026 16:39:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/18] target/s390x: Support cpacf sha256
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-5-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3bec2f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=STxvwRUYNqjuMKLQNtwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX2mxZrl2KHf9W
 aAVdTS7Pls9o3YvNQKxApv/PtWhVYuCWDLsCWUetweGGvUngxxNVqwFnpKcldi7yCQcBmsIfdnb
 Jdrw/H+lILT+QV6W+0ouB6sFro+ymTg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX2hUFFxyn39fJ
 5y7kXl+M4XBzdGaeuiKF9ssdlx+1ULMwnahloK+zxiR2nedq1x8XdovUJoYGHGEbO/Li9Qfw57t
 7RteWvnRfNYc3qq2lxbcW/PL+k/uChfWCxriY07tWzUzGHok3BYxKWc0lqkOwF8pcf1W/lLQYQa
 CmOIwd/ZdyxfimTkdKcw8cZTTXScdIDEGv9j0yldcq9NyV8J4zIbAsX3nulpu+ja4EZJb4YR/Wx
 hh4kWgZWrYp3g3X6jpl79K+v0iT31jXKNxKv2rlE+zcdlNTDOrOvBcH9BsfzT1WuGK7dh4CZ5lN
 XmbVsSHBUX9qRCEpQU2Tah9AZHtznq3zSQyhuQFeS/vjlNinovB3ViPuXntn1lxZIUTXWimpoIU
 bA/NMSXRTTx9v9LemLT+K+0HvDJOLw==
X-Proofpoint-ORIG-GUID: 5sVcjEtsyWGFLTETlfmXTWWFP7Sa6Vso
X-Proofpoint-GUID: 5sVcjEtsyWGFLTETlfmXTWWFP7Sa6Vso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240119



On 6/24/26 10:10, Harald Freudenberger wrote:
> Add a new file cpacf_sha256.c which implements sha256.
> Add support for the sha256 subfuction for CPACF kimd and klmd.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |   2 +
>   target/s390x/tcg/cpacf.h         |   5 +
>   target/s390x/tcg/cpacf_sha256.c  | 232 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |   8 ++
>   target/s390x/tcg/meson.build     |   1 +
>   5 files changed, 248 insertions(+)
>   create mode 100644 target/s390x/tcg/cpacf_sha256.c

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
