Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4741448D5;
	Mon, 11 May 2026 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512572; cv=none; b=JEoCpcQB2B/2G4/yqCmTsSvD64z9iWaWw2vu2J8EU0KM92PEh/sOVr2moTB2QQTk4vjfpcd8anL7hu3tvcrCfvutksdU0kuwFrkSN4WIdJHKuIvvKodLgBgBjd8a1HJwmxUN4uKUbP6/J76b4MpHLE9pFKUceboKVvaG4Z0NuhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512572; c=relaxed/simple;
	bh=bvTxOy00YyQesry6yZcnd2STkTxE5x+5rTNkbewO+Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz9QmTJIoH38eHN358qFhbYGr6hrKghWO4ZPgAFxDNXmnp62v5Fk3mX21A55sq20JcXJ1j2PnY9Rb1trJM+sbakxXM4Z3kd8i0gZG6uL27f3XvzGN+45FUyKQymZgrsVPditBJLlEoaH7W9jk7o2/SnIDcOGEMRWR5kkLgkssk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lnfcr7IF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lnfcr7IF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B8aFpI2353419;
	Mon, 11 May 2026 15:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GyYXGuzUvKnnlKGioDqLBqYf8XTz/7
	L0qyXrsajWKHU=; b=Lnfcr7IFUJLi9hHqd6GD0CP37aff+HSFHnXXQi+BbeI2Sw
	DhG+OX8ZM2b4rzOtfuJvgOzcx11QXd+jtb4UfHdbOeqVuysqLdbWqOt7q2FoffYd
	4ebmtmvCf3SXx+MhtjDh1K69ePrkEyOGdo95+KWAMGQYOCUjXiFsehrKin5GhwMu
	aX2+JRULtAxY/k25/sAXNuZasfGNJFKL4IfsGtnC1pmggQqIIv4dOZIiGmk4Bx78
	gCHHVKNhvRnkG03NaH+j2DuEuoiw7JPfw1Mj7iP6LTdiFwg2ZiXpXJ9+s+0XgseC
	CyWUNUnEfZ0Z916cIsj5CNCOoP+eVvDDE+4SX08w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqrwjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 15:16:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BF9R7H022698;
	Mon, 11 May 2026 15:16:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg5nfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 15:16:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BFG42k47579482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 15:16:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B904720043;
	Mon, 11 May 2026 15:16:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85DFF20040;
	Mon, 11 May 2026 15:16:04 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 May 2026 15:16:04 +0000 (GMT)
Date: Mon, 11 May 2026 17:16:03 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        meted@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        akpm@linux-foundation.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390: fix dead defaults for S390_MODULES_SANITY_TEST
 and S390_UNWIND_SELFTEST
Message-ID: <593da9c3-dbbc-47e7-9ebb-964d4bc887e7-agordeev@linux.ibm.com>
References: <20260509195043.1133169-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509195043.1133169-1-julianbraha@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2NiBTYWx0ZWRfX1KdzWoq7UBwB
 pVpJ3FuZcHnTfpZFFtnLnmAR5KnYJpTA334ZkyXC+Y1zZq5TnWxn05D9gGlxE9P7+jx6VG5ajlM
 zVxti9tv4ORT3W3uvEFuYwQq8QHfvDrcHAwvm0V7ANYse1GQSAT5d8zE2xc96iIq1TQ29lRad8l
 uXebT316ZIYnoKh7Q8mQ44Ouifd3ewYwAzh2O0AxpYZjdceoNSmdfbKC+YIC//HSnKgQNTKzdOn
 7c+CD+WgPHIQhSWS9VF9VSqwfphqfKtaLuT2S9I7Tfyxss4g7WCK12wseVc5W40w7/NuKH2rli4
 Umgx+6xBLOHgAX26UF0t5V9+qN5WJ5vfxK0i5TNU5hxG5EPJZnN5036YzGGsyxQyQp217pVyQYp
 sAIyNwHq0Tjxb5fL6ujHLVGj6p5J3PEIkyj3lV5zGJu8ytyYiejSSWNezq/QBvZL1AQMhtA+WcH
 /MRWw1bkhSUfRss8w6w==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a01f2b9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=y_g4XRjoB-AmfD2Nf9UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 3HR1Y9yVcvj-kl0LYZZVFXCubITfEwU_
X-Proofpoint-GUID: 0-82LthPj0CvGnkD0nj6VlLwZW-g4Tb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110166

On Sat, May 09, 2026 at 08:50:43PM +0100, Julian Braha wrote:
> These config options currently have unconditional defaults of 'n' from the
> def_tristate statement, which shadow the later default of
> 'KUNIT_ALL_TESTS', causing it to be dead code.

Please, note that it is Kconfig Language dead code, not kernel one.

> It looks to me like the commit 25d36a85c61b ("s390/test_unwind: convert to KUnit")
> added the KUNIT_ALL_TESTS default to S390_UNWIND_SELFTEST, but mistakenly
> didn't remove the previous 'n' default.
> 
> Then, the later commit 90c5318795ee ("s390/module: test loading modules with a lot of relocations")
> copied the Kconfig layout from S390_UNWIND_SELFTEST when adding the
> S390_MODULES_SANITY_TEST config option, without noticing the existing mistake.

Please, paraphrase the above paragraphs in imperative and honour the
line lengths.

Also, please add this patch and adjust the commit message so it looks
like a s390 selftests config cleanup.

[PATCH] "s390: include S390_KPROBES_SANITY_TEST with KUNIT_ALL_TESTS"
https://lore.kernel.org/linux-s390/20260323125118.1417455-1-julianbraha@gmail.com/


> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
> v2: remove Fixes tags
> Link to v1: https://lore.kernel.org/all/20260414215651.151228-1-julianbraha@gmail.com/

Thanks!
