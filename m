Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729398AbgCDNHH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Mar 2020 08:07:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024D50CF033122
        for <linux-s390@vger.kernel.org>; Wed, 4 Mar 2020 08:07:07 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yj8hbj9bg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 04 Mar 2020 08:07:07 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Wed, 4 Mar 2020 13:07:04 -0000
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 0/2] add callbacks for inaccessible pages
Date: Wed,  4 Mar 2020 14:06:53 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200304130655.462517-1-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

This patchset has a fixup for gup/mm, and provides the necessary arch
hooks to enable protected virtualization.

Andrew: please simply squash/fixup the first patch into the appropriate
one that is already in your tree.

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
 mm/page-writeback.c |  5 +++
 3 files changed, 61 insertions(+), 26 deletions(-)

-- 
2.24.1
