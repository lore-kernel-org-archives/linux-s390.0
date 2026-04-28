Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574742EEB0;
	Tue, 28 Apr 2026 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380891; cv=none; b=PJlhhHBpIkl4WYR4FpmNrVUz4ay4DcSJVsccj6v50wxFERYyHn8UzWdBKRsIVqmRZWWYLvMhl6anm+tc6IlW1fQwXoZk4JFGeFyAmDm+8MrBjEuTD4sCoubwzq+QSK/6ZT66Xt45yVMHMCNMMh+l20JBoat/rXZ0YXlqj92UM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380891; c=relaxed/simple;
	bh=sub5Xm+Awg+YQ56LST8JEOvdXnPVVwzyJVutk7Q+u8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwJHbJNYCi/c+ynGirc37hiyca7UCl5hCHDNnZoCIAREZZSdXLZ2R1oRUjSCouDfejSYIkF0vlvrKK+KPcmaxB1LFNbbIHmzhbuoO1WwSiSdvUPaaC+zmZLGbAQ7+qeXz3ECGDq4YeisDr+BVW5EpGhL/Hl1sFcjHb8VbVbnBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MUloB3re; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MUloB3re"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6ulRE2943552;
	Tue, 28 Apr 2026 12:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=y80dd9drzvVGuUDZReNRViOHaWqZhm
	aK6M2bGm3GiRo=; b=MUloB3rediUmOgJuzby9cFPPpIwgyCShzEFnpKNHz3Vh77
	/Mu5LJ4OWhiEVhkiZRbX1ow8MaoJ4qhOu1vAafOCehhUUsw0KnNnW8E6SqsrWOpw
	veRqY/8dai3vU8XWYsO0aRbiTg8Y/FMyYZ/iGfpF7GOH0heN+8CpeKdPlRwDAxOi
	7INjUiF8DHd9H9H6m/XS8hy38Av4SUO7UuSeYGeJAccPGq7Cizv03/fQPd4nq9jM
	nTPlW20vBDe16DaSp+ytNruQhM6k7OireGyMRGuJT13sVYcuXnMMnLnU6M1F+2JY
	o01Ld7dlRWw26PNQDm77qfcg/VLJSq7Ivht4/4IQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb55gm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 12:54:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SCcnqk012896;
	Tue, 28 Apr 2026 12:54:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy9ft1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 12:54:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SCsYAS49676660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 12:54:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 349CB2004E;
	Tue, 28 Apr 2026 12:54:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6BAB2004D;
	Tue, 28 Apr 2026 12:54:33 +0000 (GMT)
Received: from osiris (unknown [9.87.148.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Apr 2026 12:54:33 +0000 (GMT)
Date: Tue, 28 Apr 2026 14:54:32 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] s390: remove extra check of task_stack_page()
Message-ID: <20260428125432.10329Ef6-hca@linux.ibm.com>
References: <CGME20260428105633epcas5p37a93b7abb3d2ce0d1c2fbf6a72634ea7@epcas5p3.samsung.com>
 <20260428105607.1283661-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428105607.1283661-1-maninder1.s@samsung.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f0ae0e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=hD80L64hAAAA:8
 a=VnNF1IyMAAAA:8 a=lkM_ilHB-wc5t3v_04UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExOCBTYWx0ZWRfX8vER/gai4mgg
 pOQ496tz2K4DEhXmSbz3ggurLnOnWBg/t91lou/K1sZXFvn+F9ZUQjVyJ0toDRO/xStSErnZTC6
 eEW6faFHU2/DRETNMIqM5ddUyIODKirFJtH3qw0FaRJYe4rfpQm11hJqk0C1FNjzq5Me89JNT+N
 wiqmV4qgD6y0qnMly4lUjc5q59tfcE3mrsf3goAFgfPmkyT/ueirI/HfMMurm8Wu1wEYZ9af1vk
 O05ZEqLqxu1xlSXSu89OCZuQgbp+y0K4x3JPGXPzY70Whhh8xHpFb/xgQtq+EZZ3GJvfBiv5I1n
 +bfELFeuwIx13BTuwdWG0lgR+18yEikOT0KF7ZZ5z6ZYscfNloc/PNvOoRhwSjMcTHqv/BStPnH
 SbYCHLAd9x+OIHfXDeRaLPFt/0P/4jUVgElPPkMC1HJKOgBvNumL/Q7IMXjSVsBZvBIEMZm8fbe
 Imq0brWuAwTJJZrNDlg==
X-Proofpoint-GUID: yQ6bGMJbrHC_3LOGfUI5clq5-HKn0UxJ
X-Proofpoint-ORIG-GUID: yQ6bGMJbrHC_3LOGfUI5clq5-HKn0UxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280118

On Tue, Apr 28, 2026 at 04:26:07PM +0530, Maninder Singh wrote:
> There is no need to call task_stack_page(),
> because try_get_task_stack() already takes care of that.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  arch/s390/kernel/process.c | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
