Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6439BC433FE
	for <linux-s390@archiver.kernel.org>; Mon, 15 Nov 2021 21:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBBE61AFF
	for <linux-s390@archiver.kernel.org>; Mon, 15 Nov 2021 21:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbhKOVGb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:06:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348797AbhKOUAG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Nov 2021 15:00:06 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFJEbVL018128;
        Mon, 15 Nov 2021 19:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tju5j9Q8Scs4QgRKlylofcoylDnSmWDyWRsQlcKS+Is=;
 b=Re60ILRiJjwvQAODZhLwMUTsoiEsvbEQAHOPSFaOPGSCYpjuM+Whc9DzpHvhUXahYSbf
 bUNDEfjIZPL0QxW0w60TNVqxOpU09oZDcNT8CzJ2apvXf38MRu0dsFNqSeewSwNq0k/n
 Fg5FKNEUTnKFG8Wwwo/u6+RbiHRfxJukxnb4Gv7O/fIxumRR3Nxw2JcfUsbMRRL15ZFt
 /E+RICU6NaLcYE3uFhy5DeJVsn+5sT4CLLxYdQoBgKu0A/kgMO1gmma2Ecacjr2X+b9c
 S6oxjskjGtpjkMxLQeh1/VynVsKHieJn4Z5FUcFSnBzq5UuzBO7QldkQr59ZbjBILaj7 BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cbwhnrrjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 19:56:52 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AFJsVwT020039;
        Mon, 15 Nov 2021 19:56:51 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cbwhnrrhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 19:56:51 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AFJrUdg005145;
        Mon, 15 Nov 2021 19:56:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3ca4mjha36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 19:56:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AFJulFg5440034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 19:56:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 254EE4C040;
        Mon, 15 Nov 2021 19:56:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB03B4C044;
        Mon, 15 Nov 2021 19:56:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Nov 2021 19:56:46 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 0/2] ftrace/samples: fix ftrace direct multi config option + s390 support
Date:   Mon, 15 Nov 2021 20:56:12 +0100
Message-Id: <20211115195614.3173346-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: esXm-Tdh4dGSCNYswlOfHDj4c45qUbXy
X-Proofpoint-GUID: XwqQP4kB9SxZw3TVZgAAXcDv9MSh5v_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_15,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150098
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Steven,

two patches for ftrace direct multi sample:

- fix ftrace direct multi sample config option handling, required
  because of an incorrect merge resolution proposed by me.

- add s390 support for ftrace direct multi sample

If you are happy with them, I could carry with the s390 tree and
target for rc2, or you could pick them up. Whatever you prefer.

Thanks,
Heiko

Heiko Carstens (2):
  ftrace/samples: add missing Kconfig option for ftrace direct multi sample
  ftrace/samples: add s390 support for ftrace direct multi sample

 arch/s390/Kconfig                    |  1 +
 arch/x86/Kconfig                     |  2 +-
 samples/Kconfig                      | 11 +++++++++-
 samples/Makefile                     |  2 +-
 samples/ftrace/Makefile              |  2 +-
 samples/ftrace/ftrace-direct-multi.c | 30 ++++++++++++++++++++++++++++
 6 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.25.1

