Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AA7C6FA82
	for <linux-s390@archiver.kernel.org>; Fri,  9 Sep 2022 12:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiIIMGQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Sep 2022 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIIMGQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Sep 2022 08:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354E7A0610
        for <linux-s390@vger.kernel.org>; Fri,  9 Sep 2022 05:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662725173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=2DCNWHXX9qTrKwJ1OlZVUwBGEQDst43l7Dwm4pMW4nU=;
        b=DjSQi179S/z/o2LVoT4/iT4XDWpW2gr6F88b/PlToubnbj/MRrPsawBWOcTCOCSK9AhJWm
        haq+ln9jIYpk9Hemz78d3OKH5+eFesN59Ki6k7ynqMLmP3mZh5ZpD/XxWc1amtusDzx0xd
        Xo0yba6C4UsfyX2By6HT6knJj4L4b2A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-S6wDehrfNDGnzALvHfmx2A-1; Fri, 09 Sep 2022 08:06:12 -0400
X-MC-Unique: S6wDehrfNDGnzALvHfmx2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B37631818802
        for <linux-s390@vger.kernel.org>; Fri,  9 Sep 2022 12:06:11 +0000 (UTC)
Received: from localhost (unknown [10.39.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 710312026D4C
        for <linux-s390@vger.kernel.org>; Fri,  9 Sep 2022 12:06:11 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     linux-s390@vger.kernel.org
Subject: Who cares about Documentation/ABI/testing/sysfs-bus-css?
Organization: Red Hat GmbH
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date:   Fri, 09 Sep 2022 14:06:09 +0200
Message-ID: <8735d0oiq6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

I had initially added the file in $SUBJECT ages ago after the common I/O
layer had been converted to the driver model, and added to it later
on. However,

- this file does not look exhaustive
- most entries still list my old IBM email address
- I'm not sure how up-to-date the entries are in general
- nobody will care about HAL[1] nowadays :)

The good news is that the linux-s390 list is listed as a contact as
well, but I'd like to get my name removed, as I'm not really involved
with the common I/O layer anymore.

Is this file of any use? If so, would it be ok to simply list the
mailing list as a contact?


[1] _not_ a computer that doesn't let you do things, but a tool that
attempted to handle devices attached to a system, which has been
abandoned long ago

