Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726739AbfHALGh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Aug 2019 07:06:37 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71B3hR8096177
        for <linux-s390@vger.kernel.org>; Thu, 1 Aug 2019 07:06:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3x7f1thw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 07:06:35 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 1 Aug 2019 12:06:34 +0100
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/1] sending DASD patches through linux-block
Date: Thu,  1 Aug 2019 13:06:29 +0200
Message-Id: <20190801110630.82432-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org, hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, gor@linux.ibm.com

Hi Jens,

we would like to get our DASD related patches upstream through your
linux-block git tree in the future.
We hope to get a better integration and that we are able to identify
potential conflicts with generic blocklayer changes earlier.

I hope this is OK for you. I have attached a first patch that fixes a
bug in the DASD driver. This patch is based on the master branch of your
linux-block git tree.

Please let me know if I should change something in my workflow.

Kind regards,
Stefan

Stefan Haberland (1):
  s390/dasd: fix endless loop after read unit address configuration

 drivers/s390/block/dasd_alias.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
2.17.1
