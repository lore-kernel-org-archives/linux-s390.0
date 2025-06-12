Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4723A99F;
	Thu, 12 Jun 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727522; cv=none; b=tRyiDzPXQ7ws8A74qsaoct1IGbGLJbUsivmyjKWLQSA0ixcLCPEXWjSPnojO1+kM1QJCUkqIAya8J472c6cMr3dCQ2nUfngZDoRSSZXRqHgid+eFryeOAh8sYuDom/JujMkwB1iJbuaTYpuw8LZqZRoAM3UU3RzQamzLJq+Dchs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727522; c=relaxed/simple;
	bh=5VZRSU7JzGQqlG5ttPLxdMstrifHZf9JUKXSkh/CuJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cb7G4caIVMPM6/YPq2VTA73Jg0Kjp4zB7IpBJU9E0agBkoBR4WfMWjxNXIdqnfqz8JdbhoU3kW6Q/rc6h6mdPM6Mvcs8aSNTz+dfpXjFPg3DjBAMiR9ppYH54nFAgSt6oYIIo+aLbWwZNbNFf0zKCWgVNIJY4rUYaBvRRhb15+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ntI1wtiH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ntI1wtiH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CAA74e012275;
	Thu, 12 Jun 2025 11:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2AMC/bEjzv39eZGGnud64gi+zqY2Gy
	6AQYpnVFQJ9NI=; b=ntI1wtiHn/hqxY+baL8YNU65U85XzX7YVO5tHLbxJGGqXh
	2FK+Pmne7Iy+kz7fF6RIUTdTO40fJivDQkwesidYjpzrHNkuQu7TtZjtMSwnykAD
	6tThwNvs735Yv2e+GHHZCX2fhqHddMGYRyOUdG0K7t5XFEoILBUafVp6K1BjsPWQ
	b0lVDO3WhRp69dDsxbLkXfTnlwfzFLgPDLrcXdxeeQvlxGvgmYiEMtTnWks3Ih3y
	kzCcOA5QrM2n48GsbCwCNnOjofjG6JDCgbPMmJmCAo/lGpGcmTfOxAtgJ1qEgNZj
	klzn/ykODUW35LYBo6J1A7aD/NX/qauivvSvHSjA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjjewp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:24:52 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55CBOpBR005609;
	Thu, 12 Jun 2025 11:24:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjjewn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:24:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C9TMCs022352;
	Thu, 12 Jun 2025 11:24:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750504k9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:24:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55CBOkgj25494242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 11:24:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D0E720040;
	Thu, 12 Jun 2025 11:24:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70FCF2004B;
	Thu, 12 Jun 2025 11:24:45 +0000 (GMT)
Received: from osiris (unknown [9.87.144.171])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 11:24:45 +0000 (GMT)
Date: Thu, 12 Jun 2025 13:24:44 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH 5/5] mm/alloc_tag: add the CONFIG_ARCH_NEEDS_WEAK_PER_CPU
 macro when statically defining the percpu variable _shared_alloc_tag
Message-ID: <20250612112444.10868E66-hca@linux.ibm.com>
References: <cover.1749715979.git.gehao@kylinos.cn>
 <adcd63180c9492361d929019c60ffa942255988a.1749715979.git.gehao@kylinos.cn>
 <aEqWjSSLB3TPt9CH@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEqWjSSLB3TPt9CH@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Sv26n7mf3EWJevs8xBu8ADqXhqE1AM8t
X-Proofpoint-GUID: CogFJVGLtjbrl2bCisizEvHCcJ_c4YH5
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=684ab904 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=1XWaLZrsAAAA:8 a=uybNw-qwnAclyCFN39wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4NiBTYWx0ZWRfXzbs0KW3AiFNP hCFHSWNqOurrf3COjJlIlankl5U4ZnRZHhog94FLrN37KGhTrq8EhfTAhJNXuw3JeBWQmA2Uxee bbvmRBnsQa4Rt0jIdYxDOQWED70MMnvDBaNmNE7vAKAhA4UOWFZYRF87Zab/IFDqGmQxsrZbZfK
 hU354BsC3OcmSAxGpxBNjwGPS/O2isOcDIOT3fo/TVI5rqnFCEz/FSdJDPT3rQdSMzF48FiP2Oa ChUJDM8sLnH/cNbZKwSbddQre0obvu9do2nnfvjZvI/8rj77f3D1H1jIjx0iVgBOBobBOTtaEE/ JlD9q/FEG8mjmEMmGRwlG7+1dHQbwQULSDCuj3ypfA1NtVmztc4+44lpVH5kT96RV0i5DnJxed8
 4onDv6HrjNpMeBJt5SK2NtAN8ZQ72DDetR9Ol1oD052pZJBvA9JaumbZ+QbVRPx86gXc2x6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120086

On Thu, Jun 12, 2025 at 11:57:49AM +0300, Mike Rapoport wrote:
> On Thu, Jun 12, 2025 at 04:27:30PM +0800, Hao Ge wrote:
> > From: Hao Ge <gehao@kylinos.cn>
> > 
> > Recently discovered this entry while checking kallsyms on ARM64:
> > ffff800083e509c0 D _shared_alloc_tag
> > 
> > If CONFIG_ARCH_NEEDS_WEAK_PER_CPU is not defined(it is only defined for
> > s390 and alpha architectures),there's no need to statically define
> > the percpu variable _shared_alloc_tag. As the number of CPUs
> > increases,the wasted memory will grow correspondingly.
> > 
> > Enclose the definition of _shared_alloc_tag within the
> > CONFIG_ARCH_NEEDS_WEAK_PER_CPU condition.
> > 
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> > ---
> >  lib/alloc_tag.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index c7f602fa7b23..14fd66f26e42 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -24,8 +24,10 @@ static bool mem_profiling_support;
> >  
> >  static struct codetag_type *alloc_tag_cttype;
> >  
> > +#ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU
> 
> It should be enough to add #ifdef ARCH_NEEDS_WEAK_PER_CPU here instead of
> all the churn.

That won't work since ARCH_NEEDS_WEAK_PER_CPU is only defined if MODULE is
also defined, which is not the case for core kernel code like lib/alloc_tag.c.

As a side note: I'm wondering if s390 still needs ARCH_NEEDS_WEAK_PER_CPU due
to all the compiler option changes we had recently. But that's a different
story and independent of this series.
