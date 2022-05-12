Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22838C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 12 May 2022 15:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355535AbiELPUK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 May 2022 11:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352082AbiELPUJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 May 2022 11:20:09 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A629C1F8F39;
        Thu, 12 May 2022 08:20:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id D2C691E80D22;
        Thu, 12 May 2022 23:14:30 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VLbsjclGr_jR; Thu, 12 May 2022 23:14:28 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 195011E80D04;
        Thu, 12 May 2022 23:14:28 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     rostedt@goodmis.org
Cc:     agordeev@linux.ibm.com, aou@eecs.berkeley.edu,
        borntraeger@linux.ibm.com, bp@alien8.de,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        hpa@zytor.com, kunyu@nfschina.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, svens@linux.ibm.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH] kernel: Ftrace seems to have functions to improve performance through optimization
Date:   Thu, 12 May 2022 23:19:50 +0800
Message-Id: <20220512151951.58197-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220512110725.22e69e3c@gandalf.local.home>
References: <20220512110725.22e69e3c@gandalf.local.home>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


Thank you very much. Could I modify the description information of this patch and submit it again.

