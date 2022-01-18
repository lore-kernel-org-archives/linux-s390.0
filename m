Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC3CC43217
	for <linux-s390@archiver.kernel.org>; Tue, 18 Jan 2022 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347213AbiARQTC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:19:02 -0500
Received: from foss.arm.com ([217.140.110.172]:60646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236454AbiARQSe (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Jan 2022 11:18:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90C001FB;
        Tue, 18 Jan 2022 08:18:33 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFC523F774;
        Tue, 18 Jan 2022 08:18:31 -0800 (PST)
Date:   Tue, 18 Jan 2022 16:18:40 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com,
        imbrenda@linux.ibm.com, david@redhat.com, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [kvm-unit-tests] Permitted license for new library
Message-ID: <YeboYFQQtuQH1+Rf@monolith.localdoman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello,

I would like to know what licenses are permitted when adding a new library
to kvm-unit-tests (similar to libfdt). Is it enough if the library is
licensed under one of the GPLv2 compatible licenses [1] or are certain
licenses from that list not accepted for kvm-unit-tests?

[1] https://www.gnu.org/licenses/license-list.html#GPLCompatibleLicenses

Thanks,
Alex
