Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53DCC433F5
	for <linux-s390@archiver.kernel.org>; Tue,  7 Dec 2021 12:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhLGNBf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236706AbhLGNBe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Dec 2021 08:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638881883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F7IUN5dNHNGa66F/DHngfKMKHByGUtfTF2KZxIjGTME=;
        b=AANZ4jevFKNgAxQeVI3dzsN52g789FDCyhY/3ZYVxSRC6awYEsox7biKYDhO/RUxxU0kr3
        iuM48+E65RxMzijKFC3xaHggNqriobNvRKfK+7Wd1QgH+F8Q/cXX6BRq7HXmzcmEZabK/u
        jalR9yJGW1PIb26M06k6jX4ZCwjjOy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-pewo1wNwP7SJOc-JJph9GA-1; Tue, 07 Dec 2021 07:58:00 -0500
X-MC-Unique: pewo1wNwP7SJOc-JJph9GA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 468D785C86D;
        Tue,  7 Dec 2021 12:57:59 +0000 (UTC)
Received: from workhorse.redhat.com (unknown [10.39.192.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20FAF5D6BA;
        Tue,  7 Dec 2021 12:57:57 +0000 (UTC)
From:   Philipp Rudo <prudo@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     hca@linux.ibm.com, egorenar@linux.ibm.com, ltao@redhat.com
Subject: [PATCH v2 0/2] s390/kexec_file: improve error handling and messages
Date:   Tue,  7 Dec 2021 13:57:47 +0100
Message-Id: <20211207125749.6998-1-prudo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi everybody,

here is v2 of the patch I sent yesterday.

Thanks
Philipp

v2:
	- EINVAL -> ENOEXEC
	- print error message when encountering an unknown relocation
	- new patch to print error messages for all error cases in the function

Philipp Rudo (2):
  s390/kexec_file: print some more error messages
  s390/kexec_file: fix error handling when applying relocations

 arch/s390/kernel/machine_kexec_file.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

-- 
2.31.1

