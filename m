Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C24C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 11:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbiETL5R (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 07:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348804AbiETL5Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 07:57:16 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B03E5C0
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 04:57:15 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2A78C3F1B6
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653047832;
        bh=N1+eNvpQfsh94g110W5w3rgDQJpkJTHEsdjZCoxmAwY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=kKYOXWiKHyIx3fEpx4pDR4BgJ9d8FZ1jTvmIHlTKPC8o2PtgKUR/Luj8TqoC95FMU
         7f0k8bHEt8UKB8JDq8IN9+qFu4ZmYnklrLjCxdmd7H7xJuh62v6VSWzSn0GJTav0WF
         NbICFFMGy4dZ7PkAfxCOAN58TF2yoZuxkmYBqE4YxNIMImlCprVGZAhRC3XoQjKVAr
         U8xjD//eYSYe/vksuXlvfvxchHcsIhfP4EvkrjYZGQr1XRe/w1mrNsx1n7LZCZxWcr
         nvo4P14v2dwLzLhnFqcfZOt5Ek/uISDJTooByZkkolQxoccANZyZl8/8pqGRN2tBXN
         DAv/UdwkHhnBA==
Received: by mail-ed1-f69.google.com with SMTP id b14-20020a05640202ce00b0042aa312ff51so5527858edx.18
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 04:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1+eNvpQfsh94g110W5w3rgDQJpkJTHEsdjZCoxmAwY=;
        b=AMpQHeaEuFqKb/rKqM2tODWBb8UJkBYaWjMNVcgkPwcpHX9xIMP8BTI0j+80xl40Tw
         UMPJyQcJ2hu3eaiGp8fdwnQ5RI+YDMJBajoNQo+zdpOXoZbOtCXUzIMZYBm/h5ZijBjH
         nzkD/LC67IZmH+PR1UIX+pczaJ0Mi9XiiILO61os8Mets/q/z23th64N37vc2vfkisJW
         yUac9TRNtx/ctmUoXY+fLsycnOwl0JrPwhkUfZtzz91nbaM2DcK0iUEyQng7w45co/PC
         zqFpT9DqANPGEqU12H8uTQ+9qrVGRz04e0NlvnS/Q2lCt5p4wN3cree8eINBF3yeNtiz
         OL7Q==
X-Gm-Message-State: AOAM530InJ+M2/gwXPf4ljFALXbGUm0s2sFSVtBMh7HfGod7zNVXqIT0
        JLO5NV8JL1S5TiU7Et628zbMjEUh6RelkgRz29r1XDraiPnsbWDJo1bmwwwWFhEztezCYApNXhf
        Y7GYCVYxetfhDO3scl/gODmu5pm5XKdsDbp6uK4c=
X-Received: by 2002:a17:907:3f1d:b0:6f4:ce49:52ea with SMTP id hq29-20020a1709073f1d00b006f4ce4952eamr8223125ejc.47.1653047831914;
        Fri, 20 May 2022 04:57:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMmKUQtizOb5gFlIHePlKnRgA+9mCZD5XoL8J9tsroIrLPb9DgtvpydSoPbeA3cToKYHvbUw==
X-Received: by 2002:a17:907:3f1d:b0:6f4:ce49:52ea with SMTP id hq29-20020a1709073f1d00b006f4ce4952eamr8223118ejc.47.1653047831778;
        Fri, 20 May 2022 04:57:11 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b006fe88802203sm2946451ejb.46.2022.05.20.04.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:57:11 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 0/2] s390: Kconfig: Style cleanups
Date:   Fri, 20 May 2022 13:57:06 +0200
Message-Id: <20220520115708.147841-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The majority of the Kconfig files use a single tab for basic indentation
and a single tab followed by two whitespaces for help text indentation.
Fix the lines that don't follow this convention.

While at it:
  - Add trailing comments to endif/endmenu statements for better
    readability.

Juerg Haefliger (2):
  s390: Kconfig: Fix indentation and add comments
  s390: Kconfig.debug: Fix indentation

 arch/s390/Kconfig       | 20 ++++++++++----------
 arch/s390/Kconfig.debug | 12 ++++++------
 2 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.32.0

