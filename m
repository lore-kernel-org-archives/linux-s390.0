Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728899AbgBQJcE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 04:32:04 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01H9VCMd102642
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 04:32:03 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e2dw10m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 04:32:03 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <schnelle@linux.ibm.com>;
        Mon, 17 Feb 2020 09:32:01 -0000
Date: Mon, 17 Feb 2020 10:31:56 +0100
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH AUTOSEL 5.5 094/542] s390/pci: Fix possible deadlock in
 recover_store()
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-94-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214154854.6746-94-sashal@kernel.org>
Message-Id: <20200217093156.GB42010@tuxmaker.boeblingen.de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org

On Fri, Feb 14, 2020 at 10:41:26AM -0500, Sasha Levin wrote:
> From: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> [ Upstream commit 576c75e36c689bec6a940e807bae27291ab0c0de ]
> 
> With zpci_disable() working, lockdep detected a potential deadlock
> (lockdep output at the end).
> 
> The deadlock is between recovering a PCI function via the
> 
> /sys/bus/pci/devices/<dev>/recover
> 
> attribute vs powering it off via
> 
> /sys/bus/pci/slots/<slot>/power.
> 
> The fix is analogous to the changes in commit 0ee223b2e1f6 ("scsi: core:
> Avoid that SCSI device removal through sysfs triggers a deadlock")
> that fixed a potential deadlock on removing a SCSI device via sysfs.
[ ... snip ... ]

While technically useful on its own this commit really should go together with
the following upstream commit:

17cdec960cf776b20b1fb08c622221babe591d51
("s390/pci: Recover handle in clp_set_pci_fn()")

While the problem fixed here is independent,  writing to the power/recover
attributes will often fail due to an inconsistent function handle without the
second commit.
In particular without it a PCI function in the error state can not be
recovered or powered off.

I would recommend adding the second commit to the backports as well.

Thanks,
Niklas Schnelle
-- 
Niklas Schnelle
Linux on Z Development
