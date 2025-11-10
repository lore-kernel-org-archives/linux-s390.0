Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400130E858
	for <linux-s390@vger.kernel.org>; Mon, 10 Nov 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785598; cv=none; b=hbkKlY/zoZxhcdLkKZWavtW6VQVmKue59Msv790l6TfhKsO1WcPfAyKeWcn+8g8TaF6lr8JwE8h/5sNe0JH4ICVQ4tfmbIi/n3LG6qRQmu83tTOmNCtEC+iKJl6067ssQSSqRjQS2SerA7QobFdcdLzrz7M79I75APIEo2pQ8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785598; c=relaxed/simple;
	bh=DMdoMUGEIjdA5li8EyWeoPU3hAmmLMscHmBTPOiE7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlJBUK/sh79EuEcgPYQeHCPpIcPP21Cb49nZI8y9EkfNm/EUhOh4Pa7N/GbjvDyqu1mmi8k1yXFBll+UTnJ0bamAgHyxmrEAQwi/nzopy35xmheHnB1Q7toI0/E7pRqsIPErhFJmkTcrrndCj6/kyA4RdKXPYFY9iB9FJEDS+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oEcBjE8P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oEcBjE8P"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AADNX3O017468;
	Mon, 10 Nov 2025 14:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Zf8kLR8A1XKOJafXjBBPTX2py++Fi1
	Z1Yq64ifvBqMQ=; b=oEcBjE8Pk8lP/hgzmQQ1jmXRT0L6aKeD4wtPgw5pr4kI2/
	BMXyGcHbLpWwJEw5QZau+D1gLXw+BmH1wgNBp+7UBMpi0zH0nZKG1qyE3UHqP0lk
	Gy8ez38H2NW0mF+c1/avpdedlzUnqXZUJNMb5zeaKDpGTIsSf0SADBfe74aovFJi
	QdXxlI08CQ5Lei928NhqxY9OcNmKhCTHRLZNGPRVKjayhitQPx0tsSua19yBM1d+
	ivfhKfpPQ2OB3jOXI5r4SB9WCtb+prlVvD64JhAkZnW105qkZrSAzyWon55VLsDu
	qR28unAG1P883LQur+bCKHAA2JJQFn+VDH2J4hcQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk80mxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 14:39:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AAEdIwE017583;
	Mon, 10 Nov 2025 14:39:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk80mxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 14:39:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAD3vaa008239;
	Mon, 10 Nov 2025 14:39:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6mp1yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 14:39:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AAEdC3L29753674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 14:39:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E025420040;
	Mon, 10 Nov 2025 14:39:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD47520043;
	Mon, 10 Nov 2025 14:39:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Nov 2025 14:39:12 +0000 (GMT)
Date: Mon, 10 Nov 2025 15:39:11 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: page type is 0, migratetype passed is 2 (nr=256)
Message-ID: <20251110143911.1716086Add-agordeev@linux.ibm.com>
References: <87wmalyktd.fsf@linux.ibm.com>
 <1fc8eb08-7e34-4b16-a08f-c81a531ec3fb@lucifer.local>
 <A82049B8-B1B5-4234-BCFA-55779F76EDBB@nvidia.com>
 <20250512171429.GB615800@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512171429.GB615800@cmpxchg.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX2aq85fp+VJ0n
 r3dSjQ0MJFNzFIBqSDhQWOYDPrPDrEUfLxn4jK8QZ+Esrao2wpy5+9Bk5kcrFjjfCnQlcSvrLvZ
 Jg3peSrjLznnnRzXryRnRRgN42vehe/yFLysWWaLbJnqWD+Ah0Grlk9Xu2ndS640MMO9n5bMCUH
 CNeZLsnZ3JvRYYkfcFEL0HpEJb9UFxwcH8x//vUKT69e5jq8lXEZqxjA01jxfIn7NdYw1zmU1hG
 wRJKcbk2iMBRIeFoMUoxDNl3GSCmQoITa6/Ao/9UyrRrqoCEY/Oxc8imJXXlNV0fwPRUv+8Q/qS
 MXW2Oqihff/zHsO3pVXn/OBs5igg5yq+qBAHKtJ3HlMeyAk4vkSOmEyuLsilA7NVbDAeGTQShPz
 4ExVBQOSY0R+PlCwBtPTF2RnC43TRg==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6911f917 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OZ5Nl_lMQ71IryGz5pQA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: VbpO0pTYiafjfl2WEFfvTFkfhtCISfZJ
X-Proofpoint-GUID: Z9xrW-vcwR9DmODvRt7DZLy8UwKgoYBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

On Mon, May 12, 2025 at 01:14:29PM -0400, Johannes Weiner wrote:

Hi Johannes,

