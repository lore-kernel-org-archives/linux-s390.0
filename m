Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B71C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  2 Nov 2021 15:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6823860F5A
	for <linux-s390@archiver.kernel.org>; Tue,  2 Nov 2021 15:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhKBPpc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234338AbhKBPpb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Nov 2021 11:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635867776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hmf3Z3zJN3btWcgJZ06W3LVajlk/1vZ9TBv+pXreN/U=;
        b=IMAUenSVX1WQHjZGDXOxEeTA51pvLjpuLfUGJO6wqMPqcC57YCL0nDKJaHfIeiYZPBiRs/
        FvtHQUos1S5/KoHX2EF9nyUBh/EeP+TjjGmH/lk6NtAiDIZTnPKN/x69tkTwIVk45Nhm+w
        +FnTGvRxaJu3OSBqXu/fnT1J7NooSao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-VLURPoETOhih9IlRwqnyDQ-1; Tue, 02 Nov 2021 11:42:55 -0400
X-MC-Unique: VLURPoETOhih9IlRwqnyDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 221CE5074D;
        Tue,  2 Nov 2021 15:42:54 +0000 (UTC)
Received: from localhost (unknown [10.39.193.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF84F60D30;
        Tue,  2 Nov 2021 15:42:53 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, vneethv@linux.ibm.com
Subject: Re: [PATCH] s390/cio: remove uevent suppress from cio driver
In-Reply-To: <20211027085059.544736-2-vneethv@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211027085059.544736-1-vneethv@linux.ibm.com>
 <20211027085059.544736-2-vneethv@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 02 Nov 2021 16:42:52 +0100
Message-ID: <87ilxabm2r.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 27 2021, Vineeth Vijayan <vneethv@linux.ibm.com> wrote:

> 'commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")'
> introduced the uevent suppression of subchannels. Even though there
> are reasons for wanting to delay the uevent, it also introduces
> problems. As part of cleaning-up the css driver,this patch removes
> the uevent-suppress logic. The ADD uevent will be generated when
> there is a valid subchannel and not after finding the associated
> device. Removing the uevent suppress logic also introduces a new BIND
> uevent associated to the channel-subsystem.

Hm, I'd probably put that a bit differently:

commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")
introduced suppression of uevents for a subchannel until after it is
clear that the subchannel would not be unregistered again
immediately. This was done to avoid uevents being generated for I/O
subchannels with no valid device, which can happen on LPAR.

However, this also has some drawbacks: All subchannel drivers need to
manually remove the uevent suppression and generate an ADD uevent as
soon as they are sure that the subchannel will stay around. This misses
out on all uevents that are not the initial ADD uevent that would be
generated while uevents are suppressed; for example, all subchannels
were missing the BIND uevent.

As uevents being generated even for I/O subchannels without an
operational device turned out to be not as bad as missing uevents and
complicating the code flow, let's remove uevent suppression for
subchannels.

>
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> ---
>  drivers/s390/cio/chsc_sch.c     |  5 -----
>  drivers/s390/cio/css.c          | 19 -------------------
>  drivers/s390/cio/device.c       | 18 ------------------
>  drivers/s390/cio/eadm_sch.c     |  5 -----
>  drivers/s390/cio/vfio_ccw_drv.c |  5 -----
>  5 files changed, 52 deletions(-)

Patch looks sane to me, but I'll have to rely on your testing :)

