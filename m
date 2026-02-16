Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B223D7F5
	for <linux-s390@vger.kernel.org>; Mon, 16 Feb 2026 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771232923; cv=none; b=qZS3KwW0uKgz9dvrolCsOMVz7bdYZYM7v9p/Zd3x+TkmjLLSiItrPWlcrV8VVkGW+bAQu1k9ruP6G1s8jlOmKW8KrLoIHNNPFKquqPrt/ba1yit9rKqReRteM9lw5aRD/C66LTb0wspJSUXZLL8p8DdJAvofFY+HM80OstmmKCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771232923; c=relaxed/simple;
	bh=VOi+xidHL1YCGlJTYJJF3XkoZpm+kXAKw3Gs65ODBRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nu0et3RZSsmvBxlgMzU72MRVwOF0okloUPURq93t4tnrUOnPWgrNd10auLw6hR4WdY57Dq82B1yIhUZWDpjMNYZPIQXIhiBI+k1AgnhSGzu/6ZiCMLdk1CoJ5OIBe1SExlTAo8JYsyjCVCwH5KU3OYrZ9RvUydP5YJmJGF8muhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gIC+h4+R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gIC+h4+R"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FKo9Bu3434976;
	Mon, 16 Feb 2026 09:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gbFGcN+w3fR9jnZFuf/i9EiHs6mK4T
	mGoGErRfWToDE=; b=gIC+h4+R6VvLM0jpeD+yzWko1RRL6XdOZiC6pYo47i11vt
	rOIU9doZ5l3lybSJXf2krUckpLIZK/SbCCRL7dK/hSmAwpe+Prq64BlU+9T542Sw
	hXSRk4tKKfuL6RvrmzA00IQBpJFTWoJwwgsxuvRgYrQxJ0JfnfVx2+L6UM8h6YQj
	9JMp5R7d2BrDExyN09376sA3cWXx28osrYCtc7L8jzo8sI3u6rV7d+/oC4t4YYc0
	1TBriJFfQgT7EmxZN5qfgLT6hZMvBFMB5yoK/73j4DohGrCOk+9BTIOZkddii71a
	5bo5R9TqfbrzITt3MUNTn1j5XeOUvm/Dd8WZVjbQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6uevrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:08:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G7186T004035;
	Mon, 16 Feb 2026 09:08:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4cmvqs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:08:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61G98V6354395360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 09:08:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8D322004B;
	Mon, 16 Feb 2026 09:08:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B3F020043;
	Mon, 16 Feb 2026 09:08:31 +0000 (GMT)
Received: from osiris (unknown [9.87.144.68])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Feb 2026 09:08:31 +0000 (GMT)
Date: Mon, 16 Feb 2026 10:08:29 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, kexec@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/kexec: Make KEXEC_SIG available when
 CONFIG_MODULES=n
Message-ID: <20260216090829.12756A41-hca@linux.ibm.com>
References: <20260216062916.818071-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216062916.818071-1-egorenar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6992de94 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=NxbVVSpuZNI24rlRSKEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3NiBTYWx0ZWRfX0cE/W+EVSeVc
 K+kMwzbYA1uwI5Hm//lJEESmlID3WQeD1ffbUKI9WqPv3l2bLgG2uoU+bFnAdz1LB/RxOJKjBkb
 0oNOrDWYasZNzIx+3R52EPb4hEAj+/9V+sBcJaoJVUned+rwWR2+GwS9GsjgfYo12F1/gC2pLN0
 TgLjFKuGM1+hS/WNvCxyI7gDcvpB964LwxTyUFxCzIXzx9VLYAD24CcSTRknjftmLgBpfXvkZUN
 QEoF8o70Cgqn7Rl5fGdosqy92iK6sFd4PE+L0gji2E9Nq99FslwbbenkSkpBJ4wvju8U/6bcTmT
 5b0wblHMTdqXfupRdhCPwNFdYk4pgFJRXNLemWgOM4ZGhRIcJae8x3ZdOhnUw656CXoyCwjlo+K
 cgpAAjvtDZQPxqwum0TDhCOFER4TMo1OzFaF+3dlGc2YmO74fG9VR9QwRITRg6LKs4kzhleI8cl
 RGpUvYYXeo9cIy/oSoQ==
X-Proofpoint-ORIG-GUID: -jU0seWRZ-D6LsGZu_pN_RQDxne5aoAG
X-Proofpoint-GUID: -jU0seWRZ-D6LsGZu_pN_RQDxne5aoAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160076

On Mon, Feb 16, 2026 at 07:29:16AM +0100, Alexander Egorenkov wrote:
> The commit c8424e776b09 ("MODSIGN: Export module signature definitions")
> replaced the dependency of KEXEC_SIG on SYSTEM_DATA_VERIFICATION with
> the dependency on MODULE_SIG_FORMAT. This change disables KEXEC_SIG
> in s390 kernels built with MODULES=n if nothing else selects
> MODULE_SIG_FORMAT.
> 
> Furthermore, the signature verification in s390 kexec does not require
> MODULE_SIG_FORMAT because it requires only the struct module_signature and,
> therefore, does not depend on code in kernel/module_signature.c.
> 
> But making ARCH_SUPPORTS_KEXEC_SIG depend on SYSTEM_DATA_VERIFICATION
> is also incorrect because it makes KEXEC_SIG available on s390 only
> if some other arbitrary option (for instance a file system or device driver)
> selects it directly or indirectly.
> 
> To properly make KEXEC_SIG available for s390 kernels built with MODULES=y
> as well as MODULES=n _and_ also not depend on arbitrary options selecting
> SYSTEM_DATA_VERIFICATION, we set ARCH_SUPPORTS_KEXEC_SIG=y for s390 and
> select SYSTEM_DATA_VERIFICATION when KEXEC_SIG=y.
> 
> Fixes: c8424e776b09 ("MODSIGN: Export module signature definitions")
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
> 
> Changes v1 -> v2:
> - Let S390 config option select SYSTEM_DATA_VERIFICATION if KEXEC_SIG is selected
> 
>  arch/s390/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks!
