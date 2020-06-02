Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725616AbgFBH0b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jun 2020 03:26:31 -0400
Subject: Re: [PATCH 1/1] s390/pci: Log new handle in clp_disable_fh()
References: <20200522183922.5253-1-ptesarik@suse.com>
 <20200528110813.7eb1fc1f@ezekiel.suse.cz>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <9e4a0dec-d249-9443-6b93-83e3f9f33674@linux.ibm.com>
Date: Tue, 2 Jun 2020 09:26:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200528110813.7eb1fc1f@ezekiel.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org

Hi Petr,

sorry for not reacting sooner, I was on holiday, saw your message but figured it wasn't super critical.
Thanks for finding this issue and thank you Pierre and Vasily for stepping in.

Best,
Niklas Schnelle

On 5/28/20 11:08 AM, Petr Tesarik wrote:
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
>>
>> Fixes: 17cdec960cf77 (s390/pci: Recover handle in clp_set_pci_fn())
>> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
>> ---
>>  arch/s390/pci/pci_clp.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
>> index ea794ae755ae..179bcecefdee 100644
>> --- a/arch/s390/pci/pci_clp.c
>> +++ b/arch/s390/pci/pci_clp.c
>> @@ -309,14 +309,13 @@ int clp_enable_fh(struct zpci_dev *zdev, u8 nr_dma_as)
>>  
>>  int clp_disable_fh(struct zpci_dev *zdev)
>>  {
>> -	u32 fh = zdev->fh;
>>  	int rc;
>>  
>>  	if (!zdev_enabled(zdev))
>>  		return 0;
>>  
>>  	rc = clp_set_pci_fn(zdev, 0, CLP_SET_DISABLE_PCI_FN);
>> -	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
>> +	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
>>  	return rc;
>>  }
>>  
> 
