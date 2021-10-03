Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D12EC433EF
	for <linux-s390@archiver.kernel.org>; Sun,  3 Oct 2021 07:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D99611C1
	for <linux-s390@archiver.kernel.org>; Sun,  3 Oct 2021 07:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJCH2D (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 3 Oct 2021 03:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhJCH2D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 Oct 2021 03:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633245975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDTlj8yauGXn36BnLPk7YQFUogtZGxp6fGoAswuoG/g=;
        b=dr5WwdrErqvFXhFilcR50rvrGVY8HPdO5BjSl+Y8DViS0SZn+qx7crCdhD+0DflrEoX4vu
        PO0AS0orQxiq/k8TEGBxff7ArUmZntgtkjWzcMCtz+MBNkO3PN8m9WrX/X5cV6IogZ+fA6
        3TKR7bPYArXh5Pj+2eHNUifUvaxMYdU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-muxfvaGuNLO_eWzAakszqA-1; Sun, 03 Oct 2021 03:26:14 -0400
X-MC-Unique: muxfvaGuNLO_eWzAakszqA-1
Received: by mail-wm1-f71.google.com with SMTP id x3-20020a05600c21c300b0030d2b0fb3b4so5396379wmj.5
        for <linux-s390@vger.kernel.org>; Sun, 03 Oct 2021 00:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hDTlj8yauGXn36BnLPk7YQFUogtZGxp6fGoAswuoG/g=;
        b=E1UGIQ4xv0leJzn4DnNOTZ+Sle/ON5fUTkmmsAoC69Czzp6AnU2EWrWe0JklNxeEi7
         myst2Gffp3hQzRItGgt1YHUTY6opsMHif9Mf3DHEiqD1VkeaI4KcoRnnONQecQHlA6La
         k2TXU+Fih6Y+8rnuzw4lxY/1CWIEH2haKWfnYnLcMEvimQv04/DCmjJF3a8pIAYTchvU
         D77xFao0FCJ9cRBPJBNv1KIWjz/0RYBjQl3ztM+mv6etcx0wWruPAZbXccP5FmSOg2nR
         L0dpLLBirL3sIIfjN3u+dAH7905SIaWo6G7opCmz7sFj91UGOwTSlpPlCp7qy1YThmYO
         qbdg==
X-Gm-Message-State: AOAM530aOjF7DC4jzfCNkJeScpZfBKvzr1Ai4fxcrQuXQzabv1uRKGmd
        wQeJWtgnAjTC5lY90LqdO9PUgIr8lu2LUEp4TePCpbhaHFBryENdlniRsDrbedhVRTEpg9SnYrE
        gtYyZduqJN+SwpCYHn75XvQ==
X-Received: by 2002:a5d:56cc:: with SMTP id m12mr7015393wrw.22.1633245973398;
        Sun, 03 Oct 2021 00:26:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNAQtpj1eV275e1gGoSR2AJUhmX2Av/LkhXFA8TjxRNFl9fJFjPs+0pBxxeePuOYAE3C5EmA==
X-Received: by 2002:a5d:56cc:: with SMTP id m12mr7015373wrw.22.1633245973096;
        Sun, 03 Oct 2021 00:26:13 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
        by smtp.gmail.com with ESMTPSA id b15sm4804079wrr.90.2021.10.03.00.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 00:26:11 -0700 (PDT)
Date:   Sun, 3 Oct 2021 03:26:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211003032253-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003021027-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Oct 03, 2021 at 02:42:30AM -0400, Michael S. Tsirkin wrote:
> On Sun, Oct 03, 2021 at 07:00:30AM +0200, Halil Pasic wrote:
> > On Sat, 2 Oct 2021 14:20:47 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > > >From my perspective the problem is that the version of the device  
> > > > remains in limbo as long as the features have not yet been finalized,
> > > > which means that the endianness of the config space remains in limbo as
> > > > well. Both device and driver might come to different conclusions.  
> > > 
> > > Version === legacy versus modern?
> > > It is true that feature negotiation can not be used by device to decide that
> > > question simply because it happens too late.
> > > So let's not use it for that then ;)
> > > 
> > > Yes we have VERSION_1 which looks like it should allow this, but
> > > unfortunately it only helps with that for the driver, not the device.
> > > 
> > > In practice legacy versus modern has to be determined by
> > > transport specific versioning, luckily we have that for all
> > > specified transports (can't say what happens with rproc).
> > 
> > So if we look at ccw, you say that the revision negotiation already
> > determines whether VERSION_1 is negotiated or not, and the
> > feature bit VERSION_1 is superfluous?
> > 
> > That would also imply, that 
> > 1) if revision > 0 was negotiated then the device must offer VERSION_1
> > 2) if revision > 0 was negotiated and the driver cleared VERSION_1
> >    the device must refuse to operate.
> > 3) if revision > 0 was negotiated then the driver should reject 
> >    to drive a device if it does not offer VERSION_1
> > 4) if revision > 0 was negotiated the driver must accept VERSION_1
> > 5) if revision > 0 was *not* negotiated then the device should not offer
> >    VERSION_1 because at this point it is already certain that the device
> >    can not act in accordance to the virtio 1.0 or higher interface.
> > 
> > Does that sound about right?
> 
> To me, it does.
> 
> > IMHO we should also change 
> > https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-160003
> > and the definition of VERSION_1 because both sides have to know what is
> > going on before features are fully negotiated. Or?
> > 
> > Regards,
> > Halil
> > 
> 
> I guess so. And I guess we need transport-specific sections
> describing this behaviour for each transport.
> 
> So something like this, for starters?

Sent too early. So here's what I propose. Could you pls take a look
and if you like this, post a ccw section?
There's also an attempt to prevent fallback from modern to legacy
here since if driver does fallback then failing FEATURES_OK can't work
properly.
That's a separate issue, will be a separate patch when I post
this for consideration by the TC.


diff --git a/content.tex b/content.tex
index 1398390..06271f4 100644
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
 
@@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
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
+When operating a transitional device, a transitional driver
+SHOULD NOT use the device through the legacy interface if
+operation through the modern interface has failed.
+In particular, a transitional driver
+SHOULD NOT fall back to using the device through the
+legacy interface if feature negotiation failed
+(since that would defeat the purpose of the FEATURES_OK bit).
+
 \section{Notifications}\label{sec:Basic Facilities of a Virtio Device
 / Notifications}
 
@@ -1003,6 +1033,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 The driver MUST NOT write a 0 to \field{queue_enable}.
 
+\paragraph}{Legacy Interface: Common configuration structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interface: Common configuration structure layout}
+Transitional drivers SHOULD detect legacy devices by detecting
+that the device has the Transitional PCI Device ID in
+the range 0x1000 to 0x103f and lacks a VIRTIO_PCI_CAP_COMMON_CFG
+capability specifying the location of a common configuration structure.
+
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 
 The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
@@ -1288,6 +1324,10 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
 Transitional devices MUST present part of configuration
 registers in a legacy configuration structure in BAR0 in the first I/O
 region of the PCI device, as documented below.
+
+Transitional devices SHOULD detect legacy drivers by detecting
+access to the legacy configuration structure.
+
 When using the legacy interface, transitional drivers
 MUST use the legacy configuration structure in BAR0 in the first
 I/O region of the PCI device, as documented below.

