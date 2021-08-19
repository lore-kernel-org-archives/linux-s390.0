Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154B9C4320A
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0365610A3
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 16:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhHSQkZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 Aug 2021 12:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhHSQkX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Aug 2021 12:40:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75AA461053;
        Thu, 19 Aug 2021 16:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629391186;
        bh=vLAFoDWr+wIJ4KZAKlyNas4PIK7BuV9EEUd7EzA2pDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G1JxUEBbRoCN2KcDikS0IB1DW6aLXWpbLnZ7swP1UT4yDf7nbcLMz7olzGUsLnkFS
         L7VRJvC6y52XBcjfK3rvym9+hDa5OEkWwvOGv8GSnhdyL9sG17mGPzci1YB/wtWq26
         czkDN6Ti0l+p4PWyNdvhkyrBtouBCCv+8Aw/ZLxUbqisVM+WJby8P4vp7NHIuZztQV
         92MEVk2NXPJx+W6W0nkEguJ+3zYCTddGQv8PNj76PvzEvGAU3WzYnsiLFxg00Ps0aH
         CWswfkZDP2rFwG+VbRE14EkJ6SGEe4xjhAsOOq4ZjNaZLFTHy/aE0wKbTZ9NiY+W9q
         qBJZlloXBbz4Q==
Date:   Thu, 19 Aug 2021 11:39:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, alex.williamson@redhat.com,
        diana.craciun@oss.nxp.com, kwankhede@nvidia.com,
        eric.auger@redhat.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        mgurtovoy@nvidia.com, jgg@nvidia.com, maorg@nvidia.com,
        leonro@nvidia.com
Subject: Re: [PATCH V2 09/12] PCI: Add 'override_only' bitmap to struct
 pci_device_id
Message-ID: <20210819163945.GA3211852@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41539eec-b6fc-084b-0417-ac39d324189e@nvidia.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Aug 19, 2021 at 07:16:20PM +0300, Yishai Hadas wrote:
> On 8/19/2021 6:15 PM, Bjorn Helgaas wrote:
> > On Wed, Aug 18, 2021 at 06:16:03PM +0300, Yishai Hadas wrote:
> > > From: Max Gurtovoy <mgurtovoy@nvidia.com>

> > >   /**
> > >    * struct pci_device_id - PCI device ID structure
> > >    * @vendor:		Vendor ID to match (or PCI_ANY_ID)
> > > @@ -34,12 +38,14 @@ typedef unsigned long kernel_ulong_t;
> > >    *			Best practice is to use driver_data as an index
> > >    *			into a static list of equivalent device types,
> > >    *			instead of using it as a pointer.
> > > + * @override_only:	Bitmap for override_only PCI drivers.
> > "Match only when dev->driver_override is this driver"?
> 
> Just to be aligned here,
> 
> This field will stay __u32 and may hold at the most 1 bit value set to
> represent the actual subsystem/driver.

The PCI core does not require "at most 1 bit is set."

Actually, I don't think even the file2alias code requires that.  If
you set two bits, you can generate two aliases.

> This is required to later on set the correct prefix in the modules.alias
> file, and you just suggested to change the comment as of above, right ?

Yes, __u32 is fine and I'm only suggesting a comment change here.

> > As far as PCI core is concerned there's no need for this to be a
> > bitmap.
> > 
> > I think this would make more sense if split into two patches.  The
> > first would add override_only and change pci_match_device().  Then
> > there's no confusion about whether this is specific to VFIO.
> 
> Splitting may end-up the first patch with a dead-code on below, as
> found_id->override_only will be always 0.
> 
> If you still believe that this is better we can do it.

I think it's fine to add the functionality in one patch and use it in
the next if it makes the commit clearer.  I wouldn't want to add
functionality that's not used at all in the series, but it's OK when
they're both posted together.

> if (found_id->override_only) {
>     if (dev->driver_override)
>       return found_id;
>   } else
>     return found_id;
> 
> > The second can add PCI_ID_F_VFIO_DRIVER_OVERRIDE and make the
> > file2alias.c changes.  Most of the commit log applies to this part.
