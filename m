Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58183C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4031A611C7
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhJTRrm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:47:42 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40584 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJTRrX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Oct 2021 13:47:23 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:55312)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeG-00GD0R-Q5; Wed, 20 Oct 2021 11:45:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeE-001NdN-Oo; Wed, 20 Oct 2021 11:45:07 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:43:57 -0500
Message-Id: <20211020174406.17889-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeE-001NdN-Oo;;;mid=<20211020174406.17889-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18e0W1fPCKIpQXaYALvcoXNgExLbZDy/gk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 11/20] signal/s390: Use force_sigsegv in default_trap_handler
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Reading the history it is unclear why default_trap_handler calls
do_exit.  It is not even menthioned in the commit where the change
happened.  My best guess is that because it is unknown why the
exception happened it was desired to guarantee the process never
returned to userspace.

Using do_exit(SIGSEGV) has the problem that it will only terminate one
thread of a process, leaving the process in an undefined state.

Use force_sigsegv(SIGSEGV) instead which effectively has the same
behavior except that is uses the ordinary signal mechanism and
terminates all threads of a process and is generally well defined.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Fixes: ca2ab03237ec ("[PATCH] s390: core changes")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/s390/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index bcefc2173de4..51729ea2cf8e 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -84,7 +84,7 @@ static void default_trap_handler(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		report_user_fault(regs, SIGSEGV, 0);
-		do_exit(SIGSEGV);
+		force_sigsegv(SIGSEGV);
 	} else
 		die(regs, "Unknown program exception");
 }
-- 
2.20.1

