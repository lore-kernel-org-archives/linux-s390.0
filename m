Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43B3E558E;
	Mon, 30 Mar 2026 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910804; cv=none; b=NY1V5nXFBPEw0I2iE0slAtF7/rw1NoKoUPm2j/cRIr37fU/24FBnn6JrgsS7D1D/fiNcKuVg4kQ7+RJFn0q6u3qZ/k258XlflF/nGWuJeoaj5/w+Xio6hcnAqMoQEw1DqWoKRPJS7POvJbZ1m7cTDeyecb1JRCvSFaB/kTlj+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910804; c=relaxed/simple;
	bh=oGeRyjpDpZk4/Uyb3mgSDrDstArXeDuyuEvF3kMFWaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLVtvkFmhGfuijwoY8PbewAnTM0fCgZ85elYs6X/RbJ9WCe+6+70rVtzMXdYPbnak2QWodTY2gg3Wsx7W+W+yc0twlIZycpSuV476PwIPFovy1jq9XagK+kN8xEhTKG8HQqKIJYkVHVoJfsg2vMWd9IQYOTr3c7g7BRdwDOxZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OViIBhHT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OViIBhHT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UJp3KR2273702;
	Mon, 30 Mar 2026 22:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5ZGxwe27utPhf3+oIGgSJ7l7bt2gra
	X57AUsA5Vn4j0=; b=OViIBhHTeTgMlOJQ7qKKJV9elSMnXSMyFfuWvwi99IfEWI
	DUO26iQ6iaHiOACMUUMsAJ4rFE9sfszKdTlv5kbF5uvf/LYjx7cdhFF7vIbMJ4Al
	mMjxO4S1zQUpj8gbTyt9qa1Ad1uE18LWgOH5WppSDwYgWASamOzpSYBMTr8/LVxZ
	unWyqJWJUg2F+YVW196+FauHtzU0Y6gbjX078N7D431/PzmgdYuBBoAp8f/a78Ic
	Equ2JbkR86+SjkNlRvjkd1ZEJ+egmu640oDvvpzSuRFRe4emkHfb2tlIXZugFam6
	HlobbQ8ZYUt8RpV63F7TINCsBRfMeNMBSScz3Y2Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnguav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 22:46:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UI5pvU021631;
	Mon, 30 Mar 2026 22:46:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6saseura-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 22:46:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UMkMVX39518616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 22:46:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B582004B;
	Mon, 30 Mar 2026 22:46:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0AC420040;
	Mon, 30 Mar 2026 22:46:21 +0000 (GMT)
Received: from localhost (unknown [9.111.25.211])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 30 Mar 2026 22:46:21 +0000 (GMT)
Date: Tue, 31 Mar 2026 00:46:20 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH v3 7/7] mm: switch deferred split shrinker to list_lru -
 [s390] panic in __memcg_list_lru_alloc
Message-ID: <ttcqhx8@ub.hpns>
References: <20260318200352.1039011-1-hannes@cmpxchg.org>
 <20260318200352.1039011-8-hannes@cmpxchg.org>
 <4d3f8d79-3593-47df-9de8-f94f7f09a403@linux.ibm.com>
 <acrf5_rS7hO5Ec0Q@cmpxchg.org>
 <acrjmBx_hX-Aa_SH@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acrjmBx_hX-Aa_SH@cmpxchg.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6ElUKQ1fMxYJidno01eGmkeyMmnHhvd8
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cafd43 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=Pav0MyJ5xd6GPgW7jyoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE5MSBTYWx0ZWRfX9EwLaQFaUtCh
 SV6mlHktBISOTYCdAdngZxGZ9pQiD64Kc3wDXURtmLnOwyCZ679U9wcXtUbzV2vbIet8OQD5Uo9
 6jUCFqO9EEc4bfAOFe8RToM0PetcKrKB3A2wtx+syc7nYrwTZGW/A97JQjc7xsZQnAo7Pjv09o1
 3FZ1bWJa6XuTwACd7UOvxlMcKUumrlTzI/wpkaVhGyQPlj9illdgzVmxeGHsEH8w2Rs2D2D5hTZ
 JFQqGnVLowrCU1WIXRZDkUwxJK5oFgHA5cyBxWY+O9zQs3HyNt9YQrBvXdg+kqkENchlzXr0lym
 BJbl9J5DZf+96IOOS28Y03gSD6oEmHy1qeiDz3a5aCOiX6PryawCs6MzMSa18f8y8KvwdHk+l0s
 Dwn/reKrDRmRdy/dXOtLi4DClySDEmS1qZohawuqmo57Pg2hvZXOeRBEFtOL+k5eSJUxIDzWrLi
 b2sdc6QTWXdSOkm4ETw==
X-Proofpoint-ORIG-GUID: 6ElUKQ1fMxYJidno01eGmkeyMmnHhvd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300191

On Mon, Mar 30, 2026 at 04:56:56PM -0400, Johannes Weiner wrote:
> On Mon, Mar 30, 2026 at 04:41:16PM -0400, Johannes Weiner wrote:
> > Hello Mikhail,
> > 
> > On Mon, Mar 30, 2026 at 06:37:01PM +0200, Mikhail Zaslonko wrote:
> > > with this series in linux-next (since next-20260324) I see a reproducible panic on s390 in the
> > > dump kernel when running NVMe standalone dump (ngdump).
> > > This only happens in the 'capture kernel', normal boot of the same kernel works fine.
> 
> Can you verify whether the kdump kernel boots with
> cgroup_disable=memory?

Yes, that is the only special thing about that dump kernel.
Sorry for not including the command line. x86 crashes more or less the
same way with cgroup_disable=memory. But while I was doing the repro on
x86, you already found the root cause.

> Can you try the below on top of that -next checkout?
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 1ccdd45b1d14..7c7024e33653 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -637,7 +637,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware, struct shrinker *shr
>  	else
>  		lru->shrinker_id = -1;
>  
> -	if (mem_cgroup_kmem_disabled())
> +	if (mem_cgroup_disabled() || mem_cgroup_kmem_disabled())
>  		memcg_aware = false;
>  #endif

Yes, that fixes it for me on s390 and x86. Thank you!
