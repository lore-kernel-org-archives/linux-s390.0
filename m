Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727616AbfFRSnQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Jun 2019 14:43:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IIgvEo105024
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 14:43:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t74wxhhfa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 14:43:15 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 18 Jun 2019 19:43:13 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/3] net/af_iucv: fixes 2019-06-18
Date: Tue, 18 Jun 2019 20:42:58 +0200
Message-Id: <20190618184301.96472-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,
I spent a few cycles on transmit problems for af_iucv over regular
netdevices - please apply the following fixes to -net.

The first patch allows for skb allocations outside of GFP_DMA, while the
second patch respects that drivers might use skb_cow_head() and/or want
additional dev->needed_headroom.
Patch 3 is for a separate issue, where we didn't setup some of the
netdevice-specific infrastructure when running as a z/VM guest.

Thanks,
Julian


Julian Wiedmann (3):
  net/af_iucv: remove GFP_DMA restriction for HiperTransport
  net/af_iucv: build proper skbs for HiperTransport
  net/af_iucv: always register net_device notifier

 net/iucv/af_iucv.c | 49 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 13 deletions(-)

-- 
2.17.1
