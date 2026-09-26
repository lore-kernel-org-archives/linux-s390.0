Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA813955C7;
	Sat, 26 Sep 2026 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405620; cv=none; b=aoh1lY3KWM8MjR/2DSclaFC3tv/1015vYFmrfBbT8HVugcvtvJ6zhdrZXgpurc1h+uFnU0YSArWWJ8pkHfViyrU2OwaBMl++8vs8OxBzxP22QDKWf5p0AUlGSAfaggXDKunsd2r9WYVonnOYTQVBLsOZIxqlvIA9HmqsUbKYLbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405620; c=relaxed/simple;
	bh=IgFSX+NT5ixZXRvozc6pj+ZX5W/v6azRk8t1fgoTluY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTXTyvm+hntR/nCa3GAf6o4bTsticQjQiwK0H1hxAabgGB4G4s8a+ge9o4uDgZaC40gH7NxCg/D51A19BrXvjwdWAdk8R0p5da9Ob72CleS3WLI2p+C1QVhopfxRS60mdezjuQIjYbHJcdU3QAP7Far2022Wy1SXoCVG0w2WtB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ftTSIZ7m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ftTSIZ7m"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68Q6ZS5O3249832;
	Sat, 26 Sep 2026 06:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Flwsh5G3bwDuiOqhNx7WwQBsds6csD
	PfrslBfrpgMII=; b=ftTSIZ7m5EoCCDGSwhzevkyxUdWHNvXBhuYQjzKL+vB/f9
	mUVx8ZfC2PFm2jklrfDw/Fov4MOHXPJ67ILqvDT/kdELAryEA2HoXQ+ceo+YN/9W
	CoD45t/EafdIedPSqVO0zbt9B2DiArlXqalJs1YegowjG0xtA/RhEyoXe4kkYlF4
	ehES+QnygD5tXRsA/0AOoJWmifymZ9ymxoarghGX/CDfj4UavxLvKu8Tw0XA77eI
	XviciC79l/+cr8AvQs2V+R/zO0UZRERP1h37YHfb/DwFtnup4eDuec1h93RI5Wa8
	KXNx6E6YuNY5EjkYwcYa/6DYvaq6dQhlZn55aXHA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5psrja0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 26 Sep 2026 06:53:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68Q6WdEI880571;
	Sat, 26 Sep 2026 06:53:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu95ck2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Sep 2026 06:53:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68Q6rMlq51904770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 06:53:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F42C20043;
	Sat, 26 Sep 2026 06:53:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 181E220040;
	Sat, 26 Sep 2026 06:53:22 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.0.32])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 26 Sep 2026 06:53:22 +0000 (GMT)
Date: Sat, 26 Sep 2026 08:53:20 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 00/11] s390: More this_cpu_*() changes
Message-ID: <1b8c8ce7-4a1a-4b76-ac3c-4b0bbd97965f-agordeev@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921155806.2447506-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sueQVPxIUgR9MUBbGoXMr72KyEsBf_qo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAyNiBTYWx0ZWRfXzpKynrCKeamM
 QmziJYN9r6Bv96y9aAgXHn1Pvs/2X5SgKp9aPLYIpaYUwzeRiRPkJyg6hBuxFXXE1HBESACZ18U
 hxqVQytB8jSIC0K8th9m8elZxVxCYCAwdj95mJtfB6qfTe5dPiM9xwSlaqPsWy0em3wnCQvJLZj
 UX4ELz12oE6aHi9iaIUVwCyQL37cO9hWmtqd0izJQwBQg9eXoWDyCQxNxlnXOA4v5UvVoncGWMS
 06XeSkXd8SxtuU2K8UYq/kEuZvGp8K016WB1Dx6sJXfGvn/yuND4BISosCqJA1vUl3WZEItNcdm
 q7gLe7lilRn02U/T+AjN1JocnXC1w8r+w8Au2/1wO9jZHaFYD5J1/HVvaeUtNmsrPWsINdRqXch
 T0ryovY+tRSrQwePJ+n7g7+GFfuVEt2Rmz1PiR4TlyU7Fr29gBccvNOYlLpvIzYNapY79qMJQhw
 PevVnJqAXugsqjyBmOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAyNiBTYWx0ZWRfX1T2niC1+Vj5p
 M9JdBpemTQQBWGvOi9v+hzYTMig4ciXBXBXF9VKlyP40Sx7ZyDOgqR2a6Nd1ggodKjjogwwiJDt
 1FGa5Q+hrpPC7pFKz9Eykks4wKZDD1k=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6ab76be7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=B12lUmBzN89-n_Us6HUA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: sueQVPxIUgR9MUBbGoXMr72KyEsBf_qo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260026

On Mon, Sep 21, 2026 at 05:57:54PM +0200, Heiko Carstens wrote:
...
> Most of this is only about cleaning up the percpu code after preemptible
> this_cpu_*() operations have been implemented. The first ten patches are
> all more or less trivial cleanup patches trying to make the code shorter
> and more readable.
> 
> The only non-trivial patch is the last one, which converts s390's
> this_cpu_*() operations to use a similar scheme like Mark Rutland
> provided it for arm64 [1]. This allows to simplify the irq entry and exit
> path, however at the cost of slightly worse code for this_cpu_*()
> operations.
> 
> The simplified irq entry and exit code seems to be worth it. Usable

To me it absolutely worth it!

> performance numbers are not available yet, however I don't expect big
> difference to before.
> 
> [1] https://lore.kernel.org/all/20260904161758.376504-1-mark.rutland@arm.com/
> 
> Thanks,
> Heiko
> 
> Heiko Carstens (11):
>   s390/percpu: Fix comment typo
>   s390/percpu: Add sanity check to GEN_MVIY macro
>   s390/lowcore: Remove _AC() from LOWCORE_ALT_ADDRESS
>   s390/percpu: Let MVIY_PERCPU() calculate alternative displacement
>   s390/percpu/lowcore: Add and use LC_PERCPU lowcore offset defines
>   s390/percpu: Rename inline assembly symbolic names
>   s390/percpu: Use __PCPU_BEGIN() and __PCPU_END() for inline assemblies
>   s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
>   s390/percpu: Use percpu code section for this_cpu_xchg()
>   s390/percpu: Use percpu code section for this_cpu_cmpxchg()
>   s390/percpu: Rework to simplify percpu_entry() and percpu_exit()
> 
>  arch/s390/include/asm/entry-percpu.h |  71 ++----
>  arch/s390/include/asm/lowcore.h      |   5 +-
>  arch/s390/include/asm/percpu.h       | 354 +++++++++++++++++----------
>  arch/s390/kernel/irq.c               |  10 +-
>  arch/s390/kernel/nmi.c               |   4 +-
>  arch/s390/kernel/traps.c             |   4 +-
>  6 files changed, 248 insertions(+), 200 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
