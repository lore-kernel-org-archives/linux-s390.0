Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA85EB64DD
	for <linux-s390@archiver.kernel.org>; Tue, 25 Jul 2023 21:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGYVLK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGYVLJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Jul 2023 17:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C231019A4
        for <linux-s390@vger.kernel.org>; Tue, 25 Jul 2023 14:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54FA7618EA
        for <linux-s390@vger.kernel.org>; Tue, 25 Jul 2023 21:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824EBC433C8;
        Tue, 25 Jul 2023 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690319467;
        bh=+Anp/Tvfifcb/2i1tHW6p0PTF0Blh5VqYQgrdfWQsJ4=;
        h=Date:From:To:Cc:Subject:From;
        b=bhIIdB0bMix8evjUhFe/myKBxPF/jYRVG2CeauJzxEija7c1tU8C/zmmEVHS6NIS1
         Zxi7hK5D84O7Z+/wH1CTtZS/N3H1LOVuUWB5CN5IKke9HwX2KDwzkk4ZN5T8WuxHCm
         Ki0RNsOBJh4nEMlC23j6pC5BaybRYnBgx5NsRP4RjkhPmLeUnn1F4BxSlg+d/OxCyq
         plQsVJqOiPRwa3YBp8VNxw8vjFtJHkKgoASdLUDzS3j7igrsnotheBiVrog0pTydbC
         +Aqeknd7aKwsnltSXxXbN2xa99rsQQ3HRpaZWc2fBkrh24rbBpxBz2HVgT4HNcZtvC
         qbCIdlYtb+1cA==
Date:   Tue, 25 Jul 2023 14:11:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org
Subject: Build error around 'aghik' after commit 1256e70a082a ("s390/ftrace:
 enable HAVE_FUNCTION_GRAPH_RETVAL")
Message-ID: <20230725211105.GA224840@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Sven and Heiko,

Apologies if this has been reported/fixed already, I checked the s390
tree but I did not see any changes there nor did I find anything when
searching lore. After commit 1256e70a082a ("s390/ftrace: enable
HAVE_FUNCTION_GRAPH_RETVAL") in -next, I see the following errors when
building Debian's configuration [1], which selects CONFIG_MARCH_Z10=y.

GCC/binutils:

  arch/s390/kernel/mcount.S: Assembler messages:
  arch/s390/kernel/mcount.S:140: Error: Unrecognized opcode: `aghik'

clang:

  arch/s390/kernel/mcount.S:140:2: error: instruction requires: distinct-ops
   aghik %r3,%r15,160
   ^

It seems like there is already some handling for this situation in
mcount.S but my knowledge of s390 assembly is basically non-existent,
hence this report in lieu of a patch. I am more than happy to provide
any additional information or test any patches if necessary.

[1]: https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/config/s390x/config

Cheers,
Nathan
