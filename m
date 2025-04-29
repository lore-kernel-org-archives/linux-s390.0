Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779627466B;
	Tue, 29 Apr 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911903; cv=none; b=lEQsUzvkEorvLVzO/CyKxD6ahvviBZt0AyuMBn4sFuYKSpfFSBzOtwTQ3BUM+GM3SfLz7GBB1YgKbuaSfuQMoeB0iMAVVwjjphiuKVRfUoMRjkV617WK/dUo1QD+HZWON+eWxiSc3biypw0L7IaJ+B92caqJSUnXYu1bmkKRVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911903; c=relaxed/simple;
	bh=EzETxmW/tM9t+RxALcOwgpXIqTqNQgKVSKk4XBWrEPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii5H+fj3VceshVvjt1WZ1mgzmx0Y5v/RU/YwWN9ubYpWNXWVwtp/w8Rk8zqCm12yun0iLr64DMFLiIVPuqAtnKxOjWQg6fEYX1qsOlO14jt1cNYqU/8Ud/oLecTFBMt8pSqCYIP7qVFIkudjCu9hvb3YU4Z9GD9Q1IM2m+MWu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K+2M74OT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K+2M74OT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EOEP026121;
	Tue, 29 Apr 2025 07:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2UZNwP
	5UXSQV/lhMB7ppnGsZVU7Shxe3YfosshSXYxo=; b=K+2M74OTYXE6R8Y/U7FS/i
	w1iPkPwqBQ1ZmujjNPJkk1fGfK8Tjhk4Oy0FIh5ewvLN/IRg7BqSiWxGZ8H8DZ1F
	m6kq229r8AWVzRKra5CTQ1NGVHsW5VXGQ3QWpjBZymMIV3Hocg1seOGZvfR0zXWB
	NobdB6fBQ4q5mvl8AKyALTh1rMATasJ3R/sKDZWJEjDxb+DQPKRGjpBsf7RnRlCv
	Yijq+Q4fTlzxChphetcLmlty/NxvvhMMVuKOQD3GQeBEiHg22bgZ03eRYNVQX1sn
	huEaHuEB7F93HcqgtNvC8iiH/TUBgkC8SDMD73NA982X9IG2eoTKVSYHGXsIlbWQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahtwhr7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 07:31:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53T7VQDD008743;
	Tue, 29 Apr 2025 07:31:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahtwhr7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 07:31:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T50L78001336;
	Tue, 29 Apr 2025 07:31:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpa6qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 07:31:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53T7VORU45351394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 07:31:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 176FF20043;
	Tue, 29 Apr 2025 07:31:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 982FF20040;
	Tue, 29 Apr 2025 07:31:23 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Apr 2025 07:31:23 +0000 (GMT)
Date: Tue, 29 Apr 2025 09:31:22 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Kairui Song <ryncsn@gmail.com>
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
Message-ID: <20250429073122.8629Bfd-hca@linux.ibm.com>
References: <20250313165935.63303-1-ryncsn@gmail.com>
 <20250313165935.63303-7-ryncsn@gmail.com>
 <20250428135252.25453B17-hca@linux.ibm.com>
 <CAMgjq7CJO-GdmZGN7_xG6gtneAv3Wv8qv6FjE9udh18_qmCgRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7CJO-GdmZGN7_xG6gtneAv3Wv8qv6FjE9udh18_qmCgRA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA1MiBTYWx0ZWRfX+tkYyWiUTQyM bUYcw8PSu29+Q1zGZEeJu+3y/UElbgxqEEubHJ63TqWsackAc0lylTwsFvbfyZDrgPaEgVaN2WK eD2F7Vn8jtfd4Sf/Qj33WPeMUMSIUt7of5jpcfTfC5+pRK6y3V9EwMWFf/sGUo7LTOt9iZnwmnY
 X12nmhnIDNURHbhjUDZlBeQfjF/DnKTYJKiJ1Q3fpZ0pg4+vWMwDf4Gis1kOX381wzIpKGiXx5V lrCLZ1oxvibZFHkS3BUqCEg7ZZR68vSiBuiJSwhcxqPM7DAnp6J1BgrZRgRL3/y9iDmYpTa8a4s oAULq8DO6sjo4TcBIap/mQUnYqyyDmHJDoiTarMTjq7rgcaVa+25h+3Gprez7mIyBuiMrzzlROV
 Clw+lTvM8vJLByBM9GWgTP6KhZvtWmju82AaxFIZMBpRvFMWVR88Sz9PpJxNqmy6QkImam8N
X-Proofpoint-GUID: RiMMU829nfj9EPoc1pxbuJOYcANh2hzg
X-Authority-Analysis: v=2.4 cv=KtxN2XWN c=1 sm=1 tr=0 ts=6810804f cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=_IPHXnTd-d5seAnkXxwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Q7o8mo1j2xqa9xWaxKzVRSkpDrxZ06YB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290052

