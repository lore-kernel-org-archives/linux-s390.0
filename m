Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC5AC433F5
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 02:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BEC610E9
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 02:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhIGCFx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Sep 2021 22:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhIGCFx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Sep 2021 22:05:53 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93730C061575;
        Mon,  6 Sep 2021 19:04:47 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b64so8653605qkg.0;
        Mon, 06 Sep 2021 19:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cs7mCMI8BIob2gIpwkwVdKulQz4rvKjl/wf+ynJ6z9Y=;
        b=HDcmens1LBj3rKlpU88n/WQYdnrYpD37I8npnEyNuzee+6ZEblyd/Lr4TAgkqwMK6K
         R6hWuXJdkfWY9YsSrqKtNMelU45wevTKv4D3KGpqlE4aXcYgE+eBMk06rf9+vIcqvK65
         f6LIFboepPzZnEyOj08SsrrxZtUVy/RuJ54rs2JpyXwEworSh0cHJry4qFPQItAtFHzO
         rtp5xbXTmJYDHtaj9OYRWdIR9coIM0wC15tyRm0CcVTue4uH6/8HHgSowpVMJvyWr3Lr
         PjTTvD2VGBc5WESZaojfSJCRBFe3b6UqaIZJw2x8e/UuHtt//oOeB76EttA7HL2G5olL
         dyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cs7mCMI8BIob2gIpwkwVdKulQz4rvKjl/wf+ynJ6z9Y=;
        b=dQWe42En+HA+wENPmqKUviut75OoPmfLSKcL0l1aG+rXD77afMonm8HQOKnJZ4PJ86
         vrHDmS6XGkPOhTcfwZdSQDl/Wy1lvjLSM7LrlBDbRfPze7Hlr+Fbel4QA6m7BfGZjKGj
         neWCu4/wWkNSyaEYQOMuAPKCBOXTz6IQ4tua5S90Phhskza7k9YamJHDR4whykZxLZYL
         DlfgE2uYgUrvvEZmLlxY7ZtKovGKqIyG8Bn+Nx+tyGdM2F3krXrl15crbNrkxngiO91A
         yNqrfl1UUJizLTOfLGcbj2xxySIDZikaaI4pXEwaCWDZwv9TxE2FAhL4yqVcAs6+affY
         X1FQ==
X-Gm-Message-State: AOAM5310CHKrSL3s57ll9YhFQf4BARTxOEpPwpUzso1cyBCPJmn/B7KQ
        UsRosmHrObOTi1kpw+4xNxf01otvkUJgG9GBpNE=
X-Google-Smtp-Source: ABdhPJyPg7oCTcfJ+n3qrn/GXcHEf5/fzs+entEJl9L+5Q4TATk2fCWAfQJ24e71W6LlWk7EKphw3XVEKn+yW1Ze+jE=
X-Received: by 2002:a05:620a:1299:: with SMTP id w25mr13651420qki.391.1630980286653;
 Mon, 06 Sep 2021 19:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210906094927.524106-1-schnelle@linux.ibm.com>
In-Reply-To: <20210906094927.524106-1-schnelle@linux.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 7 Sep 2021 12:04:35 +1000
Message-ID: <CAOSf1CFyuf9FaeSNparj+7W0mKTPvtcM8vxjHDSFsNDC6k_7xQ@mail.gmail.com>
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

On Mon, Sep 6, 2021 at 7:49 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> Patch 3 I already sent separately resulting in the discussion below but without
> a final conclusion.
>
> https://lore.kernel.org/lkml/20210720150145.640727-1-schnelle@linux.ibm.com/
>
> I believe even though there were some doubts about the use of
> pci_dev_is_added() by arch code the existing uses as well as the use in the
> final patch of this series warrant this export.

The use of pci_dev_is_added() in arch/powerpc was because in the past
pci_bus_add_device() could be called before pci_device_add(). That was
fixed a while ago so It should be safe to remove those calls now.

> Patch 4 "PCI: Export pci_dev_lock()" is basically an extension to commit
> e3a9b1212b9d ("PCI: Export pci_dev_trylock() and pci_dev_unlock()") which
> already exported pci_dev_trylock(). In the final patch we make use of
> pci_dev_lock() to wait for any other exclusive uses of the pdev to be finished
> before starting recovery.

Hmm, I noticed the EEH
(arch/powerpc/kernel/eeh_driver.c:eeh_pe_report_edev())  and the
generic PCIe error recovery code (see
drivers/pci/pcie/err.c:report_error_detected()) only call
device_lock() before entering the driver's error handling callbacks. I
wonder if they should be using pci_dev_lock() instead. The only real
difference is that pci_dev_lock() will also block user space from
accessing the device's config space while error recovery is in
progress which seems sensible enough.
