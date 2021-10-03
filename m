Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DC9C433F5
	for <linux-s390@archiver.kernel.org>; Sun,  3 Oct 2021 06:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9061561A78
	for <linux-s390@archiver.kernel.org>; Sun,  3 Oct 2021 06:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhJCGoV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 3 Oct 2021 02:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhJCGoU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 Oct 2021 02:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633243352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r+Bl1u326f9yQhaXb6udjEGQWjjecevglQG5IV4fpCo=;
        b=dZfMOxllVGBiU9LJpGvXoqspg+dph6U38+PMQLCV1uq9keC8zo46koQIO+nYWOFAcCh9nF
        +Wwzt7WXOvAhzLEvGhnfJD/HxhRv1ZukZYKFlopSJFK1gC3p+y6zhDUU54CDfio60q4b7Q
        +YT2YLrxKMXKEcFFtxzsJlxKqKJZtc8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-Qwh-3f7wN8-U0Zt1BL4uaQ-1; Sun, 03 Oct 2021 02:42:31 -0400
X-MC-Unique: Qwh-3f7wN8-U0Zt1BL4uaQ-1
Received: by mail-ed1-f72.google.com with SMTP id w8-20020a50c448000000b003dae8d38037so1064298edf.8
        for <linux-s390@vger.kernel.org>; Sat, 02 Oct 2021 23:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+Bl1u326f9yQhaXb6udjEGQWjjecevglQG5IV4fpCo=;
        b=oIztedLMeaW7yrVLmKNl5wSSvhR/u+Y4LoHlKIJ/VwWdlTsDkMAuYtr5Av9w8P7b7s
         s3Bu9eZNAhYwlSh39pcBVp/2LrefOF0hzZ/ztQFNd+7awo6hh7rCrymbvsEpQn1yFJ6H
         dcF+IFdJbY1TOLUWpjO9SfLS6DqVTU+WRBcJqTHS4kKpBUJNqajFG4PgJV/HMPGk/Fx0
         PqQqa3nq7oyMMgsWsxlbZ24b2mmMQm75QlJYd1ebQVL55A25Z2eNDXeJZItTTrOK24F3
         fXUApOGHFHeF1dsyvliJhkIxK+JffbxVNa9dhUlVcKv3Q5RC0vs2Pfj1Q6950icVAvZb
         S8jQ==
X-Gm-Message-State: AOAM533ljMtTWSQRgL/HUCVwspaZa0Hibi9u6VIYJSczpEYEfvdeOEzO
        H8YF9EMEBunSUem+MGs6d2Di2WqA1Ok9wRsq+RbOZBqwc41Ehy0s56UHfaoSo1yN4iV6nl0w4P2
        rIPiFoVh8GhqjdEpQLaNTxQ==
X-Received: by 2002:a17:907:2d0d:: with SMTP id gs13mr8578180ejc.94.1633243350450;
        Sat, 02 Oct 2021 23:42:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtHT8Cegow6Zx3CCdmEJQH1USoUtFEpuumSAmNgt5hz1mJRyfrkZWULFFV8XgcH+xyZ4AWZQ==
X-Received: by 2002:a17:907:2d0d:: with SMTP id gs13mr8578148ejc.94.1633243350156;
        Sat, 02 Oct 2021 23:42:30 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
        by smtp.gmail.com with ESMTPSA id h10sm5564701edf.85.2021.10.02.23.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 23:42:29 -0700 (PDT)
Date:   Sun, 3 Oct 2021 02:42:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211003021027-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003070030.658fc94e.pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Oct 03, 2021 at 07:00:30AM +0200, Halil Pasic wrote:
> On Sat, 2 Oct 2021 14:20:47 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > >From my perspective the problem is that the version of the device  
> > > remains in limbo as long as the features have not yet been finalized,
> > > which means that the endianness of the config space remains in limbo as
> > > well. Both device and driver might come to different conclusions.  
> > 
> > Version === legacy versus modern?
> > It is true that feature negotiation can not be used by device to decide that
> > question simply because it happens too late.
> > So let's not use it for that then ;)
> > 
> > Yes we have VERSION_1 which looks like it should allow this, but
> > unfortunately it only helps with that for the driver, not the device.
> > 
> > In practice legacy versus modern has to be determined by
> > transport specific versioning, luckily we have that for all
> > specified transports (can't say what happens with rproc).
> 
> So if we look at ccw, you say that the revision negotiation already
> determines whether VERSION_1 is negotiated or not, and the
> feature bit VERSION_1 is superfluous?
> 
> That would also imply, that 
> 1) if revision > 0 was negotiated then the device must offer VERSION_1
> 2) if revision > 0 was negotiated and the driver cleared VERSION_1
>    the device must refuse to operate.
> 3) if revision > 0 was negotiated then the driver should reject 
>    to drive a device if it does not offer VERSION_1
> 4) if revision > 0 was negotiated the driver must accept VERSION_1
> 5) if revision > 0 was *not* negotiated then the device should not offer
>    VERSION_1 because at this point it is already certain that the device
>    can not act in accordance to the virtio 1.0 or higher interface.
> 
> Does that sound about right?

To me, it does.

> IMHO we should also change 
> https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-160003
> and the definition of VERSION_1 because both sides have to know what is
> going on before features are fully negotiated. Or?
> 
> Regards,
> Halil
> 

I guess so. And I guess we need transport-specific sections
describing this behaviour for each transport.

So something like this, for starters?

diff --git a/content.tex b/content.tex
index 1398390..c526dd3 100644
--- a/content.tex
+++ b/content.tex
@@ -140,10 +140,13 @@ \subsection{Legacy Interface: A Note on Feature
 Bits}\label{sec:Basic Facilities of a Virtio Device / Feature
 Bits / Legacy Interface: A Note on Feature Bits}
 
-Transitional Drivers MUST detect Legacy Devices by detecting that
-the feature bit VIRTIO_F_VERSION_1 is not offered.
-Transitional devices MUST detect Legacy drivers by detecting that
-VIRTIO_F_VERSION_1 has not been acknowledged by the driver.
+Transitional drivers MAY support operating legacy devices.
+Transitional devices MAY support operation by legacy drivers.
+
+Transitional drivers MUST detect legacy devices in a way that is
+transport specific.
+Transitional devices MUST detect legacy drivers in a way that
+is transport specific.
 
 In this case device is used through the legacy interface.
 
@@ -160,6 +163,25 @@ \subsection{Legacy Interface: A Note on Feature
 Specification text within these sections generally does not apply
 to non-transitional devices.
 
+\begin{note}
+The device offers different features when used through
+the legacy interface and when operated in accordance with this
+specification.
+\end{note}
+
+Transitional drivers MUST use Devices only through the legacy interface
+if the feature bit VIRTIO_F_VERSION_1 is not offered.
+Transitional devices MUST NOT offer VIRTIO_F_VERSION_1 when used through
+the legacy interface.
+
+When the driver uses a device through the legacy interface, then it
+MUST only accept the features the device offered through the
+legacy interface.
+
+When used through the legacy interface, the device SHOULD
+validate that the driver only accepted the features it
+offered through the legacy interface.
+
 \section{Notifications}\label{sec:Basic Facilities of a Virtio Device
 / Notifications}
 

