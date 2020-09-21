Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727671AbgIUPo2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 11:44:28 -0400
Subject: Re: [PATCH 1/4] s390/pci: stash version in the zpci_dev
References: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
 <1600529318-8996-2-git-send-email-mjrosato@linux.ibm.com>
 <20200921170158.1080d872.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <ea53b58a-74f0-2a10-3f08-dbcca512ef86@linux.ibm.com>
Date: Mon, 21 Sep 2020 11:44:20 -0400
MIME-Version: 1.0
In-Reply-To: <20200921170158.1080d872.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On 9/21/20 11:01 AM, Cornelia Huck wrote:
> On Sat, 19 Sep 2020 11:28:35 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> In preparation for passing the info on to vfio-pci devices, stash the
>> supported PCI version for the target device in the zpci_dev.
> 
> Hm, what kind of version is that? The version of the zPCI interface?
> 
> Inquiring minds want to know :)
> 

Ha :) It's related to PCI-SIG spec versions and which one the zPCI 
facility supports for this device.

>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h | 1 +
>>   arch/s390/pci/pci_clp.c     | 1 +
>>   2 files changed, 2 insertions(+)
> 
