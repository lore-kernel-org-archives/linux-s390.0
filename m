Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705DC2DAFA0;
	Fri, 18 Jul 2025 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752842356; cv=none; b=qk2gwuk0fgYW31ynAW1LP0AtpBTVyy0bsIhmoHeoaeqL43wnVu/ksHhKVV4NAvt7ARbq36tGiLLKQwvTPsCwbzcfF5sHkGSY4qfFG2yKi79pGFPvWEBLWzRTlxNF69/IkocgzJTl7d+nZepwaHEnsZul/N9xUraQ2PnOAwMDOms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752842356; c=relaxed/simple;
	bh=VPu2bp3Y87wyuzHmVhxa4aoG3wdfFnbJ5M6IW1g7xIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNNtZUmSCL8riIGKRyPBuLITp9/D9ypPoF+sJaE/BtvjSawysPxn7+p/go6YKLZ3gWeOUpvkxm+kUbqo041LVaHpsdrtDAYm6OTfsibPu7EoEI8ShvLE/3z4RAaSxEa4Sdi0bTjuf46l5iotMfdgL+7srM35wruD7E9+4ld5VcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=orgTmoMa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="orgTmoMa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I4x4dh032640;
	Fri, 18 Jul 2025 12:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YmvKp71r0T0UP05NQIIAnxid0d/8UH
	kXVDaZEj9a9Ow=; b=orgTmoMaYrcHR+Kz6EvT5FeN1k7RQVoJcGzLLnWobbwZP7
	Pq2DNXg52u6gK+ThXv4CeQatgpIAFkOmjX7Ypr6pvGASqRt8mh8azteSY5BoTEb7
	dBFNWFaDR60EUVrOvIFEGM92n1ExcXcLs5YcqWiuGZwxA6OulueFIaJAN/5IRTYe
	lEkgOcen3aP/KHaux48Gbk3AIQtvvfmKBDXruz4Q0yeyzXd7XpZ1+wQwBnjr0EcO
	otGJq8Rnp6PuROM7qiz4JOxAlGd4ZG5xyraN+JvxSLbXM7pR2kEJ7f5fNdQROn+s
	rE6McfPctLMZyB7Zljzj8xGnxcG3SH70Y2CLZbYQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4uguyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 12:39:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56ICQvHg004004;
	Fri, 18 Jul 2025 12:39:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4uguyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 12:39:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56IB1FqG021906;
	Fri, 18 Jul 2025 12:38:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r3gv3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 12:38:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ICcwn753281196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 12:38:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2046320043;
	Fri, 18 Jul 2025 12:38:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EE6320040;
	Fri, 18 Jul 2025 12:38:57 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.132.117])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Jul 2025 12:38:57 +0000 (GMT)
Date: Fri, 18 Jul 2025 14:38:55 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
        akpm@linux-foundation.org, ryabinin.a.a@gmail.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN
 option
Message-ID: <d5c96fb8-84b2-46de-8f1f-db53d7ed7309-agordeev@linux.ibm.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-2-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717142732.292822-2-snovitoll@gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=687a4065 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=rZjtdVduxoVio5-WNGsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: TIZuJKi-67oCtWCVyBaOzGkgvN5R-ziL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5NSBTYWx0ZWRfX9lurX+WMoby6 8zcw73eBKusO/lI+fsmCswX0W79oAVCdmpWWb4RuL1URCtCPr4UEgtPltbmXzVNehUUi+T6eXmX 4eRfKFVrYpQ27eew83zzkR+KyuIm1pQkr4MRD/AMDdQizk/b9vGMDa1q1wFOSHN5j5u9CnlZbL9
 PESfid7SFSM0zgNdAzD4h3+2AH7N3meARpmGt4UYroHp52sEdyKNpU1m+lbZRTrhHRUqCkTR4mP XWoRcVftiHuDpvOuX3q6S+bAsHfKZ6bUJr9scbjn8qAF/4vinEoTry9C4Lmi2gT7K9g7WEn0Shd IiPx1DI0r79VdBlpJzSfqa6yL5WUqhVubuUr7+O86v5JQgeMPPDFrMF1/F8Kp0Nr1jlKGElFa6Z
 y0z4sKH9jyuS5QG1lBc3a5pv6JbP4TtcPkaYW48k52mMSRsuFypEQKvGct4XoCyYnk4yLR6k
X-Proofpoint-ORIG-GUID: peX60BBMnw2ocO_Fy1XuuKvylFqoptJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=820
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180095

On Thu, Jul 17, 2025 at 07:27:21PM +0500, Sabyrzhan Tasbolatov wrote:
> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> to defer KASAN initialization until shadow memory is properly set up.
> 
> Some architectures (like PowerPC with radix MMU) need to set up their
> shadow memory mappings before KASAN can be safely enabled, while others
> (like s390, x86, arm) can enable KASAN much earlier or even from the
> beginning.
> 
> This option allows us to:
> 1. Use static keys only where needed (avoiding overhead)
> 2. Use compile-time constants for arch that don't need runtime checks
> 3. Maintain optimal performance for both scenarios
> 
> Architectures that need deferred KASAN should select this option.
> Architectures that can enable KASAN early will get compile-time
> optimizations instead of runtime checks.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v3:
> - Introduced CONFIG_ARCH_DEFER_KASAN to control static key usage
> ---
>  lib/Kconfig.kasan | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
