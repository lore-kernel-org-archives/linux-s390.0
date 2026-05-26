Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19263322C73;
	Tue, 26 May 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809044; cv=none; b=MaOmrNw9bECPVzxdDU5IOOE7LFuIuQgkAvFwZVSLdlHhappmBW4snu8MLHQ/kqzzyw/OdR4qgMn1H/+tD4WVQ/0+GRIAmAo1jr9DCnRmKLhF54yxDGtPuFzVwd9Jxz+VHPf98HfuXHo1wYsBmthdRLiegXLn70rMFpskKSzvrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809044; c=relaxed/simple;
	bh=m7Qy/CY6BmxN97rzicXLicvGEkGfvNZiwT+j/xHJu00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4dmZFXO4TLSIxZaEKlkwMW9HJ1M+s+vbif9ujXpsJctnf0QAPNsILhpp9pGd3tTqZxVDOJykA1gvwfzIC9i3L3wjFZipeDJvlDBKl+4mAXnXnHXyxl/2HRMZbAcre+ogsS7ItlLOVv5Wx8SE1/xc9X8d/wa3IR+HBfg7DMj1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MrVtUn3C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MrVtUn3C"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q7agYO1804339;
	Tue, 26 May 2026 15:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=svB3jQVUpLlX7MQIhmSWX/2Nchji9p
	0ZBDcxb/8J7UA=; b=MrVtUn3CISlrNdDVxW3lW+Aaaqd6WzzrvwrYGkxQT4RtfA
	3BBmQnFPh1pozBbZzRpSiSi2pYDMisj5ivdUf2o62T0z9pQoAN0VbyzeJDPMCEBh
	9GMWCKXGY1S0btnPWqjOhCbiVfeyesVLYpoCyHy4AlnuklYNCnyi3n7p96c/KWJz
	0NBYOaMp1othV9bhUfWFCtrvXIvELiKTNZi0jdulIPv+xbxSTnzpFxyjTGtqgshQ
	ESoRl229k+h2oMwT17tC7NbratEQBDn99D6VAgdqfiAEoynyjg3yfHqgOycepTD6
	OwJRygka2urfDO4XXntdAVoS0KGxNs1+TAt/1qyw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq3wxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 15:24:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QF94JW024104;
	Tue, 26 May 2026 15:24:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebs8y9qcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 15:24:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QFNuAF41353556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 15:23:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4D9F20043;
	Tue, 26 May 2026 15:23:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15EC720040;
	Tue, 26 May 2026 15:23:56 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.4.81])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 May 2026 15:23:55 +0000 (GMT)
Date: Tue, 26 May 2026 17:23:54 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Marco Elver <elver@google.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH] s390: Implement _THIS_IP_ using inline asm
Message-ID: <7e2410d2-7f74-416d-a1a3-35ca8ba50c77-agordeev@linux.ibm.com>
References: <20260521122727.142280-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521122727.142280-1-elver@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: fYxTi34cyghUvevhnBCVBh5DBwCuwNyM
X-Proofpoint-ORIG-GUID: iPf1kOrudgh9xMsOUoxAU8_ZlmrH-4HE
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a15bb11 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=mDV3o1hIAAAA:8
 a=NEAV23lmAAAA:8 a=1XWaLZrsAAAA:8 a=kDix7j7DZTOcE0wP3AwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzMCBTYWx0ZWRfXwkDiPSgjn04T
 0cGshxZSoOM2forRxr6f6Eu3cOJXjBpWuUwgsb3GYTjgcpYJF9YY7FP+S+IayOvtzqEunCYykRH
 QJRhlFh6yB9DbHoD3IxITXbBWuLPQxKFq3iZwIYWIWndgkbXbHGTDzVcSvYNrbyssarIq7qbQo0
 +VgsJzaviYUzWioIKJ4ua8zwWZcbXDQZpX5y6/edarDBIpnV+ReiVzb1GwI49n4MYxErDqZdGNN
 GKSVjit/RbiRswHYkwVFJ7et+1Fr3EPIxyQeskP4u4QBEH/1px6UfI2a6OHtgG0UWm5RzwBT7Zl
 jWQ8rzE42axN8gQi37zaX/a3aU4zzF8QQphKZ4EwNSqwqmUZdxlS6R8xGJ5jZnx7IJMhBMxwnbe
 6zQL+ZX8Ow+RWfuEMVK63br351HvYEHruHysO8G4eqjNnHaso/bpg/yt61QL0QRKIA8SJYchbu4
 N6Z125qpPQXhtasmsVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260130

On Thu, May 21, 2026 at 02:27:23PM +0200, Marco Elver wrote:
> Both GCC [1] and Clang [2] consider the generic version of _THIS_IP_ to
> be broken:
> 
>         #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> 
> In particular, the address of a label is only expected to be used with a
> computed goto.
> 
> While the generic version more or less works today, it is known to be
> brittle and may break with current and future optimizations. For
> example, Clang -O2 always returns 1 when this function is inlined:
> 
>         static inline unsigned long get_ip(void)
>         { return ({ __label__ __here; __here: (unsigned long)&&__here; }); }
> 
> Fix it by overriding _THIS_IP_ in <asm/linkage.h> (which is included by
> <linux/instruction_pointer.h>) using an architecture-specific inline asm
> version. Additionally, avoiding taking the address of a label prevents
> compilers from emitting spurious indirect branch targets (e.g. ENDBR or
> BTI) under control-flow integrity schemes.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120071 [1]
> Link: https://github.com/llvm/llvm-project/issues/138272 [2]
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  arch/s390/include/asm/linkage.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/include/asm/linkage.h b/arch/s390/include/asm/linkage.h
> index df3fb7d8227b..1b3ac553a642 100644
> --- a/arch/s390/include/asm/linkage.h
> +++ b/arch/s390/include/asm/linkage.h
> @@ -7,4 +7,6 @@
>  #define __ALIGN .balign CONFIG_FUNCTION_ALIGNMENT, 0x07
>  #define __ALIGN_STR __stringify(__ALIGN)
>  
> +#define _THIS_IP_ ({ unsigned long __ip; asm volatile("larl %0, ." : "=d" (__ip)); __ip; })
> +
>  #endif

Applied, thanks!
