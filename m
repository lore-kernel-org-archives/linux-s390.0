Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C2C07E96
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 12:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A867260FF3
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 12:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhGOMFG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 08:05:06 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:55998
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232003AbhGOMFG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 08:05:06 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9CE604057E;
        Thu, 15 Jul 2021 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626350530;
        bh=eLZW1fDEYy3o3BzwoAbd7HnBiJwGnZCewM6cIAUrDkQ=;
        h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type;
        b=LK/mkR/XWswD5xktMcKiF+M0Ts8qYjSryqqeSKK6Yebc4XU1RMG2ZaxWjsBLfdkfl
         APLyrU007ZJQLRwj77d86a1cI1WjYAoOx/C15W166FFYNFcMu4bvdtNzpdDX/Tkvrv
         QXhYHn85xjMCE9yDQ/at5n+DMWDMshreFF96Z8YOmv/a7SeEHFVfQ1MdTvUI2KmxqT
         zfOFZrote6kf/nqf3n7t6QVafUe/Mj3UFHmXaxT/qLQrnorASC1ioIMLZP/5BOG2sX
         vx+4mQawrYAZSQtbCQYSL+tTGu6pwsogA9bKhJ14ix1zF/UZi046DPjepIwYxKvj4T
         88QdMaynRGVfA==
To:     Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-s390@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: Range checking on r1 in function reg_set_seen in
 arch/s390/net/bpf_jit_comp.c
Message-ID: <845025d4-11b9-b16d-1dd6-1e0bd66b0e20@canonical.com>
Date:   Thu, 15 Jul 2021 13:02:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi

Static analysis with cppcheck picked up an interesting issue with the
following inline helper function in arch/s390/net/bpf_jit_comp.c :

static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
{
        u32 r1 = reg2hex[b1];

        if (!jit->seen_reg[r1] && r1 >= 6 && r1 <= 15)
                jit->seen_reg[r1] = 1;
}

Although I believe r1 is always within range, the range check on r1 is
being performed before the more cache/memory expensive lookup on
jit->seen_reg[r1].  I can't see why the range change is being performed
after the access of jit->seen_reg[r1]. The following seems more correct:

	if (r1 >= 6 && r1 <= 15 && !jit->seen_reg[r1])
                jit->seen_reg[r1] = 1;

..since the check on r1 are less expensive than !jit->seen_reg[r1] and
also the range check ensures the array access is not out of bounds. I
was just wondering if I'm missing something deeper to why the order is
the way it is.

Colin


