Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2D26158D;
	Mon, 28 Apr 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848418; cv=none; b=mDAmjkUB6QT/rAnh1ggChuwmsbo7OfxYB7JOSsTYfnuVH7vKiNHB71N8RV8CdZRl3AGHKqdVAUg0YdUl3iGwhXaO1pWl+DAjcqAsvEzQyvMxHPSXB+xwTzHXzklw83qr0WGwHkBmDGwNjiEiMB1YoXVc5sk9k49m6aTKauFeCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848418; c=relaxed/simple;
	bh=/mtzWRmpXWF29O14pU2ML458uV5VjhqyGj0MRnqGEBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9BEPijYndXnxnstbb4f/Szjd9b1kZFqpgqo6n70p6uSy9sQeIxUcArpPgT1V2KHjiA2RNx43kL8pum96JWj///87B75nrNFWow+NulnM8nPfvRrjBfkvFqil7/Ao26ux1Dzch/cEGC/fnDbmDhk0qM/zW9AMqMNMLIwfETVS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aCwUBW9V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aCwUBW9V"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SBYd4C005858;
	Mon, 28 Apr 2025 13:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=J7jj3U/6yykZIC3my3HQUM838Nstgf
	V6I3GnhczP5Z0=; b=aCwUBW9VRdlSz9TnrnG+cYo6r0olxApVqClNy63OHFmY6T
	AZqHDpTjMGaeaFKN/5fa9N2R4Jx+VKSbIIjpLALxCN6McIo3VFwe7PWYzfyWMCaq
	H8lgNy5r2d1JvN0B9HusZM2pDz6nTVKW+fD8Yx81Gv5iFfhzWUJBkjDDIXpMCMMm
	tCwU9XmRp//dKdB+P6aPMDLnNfkRxdhihPwsV0JLxXtIu0YB6D5d+xt1RnKCHFbq
	j3Mbiv69ih34YM3TTTzXuBjya22DnmL+DRQTNfH3vgJW0ROPylFlO3zkwSZ9aesa
	tzbdDpQD6VSfd8+ynZtpKYMfveLSJ3DnDGlI503g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469vqvkf0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 13:52:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53SDpBAU025144;
	Mon, 28 Apr 2025 13:52:58 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469vqvkf0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 13:52:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53SCWF9V024643;
	Mon, 28 Apr 2025 13:52:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1kxecc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 13:52:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53SDqt3N41550148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 13:52:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 454AB2004B;
	Mon, 28 Apr 2025 13:52:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CACD20040;
	Mon, 28 Apr 2025 13:52:54 +0000 (GMT)
Received: from osiris (unknown [9.111.53.81])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Apr 2025 13:52:54 +0000 (GMT)
Date: Mon, 28 Apr 2025 15:52:52 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
        Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>,
        "Huang, Ying" <ying.huang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 6/7] mm, swap: remove swap slot cache
Message-ID: <20250428135252.25453B17-hca@linux.ibm.com>
References: <20250313165935.63303-1-ryncsn@gmail.com>
 <20250313165935.63303-7-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313165935.63303-7-ryncsn@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDExMiBTYWx0ZWRfX8TneiJicY9f7 cADjOIUkSdvsMffym++5F4lA6e068C52aElb8G0kmeV8/WFaJ4kWNY23aebyZcAGTymLZ38crhJ EvHeWRvXSTXZfxJh5ZikhHVeiqF/naQPfhwqaF4a/5aPG86XnT690ejpA163XwhHqJJanJNUvDE
 LBZRwIpQhJVWutgAiI1MlHXEB0niJ0xZFQiWKth5jgBtQbEDNnnLeoGnFnKmVnq6TYRe6abC+gY /kWXeTqe9KOnYk62167DI7C+ZlFiGD8QfNy7X+YoxEJRrNhsM2IimROkMpahinCVUfQCIlPoDtG KNBAlmmqEQoC8TXhyTwZ2AvxH4Pb8W4A/OOF4/jzBsOt9guLJ9o+h/AfLZKUDel3CCCbhjbS/cu
 7EZBpkfkouyWbrUjtGo8frkMR5oIaFQBHxv2y1OL9g8bS7GWJ9jBSavqISL6YkHreTNaVq4k
X-Authority-Analysis: v=2.4 cv=AP4PelLR c=1 sm=1 tr=0 ts=680f883a cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=GvQkQWPkAAAA:8 a=20KFwNOVAAAA:8 a=jrbkKmnBssjbu1LxJvIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: TxDqPJHBmM4AOdE3pbn0iCzwEX74Iqsj
X-Proofpoint-GUID: i3ND3R8RIX7NIjtCkfguEd7d2TJDbmcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 mlxlogscore=627 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280112

Hi Kairui,

