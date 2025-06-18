Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC22857DA
	for <linux-s390@vger.kernel.org>; Wed, 18 Jun 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247005; cv=none; b=E6Ywa0T567MnLeQn1ex16NfTPEjnuqqzwFgq0zL0C8lRKds1GVah8peaHlV+N+ulTpqDp3H5EDc5fsDB9QlCK83zDV6S5vd8VxrgCQ2kPmdg5XP4muV9I8jeJaKbiIqcH5C2iOqX95jeCIspuovPaLqu3MVgRE2J32ofAGk6ZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247005; c=relaxed/simple;
	bh=PXzO0DqCEAMuc9okNRkK7gtwtsBXxaIQT84lVzxsHp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXuNVDowI2DAtbXlgFKipTdUTlPBis1azLox+AR74PiLCb2yalltfgVPPpzgle5hpG/9pBpXWkDVIGpprxG/nptByNngJZZAXb9cGgOKPLD87d++ui2tK1fXaFep6/sXLTK/violHVeQ6ln/ed2R1iDdmYAltOq5Lq2ZgHlUjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oYfnnsCc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oYfnnsCc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I8E5Rx019152
	for <linux-s390@vger.kernel.org>; Wed, 18 Jun 2025 11:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YGW9Z78c5ZPpYQe9xokdiYmnd8OTZD
	C7P43P4PliJ38=; b=oYfnnsCc1yNtmyuffAXWCtv+GaVEMh9ivJH2svxFiCxhTY
	8YZpTLGVUiT0zmozHiU4IOpEOSxvoutIZGIPipeAwAuaXGBwxXv5q6xJwSpJyDo5
	9sQ8BEbyscH5nKD4qkBZhGZtC/e5vdrzicMTHmZLPl5NabWie4j78ZYm4Y+kqIpG
	4vhlUs+/ZbYKomHZs/HvmfC9C/5iGM1hKrZaqcIYV9MndelbhhSFF8LgJtujTv6+
	p5DbTzbJLkcZwYKepbCEKzeb1FhQ3EerEhX7ugINaHUc6zPwcAH3idzeGuj4Qu4j
	h8bQweRAhNY7MD5fNhWdG5vLq2JViFgROvEN9Sgg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygne8y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 18 Jun 2025 11:43:21 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55IBhCrV026321
	for <linux-s390@vger.kernel.org>; Wed, 18 Jun 2025 11:43:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygne8y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 11:43:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55I9GC3T014267;
	Wed, 18 Jun 2025 11:43:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p42gbvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 11:43:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55IBhGLO53608884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:43:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0D9720043;
	Wed, 18 Jun 2025 11:43:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B20720040;
	Wed, 18 Jun 2025 11:43:16 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Jun 2025 11:43:16 +0000 (GMT)
Date: Wed, 18 Jun 2025 13:43:15 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        S390 ML <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] s390/boot: use the full title of the manual for facility
 bits
Message-ID: <aFKmUxi7d33rCvsQ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250616163248.77951-1-xose.vazquez@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616163248.77951-1-xose.vazquez@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NiBTYWx0ZWRfX56u/auZ4ygLp yR1UZ+DKUSPj0yffe7zjqVWERXUvFZI68O4EA9cIokvxfmbOfnubG2ym1gBxx/kr2m+aOH7LtNs WaC41tDQXnc/zVG0DPN7kOwkYhyAxqL9sA7Up28zJvaSRhrhAL+VLi968rvKL7OkTR6ZgSSGJ9n
 fjRnWjpP7mJhZ83c5YD++uwfYlivROW0oXISgtTNsa6qgAL+c5etclMIrYHiDMof3A1kxRyQQM9 kAExPsdA0ASeQcdnsCEI0N8BWtsCsaKn+DFqNqrPvDgspRq2JNDcG0/RSs7YGYGmbzvMGQ0IMRm u5etNsn0KZUcFrmtqHOkT59JVoWIQ52Z8x+kzbJqy5bm4U2sAzUHlo8WqpO9oTPxvccKSjr0zgw
 iUbbZEwFIz6GM7pxoA/YmRr29jSp49uCJv85TYqxNLADDDjkf6LEBwzdMmwzeyQnHaF/8gv2
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=6852a659 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7wVFnhiujdsryNmK0soA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 5raP64lLQEUIl0ZgzRuKu2uquONEXjjO
X-Proofpoint-GUID: 1qSYCBux1HA8B6ibM80oDTWqjp-4mPLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=515 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180096

On Mon, Jun 16, 2025 at 06:32:47PM +0200, Xose Vazquez Perez wrote:
> Also indicate the name of the section where they are listed, because it has a
> length of 2124 pages:
> z/Architecture Principles of Operation - Facility Indications
> 
> The current version is: Fourteenth Edition (May, 2022) SA22-7832-13
> 
> Cc: Heiko Carstens <hca@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:3/4=75%,authored:2/4=50%,added_lines:8/14=57%,removed_lines:41/47=87%)
> Cc: Vasily Gorbik <gor@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/4=25%,authored:1/4=25%,added_lines:5/14=36%,removed_lines:5/47=11%)
> Cc: Alexander Gordeev <agordeev@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/4=25%)
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com> (reviewer:S390 ARCHITECTURE)
> Cc: Sven Schnelle <svens@linux.ibm.com> (reviewer:S390 ARCHITECTURE,commit_signer:2/4=50%)
> Cc: S390 ML <linux-s390@vger.kernel.org> (open list:S390 ARCHITECTURE)
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
> ---
>  arch/s390/boot/als.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reformatted the commit message and applied.

Thanks!
