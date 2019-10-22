Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388525AbfJVMVV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Oct 2019 08:21:21 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9MCHNov082676
        for <linux-s390@vger.kernel.org>; Tue, 22 Oct 2019 08:21:20 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vsy97wg9x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 22 Oct 2019 08:21:20 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Tue, 22 Oct 2019 13:21:17 +0100
Subject: Re: [PATCH 12/24] scsi: introduce scsi_build_sense()
References: <20191021095322.137969-1-hare@suse.de>
 <20191021095322.137969-13-hare@suse.de>
From: Steffen Maier <maier@linux.ibm.com>
Date: Tue, 22 Oct 2019 14:21:12 +0200
MIME-Version: 1.0
In-Reply-To: <20191021095322.137969-13-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4097c14b-4b28-f7ee-595c-cb338b878d27@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hannes Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, James Bottomley <james.bottomley@hansenpartnership.com>, Johannes Thumshirn <jthumshirn@suse.de>, linux-scsi@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>

On 10/21/19 11:53 AM, Hannes Reinecke wrote:
> Introduce scsi_build_sense() as a wrapper around
> scsi_build_sense_buffer() to format the buffer and set
> the correct SCSI status.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---

>   drivers/s390/scsi/zfcp_scsi.c         |  5 +--

>   16 files changed, 60 insertions(+), 128 deletions(-)

> diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
> index e9ded2befa0d..da52d7649f4d 100644
> --- a/drivers/s390/scsi/zfcp_scsi.c
> +++ b/drivers/s390/scsi/zfcp_scsi.c
> @@ -834,10 +834,7 @@ void zfcp_scsi_set_prot(struct zfcp_adapter *adapter)
>    */
>   void zfcp_scsi_dif_sense_error(struct scsi_cmnd *scmd, int ascq)
>   {
> -	scsi_build_sense_buffer(1, scmd->sense_buffer,
> -				ILLEGAL_REQUEST, 0x10, ascq);
> -	set_driver_byte(scmd, DRIVER_SENSE);
> -	scmd->result |= SAM_STAT_CHECK_CONDITION;
> +	scsi_build_sense(scmd, 1, ILLEGAL_REQUEST, 0x10, ascq);
>   	set_host_byte(scmd, DID_SOFT_ERROR);
>   }
> 

looks like a non-functional change for zfcp, so for this part:

Acked-by: Steffen Maier <maier@linux.ibm.com> # for zfcp

> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index a0db8d8766a8..2babf6df8066 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -3117,3 +3117,21 @@ int scsi_vpd_tpg_id(struct scsi_device *sdev, int *rel_id)
>   	return group_id;
>   }
>   EXPORT_SYMBOL(scsi_vpd_tpg_id);
> +
> +/**
> + * scsi_build_sense - build sense data for a command

minor: I suppose kdoc&sphnix parse and render it correctly? Because 
Documentation/doc-guide/kernel-doc.rst says the format for function kdoc has 
"()" as function name suffix:
+ * scsi_build_sense() - build sense data for a command

> + * @scmd:	scsi command for which the sense should be formatted
> + * @desc:	Sense format (non-zero == descriptor format,
> + *              0 == fixed format)

Looks like this has already been like that. Not sure if this patch set touches 
every user of scsi_build_sense{_buffer}(). It would be nice to have meaningful 
identifiers for values passed to @desc, e.g. something like the following 
instead of "magic" zero and non-zero:

enum scsi_sense_format {
	SCSI_SENSE_FIXED = 0,
	SCSI_SENSE_DESCRIPTOR
};

> + * @key:	Sense key
> + * @asc:	Additional sense code
> + * @ascq:	Additional sense code qualifier
> + *
> + **/

minor:

+ */

[no double star at kdoc end?]

> +void scsi_build_sense(struct scsi_cmnd *scmd, int desc, u8 key, u8 asc, u8 ascq)
> +{
> +	scsi_build_sense_buffer(desc, scmd->sense_buffer, key, asc, ascq);
> +	scmd->result = (DRIVER_SENSE << 24) | (DID_OK << 16) |
> +		SAM_STAT_CHECK_CONDITION;

While this is scsi_lib and thus "internal" helper code, I wonder if this should 
nonetheless use the helper functions to access and build scmd->result in order 
to have the error-prone bit shifts in only one central place?:

	scmd->result = SAM_STAT_CHECK_CONDITION;
	set_driver_byte(scmd, DRIVER_SENSE);
	set_host_byte(scmd, DID_OK);
	

> +}
> +EXPORT_SYMBOL_GPL(scsi_build_sense);

> diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> index 6932d91472d5..9b9ca629097d 100644
> --- a/include/scsi/scsi_cmnd.h
> +++ b/include/scsi/scsi_cmnd.h
> @@ -338,4 +338,7 @@ static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
>   	return xfer_len;
>   }
> 
> +extern void scsi_build_sense(struct scsi_cmnd *scmd, int desc,
> +			     u8 key, u8 asc, u8 ascq);
> +
>   #endif /* _SCSI_SCSI_CMND_H */
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
