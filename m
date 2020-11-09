Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbgKIKCG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Nov 2020 05:02:06 -0500
Subject: Re: [PATCH net-next v3 15/15] net/smc: Add support for obtaining
 system information
References: <20201107125958.16384-1-kgraul@linux.ibm.com>
 <20201107125958.16384-16-kgraul@linux.ibm.com>
 <20201107095540.0f45b572@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Karsten Graul <kgraul@linux.ibm.com>
Message-ID: <22bd2535-4057-12a2-ae6b-fefd33129e98@linux.ibm.com>
Date: Mon, 9 Nov 2020 11:01:57 +0100
MIME-Version: 1.0
In-Reply-To: <20201107095540.0f45b572@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

On 07/11/2020 18:55, Jakub Kicinski wrote:
> On Sat,  7 Nov 2020 13:59:58 +0100 Karsten Graul wrote:
>> From: Guvenc Gulce <guvenc@linux.ibm.com>
>>
>> Add new netlink command to obtain system information
>> of the smc module.
>>
>> Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
>> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> 
> Checkpatch says:
> 
> CHECK: Please don't use multiple blank lines
> #62: FILE: include/uapi/linux/smc_diag.h:140:
>  
> +
> 
> WARNING: line length of 84 exceeds 80 columns
> #172: FILE: net/smc/smc_diag.c:687:
> +	smcd_dev = list_first_entry_or_null(&dev_list->list, struct smcd_dev, list);
> 

The checkpatch.pl script in net-next does not bring up this length warning.
We will address it in a v4.

-- 
Karsten

(I'm a dude)
