Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbgBZLMf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Feb 2020 06:12:35 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QB9lYN129873
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 06:12:34 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydkf90qqu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 06:12:34 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 26 Feb 2020 11:12:31 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: mm/gup/writeback: add callbacks for inaccessible pages: fixup for
 linux-next
Date: Wed, 26 Feb 2020 12:12:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1da2ebcf-59bd-65a1-222a-26af953ac7c5@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-mm@kvack.org, kvm list <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>

Claudio,

the patch with the arch callbacks has a (simple) merge conflict with
the longterm pinning changes in next. Can you maybe re-do this patch
on top of linux-next and send this patch to Andrew. This actually 
also means that this patch should ideally go via Andrew and not via
my tree.

Patch is here.

https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/commit/?h=next&id=732b80e677b80813e2f862ce92448436540222a3

this is my quick attempt to fix this up

diff --cc mm/gup.c
index f589299b0d4a,354bcfbd844b..a025d28ffbfd
--- a/mm/gup.c
+++ b/mm/gup.c
@@@ -470,11 -269,18 +468,17 @@@ retry
                goto retry;
        }
  
 -      if (flags & FOLL_GET) {
 -              if (unlikely(!try_get_page(page))) {
 -                      page = ERR_PTR(-ENOMEM);
 -                      goto out;
 -              }
 -              ret = arch_make_page_accessible(page);
 -              if (ret) {
 -                      put_page(page);
 -                      page = ERR_PTR(ret);
 -                      goto out;
 -              }
 +      /* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
 +      if (unlikely(!try_grab_page(page, flags))) {
 +              page = ERR_PTR(-ENOMEM);
 +              goto out;
 +      }
++      ret = arch_make_page_accessible(page);
++      if (ret) {
++              put_page(page);
++              page = ERR_PTR(ret);
++              goto out;
+       }
        if (flags & FOLL_TOUCH) {
                if ((flags & FOLL_WRITE) &&
                    !pte_dirty(pte) && !PageDirty(page))
