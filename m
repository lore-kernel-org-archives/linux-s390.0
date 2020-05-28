Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16022 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387518AbgE1KCB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 May 2020 06:02:01 -0400
Subject: Re: [PATCH 1/1] s390/pci: Log new handle in clp_disable_fh()
References: <20200522183922.5253-1-ptesarik@suse.com>
 <20200528110813.7eb1fc1f@ezekiel.suse.cz>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <595c993e-0be4-3164-2498-b915c3fc9726@linux.ibm.com>
Date: Thu, 28 May 2020 12:01:45 +0200
MIME-Version: 1.0
In-Reply-To: <20200528110813.7eb1fc1f@ezekiel.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org


On 2020-05-28 11:08, Petr Tesarik wrote:
> Hi all,
> 
> just a gentle ping.
> 
> If the current behaviour (logging the original handle) was intended,
> then it was worth mentioning in the commit message for 17cdec960cf77,
> which made the change, but since that's no longer an option, I'd be
> happy with an explanation in email.
> 
> Petr T
> 
> On Fri, 22 May 2020 20:39:22 +0200
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
>> After disabling a function, the original handle is logged instead of
>> the disabled handle.

Hi Petr,

Sorry for the delay, no doubt, you are right, the fh in zpci_dbg is the 
old one and we should use the one in the zdev struct.

Thanks,
Pierre

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>


>>
>> Fixes: 17cdec960cf77 (s390/pci: Recover handle in clp_set_pci_fn())
>> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
>> ---
>>   arch/s390/pci/pci_clp.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
>> index ea794ae755ae..179bcecefdee 100644
>> --- a/arch/s390/pci/pci_clp.c
>> +++ b/arch/s390/pci/pci_clp.c
>> @@ -309,14 +309,13 @@ int clp_enable_fh(struct zpci_dev *zdev, u8 nr_dma_as)
>>   
>>   int clp_disable_fh(struct zpci_dev *zdev)
>>   {
>> -	u32 fh = zdev->fh;
>>   	int rc;
>>   
>>   	if (!zdev_enabled(zdev))
>>   		return 0;
>>   
>>   	rc = clp_set_pci_fn(zdev, 0, CLP_SET_DISABLE_PCI_FN);
>> -	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
>> +	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
>>   	return rc;
>>   }
>>   
> 

-- 
Pierre Morel
IBM Lab Boeblingen
