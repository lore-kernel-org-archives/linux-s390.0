Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E401E5B62;
	Thu, 10 Apr 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298700; cv=none; b=gr1fHtVTyo7n9QOJZF/vg0zS/SWrD2GylqAJCK+oChch+/5CdToktUdhpUNHBW2ft7ngPP57l6jAsIp5PBzze51bU+7bwEuigPyfKkAywM9zFWvfkgaV8YRVAjkGX5aVHfcZnfnSY4HvlWCQEHrylB1d6xOi+lEq1hSNN6ghzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298700; c=relaxed/simple;
	bh=dLxovfnN/CwhNGkl703NZ4ZwXYtiPe/6MR4W5H+oTug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJvkllOqLYUTwEI7tm2xb/QKBtL+5KiDVx5BECwrXM7cClA7SHesveegKioxHNEfh7GI5+Gs7qH/SsD9doUgeMIfKqODvjS4a00rGvsAzlXlH7uTJiaEf9Hg1v4ZOzs4WGun/2NHRAdg8dpWcFPzddp6HzzlYNHkBbZIP09NyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qqlAspbA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qqlAspbA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AE3LUc010696;
	Thu, 10 Apr 2025 15:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=oX/bUdv4ulubAeUp4kEtb13gSWpHCj
	CweTWlfyCzCwk=; b=qqlAspbAAVWK4gbwQwaQj2nIIBmUtv1aci6HspxQxg/kHB
	2TOL8bbRr4UtmMDL0fRCPwUIxgzTl4sVcYgLWQhzFbg/oG3mWPAdq5i3Kj71Nxmg
	ozeYvPqE4elh06vTS8hWkChRbngBgw+x7u0N9IcFT64WIsvQbYAu1uDZ7F75GYVt
	sIGl1F9tMv+/ThvIZR4nUI19XbS+11LcJks+LVq95POuhSfebLtcGXZqQb46Wnbf
	Z5/ms3JDK5ZbIFj0DIPH/Iphos7wFSuelwaMjjRSEYpV1VSIMU2vUSIGz3nkorSU
	9mE7ZHfhc5kocR9HcpdRrIGZ7VwTUaTc8c0IJ21Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xfdqger5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 15:24:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ADGUXx025598;
	Thu, 10 Apr 2025 15:24:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbm6j40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 15:24:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AFOpf434538128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 15:24:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECE2420043;
	Thu, 10 Apr 2025 15:24:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF2E620040;
	Thu, 10 Apr 2025 15:24:50 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Apr 2025 15:24:50 +0000 (GMT)
Date: Thu, 10 Apr 2025 17:24:49 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: Allow detection of wrong
 arch_enter_lazy_mmu_mode() context
Message-ID: <Z/fiwRdmczI8f3nt@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1744129955.git.agordeev@linux.ibm.com>
 <18bf936f63e0d1e53d8291a3bc2ee2c577876d9c.1744129955.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18bf936f63e0d1e53d8291a3bc2ee2c577876d9c.1744129955.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -FkBRIrGRA2h2cwc0q47YxegGQLhwxPM
X-Proofpoint-ORIG-GUID: -FkBRIrGRA2h2cwc0q47YxegGQLhwxPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=770
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100109

On Tue, Apr 08, 2025 at 06:48:31PM +0200, Alexander Gordeev wrote:
> The lazy MMU batching may be only be entered and left under the
> protection of the page table locks for all page tables which may
> be modified. Yet, there were cases arch_enter_lazy_mmu_mode()
> was called without the locks taken, e.g. commit b9ef323ea168
> ("powerpc/64s: Disable preemption in hash lazy mmu mode").
> 
> Make default arch_enter|leave|flush_lazy_mmu_mode() callbacks
> complain at least in case the preemption is enabled to detect
> wrong contexts.
> 
> Most platforms do not implement the callbacks, so to aovid a
> performance impact allow the complaint when CONFIG_DEBUG_VM
> option is enabled only.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  include/linux/pgtable.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Andrew,

Following [1] comment to "[PATCH v2 3/3] mm: Protect kernel pgtables in
apply_to_pte_range()" I think this patch should also be dropped.

1. https://lore.kernel.org/all/Z%2FfauW5hDSt+ciwr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com/

Thanks!
