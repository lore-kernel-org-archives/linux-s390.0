Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbgDFHlZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 03:41:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0367YAhK134655
        for <linux-s390@vger.kernel.org>; Mon, 6 Apr 2020 03:41:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306paksurb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 03:41:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Mon, 6 Apr 2020 08:41:19 +0100
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/1] s390/dasd: Kconfig patch
Date: Mon,  6 Apr 2020 09:41:17 +0200
Message-Id: <20200406074118.86849-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

Hi Jens,

please see the following patch that fixes the DASD iosched Kconfig.

Regards,
Stefan

Krzysztof Kozlowski (1):
  s390: Cleanup removed IOSCHED_DEADLINE

 drivers/s390/block/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1
