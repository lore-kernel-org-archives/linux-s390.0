Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8F3C433FE
	for <linux-s390@archiver.kernel.org>; Wed,  8 Dec 2021 13:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhLHNLk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Dec 2021 08:11:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232273AbhLHNLk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Dec 2021 08:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638968883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wRswzJD1x3jKnE3rGACUJkRTagIOn38Go9vC6IITwlU=;
        b=ej9FycPi2eD4QjnmWoSAJCWGZD/Wx/sY5OnEZjP3DmUwkEeP08/gUbNyq4cLRdJhhOxOYt
        9I0HhaUkl9RYt6x/35hnQjvKDgmvlIlf/YRFcMnNMiQYAcUvzDJJ8jfKaK5eP/duIbdh9W
        p9kWxnQg2Rr4750rS5vFml2ck6fx6E0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-AqQx93YbMFOxphXrAlTsGQ-1; Wed, 08 Dec 2021 08:08:00 -0500
X-MC-Unique: AqQx93YbMFOxphXrAlTsGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C64F0800FEB;
        Wed,  8 Dec 2021 13:07:59 +0000 (UTC)
Received: from workhorse.redhat.com (unknown [10.39.193.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A03E15C23A;
        Wed,  8 Dec 2021 13:07:58 +0000 (UTC)
From:   Philipp Rudo <prudo@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     hca@linux.ibm.com, egorenar@linux.ibm.com, ltao@redhat.com
Subject: [PATCH v3 0/2] s390/kexec_file: improve error handling and messages
Date:   Wed,  8 Dec 2021 14:07:39 +0100
Message-Id: <20211208130741.5821-1-prudo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


Hi everybody,

here is v3.

@Heiko: I hope you are happy now.

Thanks
Philipp

v3:
	- add the symbol name to the error messages

v2:
	- EINVAL -> ENOEXEC
	- print error message when encountering an unknown relocation
	- new patch to print error messages for all error cases in the function

Philipp Rudo (2):
  s390/kexec_file: print some more error messages
  s390/kexec_file: fix error handling when applying relocations

 arch/s390/kernel/machine_kexec_file.c | 34 +++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

-- 
2.31.1

