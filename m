Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDD2C07E96
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 13:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8888C61AC0
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 13:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhGFNDW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232602AbhGFNDV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 09:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625576442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aP7YqwaC5NANUQbhXG09G16vw+w7MYUwX72AIDG0OD0=;
        b=CtxrBpcqYpPgJTEbTlXMMHByawucJPYa7a4WwQJOYkZcZoGnae5C139cjTIAxTYOnE40+b
        7mDLGFWn94MSbEqaEgb/ybAh6mko3ANaJP385s5C9Vu/hDYOKpvtNmbcH1rMW3Bqn4WzLX
        7OFRkGADH/b2kZPXzgZScH+VdovWcDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-tie2yMiqMVi3bgSVO2sbqA-1; Tue, 06 Jul 2021 09:00:41 -0400
X-MC-Unique: tie2yMiqMVi3bgSVO2sbqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E2D1100CA89;
        Tue,  6 Jul 2021 13:00:40 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FFB319D9D;
        Tue,  6 Jul 2021 13:00:36 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 4/5] lib: s390x: Print if a pgm
 happened while in SIE
In-Reply-To: <20210706121757.24070-5-frankja@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210706121757.24070-1-frankja@linux.ibm.com>
 <20210706121757.24070-5-frankja@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 06 Jul 2021 15:00:34 +0200
Message-ID: <878s2jha19.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 06 2021, Janosch Frank <frankja@linux.ibm.com> wrote:

> For debugging it helps if you know if the PGM happened while being in
> SIE or not.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/interrupt.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