> On Mon, May 12, 2025 at 12:35:39PM -0400, Zi Yan wrote:
> > On 12 May 2025, at 12:16, Lorenzo Stoakes wrote:
> > 
> > > +cc Zi
> > >
> > > Hi Marc,
> > >
> > > I noticed this same bug as reported in [0], but only for a _very_ recent
> > > patch series by Zi, which is only present in mm-new, which is the most
> > > unstable mm branch right now :)
> > >
> > > So I wonder if related or a coincidence caused by something else?
> > 
> > Unless Marc's branch has my "make MIGRATE_ISOLATE a standalone bit" patchset,
> > it should be caused by something else.
> > 
> > A bisect would be very helpful.
> > 
> > >
> > > This is triggered by the mm self-test (in tools/testing/selftests/mm, you
> > > can just make -jXX there) transhuge-stress, invoked as:
> > >
> > > $ sudo ./transhuge-stress -d 20
> > >
> > > The stack traces do look very different though so perhaps unrelated?
> > 
> > The warning is triggered, in the both cases, a pageblock with MIGRATE_UNMOVABLE(0)
> > is moved to MIGRATE_RECLAIMABLE(2). The pageblock is supposed to have
> > MIGRATE_RECLAIMABLE(2) before the movement.
> 
> The weird thing is that the warning is from expand(), when the broken
> up chunks are put *back*. Marc, can you confirm that this is the only
> warning in dmesg, and there aren't any before this one?
> 
> The request does the following:
> 
>   rmqueue_bulk()
>     __rmqueue()
>       __rmqueue_smallest()
>         page_del_and_expand()
>           __del_page_from_free_list()
>             VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
>                          "page type is %lu, passed migratetype is %d (nr=%d)\n",
>                          get_pageblock_migratetype(page), migratetype, nr_pages);
>          expand()
>            __add_to_free_list()
>              VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
>                           "page type is %lu, passed migratetype is %d (nr=%d)\n",
>                           get_pageblock_migratetype(page), migratetype, nr_pages);
> 
> So if only the second one triggers, but not the first one, it suggests
> we have a buddy page consisting of two pageblocks of different types -
> the first one reclaimable and the second unmovable. When we take the
> headpage off, the type matches. When we put the remainder from the
> tailblock back, it doesn't.

With some extra debugging added on top of 6.18-rc3 we see this:

[  388.664966] +++ __add_to_free_list(814) type 0, migratetype 1 order 8 nr 256 pid 3917 comm mempig_verify
[  388.665533] +++ __del_page_from_free_list(868) type 0, migratetype 1 order 8 nr 256 pid 3917 comm mempig_verify

Does it make sense?

Thanks!

FWIW here is the patch:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..82b171af5b4d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -806,12 +806,15 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
 				      unsigned int order, int migratetype,
 				      bool tail)
 {
+	enum migratetype pagetype = get_pageblock_migratetype(page);
 	struct free_area *area = &zone->free_area[order];
 	int nr_pages = 1 << order;
 
-	VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
-		     "page type is %d, passed migratetype is %d (nr=%d)\n",
-		     get_pageblock_migratetype(page), migratetype, nr_pages);
+        if (pagetype != migratetype) {
+		pr_warn("+++ %s(%d) type %d, migratetype %d order %d nr %d pid %d comm %s\n",
+			__FUNCTION__, __LINE__,
+			pagetype, migratetype, order, nr_pages, current->pid, current->comm);
+	}
 
 	if (tail)
 		list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
@@ -831,13 +834,16 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
 static inline void move_to_free_list(struct page *page, struct zone *zone,
 				     unsigned int order, int old_mt, int new_mt)
 {
+	enum migratetype pagetype = get_pageblock_migratetype(page);
 	struct free_area *area = &zone->free_area[order];
 	int nr_pages = 1 << order;
 
 	/* Free page moving can fail, so it happens before the type update */
-	VM_WARN_ONCE(get_pageblock_migratetype(page) != old_mt,
-		     "page type is %d, passed migratetype is %d (nr=%d)\n",
-		     get_pageblock_migratetype(page), old_mt, nr_pages);
+        if (pagetype != old_mt) {
+		pr_warn("+++ %s(%d) type %d, migratetype %d order %d nr %d pid %d comm %s\n",
+			__FUNCTION__, __LINE__,
+			pagetype, old_mt, order, nr_pages, current->pid, current->comm);
+	}
 
 	list_move_tail(&page->buddy_list, &area->free_list[new_mt]);
 
@@ -855,11 +861,14 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
 static inline void __del_page_from_free_list(struct page *page, struct zone *zone,
 					     unsigned int order, int migratetype)
 {
+	enum migratetype pagetype = get_pageblock_migratetype(page);
 	int nr_pages = 1 << order;
 
-        VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
-		     "page type is %d, passed migratetype is %d (nr=%d)\n",
-		     get_pageblock_migratetype(page), migratetype, nr_pages);
+        if (pagetype != migratetype) {
+		pr_warn("+++ %s(%d) type %d, migratetype %d order %d nr %d pid %d comm %s\n",
+			__FUNCTION__, __LINE__,
+			pagetype, migratetype, order, nr_pages, current->pid, current->comm);
+	}
 
 	/* clear reported state and update reported page count */
 	if (page_reported(page))
