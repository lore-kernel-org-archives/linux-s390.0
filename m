Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235064E73AC;
	Mon, 28 Sep 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609834; cv=none; b=MFSVNXNiJkLkctFcy9cIVgs/nXl9PsNTvI7AUlPfbTumByXgks+Ra4+F63AIixOC9OjAORWf5mwB0AFTUXOGRhmfzkR4zVUdrJSp9cYpO4XGi+jTgmdQRONO4CJCM4YdVrx04bErS6mIt2TTlYj4skK1tJ63oY7Akevv9jV4pPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609834; c=relaxed/simple;
	bh=SPTOmILr1Jqytd9MENU8BCc3uKKPoptUQiPnWqpe29U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fgn1l3uaGWZ8W4HiEkosEze678uiuUbLM8GYwWY2UVKj353sHKvipRNJiOCjRO/oaUw2Z/qNN6dVvQmKHHmnvedy7CLWVEHvw9EmqE9EC/f0gaepr0YkWXpKkAUHGC8V7vutGIlE41bfd9wFaxahSTUHXIYBgGGPS1Kkyj4sgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=srcRUv1c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="srcRUv1c"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SF5nhM1452440;
	Mon, 28 Sep 2026 15:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Fnaw5fa8RjujRI4Fw0fluvs+Y13a4g
	ZRXsLtflWqxis=; b=srcRUv1c2DAnbMf2CckQeO4oTvX+Ho0vyiRvB/4Iwmgl16
	03D2f8W4BaiSQGhqVThjxCSRtN75MdVpzhEa2Ys7u3zYUi8i6xtYp1EtitgXIyrb
	uTQcZAEzMJG/NlNNnvMOzgTJSJrK7670JoddupwoUlTBkJsUWht0gnAvNqEbMA4p
	6TF7ndh7k/qlquU4sVGy44VzZZqoRJF4pXzsLWbqB88kLPRX3ZGbtMR62Yya4mi3
	D7L+ICoDq5e8cjBFkvWOK7zA61KHDYTo9Vcg/9ToMIhwtPMGAqrPmp98JiF8TgPR
	A+w09dDC9iFUo0hvp1IA/YNDayrijA8rjKpddrPw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt1wd7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 15:36:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SElZUx261362;
	Mon, 28 Sep 2026 15:36:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw605t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 15:36:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SFab9437880088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 15:36:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DC5720043;
	Mon, 28 Sep 2026 15:36:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68CFF20040;
	Mon, 28 Sep 2026 15:36:36 +0000 (GMT)
Received: from osiris (unknown [9.87.129.112])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Sep 2026 15:36:36 +0000 (GMT)
Date: Mon, 28 Sep 2026 17:36:57 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 12/29] arm64: sysreg: Convert SPSR_ELx to automatic
 register generation
Message-ID: <20260928153657.428362-A-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-13-seiden@linux.ibm.com>
 <arqC65oRDWQ6GdXb@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arqC65oRDWQ6GdXb@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _z1hOOybbmZNieCRHvBXyjVT2_uOHDOJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX98lod/3sBFaA
 8V+awko8+buc0ItAWCZedr/k2ojJIDn0A7Heuwh8GhW1asPGcg16Uu4hxAq7LaILmuywALd0jnB
 Yk/vqe3jMXAN2uRDb4N+2w+amnNLg9WepOilBuRrDCLyH9p4mnbhM0u5szVBSxd4cAmIgQojisv
 ElOCa1teFlecGVHsM69g1peXPExko2+DhySK6HuUfiVr7Kd0BrKCpoWw9K1nmo9mfL3/+Xs9yZf
 9Z0VJ51+7XazVECSV3H9uH7SHD3CU0pH4aWTAx/qp8ix0eC/S92DFCEr+9PGhf1hHhMklq67LVK
 YHof2iFsE0Uut7OsriFAWxaNenG2J6J0c1YWKG3aiGM7G3BKOKDNWfASYsQiLXwJoMaEbVrxDR1
 XqgI9G2q7AppdE+0JCVnmdgf5xh8qkd/bXImKAM4KfJnSAeOLJ5UPfkO3xjLchMBs7powYzDxgQ
 3RISNodhIj5Za/YL61A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX5n+wcv6NShgV
 abtd/m18G0+TrXubIg63yelzZiA+vsuNBHa/baoQWMQi8s2dTwgdC2mHfsWBrrJaaI19w5t6waO
 DN5pzJ6P7B7jojRG3e+2SirbRSuNJP0=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6aba8991 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=7CQSdrXTAAAA:8
 a=KUox05WIIvyt-1d-WMEA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: _eFy_ikVnOiEq-NUUmMhJ3kKmgiNBy2C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280062

On Mon, Sep 28, 2026 at 04:08:27PM +0100, Catalin Marinas wrote:
> On Fri, Sep 18, 2026 at 03:30:49PM +0200, Steffen Eiden wrote:
> > Convert SPSR_EL{1, 2, 12} to automatic register generation as per
> > DDIO616 2026-06. No functional change.
> 
> What's this document? DDI0616 is the SME spec (also s/DDIO/DDI0/ -
> replace letter O with zero). Maybe use DDI0601 (system registers spec)
> or the Arm ARM, DDI0487.

yes, I used DDI0601. Sorry.

But Arm ARM, DDI0487 will do the job as well.

> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.
