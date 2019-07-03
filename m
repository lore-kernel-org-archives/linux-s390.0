Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbfGCKUP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Jul 2019 06:20:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63AJGtC146420
        for <linux-s390@vger.kernel.org>; Wed, 3 Jul 2019 06:20:13 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tgrdrwm4k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 03 Jul 2019 06:20:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 3 Jul 2019 11:20:11 +0100
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 0/3] docs: s390: restore content and update s390dbf.rst
Date: Wed,  3 Jul 2019 12:19:46 +0200
Message-Id: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-doc@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org

This is based on top of the 3 s390 patches Heiko already queued on our
s390 features branch.
[("Re: [PATCH v3 00/33] Convert files to ReST - part 1")
 https://www.spinics.net/lists/linux-doc/msg66137.html
 https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/Documentation/s390?h=features]

If I was not mistaken, some documentation was accidentally lost
and patch 1 restores it.

After having looked closer, I came up with patches 2 and 3.
Rendered successfully on a current Fedora 30 and it looks good:
$ make SPHINXDIRS="s390" htmldocs

Steffen Maier (3):
  docs: s390: restore important non-kdoc parts of s390dbf.rst
  docs: s390: unify and update s390dbf kdocs at debug.c
  docs: s390: s390dbf: typos and formatting, update crash command

 Documentation/s390/s390dbf.rst | 390 +++++++++++++++++++++++++++++++++++++++--
 arch/s390/include/asm/debug.h  | 112 ++----------
 arch/s390/kernel/debug.c       | 105 +++++++++--
 3 files changed, 473 insertions(+), 134 deletions(-)

-- 
1.8.3.1
