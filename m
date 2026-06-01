Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193B3AE183;
	Mon,  1 Jun 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329508; cv=none; b=p7+E9AG3gbg852jCvIUAYc+591I6/BKKbqk+4mhAdn+jOTBlG+TmTl0azT+xr+1CFLEZjcNrx3ZS52tC9uLKmov1mz4m+8CYkPkt8BPOBsViLPj+xj5obvijecMHEovTrBsXt4fDranyaPpThF9NYS4wDqk/PL2+4TrNAOT8Bso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329508; c=relaxed/simple;
	bh=hFvimF11ShkeIwg+CHkDJoppKEDLn9a9+H7MXNROPBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecJX9t+rVpHmngoNOiKaDDtLmk/4RnO/Ccye+ITdKEkA6vU6NAlEiEmI2MwXM+hFnbA1J5g7cZib8h7UaVrdI6U1BLU1csGJNUwuupJJjqNCrCzJ6F9otFauw63RuVDraB2vyh9apA6lexcsyr0Rf6no3IHKsnyc7JKvO6+Rw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q2QdkTfq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q2QdkTfq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Fgl7T1958975;
	Mon, 1 Jun 2026 15:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KVDcpE8o3uuZ0QtgmIrSs5gbQcnW7u
	fMsS7wcVBG0y0=; b=q2QdkTfqZHAjJj6NGKVw3J67mUzCoAuC+MTAV8GC3/zaW9
	XtLE487z/NKZ5qKkyDwv/S+6iMMlw3V6LRpHuLxSFLtIp6BQl3jJvIFpXtKP80+Q
	cLSwCTjO92d+3x1Qk+5xIAALBeY++i85qezZua8O+5XpRiS0M68ocS40QVLS8PO8
	E/By7XAg35tBjAmihLn2f4jbL8zn3E3/Br3GnKBevJtGaQ7cYYwYTIxnvgIgnLfX
	8eXASZjqtx2pEYKqSazX2A6CopNEMhVPguYg3JQSunWtGFSrvvo4vawgTdUrS0oB
	oDKTVD/tdAuasZ4Ln5rLPbPZHZoEtzGHhUQ+yoWQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4sks3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:58:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Fs630023611;
	Mon, 1 Jun 2026 15:58:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jxvxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:58:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651FwAYR46727522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 15:58:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEA1C20043;
	Mon,  1 Jun 2026 15:58:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 338FC20040;
	Mon,  1 Jun 2026 15:58:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 15:58:09 +0000 (GMT)
Date: Mon, 1 Jun 2026 17:58:08 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
        anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, byungchul@sk.com,
        catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
        gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz,
        jackmanb@google.com, jannh@google.com, jglisse@google.com,
        joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
        liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com,
        matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
        peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com,
        raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com,
        surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de,
        usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yang@os.amperecomputing.com, ying.huang@linux.alibaba.com,
        ziy@nvidia.com, zokeefe@google.com, linux-s390@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
Message-ID: <20260601155808.2755103A59-agordeev@linux.ibm.com>
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522134724.f4f11941a85ef18b307d16ae@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522134724.f4f11941a85ef18b307d16ae@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nfwYDs9TcjCv1m5SD5Q2yxQgbgrtXAhC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1NiBTYWx0ZWRfXyLYMZqvlBwmh
 FIBRb5tIWjWqfgO88TmAAfsO9qJCH2UQwFruqUM2DQZBhQbobvvub4gPHV1p0z/SprglZkt6gtI
 0ZEF7AzWNA9ysO0OSentgtCFSwU0Un2rFtOGyM+K1rqIkikhyLFyyZlMTviw6/Zg9EcDnW7V7/S
 G55DaMhAz6x7AwyHrk+c/RIHNV6UHt48a2t2XkLJrXBtkV6zE47lbWpx890raV5NiBCi4qKcoPm
 dQjA8ZvyVhdhV+MTZgejzg3iX5UEsawV2oi0yISpbc5myMiWvU5T/mvzb7itDe2zHSOM/a74Won
 Q5udMQxXvQdazyql+2jTgVazntIUYbNA4cIG6cFUdyyIjShE2MpYpdgTLRQAAOxKpQ8JvHPD+Va
 P4oKM1LpyU0RLzhy2HWRO8jGU3jl9ArFxP6Wzpe3+CpKC0Lq1YEuZ0+91gxoGiLvrlP9AfHV9Gi
 NXy5vwkdCVghclNBSBg==
X-Proofpoint-ORIG-GUID: nfwYDs9TcjCv1m5SD5Q2yxQgbgrtXAhC
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1dac15 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=0zv6X75myPOFEK8-PwYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010156

On Fri, May 22, 2026 at 01:47:24PM -0700, Andrew Morton wrote:

Hi Andrew et al,

> On Fri, 22 May 2026 08:59:55 -0600 Nico Pache <npache@redhat.com> wrote:
> 
> > The following series provides khugepaged with the capability to collapse
> > anonymous memory regions to mTHPs.
> 
> Thanks, I've update mm.git's mm-unstable branch to this version.
> 
> It sounds like I might be dropping it soon, haven't started looking at
> that yet.  But let's at least eyeball the latest version at this time.
> 
> Sashiko was able to apply this, so the base-it-on-hotfixes thing worked
> well, thanks.  The AI checking made a few allegations:

This series appears to cause hangs on s390 in linux-next.
The issue is not easily reproducible, so it is not yet confirmed.
Any ideas for a reliable reproducer that exercises the code path below?

    [ 2749.385719] sysrq: Show Blocked State
    [ 2749.385730] task:khugepaged      state:D stack:0     pid:209   tgid:209   ppid:2      task_flags:0x200040 flags:0x00000000
    [ 2749.385735] Call Trace:
    [ 2749.385736]  [<0000017f63c8b226>] __schedule+0x316/0x890
    [ 2749.385740]  [<0000017f63c8b7dc>] schedule+0x3c/0xc0
    [ 2749.385743]  [<0000017f63c8b888>] schedule_preempt_disabled+0x28/0x40
    [ 2749.385746]  [<0000017f63c902ea>] rwsem_down_write_slowpath+0x2fa/0x8b0
    [ 2749.385749]  [<0000017f63c90910>] down_write+0x70/0x80
    [ 2749.385752]  [<0000017f6313407a>] collapse_huge_page+0x2ea/0x9e0
    [ 2749.385755]  [<0000017f6313491e>] mthp_collapse+0x1ae/0x1f0
    [ 2749.385757]  [<0000017f63134fda>] collapse_scan_pmd+0x67a/0x8f0
    [ 2749.385760]  [<0000017f6313751a>] collapse_single_pmd+0x15a/0x260
    [ 2749.385762]  [<0000017f6313792c>] collapse_scan_mm_slot.constprop.0+0x30c/0x470
    [ 2749.385765]  [<0000017f63137cb6>] khugepaged+0x226/0x240
    [ 2749.385768]  [<0000017f62db3128>] kthread+0x148/0x170
    [ 2749.385770]  [<0000017f62d2c238>] __ret_from_fork+0x48/0x220
    [ 2749.385772]  [<0000017f63c95d0a>] ret_from_fork+0xa/0x30

Thanks!
