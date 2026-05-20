Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D332AAC6;
	Wed, 20 May 2026 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279342; cv=none; b=QmGiDuVt2Nr8dWiKoYdL3aiR5Dpj25DkR5Medh6FmNs0R3uiOZ+iUGlVrXTQ4MzKTUCHXUSfHvEtPEiW2DWR2iDIodGr++POmNZhywk6ij06NDIjvTDNPwIjXcsa90zBA0HcONFJTtL0smoFjWzSfGRkrEMHaP403ZHdjldX+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279342; c=relaxed/simple;
	bh=f/T2PeXW9wc7BHOLi3Vhvg0R6ZqFUUdz4UBG+p54z4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs1sLf9HIINkV/0oUNYlx1IZUu9iWFvznmiiSDUnzGnsQwBJ6ih1AbChIIneQEnmTtLmWzr2dEzPpkE789hH8AZozgKtapJc/KwWJoRzVC85OYtwxQeS5/j1A+GGMAdP5foQmiBUifLIt+S/Ytn6mxGyxfCGlZS5/OvwdqQld9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RZvFznAE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RZvFznAE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K8u5nA1853987;
	Wed, 20 May 2026 12:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PxoWntdEnXNof82uV6Z9BhIQfNiQv+
	+UpIhkoUT4ikA=; b=RZvFznAEWpGp/4rxJu5PaKsHV90efovA3RRHTyc9oaDPTz
	EzsmyvR7leyg677Z5W4VtPE6kvGBONwh6kWFsM6WmaEwtFH+B8ClMb3sbhTLYHb6
	y1HEDdcnDaeQnKd/zneQNxeE8sGylV2wuDt7eqh8IklLIiLFgT3YjdW8GZXOhLlk
	kSnopkIJltYEzuzM1a6PwWiQcvprdGJPKiHYMDorjlWKcd0NiP3Qrz2+eW2zS6ho
	tvFfvFcqkkqEo5RtyIMJwBLEnd50OVA2M/0X5hnv+uOOoSmJ8QJW7xcs5ZpMrHvw
	brEbKpSfHbAbXNOYnWlub5NV95rPh/6IM1qssHLg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8gx27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 12:15:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KC95sX002325;
	Wed, 20 May 2026 12:15:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk78bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 12:15:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KCFYAM60817772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 12:15:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 543402004B;
	Wed, 20 May 2026 12:15:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 297CB20043;
	Wed, 20 May 2026 12:15:34 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 May 2026 12:15:34 +0000 (GMT)
Date: Wed, 20 May 2026 14:15:32 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        meted@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        akpm@linux-foundation.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: cleanup kconfig defaults for selftests
Message-ID: <ae8f5fd8-456a-454d-93b9-cae8c03a4677-agordeev@linux.ibm.com>
References: <20260512174336.907050-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512174336.907050-1-julianbraha@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDExNyBTYWx0ZWRfXzLfClthbFFNi
 PnAarrePFILrf2NIQU8vdoifKJGITkfl8YmFzLkY9C1y6yGvZ0Ms5/9WkpO4ztCl3HTTyGCRbXJ
 +lR2D/hlN8nCrcyA3IxVLscK3qRPHjWvUCqEB6i9c0BsEykm/9h018rIai5/UfxxGyczxI78w+L
 DLjBUsPULmNjazFVao6h+JL4PLW/emlKc6srx2Fx/cWK5bvwMlcs2ZqfZ9+eNY+h5M68OE9cOLE
 9YN5pX6DMWYNEv4AKVQdkIXyKuRk/qYV8EKj6MyAz3plhUByhpxlEIcogGjGXxmQILX/KzY6QXr
 QoKsx4hQ4XXHHlYf9H/ZsTHpO6czlWVr8TVderE2PPipwSekARKA2iJAnMTWiB6xpycnIeg1GXs
 TW3e0/2FK9PXXwjOysfP13+tGZut165OO1vl7BQnLNsm2P4hZuX8AHijw3gtR0UqfS6XML8zFve
 YngLotFRh2fgFFORAWQ==
X-Proofpoint-GUID: k4ejR5R8IMUh_1G6BVb08eGm2WHSgzQX
X-Proofpoint-ORIG-GUID: nhPWsW4zPm6LQKlYDRDfhMIXW9k9aqBY
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0da5eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=Gwd7sisTJMT39k_OoesA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200117

On Tue, May 12, 2026 at 06:43:36PM +0100, Julian Braha wrote:
> Remove the unconditional defaults of 'n' from the def_tristate statements,
> which shadow the later 'KUNIT_ALL_TESTS' default, causing it to be dead
> kconfig code.
> 
> Also, include S390_KPROBES_SANITY_TEST in KUNIT_ALL_TESTS.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  arch/s390/Kconfig | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied, thanks!
