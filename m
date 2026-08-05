Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3243AAF6F;
	Wed,  5 Aug 2026 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924423; cv=none; b=Cw82U5iYn20OJM9yOObqFpbx56zabDLnjhrrJoMzpwa75uMcYdN+nRDBOb5EfxXFlHIZTcrtoRSRutpxSHCQTyF1scrk1mHN9j9/yI/aIWYoZGSOPJxt0x8lZRLakDYYbiRT66NUQYLRB2KjTfLyvr5e3c2epzjcEEgSYQtNZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924423; c=relaxed/simple;
	bh=VBM0QhDEhOTj1Dkc/yYu/dM0DqaykQQMUVWTMNMTvgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeBwEsIwGFsVJZHYqiDLMR1gMh2pV79sUN4i5wFjKLMWakUHo+xItSjcA1SmZ5NaQVKFJ/0kFQp5+AwI2Oa0/mFECsSqtqqrB/94XmcATivNw5jmD0AjCtt92w1E2UVREkBkmxQcpNTmK6rDeDRa/NXjt7u4hThyeItGzrZ8BOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FvVOmQ0W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FvVOmQ0W"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758ldCM3288601;
	Wed, 5 Aug 2026 10:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=koxjNr0iWBD68JG8tZtGfFjFTRXV0P
	6k29YMLINJQBo=; b=FvVOmQ0W+H0VKWP8MKR/453R6QVw5T27nFZ/b5ChPB6gjS
	BpgeamOWPE9L8J/A3MwCeX91inhok6IZLq7QtmPsdnOHx9tmN8QJVNC5qrwCleec
	Z8UC2usPSqjEmUNRXZE3QiOtd8TkBvwU/DuFxVvx7CiTPCx90jMzsrWnaAkh7DxG
	ELJc0d7TtaGMN6EMRK80B9GcBUFLP9O2N6GNpL8W67ieQhwA/7En0K8APDMkA13S
	sZKZZLcvRk6vQlrLD+F1Dib7TTqrYCNj0bwr2Y1Z5esvAlFafAwetZmQTqdcI9L0
	HgKgVeAoFtB5+OGEmOFpjlc3EUYC0ffTagpMhuZw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67ht9gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 10:06:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6759uRA8016411;
	Wed, 5 Aug 2026 10:06:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgdut7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 10:06:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675A6ig952363538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 10:06:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AA3320040;
	Wed,  5 Aug 2026 10:06:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDBDE2005A;
	Wed,  5 Aug 2026 10:06:43 +0000 (GMT)
Received: from osiris (unknown [9.111.89.228])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Aug 2026 10:06:43 +0000 (GMT)
Date: Wed, 5 Aug 2026 12:06:42 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Bradley Morgan <include@grrlz.net>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 2/3] s390: Implement arch_do_panic()
Message-ID: <20260805100642.76476B64-hca@linux.ibm.com>
References: <20260805-arch_do_panic-v4-0-af4a36f99414@linux.ibm.com>
 <20260805-arch_do_panic-v4-2-af4a36f99414@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-arch_do_panic-v4-2-af4a36f99414@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX4WMPZhm8LWSE
 +IBwInoKY0WjeXP6KzTXnk2E1XsYv+CXWw9rDzdJrylhrA4Gk9jHzvqPaVUsQFCwVB2TppSsTAJ
 +W87stRBI2jfeyWSneC+LJzExhc4qUA=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a730b39 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=vaa-I4Qfp-vEu9COqkMA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX716O3EgNNVm+
 0eXP+cmh53Kc3yqUyjNMyebAcrN8g8RAW69gyAfQT/VTY/OrUN/sMWgdYlNFyRwf3l/9wYwZA/G
 CSlld0WCtVHx8kOHw+2q9eq8m1sVWxK+aCWRzCidYFeDyiJ8kA0b9z1mX7uae9zH73ML/xro3fg
 aohxhNC0y2/h5t5J4YbkJbCLb6dDzX63rLz5H+hW2+ivaLAVdGmPFDQhqrD3gFcPy51Vy7gDNRI
 xpa7QQZw2KkWrtkFligDHgrskae7Rm9CUxK8Vp80kcwVXIgqF/LdFUGbzqTqWvhfOEDjHmBK843
 yJ/MgbfiSuqb2Y8XY6I7geciUuf49CTqGfRrmItX75hXBmuo8d5ZcHsi0wW76R25FHppiu2qG5E
 8Jr6BJu5ox5gKqtrwH5PjRJRn+Kvy90BOCn2qyC/prSZ/9fWavLXSm4kLVkvnC1OqfDvZpM/+YT
 r0DRa2k21hE0Xn7LmTw==
X-Proofpoint-ORIG-GUID: zZ_F3FaVk-l1oUM2Ar4jO2hp6dIcAgeW
X-Proofpoint-GUID: zZ_F3FaVk-l1oUM2Ar4jO2hp6dIcAgeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050077

On Wed, Aug 05, 2026 at 11:48:37AM +0200, Mete Durlu wrote:
> Implement s390 specific arch_do_panic() instead of using s390 specific
> ifdef sections in vpanic() code.
> No functional changes.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  arch/s390/kernel/ipl.c | 6 ++++++
>  kernel/panic.c         | 3 ---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 3c346b02ceb9..31ff7c12c354 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -13,6 +13,7 @@
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/kstrtox.h>
> +#include <linux/panic.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/reboot.h>
>  #include <linux/ctype.h>
> @@ -2343,6 +2344,11 @@ static struct notifier_block on_panic_nb = {
>  	.priority = INT_MIN,
>  };
>  
> +void arch_do_panic(void)
> +{
> +	disabled_wait();
> +}
> +

Please move this to arch/s390/kernel/traps.c somewhere near
kernel_stack_invalid() and monitor_event_exception().
