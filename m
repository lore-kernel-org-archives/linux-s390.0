Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2C3B5850;
	Tue,  6 Oct 2026 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287589; cv=none; b=bE4mda7PPl3m8uS7RNyBOZlJ+jSmEPPBvyShulHcnyG9XtBgl8rZAx5Sfcgj7bfMeuPtTiI6QarPz6tHclJ0visDtb1UafWcjfq6/THKRZAzW0EUMd7Gjy752xek408fC4pgSVar91XAvFq4JMPDbmv/y/c3EcRenZ/jnP183eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287589; c=relaxed/simple;
	bh=9i6foN6yjLIryG0kWvbO1cvvwfaRFDLwaupi5jqhNNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb5nbqjw0zCX5YsJ9ocAI1qpbbilFlY4blkaiCFzaetEy/v+JZy2+9SjFTyjO3A3lYRGEDOtp0UuOTcl+HFQOx5ThP6UFqVdS2WDz6c//Mqd45H+2yqpK6bAuZrpR407zObbn3tMPTdcrKjrpwB5fFN7PImh6hInLwFexaZzZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=datM5ADT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="datM5ADT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BZTlP1804981;
	Tue, 6 Oct 2026 11:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=954Jsb
	TOOUk3tY9TKB0IeH9UR3cz+9GCBY1g7xl1Qeg=; b=datM5ADT5NzCSa3QFrVdFH
	a3uH8xL5UxZQhp1YAlh5dtwqWP0hUkDFCo05q1DBsdLXIToF+EX9qDvzL7mDNdsY
	JspjMhb4uhU8cQm8MJhoaYwJKyI7tSIaNSD3feNYoxiAV5eN+b7ZZySVYl/mgxce
	kQTD93MeFbPKKlhEXYCBLqxhyTLl9af2pZQ6CpJkpFtBt7k/J1r1xDNC6kiX+l0n
	gp/sA0mKh+nLnTL0BXNPAihgvFzCoqnK2w6ODpvr27hSzMiq3K5IfvkaOBA0fac9
	DzPrzUWEhM0NYhikSNUD2eXNbWXRWt7RC+LEPczS+MDmcbCQsEsXJMcP6rLELQjQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrfq2x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 11:53:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696BWZ4M203605;
	Tue, 6 Oct 2026 11:53:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jsq9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 11:53:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696Br20621561968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 11:53:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E5E420043;
	Tue,  6 Oct 2026 11:53:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FAFC20040;
	Tue,  6 Oct 2026 11:53:02 +0000 (GMT)
Received: from li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com (unknown [9.111.61.88])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 11:53:02 +0000 (GMT)
Date: Tue, 6 Oct 2026 13:53:00 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/cpum_cf: Honor hwctr session cpu mask during
 hotplug
Message-ID: <asThHGuWXOWS2XvQ@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
References: <20261006111304.4023017-1-sumanthk@linux.ibm.com>
 <20261006111304.4023017-3-sumanthk@linux.ibm.com>
 <20261006112418.5D1021F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006112418.5D1021F00893@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NiBTYWx0ZWRfX3xtbtPDSEj5U
 Tq4JtNHd2powx+xuifvJ4jbNTwhKCAZMR3/rZoqcqbLu1uCQ6LN96e7EMKwYtl7SO+fsOozsdra
 itMaUZzNL4PnXppsIEEImYF+UBPbtO4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NiBTYWx0ZWRfXy9mp9nbT+wKY
 llU7r5vKpLHCAdnNeuEozp+BgIeXFywZvqAbAysDwyxtHTC4Hq4NJl8nZAlHNsqn4tXGyUYqdZe
 UZfczVDr+wPWjAxeE278SLawCy2tRT492HVNIvlWIT1T2KBdvlpjlYsW7ZPqPEs5wjcFoc3QBQK
 8TyraPCYrNxv3PnQh9lXuc90w4JXhwCdt4ohhni8VBKqiq//X6h01027KFUhn8TDLxs8w6F7WhC
 goH4Wl9uTALzXEzK08wHwpgXdLFcUn56RZh0gP2iurMC26TUaigufPSk7zpUgcJaa6KSpxboret
 NtcL/0GH8IsqY6FgTeAsvXjZfVGnb1v27t5D7XLFAtzFujCZ3wmEpMX9J+I6fAWjTQQ/R2aUYNd
 XeySwn9dTdsvMdD0aPp2aJinYuOQpYpNIIdFTVZBzE8owDzmdXaLXGwEwJMJzVoFhvlyxSvE6v/
 eN0YO3p8SBH0IbT5BYg==
X-Proofpoint-GUID: wPnrT9k1m_b4dwP06ZOZ6yzYE_I9W6hJ
X-Proofpoint-ORIG-GUID: wPnrT9k1m_b4dwP06ZOZ6yzYE_I9W6hJ
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac4e123 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=jfqB6kGl0Oe-Ip6igQsA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060046

On Tue, Oct 06, 2026 at 11:24:17AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] s390/cpum_cf: strict mask enforcement breaks legacy lshwc tools
> --
> 
> commit d3def3a5308e1d518c4fe69c3d9a0fc29e832d28
> Author: Sumanth Korikkar <sumanthk@linux.ibm.com>
> 
> s390/cpum_cf: Honor hwctr session cpu mask during hotplug
> 
> This commit updates cfset_online_cpu() and cfset_offline_cpu() to start and
> stop counter sets only for active hwctr sessions that include the CPU in
> their requested mask. It prevents the kernel from dynamically modifying
> the session mask on each hotplug event.
> 
> > diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
> > index 1d63dc3b0ab99..a2334af515447 100644
> > --- a/arch/s390/kernel/perf_cpum_cf.c
> > +++ b/arch/s390/kernel/perf_cpum_cf.c
> > @@ -1778,17 +1779,19 @@ static int cfset_online_cpu(unsigned int cpu)
> >  
> >  	if (!list_empty(&cfset_session.head)) {
> >  		list_for_each_entry(rp, &cfset_session.head, node) {
> > +			if (!cpumask_test_cpu(cpu, &rp->mask))
> > +				continue;
> > +
> 
> [Severity: Critical]
> Could this strict mask enforcement cause a userspace regression with legacy
> lshwc tools?
> 
> Legacy versions of lshwc initiate 'allcpu' sessions by providing the currently
> online CPU mask instead of the possible CPU mask.
> 
> When a new CPU is hotplugged, this strict evaluation will silently exclude the
> new CPU, preventing the legacy behavior of dynamically expanding the session
> mask to newly onlined CPUs.
> 
> Since this change alters the semantic behavior of hwctr sessions, will systems
> using legacy s390-tools on an updated kernel encounter incomplete data for newly
> hotplugged CPUs?
> 
> Breaking existing userspace applications, even when fixing a bug such as the
> incorrect inclusion of CPUs in subset masks, is generally considered an ABI
> regression.
> 
> >  			p.sets = rp->ctrset;
> >  			cfset_ioctl_on(&p);
> > -			cpumask_set_cpu(cpu, &rp->mask);
> >  		}
> >  	}
> >  	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006111304.4023017-1-sumanthk@linux.ibm.com?part=2

Without this patch, newly online cpus are added to the hwctr session
unconditionally, ignoring the cpu mask provided by lshwc userspace.

With the patch, the kernel honors the cpu mask provided by userspace.
For the allcpu case, the corresponding lshwc change to use "all possible
cpus" is also needed.

This is already mentioned in the note. Patch "s390/cpum_cf: Honor hwctr
session cpu mask during hotplug" should not be backported to stable
until the corresponding lshwc change is available.

Thanks
