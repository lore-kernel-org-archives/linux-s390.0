Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4372BC48BE5
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2847B61075
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 14:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhFPOzZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:55:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234142AbhFPOzZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Jun 2021 10:55:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GEXvds102428;
        Wed, 16 Jun 2021 10:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tPX5ov5SifBL+90Huu9lmP5cCIoeuJj6SuSnnGi58po=;
 b=KlT1yWEZHmpspfIskPVkLUyuQmxSoCfA8wk2ROGazrgHv5ABLJ45RyVn2hRsR3DZFN63
 oBHzDuXo7d4zfKn9ZXAacMiQ7hXO09gfNMBZHKBzYtTFZhsynPYmNp7KXhp09wneAjfV
 KCESjIe/Te6cIWlEallMMyl7ztdx+oQ04Ng2l2euymJjAEbB32SYF3XVR+L9SG34FNPV
 jfLhSbfuqKIvhk5A1h4J0nMaR3lIkXYnpnfap/7cYuiqGaqZ4wHaWOo02kAo0h4SNufO
 L+qcF+eg1PtkDkwhRjiUKcvpDcx+ecm5xmpSitAq6llNmFE1saRGe13KVmmWccJPA1GV WQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 397jgdtn6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:53:13 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15GEmTQj001442;
        Wed, 16 Jun 2021 14:53:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 395c3t8yg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 14:53:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15GEr9ku29491628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 14:53:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB37242045;
        Wed, 16 Jun 2021 14:53:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD87D4203F;
        Wed, 16 Jun 2021 14:53:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jun 2021 14:53:08 +0000 (GMT)
From:   Karsten Graul <kgraul@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, guvenc@linux.ibm.com
Subject: [PATCH net-next v2 0/4] net/smc: Add SMC statistic support
Date:   Wed, 16 Jun 2021 16:52:54 +0200
Message-Id: <20210616145258.2381446-1-kgraul@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pf1YHYgXxTQsfm_qR1AqddFYbEYn0bsZ
X-Proofpoint-ORIG-GUID: pf1YHYgXxTQsfm_qR1AqddFYbEYn0bsZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-16_07:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Please apply the following patch series for smc to netdev's net-next tree.

This v2 is a resend of the code contained in v1 but with an updated
cover letter to describe why we have chosen to use the generic netlink
mechanism to access the smc protocol's statistic data.

The patchset adds statistic support to the SMC protocol. Per-cpu
variables are used to collect the statistic information for better
performance and for reducing concurrency pitfalls. The code that is
collecting statistic data is implemented in macros to increase code
reuse and readability.
The generic netlink mechanism in SMC is extended to provide the
collected statistics to userspace.
Network namespace awareness is also part of the statistics
implementation.

SMC is a protocol interacting with PCI devices (like RoCE Cards) and
runs on top of the TCP protocol. As SMC is a network protocol and not
an ethernet device driver, we decided to use the generic netlink
interface. This should be comparable to what other protocols in the
net subsystem like tipc, ncsi, ieee802154 or tcp, et al, do.
There is already an established internal generic netlink interface
mechanism in SMC which is used to collect SMC Protocol internal
information. This patchset extends that existing mechanism.

Guvenc Gulce (4):
  net/smc: Add SMC statistics support
  net/smc: Add netlink support for SMC statistics
  net/smc: Add netlink support for SMC fallback statistics
  net/smc: Make SMC statistics network namespace aware

 include/net/net_namespace.h |   4 +
 include/net/netns/smc.h     |  16 ++
 include/uapi/linux/smc.h    |  83 ++++++++
 net/smc/Makefile            |   2 +-
 net/smc/af_smc.c            | 102 +++++++--
 net/smc/smc_core.c          |  13 +-
 net/smc/smc_netlink.c       |  11 +
 net/smc/smc_netlink.h       |   2 +-
 net/smc/smc_rx.c            |   8 +
 net/smc/smc_stats.c         | 413 ++++++++++++++++++++++++++++++++++++
 net/smc/smc_stats.h         | 266 +++++++++++++++++++++++
 net/smc/smc_tx.c            |  18 +-
 12 files changed, 917 insertions(+), 21 deletions(-)
 create mode 100644 include/net/netns/smc.h
 create mode 100644 net/smc/smc_stats.c
 create mode 100644 net/smc/smc_stats.h

-- 
2.25.1

