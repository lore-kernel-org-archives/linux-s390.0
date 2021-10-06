Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E587C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  6 Oct 2021 16:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391B961076
	for <linux-s390@archiver.kernel.org>; Wed,  6 Oct 2021 16:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbhJFQDY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239308AbhJFQDX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Oct 2021 12:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633536091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEl+i4Q5vQVY6PXzlnIHOyFJNjpzsr4LDFHpJofizVs=;
        b=HKXfQdPA7wm+2XnzAILiJ62pgsgTJG6RVBY5iYZGNG6cvrUN3u2pqXJdlQ6TkFfI17o9PT
        GfeSqvrrv7tIKSGlc6If1gZ7Ym9cTJAcMzcIxGn4cJWdSTwOpBWu30SV3JXt7DadeRUfiC
        oVWtVrWKW7t3gCfGvrdHXO2s5fYoyG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-Dnva_suzO-KGrXuU2kNM7w-1; Wed, 06 Oct 2021 12:01:29 -0400
X-MC-Unique: Dnva_suzO-KGrXuU2kNM7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF44018125C1;
        Wed,  6 Oct 2021 16:01:28 +0000 (UTC)
Received: from gondolin.fritz.box (unknown [10.39.193.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 459C960936;
        Wed,  6 Oct 2021 16:01:27 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 2/2] vfio-ccw: step down as maintainer
Date:   Wed,  6 Oct 2021 18:01:20 +0200
Message-Id: <20211006160120.217636-3-cohuck@redhat.com>
In-Reply-To: <20211006160120.217636-1-cohuck@redhat.com>
References: <20211006160120.217636-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

I currently don't have time to act as vfio-ccw maintainer
anymore, but I trust that I leave it in capable hands.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0149e1a3e65e..92db89512678 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16374,7 +16374,6 @@ F:	drivers/s390/crypto/vfio_ap_ops.c
 F:	drivers/s390/crypto/vfio_ap_private.h
 
 S390 VFIO-CCW DRIVER
-M:	Cornelia Huck <cohuck@redhat.com>
 M:	Eric Farman <farman@linux.ibm.com>
 M:	Matthew Rosato <mjrosato@linux.ibm.com>
 R:	Halil Pasic <pasic@linux.ibm.com>
-- 
2.31.1

