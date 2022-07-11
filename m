Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C8FC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 10:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiGKKdn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 06:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGKKdT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 06:33:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45346286D3
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 02:43:57 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B8FNAT002866;
        Mon, 11 Jul 2022 09:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=L6nK1HTJs3obWwk+ljZ2j3Y10HjNuq9KKzXTw1l0KDE=;
 b=Tv/hAJgNy1ixv4f5zFLTxZAYPzy9s937mprmLKB3aMMrdGTGgwW9GXk6EMwLiLxD7DP1
 PBN+I4fZGjx652GQNoIEtuegHTEsRn0/9Jnrl37XoDLPvM8Ca+6iZVwIn+YaDt0Xoyec
 9/DdxXdkTMJhk5jLMZFFiCyqkFjwZLgBUyLpehoUhkIoPfmAb4Jwm6VQXzq4Lx6YQpZF
 eL2xi1p9voCyamOyA+LLtblQwPyQEkdJVAo3NOmlNc7jUs+4JXP3w+vv5Qn4+4ToPmHD
 VF1kOy1nUs9mTl7n3W100sz/5zF8EXvtaPil//XqzR9WVk6FNo+3VVuun35/Lh3d1RZK MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h83whnyjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:43:55 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26B8tkBk015793;
        Mon, 11 Jul 2022 09:43:54 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h83whnyj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:43:54 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26B9a8j9023371;
        Mon, 11 Jul 2022 09:43:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3h70xhswh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:43:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26B9hn0615597970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 09:43:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8E4FA405D;
        Mon, 11 Jul 2022 09:43:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7C7AA4040;
        Mon, 11 Jul 2022 09:43:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Jul 2022 09:43:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 6854BE030B; Mon, 11 Jul 2022 11:43:49 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v2] trace-cmd: fix writing of uncompressed size
Date:   Mon, 11 Jul 2022 11:43:40 +0200
Message-Id: <20220711094340.2829115-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EcQeJhc4DR1fkrtSwK_UsWcyF3dAmAs-
X-Proofpoint-ORIG-GUID: l_5IjszsdpqNZzwM3MOs3nFNb7yKApai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_15,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=853 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110040
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

pointer in struct tracecmd_compression is 'unsigned long', which is 8 byte
in size on most platforms, but the tep_read_number() call in the next line
treats it as a 4 byte value. As there's no need for unsigned long change
the type to unsigned int.

Fixes: 3f8447b1 ("trace-cmd library: Add support for compression algorithms")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 lib/trace-cmd/trace-compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/trace-cmd/trace-compress.c b/lib/trace-cmd/trace-compress.c
index a63295e..461de8d 100644
--- a/lib/trace-cmd/trace-compress.c
+++ b/lib/trace-cmd/trace-compress.c
@@ -32,7 +32,7 @@ struct tracecmd_compression {
 	int				fd;
 	unsigned int			capacity;
 	unsigned int			capacity_read;
-	unsigned long			pointer;
+	unsigned int			pointer;
 	char				*buffer;
 	struct compress_proto		*proto;
 	struct tep_handle		*tep;
-- 
2.36.1