On Mon, Apr 28, 2025 at 11:31:59PM +0800, Kairui Song wrote:
> On Mon, Apr 28, 2025 at 9:53 PM Heiko Carstens <hca@linux.ibm.com> wrote:
> > > +     if (order) {
> > > +             /*
> > > +              * Should not even be attempting large allocations when huge
> > > +              * page swap is disabled. Warn and fail the allocation.
> > > +              */
> > > +             if (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUSTER) {
> > > +                     VM_WARN_ON_ONCE(1);
> > > +                     return entry;
> > > +             }
> > > +     }
> 
> The !CONFIG_THP_SWAP check existed before because slot cache should
> reject high order allocation. But slot cache is gone, so large
> allocation will directly go to the allocator.
> 
> It was not a meaningful WARN in the first place, and now the allocator
> should just fail silently for high order allocation, that's totally
> fine and expected and will just inform the caller to split the folio.
> 
> I'll just change the WARN_ON condition to `if (order && size >
> SWAPFILE_CLUSTER)` then, this should silence the WARN.

If I understand your suggestion correctly then this would be the
resulting code:

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2eff8b51a945..5a7797143948 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1276,7 +1276,7 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp)
         * Should not even be attempting large allocations when huge
         * page swap is disabled. Warn and fail the allocation.
         */
-       if (order && (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUSTER)) {
+       if (order && size > SWAPFILE_CLUSTER) {
                VM_WARN_ON_ONCE(1);
                return -EINVAL;
        }

However, with that change I get this splat (and a few more) instead:

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(l->owner != current)
WARNING: CPU: 4 PID: 934 at ./include/linux/local_lock_internal.h:52 folio_alloc_swap+0x22e/0x560
Modules linked in:
CPU: 4 UID: 0 PID: 934 Comm: swapon01 Not tainted 6.15.0-rc4-00021-gca91b9500108-dirty #2 PREEMPT 
Hardware name: IBM 3931 A01 704 (z/VM 7.4.0)
Krnl PSW : 0704f00180000000 000003ffe05231b2 (folio_alloc_swap+0x232/0x560)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
Krnl GPRS: 000003ff80000002 0000000000000003 0000000000000028 000003ffe2fe6c90
           0000000000000003 000003ff80000003 000003ffe19fc538 000003720322c000
           0000000000000000 000002f2ab38f000 000002f200000100 000003720322c000
           0000000000000000 000002f3f0eda278 000003ffe05231ae 0000037febbdb3f8
Krnl Code: 000003ffe05231a2: c020008e69bc        larl    %r2,000003ffe16f051a
           000003ffe05231a8: c0e5ffe2f4dc        brasl   %r14,000003ffe0181b60
          #000003ffe05231ae: af000000            mc      0,0
          >000003ffe05231b2: a7f4ff92            brc     15,000003ffe05230d6
           000003ffe05231b6: a7080001            lhi     %r0,1
           000003ffe05231ba: a7a80001            lhi     %r10,1
           000003ffe05231be: a7980000            lhi     %r9,0
           000003ffe05231c2: a7f4ff04            brc     15,000003ffe0522fca
Call Trace:
 [<000003ffe05231b2>] folio_alloc_swap+0x232/0x560 
 [<000003ffe046d2d2>] shrink_folio_list+0xe02/0x12d0 
 [<000003ffe046edc8>] shrink_inactive_list+0x188/0x5a0 
 [<000003ffe046f7d4>] shrink_lruvec+0x104/0x400 
 [<000003ffe046fd0c>] shrink_node_memcgs+0x23c/0x2c0 
 [<000003ffe046fe3a>] shrink_node+0xaa/0x420 
 [<000003ffe0470500>] do_try_to_free_pages+0xd0/0x5c0 
 [<000003ffe0472144>] try_to_free_mem_cgroup_pages+0x144/0x290 
 [<000003ffe057b33a>] try_charge_memcg+0x1ca/0x420 
 [<000003ffe057b5ea>] charge_memcg+0x5a/0x1a0 
 [<000003ffe057d5d4>] __mem_cgroup_charge+0x44/0x160 
 [<000003ffe04bb6ac>] alloc_anon_folio+0x27c/0x5d0 
 [<000003ffe04bbbac>] do_anonymous_page+0x1ac/0x7b0 
 [<000003ffe04bdec2>] __handle_mm_fault+0x212/0x4c0 
 [<000003ffe04be20c>] handle_mm_fault+0x9c/0x230 
 [<000003ffe015422c>] do_exception+0x1dc/0x540 
 [<000003ffe125c560>] __do_pgm_check+0x130/0x220 
 [<000003ffe126e3ae>] pgm_check_handler+0x11e/0x170 
INFO: lockdep is turned off.
Last Breaking-Event-Address:
 [<000003ffe0181c96>] __warn_printk+0x136/0x140
irq event stamp: 4120751
hardirqs last  enabled at (4120751): [<000003ffe126d0ee>] _raw_spin_unlock_irq+0x3e/0x80
hardirqs last disabled at (4120750): [<000003ffe126cca8>] _raw_spin_lock_irq+0x98/0xd0
softirqs last  enabled at (4104986): [<000003ffe018c1fc>] handle_softirqs+0x2fc/0x550
softirqs last disabled at (4104969): [<000003ffe018b9c6>] __irq_exit_rcu+0x126/0x140
---[ end trace 0000000000000000 ]---
