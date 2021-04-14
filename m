Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EB4C433B4
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 17:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E84611F0
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 17:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347363AbhDNRvY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Apr 2021 13:51:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21690 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236918AbhDNRvX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Apr 2021 13:51:23 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EHX7IZ015247;
        Wed, 14 Apr 2021 13:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=WfgXuFqCocKI8cjboJAgQRGenlLQS0CmotFyXw0ZvWQ=;
 b=UDgcSIvHNqThesFwecIfIYqIk9KBj1lgBwWiVebW/ogMY73hJusq9pbJ6Lu1FS5bMIAn
 5OEZfmOmULLCu9BLT0uxUBAOU+OZQ7KTOkIzIRzQQEvBMVxIaXnL3jAzB37u1Ai/EF7J
 /BrqPn953PjLC3cWMLls17/WmQS56kLYL4rYcqS/JxWLKxxExxfc0fLRtY6oh+5A4Rc8
 aV5EEmww0FqpAeEDKQ+Aj75tR51OJLCmSYdq4X6gJ3fLpWQS4MRqdGeD15vSW0/5KuAf
 TlCB56oSEb907mgRYR6wfFCY0zRtBvgGFzCbdTupqi3txQ8f/r7Z3/rqssCZL+W2aSlu IA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37x46u9hnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 13:51:01 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13EHmQbS020172;
        Wed, 14 Apr 2021 17:50:59 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 37u3n8uesy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 17:50:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13EHoudC13697474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 17:50:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B978A407D;
        Wed, 14 Apr 2021 17:50:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AA36A4068;
        Wed, 14 Apr 2021 17:50:56 +0000 (GMT)
Received: from osiris (unknown [9.171.48.167])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 14 Apr 2021 17:50:55 +0000 (GMT)
Date:   Wed, 14 Apr 2021 19:50:55 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.12-rc8 / 5.12
Message-ID: <YHcrf6Z0BkFU/F7j@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c2ZlawF-CvFMaZGCsVAzL9xqxzruQoDP
X-Proofpoint-ORIG-GUID: c2ZlawF-CvFMaZGCsVAzL9xqxzruQoDP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_10:2021-04-14,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0
 phishscore=0 mlxlogscore=427 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104140115
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linux,

please pull two small s390 patches. This is also supposed to be the
last s390 pull request for 5.12. There are no known bugs left.

Thanks,
Heiko

The following changes since commit ad31a8c05196a3dc5283b193e9c74a72022d3c65:

  s390/setup: use memblock_free_late() to free old stack (2021-04-07 14:37:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-7

for you to fetch changes up to a994eddb947ea9ebb7b14d9a1267001699f0a136:

  s390/entry: save the caller of psw_idle (2021-04-12 12:44:31 +0200)

----------------------------------------------------------------
s390 updates

- setup stack backchain properly in external and i/o interrupt handler
  to fix stack unwinding. This broke when converting to generic entry.

- save caller address of psw_idle to get a sane stacktrace.

----------------------------------------------------------------
Vasily Gorbik (2):
      s390/entry: avoid setting up backchain in ext|io handlers
      s390/entry: save the caller of psw_idle

 arch/s390/kernel/entry.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index c10b9f31eef7..12de7a9c85b3 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -401,15 +401,13 @@ ENTRY(\name)
 	brasl	%r14,.Lcleanup_sie_int
 #endif
 0:	CHECK_STACK __LC_SAVE_AREA_ASYNC
-	lgr	%r11,%r15
 	aghi	%r15,-(STACK_FRAME_OVERHEAD + __PT_SIZE)
-	stg	%r11,__SF_BACKCHAIN(%r15)
 	j	2f
 1:	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	lctlg	%c1,%c1,__LC_KERNEL_ASCE
 	lg	%r15,__LC_KERNEL_STACK
-	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
-2:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
+2:	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
+	la	%r11,STACK_FRAME_OVERHEAD(%r15)
 	stmg	%r0,%r7,__PT_R0(%r11)
 	# clear user controlled registers to prevent speculative use
 	xgr	%r0,%r0
@@ -445,6 +443,7 @@ INT_HANDLER io_int_handler,__LC_IO_OLD_PSW,do_io_irq
  * Load idle PSW.
  */
 ENTRY(psw_idle)
+	stg	%r14,(__SF_GPRS+8*8)(%r15)
 	stg	%r3,__SF_EMPTY(%r15)
 	larl	%r1,psw_idle_exit
 	stg	%r1,__SF_EMPTY+8(%r15)
