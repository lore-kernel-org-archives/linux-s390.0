Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24613 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727383AbfLPMJa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 16 Dec 2019 07:09:30 -0500
Date: Mon, 16 Dec 2019 13:09:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC QEMU PATCH] pc-bios/s390-ccw: Add zipl-like "BOOT_IMAGE=x"
 to the kernel parameters
Message-ID: <20191216130920.42711f32.cohuck@redhat.com>
In-Reply-To: <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
References: <20191216112432.13412-1-thuth@redhat.com>
        <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Stefan Haberland <sth@linux.ibm.com>, qemu-s390x@nongnu.org, psundara@redhat.com, Jan =?UTF-8?B?SMO2cHBuZXI=?= <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org

On Mon, 16 Dec 2019 12:29:24 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 16.12.19 12:24, Thomas Huth wrote:
> >  Note: I've marked the patch as RFC since I'm not quite sure whether
> >  this is really the right way to address this issue: It's unfortunate
> >  that we have to mess with different location in ZIPL which might also
> >  change again in the future. As suggested by Christian on IRC last week,
> >  maybe it would make more sense to change ZIPL to add this parameter
> >  already when zipl is installed (i.e. by the Linux userspace "zipl" pro-
> >  gram), instead of adding it during boot time? Also, the BOOT_IMAGE para-
> >  meter on s390x is quite different from the BOOT_IMAGE paramter that is
> >  used on x86 - while s390x only uses one single number here, the x86
> >  variant (added by grub2, I guess) uses the boot device + full filename
> >  of the kernel on the boot partition. Should we maybe make the s390x
> >  variant more conform to x86? If so, I think this really has to be fixed
> >  in zipl userspace tool, and not in the s390-ccw bios (and zipl stage3
> >  bootloader).  
> 
> Yes, I actually think we should revisit the whole BOOT_IMAGE scheme on s390.
> Maybe we should use the kernel name, or the name of the boot menu entry.
> And maybe we should not use 0 (when the default is running) but instead
> really use to what 0 points to.

Probably dumb question: Is booting via the s390-ccw bios the only time
we boot without going through zipl? What about e.g. booting from the
reader under z/VM? There's probably no BOOT_IMAGE= statement there,
either?
