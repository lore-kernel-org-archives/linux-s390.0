Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC69CC433EF
	for <linux-s390@archiver.kernel.org>; Wed,  6 Oct 2021 14:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF5F61184
	for <linux-s390@archiver.kernel.org>; Wed,  6 Oct 2021 14:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhJFO1s (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Oct 2021 10:27:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231356AbhJFO1r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Oct 2021 10:27:47 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196DSp9d001008;
        Wed, 6 Oct 2021 10:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rzPMALKGA6XMuv435p9x/PS4RHZse9EyIaUy6qjVuL0=;
 b=NkfdQ8sQZSmHF5RPIQ9VvK0KzNLhHdfbXxWCrbVPoPzqs4vp0/SEFdK6CuU1x+TnMojB
 Mlq+hGZH6pCferJ+3S4aewQ73XJnwwLOr5BvMobiXcCHeKa8n9hZgk5Y7CLsMXymJivx
 5FDHi5vRGwaz/zPxBNX9s8J7MTJKfrfEJQQEfxHCwkWWgbP98OFTppFiY7p4Oeb+5vLy
 zli5w0qgpHc6bKJ9FznTcUBnUBROp3SaGkWJhojdL+CJhePJ5mnDGqrWVQw358UOkV9f
 ngXbtarz8Ryo7orsKtTDyNYHKXv8IsaF3IV3MN+mnPAUs/B4FYOSE+O3etA/6NAyre7l hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhcqk9g4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 10:25:46 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 196DTA6Z002572;
        Wed, 6 Oct 2021 10:25:45 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhcqk9g3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 10:25:45 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 196ECDng030410;
        Wed, 6 Oct 2021 14:25:42 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3bef2a3r8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 14:25:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 196EKJnC55312836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Oct 2021 14:20:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3512311C05B;
        Wed,  6 Oct 2021 14:25:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A4D711C052;
        Wed,  6 Oct 2021 14:25:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Oct 2021 14:25:37 +0000 (GMT)
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Halil Pasic <pasic@linux.ibm.com>, markver@us.ibm.com,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        qemu-devel@nongnu.org
Subject: [PATCH 1/1] virtio: write back F_VERSION_1 before validate
Date:   Wed,  6 Oct 2021 16:25:33 +0200
Message-Id: <20211006142533.2735019-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6SJN1e6Wk8CcV1EJ_v0Cs0lygJFuRqfD
X-Proofpoint-GUID: 6Ww4Q-dWxjfZ_JKOOMojtbiksYxrUCgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_03,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060089
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The virtio specification virtio-v1.1-cs01 states: Transitional devices
MUST detect Legacy drivers by detecting that VIRTIO_F_VERSION_1 has not
been acknowledged by the driver.  This is exactly what QEMU as of 6.1
has done relying solely on VIRTIO_F_VERSION_1 for detecting that.

However, the specification also says: driver MAY read (but MUST NOT
write) the device-specific configuration fields to check that it can
support the device before setting FEATURES_OK.

In that case, any transitional device relying solely on
VIRTIO_F_VERSION_1 for detecting legacy drivers will return data in
legacy format.  In particular, this implies that it is in big endian
format for big endian guests. This naturally confuses the driver which
expects little endian in the modern mode.

It is probably a good idea to amend the spec to clarify that
VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
is complete. However, we already have regression so let's try to address
it.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
Fixes: fe36cbe0671e ("virtio_net: clear MTU when out of range")
Reported-by: markver@us.ibm.com
---
 drivers/virtio/virtio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 0a5b54034d4b..494cfecd3376 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -239,6 +239,16 @@ static int virtio_dev_probe(struct device *_d)
 		driver_features_legacy = driver_features;
 	}
 
+	/*
+	 * Some devices detect legacy solely via F_VERSION_1. Write
+	 * F_VERSION_1 to force LE for these when needed.
+	 */
+	if (drv->validate && !virtio_legacy_is_little_endian()
+			  && BIT_ULL(VIRTIO_F_VERSION_1) & device_features) {
+		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
+		dev->config->finalize_features(dev);
+	}
+
 	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
 		dev->features = driver_features & device_features;
 	else

base-commit: 60a9483534ed0d99090a2ee1d4bb0b8179195f51
-- 
2.25.1

