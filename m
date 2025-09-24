Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E872848B2;
	Wed, 24 Sep 2025 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704638; cv=none; b=W3++CJVnS3uvZb5r/fv28XuEK8gXDojCDhf35EoyFbCpH119Xp4OGWotj+dpIFwEHs3tZBn1wlvPQXfAiVBkY10GBOEKxIMgsmpwHvSd1JxU9CiSWbfXEhpSJAXoY7ip/hG9zDnLHHsuNURnToisHSVSo0aGRe8ztO5AHtbVGIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704638; c=relaxed/simple;
	bh=qg6Gwo5bLTaLAektR6XB5xMkGmF4GaktPpkpxzMUeTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2jk+Nd75nNrPXyXLKwxv5PpYpXu+nwzyhliXo1fJHkuFLd1IhvDD41CobaF+St9n0cOOa2UjyyouL8suZo7EdwxUKr4jx5Xk0ljAhG7ks2ahaGeFytMPCMjkRnkMU07GnYi8m73l+Gi9vQWfyuXOGLuM+qHKir5pQwK5ylcnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kwqkDqQ1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kwqkDqQ1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O02bGJ003988;
	Wed, 24 Sep 2025 09:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xtC9PWGAkLhMybSRETjhAmZEaUTjwz
	eStgYVf7EJiHQ=; b=kwqkDqQ1gMRAdhMArluu+RxwrMehfHQiPmZ9Dard+0Drdo
	Dhogo5ohYjfKfeiI5cDdj8dYQO9fCE6vsP4dMlLoTdSUutLvYwJ3EukmVQlmIJWd
	997vZn6mwSKBhB4PmW4SjpfggcLpx27AdYG8Ua1W7acSW3C0f/fLtKxfVAj6NKcX
	WOVdJV7FvrhqOKj17VwbmPO8Wgxwb1tBM4tntodUxdl9rCLTpu7ZTbDvUkiFyjdC
	oQ3dwkKzqMn98BX/vYn48/38TeY7Uxq9sA+KLUnAsAHtF0jM8RZ4Kx3mWpPYwAtt
	R60ZTjhMLDrWIt3BGu9fwI+q3bqADNF0txo0BXBA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwynq36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 09:03:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58O93bpj013282;
	Wed, 24 Sep 2025 09:03:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwynq30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 09:03:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58O8VZ48008331;
	Wed, 24 Sep 2025 09:03:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yxyy2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 09:03:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58O93W9X51315122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 09:03:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1C3B20043;
	Wed, 24 Sep 2025 09:03:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FBB220040;
	Wed, 24 Sep 2025 09:03:32 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Sep 2025 09:03:32 +0000 (GMT)
Date: Wed, 24 Sep 2025 11:03:30 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] s390: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
Message-ID: <20250924090330.7748Aaf-hca@linux.ibm.com>
References: <20250917153859.363593-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917153859.363593-1-marco.crivellari@suse.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d3b3e9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=R1_GTazKnjilNYR4TU4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: hDw4_CXPXpEB0Hp2Ar6QAy32g6sS15Or
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX6+BkIp08kFr0
 pH8VhgL7zNKjSTQ29MIoSoKYhz7KVme7YSy+b5uiqHKvWFGYyDJiPRaEY+D/rZboUctA86nBCwS
 i0RIS2Az3MS/eLIqmeyzdsr2PApwMTuudxxytdm0Pu2q6qb1mdgd5C2GoZN90LMVWq+bGs+lD5+
 eNOEdOW2U79pFRl0d+vbd8oyw+bchMANoUq0/l8rTUH0W1mjH/wmR8RHwzXFUoP/qwXOouJwORd
 PZ8GOAu1Q/vHXWuroP7qU+9r9wVYsGPGkxbStWwuNeoGHKNdJ1YoOj2bYi2qJ4gWesWAmECr0p4
 hjIW+a53f+h5RglPJYLTJBgapmHhr5pOsq8Zsopv+vlc8aDHMvdkwmX/yRRPfLpKsdnxW1Q7GBA
 JK6W4eSe
X-Proofpoint-ORIG-GUID: 2mLPRkMubomomzoWQ--0Qgc2dOO32JXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015

On Wed, Sep 17, 2025 at 05:38:56PM +0200, Marco Crivellari wrote:
> This patchset is the first stone on a refactoring needed in order to
> address the points aforementioned; it will have a positive impact also
> on the cpu isolation, in the long term, moving away percpu workqueue in
> favor to an unbound model.
...
> ---
> Changes in v2:
> - New in the series, 2/3: arch/s390/kernel/hiperdispatch.c does not benefit from
>   system_wq: this has been converted directly to system_unbound_wq.
> - the others system_wq users are converted to system_percpu_wq in patch 3/3
> 
> 
> Marco Crivellari (3):
>   drivers/s390: WQ_PERCPU added to alloc_workqueue users
>   s390/diag324: replace use of system_wq with system_percpu_wq
>   s390: replace use of system_wq with system_dfl_wq
> 
>  arch/s390/kernel/diag/diag324.c  | 4 ++--
>  arch/s390/kernel/hiperdispatch.c | 2 +-
>  drivers/s390/char/tape_3590.c    | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Series applied, thanks!
