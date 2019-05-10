Return-Path: <SRS0=etnf=TK=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 1/4] s390: pci: Exporting access to CLP PCI function and
 PCI group
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
 <1557476555-20256-2-git-send-email-pmorel@linux.ibm.com>
 <a06ffd83-5fde-8c6e-b25b-bd4163d4cd5f@arm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 10 May 2019 16:45:15 +0200
MIME-Version: 1.0
In-Reply-To: <a06ffd83-5fde-8c6e-b25b-bd4163d4cd5f@arm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <289bdf82-75ba-4ba4-9362-dd8fc721cfc8@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, sebott@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, kvm@vger.kernel.org, heiko.carstens@de.ibm.com, walling@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, iommu@lists.linux-foundation.org, schwidefsky@de.ibm.com, gerald.schaefer@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 10/05/2019 12:21, Robin Murphy wrote:
> On 10/05/2019 09:22, Pierre Morel wrote:
>> For the generic implementation of VFIO PCI we need to retrieve
>> the hardware configuration for the PCI functions and the
>> PCI function groups.
>>
>> We modify the internal function using CLP Query PCI function and
>> CLP query PCI function group so that they can be called from
>> outside the S390 architecture PCI code and prefix the two
>> functions with "zdev" to make clear that they can be called
>> knowing only the associated zdevice.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h |  3 ++
>>   arch/s390/pci/pci_clp.c     | 72 
>> ++++++++++++++++++++++++---------------------
>>   2 files changed, 41 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 305befd..e66b246 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -261,4 +261,7 @@ cpumask_of_pcibus(const struct pci_bus *bus)
>>   #endif /* CONFIG_NUMA */
>> +int zdev_query_pci_fngrp(struct zpci_dev *zdev,
>> +             struct clp_req_rsp_query_pci_grp *rrb);
>> +int zdev_query_pci_fn(struct zpci_dev *zdev, struct 
>> clp_req_rsp_query_pci *rrb);
>>   #endif
>> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
>> index 3a36b07..4ae5d77 100644
>> --- a/arch/s390/pci/pci_clp.c
>> +++ b/arch/s390/pci/pci_clp.c
>> @@ -113,32 +113,18 @@ static void clp_store_query_pci_fngrp(struct 
>> zpci_dev *zdev,
>>       }
>>   }
>> -static int clp_query_pci_fngrp(struct zpci_dev *zdev, u8 pfgid)
>> +int zdev_query_pci_fngrp(struct zpci_dev *zdev,
>> +             struct clp_req_rsp_query_pci_grp *rrb)
>>   {
>> -    struct clp_req_rsp_query_pci_grp *rrb;
>> -    int rc;
>> -
>> -    rrb = clp_alloc_block(GFP_KERNEL);
>> -    if (!rrb)
>> -        return -ENOMEM;
>> -
>>       memset(rrb, 0, sizeof(*rrb));
>>       rrb->request.hdr.len = sizeof(rrb->request);
>>       rrb->request.hdr.cmd = CLP_QUERY_PCI_FNGRP;
>>       rrb->response.hdr.len = sizeof(rrb->response);
>> -    rrb->request.pfgid = pfgid;
>> +    rrb->request.pfgid = zdev->pfgid;
>> -    rc = clp_req(rrb, CLP_LPS_PCI);
>> -    if (!rc && rrb->response.hdr.rsp == CLP_RC_OK)
>> -        clp_store_query_pci_fngrp(zdev, &rrb->response);
>> -    else {
>> -        zpci_err("Q PCI FGRP:\n");
>> -        zpci_err_clp(rrb->response.hdr.rsp, rc);
>> -        rc = -EIO;
>> -    }
>> -    clp_free_block(rrb);
>> -    return rc;
>> +    return clp_req(rrb, CLP_LPS_PCI);
>>   }
>> +EXPORT_SYMBOL(zdev_query_pci_fngrp);
> 
> AFAICS it's only the IOMMU driver itself which needs to call these. That 
> can't be built as a module, so you shouldn't need explicit exports - the 
> header declaration is enough.
> 
> Robin.