On Fri, Mar 14, 2025 at 12:59:34AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Slot cache is no longer needed now, removing it and all related code.
...
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/swap.h       |   3 -
>  include/linux/swap_slots.h |  28 ----
>  mm/Makefile                |   2 +-
>  mm/swap_slots.c            | 295 -------------------------------------
>  mm/swap_state.c            |   8 +-
>  mm/swapfile.c              | 194 ++++++++----------------
>  6 files changed, 67 insertions(+), 463 deletions(-)
>  delete mode 100644 include/linux/swap_slots.h
>  delete mode 100644 mm/swap_slots.c
...
> diff --git a/mm/swapfile.c b/mm/swapfile.c
...
> +swp_entry_t folio_alloc_swap(struct folio *folio)
>  {
> -	int order = swap_entry_order(entry_order);
> -	unsigned long size = 1 << order;
> +	unsigned int order = folio_order(folio);
> +	unsigned int size = 1 << order;
>  	struct swap_info_struct *si, *next;
> -	int n_ret = 0;
> +	swp_entry_t entry = {};
> +	unsigned long offset;
>  	int node;
>  
> +	if (order) {
> +		/*
> +		 * Should not even be attempting large allocations when huge
> +		 * page swap is disabled. Warn and fail the allocation.
> +		 */
> +		if (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUSTER) {
> +			VM_WARN_ON_ONCE(1);
> +			return entry;
> +		}
> +	}

This warning triggers on s390. CONFIG_THP_SWAP is disabled and order
is 8 when this triggers (reproduced with ltp's swapon01 test case):

------------[ cut here ]------------
WARNING: CPU: 1 PID: 895 at mm/swapfile.c:1227 folio_alloc_swap+0x438/0x440
Modules linked in:
CPU: 1 UID: 0 PID: 895 Comm: swapon01 Not tainted 6.14.0-rc6-00227-g0ff67f990bd4-dirty #25
Hardware name: IBM 3931 A01 704 (z/VM 7.4.0)
Krnl PSW : 0704d00180000000 000003ffe051210c (folio_alloc_swap+0x43c/0x440)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
Krnl GPRS: 0000000080000000 0000000000000001 0000000000000013 0000000000070000
           0000000000000006 fffffef40e9da000 0000000000000000 0000037202fc4000
           0000037f00000100 0000000000000100 0000037fe2e4b770 0000037202fc4000
           0000000000000000 0000000000000000 000003ffe0512108 0000037fe2e4b3c8
Krnl Code: 000003ffe05120fe: b9160044            llgfr   %r4,%r4
           000003ffe0512102: c0e5ffdf8c0b        brasl   %r14,000003ffe0103918
          #000003ffe0512108: af000000            mc      0,0
          >000003ffe051210c: a7f4fe94            brc     15,000003ffe0511e34
           000003ffe0512110: c0040069ce74        brcl    0,000003ffe124bdf8
           000003ffe0512116: eb8ff0580024        stmg    %r8,%r15,88(%r15)
           000003ffe051211c: b90400ef            lgr     %r14,%r15
           000003ffe0512120: e3f0ffb8ff71        lay     %r15,-72(%r15)
Call Trace:
 [<000003ffe051210c>] folio_alloc_swap+0x43c/0x440 
 [<000003ffe050afa6>] add_to_swap+0x56/0xf0 
 [<000003ffe045fdc0>] shrink_folio_list+0xe80/0x13b0 
 [<000003ffe0461946>] shrink_inactive_list+0x1a6/0x550 
 [<000003ffe04624a2>] shrink_lruvec+0x2b2/0x410 
 [<000003ffe0462840>] shrink_node_memcgs+0x240/0x2d0 
 [<000003ffe0462986>] shrink_node+0xb6/0x3e0 
 [<000003ffe046302a>] do_try_to_free_pages+0xda/0x610 
 [<000003ffe0464d2c>] try_to_free_mem_cgroup_pages+0x14c/0x2a0 
 [<000003ffe0568270>] try_charge_memcg+0x220/0x5d0 
 [<000003ffe056867a>] charge_memcg+0x5a/0x270 
 [<000003ffe056a484>] __mem_cgroup_charge+0x44/0x80 
 [<000003ffe04acf20>] alloc_anon_folio+0x280/0x610 
 [<000003ffe04ad45a>] do_anonymous_page+0x1aa/0x5e0 
 [<000003ffe04af4c4>] __handle_mm_fault+0x244/0x500 
 [<000003ffe04af820>] handle_mm_fault+0xa0/0x170 
 [<000003ffe01533f8>] do_exception+0x1d8/0x4a0 
 [<000003ffe11fb92a>] __do_pgm_check+0x13a/0x220 
 [<000003ffe120c3ce>] pgm_check_handler+0x11e/0x170 
---[ end trace 0000000000000000 ]---
