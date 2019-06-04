Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727196AbfFDIPZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 04:15:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x548CHXC030764
        for <linux-s390@vger.kernel.org>; Tue, 4 Jun 2019 04:15:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2swhyh70ts-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Jun 2019 04:15:23 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 4 Jun 2019 09:15:21 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net 1/4] s390/qeth: handle limited IPv4 broadcast in L3 TX path
Date: Tue,  4 Jun 2019 10:15:06 +0200
In-Reply-To: <20190604081509.56160-1-jwi@linux.ibm.com>
References: <20190604081509.56160-1-jwi@linux.ibm.com>
Message-Id: <20190604081509.56160-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When selecting the cast type of a neighbourless IPv4 skb (eg. on a raw
socket), qeth_l3 falls back to the packet's destination IP address.
For this case we should classify traffic sent to 255.255.255.255 as
broadcast.
This fixes DHCP requests, which were misclassified as unicast
(and for IQD interfaces thus ended up on the wrong HW queue).

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 0271833da6a2..2df67abdfde7 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1911,6 +1911,8 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 	/* no neighbour (eg AF_PACKET), fall back to target's IP address ... */
 	switch (qeth_get_ip_version(skb)) {
 	case 4:
+		if (ipv4_is_lbcast(ip_hdr(skb)->daddr))
+			return RTN_BROADCAST;
 		return ipv4_is_multicast(ip_hdr(skb)->daddr) ?
 				RTN_MULTICAST : RTN_UNICAST;
 	case 6:
-- 
2.17.1
