Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98CBC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 07:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiGKHof (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 03:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGKHoe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 03:44:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BA613D7D
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 00:44:33 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B5c0vL014445;
        Mon, 11 Jul 2022 07:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=V/dJnDvD0k2no5KkQKP1NFv1ecUmiq1rAiROL+HwMC8=;
 b=ZlvKZTabp4hLCijBSjcaOT8pkTOUsz65g24Yu/QWMtOPrW6yRP3/cDTG2APnM3E8Gwdl
 VbXy/CMVS5pDb+RXX4SOXaaDaCNIx1CS9gCS6H3wsNw3RvjmR/aO7wcbClNwQJ+0JoV5
 7SzpNi8/KpPlKxiGiJczyYqZo0bqiGDRNt4kAFtWPRsvVnGvin5j1JdhYA04lYeQuMxQ
 mT0g46p1HzjuO/6pUJ1XW/45IXuI7XVqh+zslOhFHw+gLEqSFN4GPu0MpCee/C090eC6
 XDozI8N5FetXiMeTtwlOOco7CVAdNdQp8d5UhZq9keyuYoNkHnXeZ/Ml8ryZax0coTP1 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h84dgb26u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 07:44:32 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26B7aWdp017672;
        Mon, 11 Jul 2022 07:44:31 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h84dgb263-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 07:44:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26B7Xv3u015040;
        Mon, 11 Jul 2022 07:44:29 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a8tc8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 07:44:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26B7h0XX19136834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 07:43:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEF2CA405F;
        Mon, 11 Jul 2022 07:44:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCBAAA405C;
        Mon, 11 Jul 2022 07:44:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Jul 2022 07:44:26 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 9AF41E030B; Mon, 11 Jul 2022 09:44:26 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] trace-cmd: fix writing of uncompressed size
Date:   Mon, 11 Jul 2022 09:44:18 +0200
Message-Id: <20220711074418.858843-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LiZsK5iMBBAUzhgtOQAwZXaQkS2nlnSv
X-Proofpoint-ORIG-GUID: 09W6ko-sBXCxA8cwBeEWu4ulMMRWz6c5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_13,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=784
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207110030
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Pass &size instead of &handle->pointer. Interestingly this doesn't hurt
on x86, but makes trace-cmd fail on s390.

Fixes: 3f8447b1 ("trace-cmd library: Add support for compression algorithms")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 lib/trace-cmd/trace-compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/trace-cmd/trace-compress.c b/lib/trace-cmd/trace-compress.c
index a63295e..ad9b7fc 100644
--- a/lib/trace-cmd/trace-compress.c
+++ b/lib/trace-cmd/trace-compress.c
@@ -331,7 +331,7 @@ int tracecmd_compress_block(struct tracecmd_compression *handle)
 		goto out;
 
 	/* Write uncompressed data size */
-	endian4 = tep_read_number(handle->tep, &handle->pointer, 4);
+	endian4 = tep_read_number(handle->tep, &size, 4);
 	ret = do_write(handle, &endian4, 4);
 	if (ret != 4) {
 		ret = -1;
-- 
2.36.1

