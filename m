Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31501C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 22 Nov 2021 17:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbhKVRpM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:45:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237678AbhKVRpL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Nov 2021 12:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637602924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o4mlm08P1WadObb1MlpqsGPkZDJK+PxDrwM0H9rW8xg=;
        b=YJkFU5gRM63b+zs4tPCwZyEIpIbcNR+qfC7ns9eKdMvv+1Ar7lyiixCs3LaTdFhK4W5TKy
        BK1MDoyirNZ1dmmwAFVY5KHOg+rMduDWBPsuBYNeBBcvkgasNksoWgkU5DHeuJVMMn8hqk
        vn+txsIy9Y8CdCLtCFRk6kLVPNkHmwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-_48uOA2eMZ6o0pX6_T9r7Q-1; Mon, 22 Nov 2021 12:42:02 -0500
X-MC-Unique: _48uOA2eMZ6o0pX6_T9r7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C71491966321;
        Mon, 22 Nov 2021 17:42:01 +0000 (UTC)
Received: from localhost (unknown [10.2.17.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65EA360C7F;
        Mon, 22 Nov 2021 17:42:01 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, vneethv@linux.ibm.com
Subject: Re: [RFC v3 1/1] s390/cio: remove uevent suppress from cio driver
In-Reply-To: <20211122103756.352463-2-vneethv@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211122103756.352463-1-vneethv@linux.ibm.com>
 <20211122103756.352463-2-vneethv@linux.ibm.com>
User-Agent: Notmuch/0.33.1 (https://notmuchmail.org)
Date:   Mon, 22 Nov 2021 18:41:59 +0100
Message-ID: <875yskkryw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Nov 22 2021, Vineeth Vijayan <vneethv@linux.ibm.com> wrote:

> commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")
> introduced suppression of uevents for a subchannel until after it is
> clear that the subchannel would not be unregistered again
> immediately. This was done to avoid uevents being generated for I/O
> subchannels with no valid device, which can happen on LPAR.
>
> However, this also has some drawbacks: All subchannel drivers need to
> manually remove the uevent suppression and generate an ADD uevent as
> soon as they are sure that the subchannel will stay around. This misses
> out on all uevents that are not the initial ADD uevent that would be
> generated while uevents are suppressed; for example, all subchannels
> were missing the BIND uevent.
>
> As uevents being generated even for I/O subchannels without an
> operational device turned out to be not as bad as missing uevents and
> complicating the code flow, let's remove uevent suppression for
> subchannel

s/subchannel/subchannels./

>
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> [cohuck@redhat.com: modified changelog]
> ---
>  drivers/s390/cio/chsc_sch.c     |  5 -----
>  drivers/s390/cio/css.c          | 19 -------------------
>  drivers/s390/cio/device.c       | 18 ------------------
>  drivers/s390/cio/eadm_sch.c     |  5 -----
>  drivers/s390/cio/vfio_ccw_drv.c |  5 -----
>  5 files changed, 52 deletions(-)

(...)

> @@ -1035,16 +1027,6 @@ static int io_subchannel_probe(struct subchannel *sch)
>  				      "attributes for subchannel "
>  				      "0.%x.%04x (rc=%d)\n",
>  				      sch->schid.ssid, sch->schid.sch_no, rc);
> -		/*
> -		 * The console subchannel already has an associated ccw_device.
> -		 * Throw the delayed uevent for the subchannel, register
> -		 * the ccw_device and exit.

Maybe keep at least part of this comment?

/*
 * The console subchannel already has an associated ccw_device.
 * Register it and exit.
 */

> -		 */
> -		if (dev_get_uevent_suppress(&sch->dev)) {
> -			/* should always be the case for the console */
> -			dev_set_uevent_suppress(&sch->dev, 0);
> -			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> -		}
>  		cdev = sch_get_cdev(sch);
>  		rc = device_add(&cdev->dev);
>  		if (rc) {

Otherwise looks good to me.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

