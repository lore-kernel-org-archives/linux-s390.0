Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B47C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 15:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355077AbiCPPHz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347402AbiCPPHr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 11:07:47 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88554245B6
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 08:06:33 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B72C83F618
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443188;
        bh=YN/pEmxY5lmFXd8VsSTx/x5950RRmwZUldBJe65d5RE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=OJ6zhCcA3bygcEG+18xSTTYl7kXNkIzbYmQwfETZMYJa2CrRB7AGUTrMv8arVs25N
         NNLvQllxEQeEPVOgDQOkHi+RFu7gGqNfpmZivE9JQYJ4IJYR3Ub113/UtT2jKj4Lid
         Sz/uwD0HI3PTPo7LVVVLD7n/XliXVbN3l14h22eu14v4oudijSOIKA1KzxxNpbpJTw
         tjoODE/3qjfumlsN+rCLkb0JE2P/GmysM5Yc5IQTnXKAzzyRTO9r3CZPXxveQX82pi
         qVvXgwVJvrLNyMO2YhH5S8PF4+uLbcAkRikofXOtZ6MAOUixBVwlVRwHxDHntVLBcU
         Wtkj8Itx430iw==
Received: by mail-wr1-f72.google.com with SMTP id j44-20020adf912f000000b00203a5a55817so657698wrj.13
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 08:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YN/pEmxY5lmFXd8VsSTx/x5950RRmwZUldBJe65d5RE=;
        b=45M6GUgKO+dIX4TE8Lw/OYQYP8zJCBvyAcMt/OL0quCMsx0woJfyA2RG11BPlX52o4
         81IT8ydc+jz2VGmgW60bnKGIHqOYOpbAdeiDVwhoCXEs5S/hN2N4AexoiLgQGmSgsCd3
         OubeDYKnChvyJi1wueieSf5yxcoGcwle8EaE4I7pHo3H/iLwYGm31B+DoZAt4jwjq45b
         xeJlZX11F3dmgvh4zAFBaD3M1hSr2DEO8rPSQgFUwunNAzx8EMzv213+q7LriOEKqoK2
         ZLQ9YD2QfCumzVAx5vFOw968mG3hUt+NYcIJO18yJRY+EuXoLn43sbVD7P2W1Ld9kJUA
         QAjQ==
X-Gm-Message-State: AOAM532JGdTmhXsdg76Xvwf5maHXyYCInZgzAMMxHFtAAXeZpGnDdEq9
        J5YXMDkeBKesdJIMuP0rSmstANj6eoukJKs7lBnft2TjKpNVV58+RDNqxhbw4zOD1k9zfLNEE6r
        AKnVkEBrKcVL19Fkj3IBfLFqFJp3rAftEHaHOWWI=
X-Received: by 2002:adf:d1e3:0:b0:1f1:f268:aea1 with SMTP id g3-20020adfd1e3000000b001f1f268aea1mr286257wrd.463.1647443184105;
        Wed, 16 Mar 2022 08:06:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK/0iXUCy7W2hGO6fQCeqBcBjEbHGvRHvC+ntVQfT1EKGUSf6rpLBWwFreMjWSWRs9UQG0wA==
X-Received: by 2002:adf:d1e3:0:b0:1f1:f268:aea1 with SMTP id g3-20020adfd1e3000000b001f1f268aea1mr286217wrd.463.1647443183806;
        Wed, 16 Mar 2022 08:06:23 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d59ae000000b00203dcc87d39sm3130155wrr.54.2022.03.16.08.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:06:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v5 00/11] Fix broken usage of driver_override (and kfree of static memory)
Date:   Wed, 16 Mar 2022 16:05:22 +0100
Message-Id: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

This is a continuation of my old patchset from 2019. [1]
Back then, few drivers set driver_override wrong. I fixed Exynos
in a different way after discussions. QCOM NGD was not fixed
and a new user appeared - IMX SCU.

It seems "char *" in driver_override looks too consty, so we
tend to make a mistake of storing there string literals.

Changes since latest v4
=======================
1. Correct commit msgs and comments after Andy's review.
2. Re-order code in new helper (patch #1) (Andy).
3. Add tags.

Changes since latest v3
=======================
1. Wrap comments, extend comment in driver_set_override() about newline.
2. Minor commit msg fixes.
3. Add tags.

Changes since latest v2
=======================
1. Make all driver_override fields as "const char *", just like SPI
   and VDPA. (Mark)
2. Move "count" check to the new helper and add "count" argument. (Michael)
3. Fix typos in docs, patch subject. Extend doc. (Michael, Bjorn)
4. Compare pointers to reduce number of string readings in the helper.
5. Fix clk-imx return value.

Changes since latest v1 (not the old 2019 solution):
====================================================
https://lore.kernel.org/all/708eabb1-7b35-d525-d4c3-451d4a3de84f@rasmusvillemoes.dk/
1. Add helper for setting driver_override.
2. Use the helper.

Dependencies (and stable):
==========================
1. All patches, including last three fixes, depend on the first patch
   introducing the helper.
2. The last three commits - fixes - are probably not backportable
   directly, because of this dependency. I don't know how to express
   this dependency here, since stable-kernel-rules.rst mentions only commits as
   possible dependencies.

[1] https://lore.kernel.org/all/1550484960-2392-3-git-send-email-krzk@kernel.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (11):
  driver: platform: Add helper for safer setting of driver_override
  amba: Use driver_set_override() instead of open-coding
  fsl-mc: Use driver_set_override() instead of open-coding
  hv: Use driver_set_override() instead of open-coding
  PCI: Use driver_set_override() instead of open-coding
  s390/cio: Use driver_set_override() instead of open-coding
  spi: Use helper for safer setting of driver_override
  vdpa: Use helper for safer setting of driver_override
  clk: imx: scu: Fix kfree() of static memory on setting driver_override
  slimbus: qcom-ngd: Fix kfree() of static memory on setting
    driver_override
  rpmsg: Fix kfree() of static memory on setting driver_override

 drivers/amba/bus.c              | 28 +++--------------
 drivers/base/driver.c           | 56 +++++++++++++++++++++++++++++++++
 drivers/base/platform.c         | 28 +++--------------
 drivers/bus/fsl-mc/fsl-mc-bus.c | 25 +++------------
 drivers/clk/imx/clk-scu.c       |  7 ++++-
 drivers/hv/vmbus_drv.c          | 28 +++--------------
 drivers/pci/pci-sysfs.c         | 28 +++--------------
 drivers/rpmsg/rpmsg_core.c      |  3 +-
 drivers/rpmsg/rpmsg_internal.h  | 11 +++++--
 drivers/rpmsg/rpmsg_ns.c        | 14 +++++++--
 drivers/s390/cio/cio.h          |  6 +++-
 drivers/s390/cio/css.c          | 28 +++--------------
 drivers/slimbus/qcom-ngd-ctrl.c | 13 +++++++-
 drivers/spi/spi.c               | 26 +++------------
 drivers/vdpa/vdpa.c             | 29 +++--------------
 include/linux/amba/bus.h        |  6 +++-
 include/linux/device/driver.h   |  2 ++
 include/linux/fsl/mc.h          |  6 ++--
 include/linux/hyperv.h          |  6 +++-
 include/linux/pci.h             |  6 +++-
 include/linux/platform_device.h |  6 +++-
 include/linux/rpmsg.h           |  6 ++--
 include/linux/spi/spi.h         |  2 ++
 include/linux/vdpa.h            |  4 ++-
 24 files changed, 169 insertions(+), 205 deletions(-)

-- 
2.32.0

