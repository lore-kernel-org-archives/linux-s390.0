Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731428AbgHQRUC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 13:20:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1A8C061389
        for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2020 10:20:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f24so18662498ejx.6
        for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2020 10:20:02 -0700 (PDT)
MIME-Version: 1.0
From: Christian Svensson <christian@cmd.nu>
Date: Mon, 17 Aug 2020 19:19:47 +0200
Message-ID: <CADiuDAQuKZWppo6geDiquAbfak6+Y8MNALtEXcwbAP+MWYa6Pg@mail.gmail.com>
Subject: IUCV 2WAY missing from AF_IUCV?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org

Hi,

[This message was posted to the z/VM and linux-390 message list as well]

I am trying to call TCPIP service using IUCV.
I found AF_IUCV which seemed to do what I want, but reading
more into it it looks like AF_IUCV only ever implemented one-way
SEND operations.

Is that correct?

There appears to exist a message_send and a message_send2way in
the Linux IUCV interface, however only message_send appears to be used
by AF_IUCV.

If my reading is correct, is there any way I can work around this
without writing a kernel module?

Thanks
