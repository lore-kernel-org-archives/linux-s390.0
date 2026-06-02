Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4A3DBD55;
	Tue,  2 Jun 2026 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400095; cv=none; b=CJlFT5ROUVJFDKI13iw8lOLXne2Pdq5ucxecgs3ER3eNw8fvccZO5Axd94sQ52/INo8nSvDfF5YgvmY7llODf1Pllsr+iD/C9m8NsK9C0Wnhka9GL3oyrJ/Azpq5J4bi6LDIKTiLI+uApQSFhmcmpH/QctTLuJRuDEoPeo3Zig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400095; c=relaxed/simple;
	bh=3sSWfEUN+CyzKYcS5xttq4O+ZfFhH77QLGRxJtXfMa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8ajWGBopdtMjOAtOVSnYZeAMJC6JNOTCf10MQBWNpYgS+91tk4Eu1j/sLUS75Uq7l2bW6A8K2XrHLz/BOGmto+KzgYvofQFHu12soWLRV30pc/1OOFxI+Sc+EwY8oiwOaJSLJOZ2DpVm1dzgrQLbiZ0lRV6lCS77KvNwU3mjGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lPVaDd2y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lPVaDd2y"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651NhBDE065560;
	Tue, 2 Jun 2026 11:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iiDQglSxJHAhGLlng6vWJWEiK7rco7
	KBZjOMO6SDYzM=; b=lPVaDd2yPWJgdWgj3l3Mz3fiqjQyLt6jaEuWTv5r1YAxNC
	F0RmMr39trTUL0LpUUMyYMERrnpbb08Sr7k9hd6swNKLFSCv4083Ik0GsHfGkYJQ
	jPC26whE9Kyx4wo7YdLnKfk5plyuyx7bmTP9xRLNZIOl6a20pK5pUUlSQJJFSXR2
	n807wv+JLcl+xgLlbXuRgdt1WOrzfhUv17Xo9h/dd6dfTe5bLT8ui23pJqNBZ2kc
	NAvgQIGSOe8LYaebRzeYkdkx4ku+0wiv67xseWi3RQZ3SIa0AQldVj6od4FC8idv
	qI0rkFZU8eTJkOiKjrFTuEekCVUBpXOqPWADmnMA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4wm2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:34:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652BO5VG032379;
	Tue, 2 Jun 2026 11:34:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegjs3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:34:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652BYl1550070010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 11:34:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32C1820043;
	Tue,  2 Jun 2026 11:34:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA2F220040;
	Tue,  2 Jun 2026 11:34:46 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.22.2])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 11:34:46 +0000 (GMT)
Date: Tue, 2 Jun 2026 13:34:45 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 4/7] s390/percpu: Use new percpu code section for
 arch_this_cpu_add_return()
Message-ID: <bf782cea-29d5-493b-b1f0-81c9173e7ff9-agordeev@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-5-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526055702.1429061-5-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Azqqy_YCzmyImrfjJT3yJ-0aozLL45xA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEwNiBTYWx0ZWRfXw7Mnp4uRWjsY
 99l0W2mi/HOSadK9bsRjaWRsvqfZTurWrXrs6PbdLoqbaicpCkzLumscqn2u+hCiGaxy0Yu3FgT
 tBALNKSMfgvXRb8b+z6E0ZqMDNmL9iSOo51OPx7JnzyRLvHR9uZOPSaLvsQtfy5aSgGkVO0Rclh
 dcGRsa6iK0jJ4Y8VXzU8DJ6RJtZukC9eWLq2GSuXL33ClR2BB+tFOH/DsVZruW+QJgQ4VYCR+zz
 R4qPxAJIWjhLt7EJhXiawFLtKlLfNpSXmSLfoJZqgIVPFV8bcsNDYJ4Wff93uKOBQbBlHVz37lF
 U8a+7Wfqxwlh2hgbPvhnP/g0V8Cws+rCrvHxC0hMtT2Nbu/gaDaEX/IWEJJS4t1jvtSh8Y+7ygi
 1ECxcfC7sgBvy0R9SNxrAM3O77tVeNNuZoyNJX7YZWDTar/WNWluwK3IczJm2T0m8nWpuUBHMeD
 dMXKhEX9/CZHp56ephA==
X-Proofpoint-ORIG-GUID: Azqqy_YCzmyImrfjJT3yJ-0aozLL45xA
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1ebfdb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=RgTNVsn8aNFh4s-J9MIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020106

On Tue, May 26, 2026 at 07:56:59AM +0200, Heiko Carstens wrote:
> Convert arch_this_cpu_add_return() to make use of the new percpu code
> section infrastructure.
> 
> With this the text size of the kernel image is reduced by ~4k
> (defconfig). Also 66 generated preempt_schedule_notrace() function
> calls within the kernel image (modules not counted) are removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/percpu.h | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
