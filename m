Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727901AbgKXJeO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 04:34:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AO9WARr011799
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2020 04:34:13 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350rkp4xbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2020 04:34:13 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AO9WI2l012347
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2020 04:34:13 -0500
From: Vineeth Vijayan <vneethv@linux.ibm.com>
Subject: [RFC 0/1] Remove uevent suppression logic from css driver
Date: Tue, 24 Nov 2020 10:34:06 +0100
Message-Id: <20201124093407.23189-1-vneethv@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: cohuck@redhat.com, oberpar@linux.ibm.com
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, fiuczy@linux.ibm.com

This RFC is a follow-up for the below mentioned thread.
https://marc.info/?l=linux-s390&m=158591045732735&w=2

As mentioned in the RFD, we tried to remove the uevent suppression
logic from the css driver. I think this would help the vfio-cww 
udev-rules to bind to the subchannel before the io-subchanneli driver.

Here, the uevent is generated after,stsch() and css_sch_is_valid() 
which makes sure that the subchannel is valid.


Vineeth Vijayan (1):
  s390/cio: Remove uevent-suppress from css driver

 drivers/s390/cio/chsc_sch.c     |  5 -----
 drivers/s390/cio/css.c          | 19 -------------------
 drivers/s390/cio/device.c       | 18 ------------------
 drivers/s390/cio/eadm_sch.c     |  5 -----
 drivers/s390/cio/vfio_ccw_drv.c |  5 -----
 5 files changed, 52 deletions(-)

-- 
2.17.1
