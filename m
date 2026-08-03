Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41BE401A38;
	Mon,  3 Aug 2026 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756743; cv=none; b=inOTQwu+0Cbq64EHRmnHB/IRx/1PEvTRFrKROnVnVPOUiqL4PAL/ms8okA+5RU94K8Lp4l1ybSQt8Fti9iD9yZ8Mb0j1eJDPHwfmMTLZURwaYQ84z0tQOSDVCsx2ZTeixlta3SkX8Aes/MJIpqD1/w2lxPxZytLa3JQngikGm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756743; c=relaxed/simple;
	bh=cwnNEFwBgSf0j3qHZHUIxmgsg6LjKcjbotuwnnZFla8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYOm9El4u+7y7OwC0WL9p4T6+niUtfenFHpeU8sOYGepgcD6VkxlT/GTLU5sDAivzF35szxsQPgUgm1l7p3w8+wtB5j6CMa1jm+H0eOtLXAl0B5Oc3Lwc4856xsSOdxJmpoOKNFJOZwbiCsIp2B6VdRoSZP+gLI9ihiOcFfMNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tRADKcL8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tRADKcL8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Llgu4167209;
	Mon, 3 Aug 2026 11:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LtVbvSuBXjK37EiKWKtzc+M2G/g6wv
	6sTQsbFc+thKs=; b=tRADKcL89WwYouQwSfue3HAeGc+0KFFQlt8ttudQJ+gwoT
	Qk7MSLzXiWlmh1JiNPxuP53kmvYpaPewVkyzY8VamjBxFMLwupB10QFt9v2MTrHv
	CHPJ+WGDi6OWnq4bjVXGT1+S9mTdkNY4sTPfps7cxU5u8PmGdm16AVl1qjbQkse7
	tjciNktTy3DsYn901k18qJRYc4SsmksSyAoD+lB9GUYgITv2snvzcAAPioz4wg3I
	M/vB5aulu8XLkkGizzMMBJPOt21athk9FPMPN0ClrKNQD6kzAqCqJMoyfnP9kZ5h
	GpXcWEk3QkXuvWOVU3DhGh+oh5a0bVo1aC1YmiYw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g0a04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 11:32:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673BQKpY021651;
	Mon, 3 Aug 2026 11:32:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jw4m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 11:32:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673BVtoB29688218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 11:31:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 984292004B;
	Mon,  3 Aug 2026 11:31:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F36DF20043;
	Mon,  3 Aug 2026 11:31:54 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Aug 2026 11:31:54 +0000 (GMT)
Date: Mon, 3 Aug 2026 13:31:53 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, llvm@lists.linux.dev,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] s390: Add kCFI support
Message-ID: <ttj6yp5@ub.hpns>
References: <20260727140514.116501-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727140514.116501-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX0+RsWmMmZc0a
 2S2u6hy+sk+he+w/r57W/ARqowhb+DKzOWwkPqc9m1G9bcqmHINHoFezNX5Gf64cjOHUtRtwJKJ
 4IudQuLn0EDhuRGErtVZ7FIPogS+pQWeiOuUNzGRRUQf2PwWkQCseRk5JPiSpmNv0cly1ldHQrp
 aLEOucUiRpC2eMD82+WPANPAVmjHTMYSNK6tSZUumltY7M7cGfRpEsTKiP6o+W1PTo56nKuzBCY
 w4KsCtbx8SpSJ9M4N5iiauxZTBUxV7ni9/uv1N85ptHKLpXtdHP0nIHUtvZrhnJz/qVO64zu+6x
 geuc8EA19GWqmVy2vsLiYv0ghDuNX7sjvh10L/DgnEGSYvfrRLGEZ8yvV8cgW67fhorcWawZ4Dj
 SrNh8gySljOkPT2yIgGyAZOwW7qB5tBQr1BNlODiTNsiAt920/Lc2qgx/5JdEr0bTSTexABAfaO
 zyfU/d35u9GDjtzJ76A==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a707c33 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=iaD2VS8y51Av8r_WQYEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: S5Yxxw9XBRsJyYqAAF0aNjAGA9Youc-a
X-Proofpoint-ORIG-GUID: dqxDAyJQK-Pp7rMXWZvQv9Ftv1oBawp7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX+ICqe7BwLuwU
 vX60jDd02PqQOIEUMy2opcpdiQp+g3Ax/Itv+CvTtgb7TaeA+CPOo+pHvtOtI6C8OWrmOjUK/0P
 R9N75l7zUB8UyYZlclPMSy9P6Mx78wE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030101

On Mon, Jul 27, 2026 at 04:05:07PM +0200, Heiko Carstens wrote:
> Heiko Carstens (6):
>   s390/tools: Pass symbol name to do_relocs()
>   s390/tools/relocs: Ignore __kcfi_typeid_ relocations
>   s390: Add ftrace_stub_graph
>   s390/diag: Generate CFI type information for assembly functions
>   s390/bpf: Add kCFI support
>   s390/Kconfig: Select ARCH_SUPPORTS_CFI
> 
>  arch/s390/Kconfig               |   2 +
>  arch/s390/include/asm/cfi.h     |   7 ++
>  arch/s390/kernel/mcount.S       |   9 +-
>  arch/s390/kernel/text_amode31.S |  13 +--
>  arch/s390/net/bpf_jit_comp.c    |  28 +++++-
>  arch/s390/tools/relocs.c        | 158 +++++++++++++++++++++++++++++++-
>  6 files changed, 203 insertions(+), 14 deletions(-)
>  create mode 100644 arch/s390/include/asm/cfi.h

Applied, thank you!
