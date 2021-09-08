Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D3DC433F5
	for <linux-s390@archiver.kernel.org>; Wed,  8 Sep 2021 01:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E53E61132
	for <linux-s390@archiver.kernel.org>; Wed,  8 Sep 2021 01:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346370AbhIHBia (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbhIHBia (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Sep 2021 21:38:30 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E01C061575;
        Tue,  7 Sep 2021 18:37:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 62so350240qvb.11;
        Tue, 07 Sep 2021 18:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciBzCjagQnTip0jhcuPtA6NB3onzElPc291uOOyrzyM=;
        b=bithVZitjX59Lt3RcjNnDfJU/uUHPRrRkBDyknarhntnoXj1G1iASqbCbdRhUo8Pt+
         FLV7z+W1O2JmgFRT+v3sCKCrhguRv38WbDPivEuQAOrdEMPR978YFR3uo5M1/7qdBI3L
         TVR/BczxCBKRzQm1liSpdbfmtiPuA/JChcClxVYzaFBzPn/Cy+Z8XC2f6n37GxzuY+k7
         mhKRqTyFNeV2HN22zApu3nlxxMFMxcSTf26Ecxz813ag7CQbzOdaOVR8LEX2t27h3E7L
         gypmOInhelID1nSq5dNuub0y5sPGnWK4RVggceJIxrdRlZthcZ/fZRuDxRVAl91y3Tci
         rQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciBzCjagQnTip0jhcuPtA6NB3onzElPc291uOOyrzyM=;
        b=uUyAZPeisriHknbjTLMfWmO5OWrQnTsgD8kt8OWcCZf8bnM6VIv7NzUdik5rMmPOtp
         fN3l//3yMYs82VQ+ABzF0gELVtdqmsDwczFP9uS0c1omwtLld3Q19S0utJLX7jRjIlUC
         hbEvdq8FtQ20PxbvlyPueUJVHJzSGP67KvB/QPAsmjMDQbbTmQpoug1oaI6+fKVuRHBh
         dhxLUE36Z/4M8uHclzGGKqAQo4h9vqilGcYzRPZe8/VfJL4fmxggsqWRe8+d4RzcfPFu
         dDW0hgUBsfZrCr+mifxxJMY0wrVzGhavUTGxhk8VYjk9Omzd7amqovA0UgBSn0/zh3GJ
         Fm2A==
X-Gm-Message-State: AOAM533z/fKD/uMdnCoxQBo7n7MuJKzPPOCFYjXZ+pvjLUm+YZY5MS2y
        7CK7dOWEXxrfJr9p3/e0XPVCVWnwj0kNYcxyKpW/kmyMxxGMdMyH
X-Google-Smtp-Source: ABdhPJyZX8Ws4H4CK//9vF6DwOfMVVDxAED9g7heseyQVdqgO/Dg6FserqZ3XyM3raWxTLzCUa//Kzk5ma7acROdNGk=
X-Received: by 2002:a0c:80ce:: with SMTP id 72mr1195106qvb.39.1631065042341;
 Tue, 07 Sep 2021 18:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210906094927.524106-1-schnelle@linux.ibm.com>
 <CAOSf1CFyuf9FaeSNparj+7W0mKTPvtcM8vxjHDSFsNDC6k_7xQ@mail.gmail.com>
 <e739c2919f97e277849a1bc1324a20df6a7d59eb.camel@linux.ibm.com> <0c9326c943c0e6aa572cc132ee2deb952bf41c7f.camel@linux.ibm.com>
In-Reply-To: <0c9326c943c0e6aa572cc132ee2deb952bf41c7f.camel@linux.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 8 Sep 2021 11:37:11 +1000
Message-ID: <CAOSf1CH2T-R44qx1mGpJQ8WgD0upxG8sQNud_5L3SHYZJm9LRA@mail.gmail.com>
Subject: Re: [PATCH 0/5] s390/pci: automatic error recovery
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linas Vepstas <linasvepstas@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 7, 2021 at 10:21 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> On Tue, 2021-09-07 at 10:45 +0200, Niklas Schnelle wrote:
> > On Tue, 2021-09-07 at 12:04 +1000, Oliver O'Halloran wrote:
> > > On Mon, Sep 6, 2021 at 7:49 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > > Patch 3 I already sent separately resulting in the discussion below but without
> > > > a final conclusion.
> > > >
> > > > https://lore.kernel.org/lkml/20210720150145.640727-1-schnelle@linux.ibm.com/
> > > >
> > > > I believe even though there were some doubts about the use of
> > > > pci_dev_is_added() by arch code the existing uses as well as the use in the
> > > > final patch of this series warrant this export.
> > >
> > > The use of pci_dev_is_added() in arch/powerpc was because in the past
> > > pci_bus_add_device() could be called before pci_device_add(). That was
> > > fixed a while ago so It should be safe to remove those calls now.
> >
> > Hmm, ok that confirms Bjorns suspicion and explains how it came to be.
> > I can certainly sent a patch for that. This would then leave only the
> > existing use in s390 which I added because of a dead lock prevention
> > and explained here:
> > https://lore.kernel.org/lkml/87d15d5eead35c9eaa667958d057cf4a81a8bf13.camel@linux.ibm.com/
> >
> > Plus the need to use it in the recovery code of this series. I think in
> > the EEH code the need for a similar check is alleviated by the checks
> > in the beginning of
> > arch/powerpc/kernel/eeh_driver.c:eeh_handle_normal_event() especially
> > eeh_slot_presence_check() which checks presence via the hotplug slot.
> > I guess we could use our own state tracking in a similar way but felt
> > like pci_dev_is_added() is the more logical choice.

The slot check is mainly there to prevent attempts to "recover"
devices that have been surprise removed (i.e NVMe hot-unplug). The
actual recovery process operates off the eeh_pe tree which is frozen
in place when an error is detected. If a pci_dev is added or removed
it's not really a problem since those are only ever looked at when
notifying drivers which is done with the rescan_remove lock held. That
said, I wouldn't really encourage anyone to follow the EEH model since
it's pretty byzantine.

> Looking into this again, I think we actually can't easily track this
> state ourselves outside struct pci_dev. The reason for this is that
> when e.g. arch/s390/pci/pci_sysfs.c:recover_store() removes the struct
> pci_dev and scans it again the new struct pci_dev re-uses the same
> struct zpci_dev because from a platform point of view the PCI device
> was never removed but only disabled and re-enabled. Thus we can only
> distinguish the stale struct pci_dev by looking at things stored in
> struct pci_dev itself.

IMO the real problem is removing and re-adding the pci_dev. I think
it's something that's done largely because the PCI core doesn't really
provide any better mechanism for getting a device back into a
known-good state so it's abused to implement error recovery. This is
something that's always annoyed me since it conflates recovery with
hotplug. After a hot-(un)plug we might have a different device or no
device. In the recovery case we expect to start and end with the same
device. Why not apply the same logic to the pci_dev?

Something I was tinkering with before I left IBM was re-working the
way EEH handles recovering devices that don't have a driver with error
handling callbacks to something like:

1. unbind the driver
2. pci_save_state()
3. do the reset
4. pci_restore_state()
5. re-bind the driver

That would allow keeping the pci_dev around and let me delete a pile
of confusing code which handles binding the eeh_dev to the new
pci_dev. The obvious problem with that approach is the assumption the
device is functional enough to allow saving the config space, but I
don't think that's a deal breaker. We could stash a copy of the device
state before we allow drivers to attach and use that to restore the
device after the reset. The end result would be the same known-good
state that we'd get after a re-scan.

> That said, I think for the recovery case we might be able to drop the
> pci_dev_is_added() and rely on pdev->driver != NULL which we check
> anyway and that should catch any PCI device that was already removed.

Would that work if there was an error on a device without a driver
bound? If you're just trying to stop races between recovery and device
removal then pci_dev_is_added() is probably the right tool for the
job. Trying to substitute it with a proxy seems like a bad idea.
