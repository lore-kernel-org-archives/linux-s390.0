Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727186AbgCFNZs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Mar 2020 08:25:48 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026DOLfL173268
        for <linux-s390@vger.kernel.org>; Fri, 6 Mar 2020 08:25:47 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfmg4vm4f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 06 Mar 2020 08:25:46 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 6 Mar 2020 13:25:43 -0000
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v4 0/2] add callbacks for inaccessible pages
Date: Fri,  6 Mar 2020 14:25:35 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200306132537.783769-1-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

This patchset has a fixup for gup/mm, and provides the necessary arch
hooks to enable protected virtualization.

Andrew: please simply squash/fixup the first patch into the appropriate
one that is already in your tree.

v3-> v4:
* changed WARN_ON into VM_BUG_ON_PAGE as per review,
* and small improvement of the associated comment
v2 -> v3:
* revert some cosmetic changes to improve readability
* improve some comments
v1 -> v2:
* use put_compound_head in the first patch
* fix commit message of the second patch
* minor code cleanups
* some comments to explain why sometimes we are not doing things

Claudio Imbrenda (2):
  mm/gup: fixup for 9947ea2c1e608e32 "mm/gup: track FOLL_PIN pages"
  mm/gup/writeback: add callbacks for inaccessible pages

 include/linux/gfp.h |  6 ++++
 mm/gup.c            | 76 +++++++++++++++++++++++++++++----------------
 mm/page-writeback.c |  9 +++++-
 3 files changed, 64 insertions(+), 27 deletions(-)

-- 
2.24.1
