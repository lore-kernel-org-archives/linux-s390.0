Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727159AbgB1Pnd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 28 Feb 2020 10:43:33 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01SFYdtD013478
        for <linux-s390@vger.kernel.org>; Fri, 28 Feb 2020 10:43:31 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yepxk3f6a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 28 Feb 2020 10:43:31 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 28 Feb 2020 15:43:29 -0000
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [RFC v1 0/2] add callbacks for inaccessible pages
Date: Fri, 28 Feb 2020 16:43:19 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200228154322.329228-1-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-next@vger.kernel.org, akpm@linux-foundation.org
Cc: borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

This patchset has a fixup for gup/mm, and provides the necessary arch
hooks to enable protected virtualization.

Claudio Imbrenda (2):
  mm/gup: fixup for 9947ea2c1e608e32 "mm/gup: track FOLL_PIN pages"
  mm/gup/writeback: add callbacks for inaccessible pages

 include/linux/gfp.h |  6 ++++++
 mm/gup.c            | 24 ++++++++++++++++++++----
 mm/page-writeback.c |  5 +++++
 3 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.24.1