This is right and seeing the pointer type only zPCI and s390iommu can 
make use of it.
If nobody has another point of view I will remove the export on the
next iteration.

Thanks,
Pierre

> 
>>   static int clp_store_query_pci_fn(struct zpci_dev *zdev,
>>                     struct clp_rsp_query_pci *response)
>> @@ -174,32 +160,50 @@ static int clp_store_query_pci_fn(struct 
>> zpci_dev *zdev,
>>       return 0;
>>   }
>> -static int clp_query_pci_fn(struct zpci_dev *zdev, u32 fh)
>> +int zdev_query_pci_fn(struct zpci_dev *zdev, struct 
>> clp_req_rsp_query_pci *rrb)
>> +{
>> +
>> +    memset(rrb, 0, sizeof(*rrb));
>> +    rrb->request.hdr.len = sizeof(rrb->request);
>> +    rrb->request.hdr.cmd = CLP_QUERY_PCI_FN;
>> +    rrb->response.hdr.len = sizeof(rrb->response);
>> +    rrb->request.fh = zdev->fh;
>> +
>> +    return clp_req(rrb, CLP_LPS_PCI);
>> +}
>> +EXPORT_SYMBOL(zdev_query_pci_fn);
>> +
>> +static int clp_query_pci(struct zpci_dev *zdev)
>>   {
>>       struct clp_req_rsp_query_pci *rrb;
>> +    struct clp_req_rsp_query_pci_grp *grrb;
>>       int rc;
>>       rrb = clp_alloc_block(GFP_KERNEL);
>>       if (!rrb)
>>           return -ENOMEM;
>> -    memset(rrb, 0, sizeof(*rrb));
>> -    rrb->request.hdr.len = sizeof(rrb->request);
>> -    rrb->request.hdr.cmd = CLP_QUERY_PCI_FN;
>> -    rrb->response.hdr.len = sizeof(rrb->response);
>> -    rrb->request.fh = fh;
>> -
>> -    rc = clp_req(rrb, CLP_LPS_PCI);
>> -    if (!rc && rrb->response.hdr.rsp == CLP_RC_OK) {
>> -        rc = clp_store_query_pci_fn(zdev, &rrb->response);
>> -        if (rc)
>> -            goto out;
>> -        rc = clp_query_pci_fngrp(zdev, rrb->response.pfgid);
>> -    } else {
>> +    rc = zdev_query_pci_fn(zdev, rrb);
>> +    if (rc || rrb->response.hdr.rsp != CLP_RC_OK) {
>>           zpci_err("Q PCI FN:\n");
>>           zpci_err_clp(rrb->response.hdr.rsp, rc);
>>           rc = -EIO;
>> +        goto out;
>>       }
>> +    rc = clp_store_query_pci_fn(zdev, &rrb->response);
>> +    if (rc)
>> +        goto out;
>> +
>> +    grrb = (struct clp_req_rsp_query_pci_grp *)rrb;
>> +    rc = zdev_query_pci_fngrp(zdev, grrb);
>> +    if (rc || grrb->response.hdr.rsp != CLP_RC_OK) {
>> +        zpci_err("Q PCI FGRP:\n");
>> +        zpci_err_clp(grrb->response.hdr.rsp, rc);
>> +        rc = -EIO;
>> +        goto out;
>> +    }
>> +    clp_store_query_pci_fngrp(zdev, &grrb->response);
>> +
>>   out:
>>       clp_free_block(rrb);
>>       return rc;
>> @@ -219,7 +223,7 @@ int clp_add_pci_device(u32 fid, u32 fh, int 
>> configured)
>>       zdev->fid = fid;
>>       /* Query function properties and update zdev */
>> -    rc = clp_query_pci_fn(zdev, fh);
>> +    rc = clp_query_pci(zdev);
>>       if (rc)
>>           goto error;
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
