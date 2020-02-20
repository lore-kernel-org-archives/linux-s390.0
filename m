Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgBTQLm (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 11:11:42 -0500
Date: Thu, 20 Feb 2020 11:11:39 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.5 094/542] s390/pci: Fix possible deadlock in
 recover_store()
Message-ID: <20200220161139.GB1734@sasha-vm>
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-94-sashal@kernel.org>
 <20200217093156.GB42010@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200217093156.GB42010@tuxmaker.boeblingen.de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org

On Mon, Feb 17, 2020 at 10:31:56AM +0100, Niklas Schnelle wrote:
>On Fri, Feb 14, 2020 at 10:41:26AM -0500, Sasha Levin wrote:
>> From: Niklas Schnelle <schnelle@linux.ibm.com>
>>
>> [ Upstream commit 576c75e36c689bec6a940e807bae27291ab0c0de ]
>>
>> With zpci_disable() working, lockdep detected a potential deadlock
>> (lockdep output at the end).
>>
>> The deadlock is between recovering a PCI function via the
>>
>> /sys/bus/pci/devices/<dev>/recover
>>
>> attribute vs powering it off via
>>
>> /sys/bus/pci/slots/<slot>/power.
>>
>> The fix is analogous to the changes in commit 0ee223b2e1f6 ("scsi: core:
>> Avoid that SCSI device removal through sysfs triggers a deadlock")
>> that fixed a potential deadlock on removing a SCSI device via sysfs.
>[ ... snip ... ]
>
>While technically useful on its own this commit really should go together with
>the following upstream commit:
>
>17cdec960cf776b20b1fb08c622221babe591d51
>("s390/pci: Recover handle in clp_set_pci_fn()")
>
>While the problem fixed here is independent,  writing to the power/recover
>attributes will often fail due to an inconsistent function handle without the
>second commit.
>In particular without it a PCI function in the error state can not be
>recovered or powered off.
>
>I would recommend adding the second commit to the backports as well.

I took that commit as well, thank you.

-- 
Thanks,
Sasha
