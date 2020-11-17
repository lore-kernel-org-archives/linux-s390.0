Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbgKQSo3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 13:44:29 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIWPIt189177
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:29 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34vd6hxqg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:29 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AHIWoLT192978
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:29 -0500
Date: Tue, 17 Nov 2020 19:44:22 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390/vmem: fix possible memory overwrite
Message-ID: <20201117184422.GE4746@osiris>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <1abf78a289d76d7448a5640073cf6e8221a54a55.1605000280.git.agordeev@linux.ibm.com>
 <aec7d80c-a7a1-d3db-9719-1ca69fb80887@redhat.com>
 <20201110105052.GA11672@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110105052.GA11672@oc3871087118.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org

On Tue, Nov 10, 2020 at 11:50:52AM +0100, Alexander Gordeev wrote:
> > >  static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
> > >  {
> > >+	unsigned long size = min(end - start, sizeof(struct page));
> > >+
> > >  	/*
> > >  	 * As we expect to add in the same granularity as we remove, it's
> > >  	 * sufficient to mark only some piece used to block the memmap page from
> > >  	 * getting removed (just in case the memmap never gets initialized,
> > >  	 * e.g., because the memory block never gets onlined).
> > >  	 */
> > >-	memset(__va(start), 0, sizeof(struct page));
> > >+	memset(__va(start), 0, size);
> > >  }
> > >  static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
> > >
> > 
> > I don't really see a need for that. Can you spell out one possible
> > configuration that would trigger that in the future? It's sounds
> > very unlikely and I have the feeling there might be more to change
> > at other points.
> 
> No configuration in mind. But dependency on struct page is the only
> obstacle that prevents the whole thing to become generic (unless I
> am missing something). Moreover, the memset() would not be needed
> also - just a single non-PAGE_UNUSED word within [start..end) should
> be enough.

Well, I agree with David here - so not applying.
