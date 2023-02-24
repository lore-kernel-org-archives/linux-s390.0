Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E313BC61DA4
	for <linux-s390@archiver.kernel.org>; Fri, 24 Feb 2023 04:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBXETW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 23 Feb 2023 23:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBXETW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Feb 2023 23:19:22 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F31918143;
        Thu, 23 Feb 2023 20:19:20 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6A4CA30008C8D;
        Fri, 24 Feb 2023 05:19:18 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 511943E9A6; Fri, 24 Feb 2023 05:19:18 +0100 (CET)
Date:   Fri, 24 Feb 2023 05:19:18 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: s390: Fix use-after-free of PCI bus
 resources with s390 per-function hotplug
Message-ID: <20230224041918.GB26067@wunner.de>
References: <1793b3cd12921b7a3fa8b3ee7e20b7cf1df1eca1.camel@linux.ibm.com>
 <20230223195345.GA3805039@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223195345.GA3805039@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Feb 23, 2023 at 01:53:45PM -0600, Bjorn Helgaas wrote:
> Hmm.  Good question.  Off the top of my head, I can't explain the
> difference between pci_rescan_remove_lock and pci_bus_sem, so I'm
> confused, too.  I added Lukas in case he has a ready explanation.

pci_bus_sem is a global lock which protects the "devices" list of all
pci_bus structs.

We do have a bunch of places left where the "devices" list is accessed
without holding pci_bus_sem, though I've tried to slowly eliminate
them.

pci_rescan_remove_lock is a global "big kernel lock" which serializes
any device addition and removal.

pci_rescan_remove_lock is known to be far too course-grained and thus
deadlock-prone, particularly if hotplug ports are nested (as is the
case with Thunderbolt).  It needs to be split up into several smaller
locks which protect e.g. allocation of resources of a bus (bus numbers
or MMIO / IO space) and whatever else needs to be protected.  It's just
that nobody has gotten around to identify what exactly needs to be
protected, adding the new locks and removing pci_rescan_remove_lock.

Thanks,

Lukas
