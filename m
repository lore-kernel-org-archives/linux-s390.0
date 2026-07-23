Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7844DB7B
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815440; cv=none; b=B8JxmoHg0x96Q0HIaEF5v//18n716a76LBe3tx98pY05vClm+0xXzZ4xPGdy+fasaO5Mn9MwAMZE16swXog3wuLS9q6o9C+DEVsduw4MSLN4gBTK+cjRg35gpQmqKeN+f/1JcBBFJ9h+XKayN11eN3g3WK2qfWXFa3187vWOlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815440; c=relaxed/simple;
	bh=ZBFegY2McFd58xKRL9lnD0XZoKpqN0CYJirPRnTX6vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpLEdl571e7o75px9tsTF2rD9Q+mYSKtJ+Q3rcUgeIM0cX+8zJEcVeoWaxPfq5aJ1Yic0DsP+QJLpsBCAMAxQGUrMh9yDM0AfhOPR7sIHmCqGnyZ8pz7/bRQAAf1yMwhfy/s0/SveTKeLvemO2nqcF9WKN/xbTPDsB4lPxfUv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VLp8xCBu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VLp8xCBu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBiSU3094728
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XfIyViuTTwhiqqOkUsk+grhtTS9VSK
	xuD2B4Tn89jdg=; b=VLp8xCBufmdKM7+wpEnzZcR5NVL5dUBXhj1BE4oaBmYWyp
	84AcyJoBLAscn/gDU0PtseOBMqk5xWqPrYEP4flAmO4MLgA0n8d0g00WayI5eiGD
	pfLcSVauKhiA1dLi7Q/IzktyaoYHwIB8/M63cR9Hj37KTSADp518X7nSF7jacHjq
	ols2I+BEab2sm7uopx5WYr17VhNOz0FCkNXkTLG8NvolQ1z5jLDVU5VZYVj3exMl
	DQL4hyG2xO8LLIYdA6NyAJYnOmFgMXmIF5tGYCDZLZGShlEHl8k4JaFWK0BswpXG
	zSLw3+VsSLG2+RAgOA92fuBwcZ+D69x5Jqu5XZAA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahf9pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:03:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDnjLw006571
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:03:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahce5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:03:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NE3q1P30605884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 14:03:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A20DC2010F;
	Thu, 23 Jul 2026 14:03:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42873200FF;
	Thu, 23 Jul 2026 14:03:28 +0000 (GMT)
Received: from osiris (unknown [9.111.90.204])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Jul 2026 14:03:28 +0000 (GMT)
Date: Thu, 23 Jul 2026 16:03:26 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/smp: Reflect (de)configured CPUs to cpu_enabled_mask
Message-ID: <20260723140326.27454Ef4-hca@linux.ibm.com>
References: <20260723-enabled_cpus-v1-1-3a2cbdc374b0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-enabled_cpus-v1-1-3a2cbdc374b0@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c8jDiL7TQKV1glGeIoqq0gHhdAX6I-od
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX6LjtqHZ5ap3Y
 Xa+w620QXIvnpuyeNV7rEOnWrYadmxpkZBFlXbqVcBT5ZyZM6imTS4eXvilxpb7muN0a9ZDLSUi
 +jR/xug7BBA0RPph2iHBWYOb9LvAazm6g+utj91OlYW0Gbw88kxxgCVy9pq0tL6HLBTH15uk/Uu
 YqFXw4Yqb8N/Dna2fI3seKO4YvXoqYcB2PUC2sPb1mifVzUmXMERwftli6XQiK/G0tH7cgmO9d2
 +7d50WVGRtK8rJeyClhAOSUxw5gnqXUYeTaYCvdZfkDUPlHz/sxXl5vYQ6wAnxWcVw2hc2C0vgz
 YHIW/R1INrG4avoFBPPjh7S2Xy3/VItN1tFSxDbIhG+3uZyXby5AzfhOBTd2PVQ5uSa4WWhItQe
 jkngtOAKO1uxuIlRQCWuyGs7N5hFnNBLOJ2gGJQUG7J0bKwEgzv18pg/FOkfNh9MrL2Ycog7/KD
 8M1769DpdC0gVTu6sNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX9cPPtP4xzpU2
 rmwgOqFKZ0hJjNKJgqEQKhPHBPVA47K90gEwuELJBKWo7O2KRzMNvI8G8YniUbx7NdfU8Ugxq/l
 GZg2W4YV2lodC+d6cSd6YIXPF0smqwY=
X-Proofpoint-GUID: c8jDiL7TQKV1glGeIoqq0gHhdAX6I-od
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a621f4d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=dxUnBXBTGvNPyM1y3QAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

On Thu, Jul 23, 2026 at 03:36:43PM +0200, Mete Durlu wrote:
> On s390, CPUs can be in a state where it is not possible to hotplug
> them online before certain prequisite steps. For example the CPUs which
> get introduced during runtime of a system can posses a "deconfigured"
> state which prevents them from being hotplugged online before they get
> configured. Another case is when users set the configured state of CPUs
> themselves via "chcpu" or sysfs attributes.
> 
> On s390 available CPUs are being registered as new devices via
> smp_add_core() either during boot or after a CPU rescan (for newly added
> CPUs during runtime). Registered CPUs are marked as enabled without
> considering the configure states. Add necessary checks to smp_add_core()
> and userspace configure attribute handler. Reflect the configured CPUs
> to cpu_enabled_mask to correctly represent which CPUs can be hotplugged
> online.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  arch/s390/kernel/smp.c | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
