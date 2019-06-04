Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727211AbfFDIP0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 04:15:26 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x548CEqP141748
        for <linux-s390@vger.kernel.org>; Tue, 4 Jun 2019 04:15:25 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swhxmqyf3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Jun 2019 04:15:25 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 4 Jun 2019 09:15:22 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net 2/4] s390/qeth: check dst entry before use
Date: Tue,  4 Jun 2019 10:15:07 +0200
In-Reply-To: <20190604081509.56160-1-jwi@linux.ibm.com>
References: <20190604081509.56160-1-jwi@linux.ibm.com>
Message-Id: <20190604081509.56160-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

While qeth_l3 uses netif_keep_dst() to hold onto the dst, a skb's dst
may still have been obsoleted (via dst_dev_put()) by the time that we
end up using it. The dst then points to the loopback interface, which
means the neighbour lookup in qeth_l3_get_cast_type() determines a bogus
cast type of RTN_BROADCAST.
For IQD interfaces this causes us to place such skbs on the wrong
HW queue, resulting in TX errors.

Fix-up the various call sites to first validate the dst entry with
dst_check(), and fall back accordingly.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
v1 -> v2: prefer dst_check() over dst->obsolete (davem)

 drivers/s390/net/qeth_l3_main.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 2df67abdfde7..2eae5cd745c9 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1888,13 +1888,19 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 
 static int qeth_l3_get_cast_type(struct sk_buff *skb)
 {
+	int ipv = qeth_get_ip_version(skb);
 	struct neighbour *n = NULL;
 	struct dst_entry *dst;
 
 	rcu_read_lock();
 	dst = skb_dst(skb);
-	if (dst)
-		n = dst_neigh_lookup_skb(dst, skb);
+	if (dst) {
+		u32 cookie = (ipv == 6) ? rt6_get_cookie(skb_rt6_info(skb)) : 0;
+
+		if (dst_check(dst, cookie))
+			n = dst_neigh_lookup_skb(dst, skb);
+	}
+
 	if (n) {
 		int cast_type = n->type;
 
@@ -1909,7 +1915,7 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 	rcu_read_unlock();
 
 	/* no neighbour (eg AF_PACKET), fall back to target's IP address ... */
-	switch (qeth_get_ip_version(skb)) {
+	switch (ipv) {
 	case 4:
 		if (ipv4_is_lbcast(ip_hdr(skb)->daddr))
 			return RTN_BROADCAST;
@@ -1990,6 +1996,9 @@ static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 	if (ipv == 4) {
 		struct rtable *rt = skb_rtable(skb);
 
+		if (rt && !dst_check(skb_dst(skb), 0))
+			rt = NULL;
+
 		*((__be32 *) &hdr->hdr.l3.next_hop.ipv4.addr) = (rt) ?
 				rt_nexthop(rt, ip_hdr(skb)->daddr) :
 				ip_hdr(skb)->daddr;
@@ -1997,6 +2006,9 @@ static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 		/* IPv6 */
 		const struct rt6_info *rt = skb_rt6_info(skb);
 
+		if (rt && !dst_check(skb_dst(skb), rt6_get_cookie(rt)))
+			rt = NULL;
+
 		if (rt && !ipv6_addr_any(&rt->rt6i_gateway))
 			l3_hdr->next_hop.ipv6_addr = rt->rt6i_gateway;
 		else
-- 
2.17.1
