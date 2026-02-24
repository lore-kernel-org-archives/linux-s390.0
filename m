Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A739B49B;
	Tue, 24 Feb 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938320; cv=none; b=YxGwJ5JprNjYTMOXsMheb1ROuYZBjY6gGl1qExlw1GT72UW8vWmOqu3vhyGTUBoqCc5Gc2+e9+46+vi3yop5AjiRVueNs2fPyilZdbPeCIHP+g2Ogyxx3A5HSTgQjMwgBtxQVhIuTMZ+D2fexfHy4PlJuABsHpTvE4LmWWf+9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938320; c=relaxed/simple;
	bh=TLXO9SsWB13vq7bPCpMwkcE2rX4n2VFTYu6EubhMPOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHLnfHj4fsdEyie4cGMMeceureASx1Fy2mh5HyESzMDtroVxnStT0HPNCH4VUGEIy+LJxF5U3c9fhvPDwzO13jUEwUZDrG8QqR/PWkGfIQSkArgFlcZDI8gmYKk1UW1oug95Tjk92MOMmHM+pgHBNEZGvxSb+XBHhNyX7DKfV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OVtLzw38; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OVtLzw38"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O83maL2345992;
	Tue, 24 Feb 2026 13:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wO64/dkjbW/dvFC/vqTXMyNPJLKJF7
	tJot1AAAqsBp4=; b=OVtLzw386cqqEN37RlRH6SOPVS0YfpM6+NNCREe1cEwYeg
	O7FA3I9ee7WboClZR71kA5J+WFSubxzJC+nE+aJypc3bjKqXgQCeDf/4qTy5SKhr
	ZhTaoJIPi9HIcvAtdUN8Ks8KIcJ6aB5ipwyzjSA7QQXQvsUl7hEtmuy7qpjD9ftr
	fR7lnjFAJTuRe3c0ZX+kDTM29i9GtoqMqLZWyI6Po6asx10ZCZTh6RU0HlnLZqjZ
	7z7LU2cq15D5/dVqRXUbKSvcly+RBU2lFfFWN9v4v/snifEbXfNrG+9nKnyuQnJP
	ubiYhIbCCpi66j+0hwlJSYXTRljAozQhlnGyLidA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858h0m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 13:05:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OCQq3G013438;
	Tue, 24 Feb 2026 13:05:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy118h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 13:05:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61OD4xLB57475566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 13:04:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63BDE2004B;
	Tue, 24 Feb 2026 13:04:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCBA820043;
	Tue, 24 Feb 2026 13:04:58 +0000 (GMT)
Received: from localhost (unknown [9.111.88.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Feb 2026 13:04:58 +0000 (GMT)
Date: Tue, 24 Feb 2026 14:04:57 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH 1/4] mm/page_table_check: Pass mm_struct to
 pxx_user_accessible_page()
Message-ID: <your-ad-here.call-01771938297-ext-2808@work.hours>
References: <cover.1771845678.git.agordeev@linux.ibm.com>
 <68c2f6df2955033cbf1ccbd2b5c2816e72ac345c.1771845678.git.agordeev@linux.ibm.com>
 <20260223101335.aa3696d86341260e03989ac0@linux-foundation.org>
 <cfdc9b3d-06fd-4cc1-b946-076ff1479c66-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfdc9b3d-06fd-4cc1-b946-076ff1479c66-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEwMyBTYWx0ZWRfX82K/iej59Gbi
 jcOJ4LV65vjd++THoXAxHcOdHzl9vxwXul+tKmMciocrWFcM4MzDCiFMma5wnoQRFwQzwk2EUBo
 owgONljOlgoxYQ/sphxEac8MzWSTdSTmmJ1euVadS2kLw2mK651rPT6pc4Y8JUKpz9+kA0i3Qdr
 0NjLoQ/uXZ4ylbetYJiJi3eLDnxuBmvkISzhb5p3iHvDssAio/iJP3IhtlhLBtIntIKgtZ9jvQY
 N9UvSFPPSWb+D7jqlrvouPooEObPd0Ls/OaMZsv0oPQpzoQWIDGhIC9pPsqz8KYKLAxWPGkOYqe
 xvgEJpXH9jQLtd4G6OrmHss4/N8DuG3FasVJOptPVsjLFxrmQpgI9vS48WGLo4GGfHF/pUL//u+
 dzDB3AI8mMgPzjh+Uue9Gm/engWga5K7G9IVgo/bX9fukaUzzkeWhv/HczqOxdZfsFvXjrwQOyl
 SfanzqqZBDLrB1sjlbg==
X-Proofpoint-GUID: -kGng4CI3unx1jXZ8zqVfjNMiflOOOSx
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=699da200 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Z4Rwk6OoAAAA:8
 a=8RkruKr-LY4rosFeA0QA:9 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: -kGng4CI3unx1jXZ8zqVfjNMiflOOOSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240103

On Tue, Feb 24, 2026 at 07:06:28AM +0100, Alexander Gordeev wrote:
> On Mon, Feb 23, 2026 at 10:13:35AM -0800, Andrew Morton wrote:
> > >  arch/arm64/include/asm/pgtable.h |  6 +++---
> > >  arch/riscv/include/asm/pgtable.h |  6 +++---
> > >  arch/x86/include/asm/pgtable.h   |  6 +++---
> > >  mm/page_table_check.c            | 15 ++++++---------
> > >  4 files changed, 15 insertions(+), 18 deletions(-)
> > 
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Thank you, Andrew!
> 
> > I assume this can go into the s390 tree?
> 
> I think so.
> @Vasily?

I've picked it up, thank you!
