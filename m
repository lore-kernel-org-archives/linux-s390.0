Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C9378822
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737003; cv=none; b=fhEJdwk7I2kHBhUo2Joq3go6GISLoMn9dYCAPfa6v8EpIeixydAzIAWyWu8ZDP02ue7JIvcDZ1rWj/Vd/kIuNd1Ng8S7wpRY+Q1QxFyBfJN0znie1qIK90AlCSiTIEaIsONAYVj9IBWJaehv15X/JD9lZRAB4MNLxZOYEH8dg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737003; c=relaxed/simple;
	bh=M7ZW9i37DraLNSU2rT4GE8UWW6i3kXO3U7cRdAZlFsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzD33BGgufn02quSAF27OIK9fRMVpzPKxxry7gzOI97FjdvlzryqwuK3e0+DG4ntM010sKuFsHaKIGv13k/2t7tVKEZ+3muTi/y6283hlHaXDQfSAh75Wap9+DBL0vmr/Uo1ZWI20TDWTuiCyG0Q89KPZvqvodCPFjHfvRK8m+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mw3KdtP0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mw3KdtP0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1TqA946100
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 13:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TAFoNfb89NDmZbaQGGM1g2sTXV3YM6
	29pqStJRnVZfc=; b=mw3KdtP0VABrcNY1lSGIiGpFei489FQNkJ/eTdBewTS8jp
	U1Lkcp4SQDXKUt0+Gttsm8oD6rJQJgaJhkbre90eaZ3HpFzaXfCzd0bpLyLJui5h
	3Oj7o+uswZ+MWUnzqhZbu78+UgxlTbRuw6I0YfA43c5sdsVP3im7CqSAsQ3RU0rO
	8CksY2+QjQEvqeieXwso7oDLzgn4A2FGrOpxSsFtVeQpiqY8Ewae5oIGb5uAcItz
	6k6IaidXxeFA2XqPGVXEZg8oXMBYfGR1e46qCV1AmdnapZ51mtc6ynMNp9sGrXRn
	rFMUfbMPFteNGe4hAUWjf8Zp1bb0TStsa2HBWM9Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx848750-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 13:09:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IBrTC01563705
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 13:09:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gs4tv8900-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 13:09:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ID9pco38666700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:09:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C17A20049;
	Fri, 18 Sep 2026 13:09:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5195520040;
	Fri, 18 Sep 2026 13:09:51 +0000 (GMT)
Received: from osiris (unknown [9.111.38.246])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 13:09:51 +0000 (GMT)
Date: Fri, 18 Sep 2026 15:09:50 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH] s390/debug: Reject NULL debug info in debug_dump()
Message-ID: <20260918130950.20386G5f-hca@linux.ibm.com>
References: <20260916165330.2309909-1-zaslonko@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916165330.2309909-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX264FkhOjkbyY
 zEZpwwfEbM1X0b/EmjtN3my+u9BtR3zl1BmPbFfQ+VbBQy1Oll08+9Yy9ec+6/BK93/eKnV6XZV
 YJ09sTzfLlxXgSRe+I2emMtrhZBCkra56XmtDHsk4dewdEiwPpj5w5GWDoWec72IAe2/Zj0ttOA
 N4khxzWHT+saBqxxQPjLeTgnWjAbsXAkicHztvsMILKQTMd4V8E+qBDMEhvapengrFrZXdlTWBN
 IqQu0wzjbtd4WVR01XATmG6NeHDu1yo2M+J3Jm+owqjqZG1RSTpQeLWwsIaCcM4Jd1viwrPTZ1h
 z355zxZcDAQu3HVcAdmEt4qdJPBLw6P++1rwNAyRJWcCuU9cfOgW5reu7aiSo6OpvQJhQG25gDl
 5bvbpCWfxBD3SZ6omy6CgPoBsDienAEml7/NuyZg47UUl+cYlppQAPcrrdczwkpuZSXq92ldXQ8
 5jKfP/T1EtmjQsdb5TA==
X-Proofpoint-ORIG-GUID: t2VPftmgT2XI6DalQRz_zN_pRBr9EXuc
X-Proofpoint-GUID: t2VPftmgT2XI6DalQRz_zN_pRBr9EXuc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfXz16bV/rCK9c3
 Ey31zB3CIuXBamfXGPwZf602KrpnZjoKS35Vp4d37rn3ESUKLPXxaoqGklWJrvWPXJ1LYS9ylMI
 MYMrs7tbWt2eplreomH96q+2x7UeijA=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aad3824 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3qzucv9DT1HE34bQ4SwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180184

On Wed, Sep 16, 2026 at 06:53:30PM +0200, Mikhail Zaslonko wrote:
> debug_dump() passes id on to debug_info_copy(), which dereferences
> in->name unchecked. debug_unregister(), debug_set_size() and
> debug_register_view() guard against a NULL id but debug_dump() does not.
> Nothing reaches this today, but add the check for consistency.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260910110147.96E851F000FF@smtp.kernel.org/
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> ---
>  arch/s390/kernel/debug.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks!
