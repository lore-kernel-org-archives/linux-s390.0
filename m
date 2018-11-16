From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 16 Nov 2018 14:40:37 +0000
Subject: Re: [PATCH 12/23] zfcp: update kernel message for invalid FCP_CMND length, it's not the CDB
Message-Id: <81b2b4d4-27d7-6781-afb0-fdb1489a88d3@linux.ibm.com>
In-Reply-To: <d240881b-7fd3-6898-ee39-00ec8c78e862@suse.de>
References: <d240881b-7fd3-6898-ee39-00ec8c78e862@suse.de>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/16/2018 12:13 PM, Hannes Reinecke wrote:
> On 11/8/18 3:44 PM, Steffen Maier wrote:
>> The CDB is just a part inside of FCP_CMND, see zfcp_fc_scsi_to_fcp().
>> While at it, fix the device driver reaction: adapter not LUN shutdown.
>>
>> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
>> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
>> ---
>> � drivers/s390/scsi/zfcp_fsf.c | 7 ++-----
>> � 1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
>> index c949c65ffc6a..0bdbc596da97 100644
>> --- a/drivers/s390/scsi/zfcp_fsf.c
>> +++ b/drivers/s390/scsi/zfcp_fsf.c
>> @@ -2090,11 +2090,8 @@ static void zfcp_fsf_fcp_handler_common(struct 
>> zfcp_fsf_req *req,
>> ��������� break;
>> ����� case FSF_CMND_LENGTH_NOT_VALID:
>> ��������� dev_err(&req->adapter->ccw_device->dev,
>> -����������� "Incorrect CDB length %d, LUN 0x%016Lx on "
>> -����������� "port 0x%016Lx closed\n",
>> -����������� req->qtcb->bottom.io.fcp_cmnd_length,
>> -����������� (unsigned long long)zfcp_scsi_dev_lun(sdev),
>> -����������� (unsigned long long)zfcp_sdev->port->wwpn);
>> +����������� "Incorrect FCP_CMND length %d, FCP device closed\n",
>> +����������� req->qtcb->bottom.io.fcp_cmnd_length);
>> ��������� zfcp_erp_adapter_shutdown(req->adapter, 0, "fssfch4");
>> ��������� req->status |= ZFCP_STATUS_FSFREQ_ERROR;
>> ��������� break;
>>
> Really? You're only fixing the message, not the adapter behaviour.
> Care to clarify the commit message?

This is one of few cases in zfcp where we shutdown the entire adapter.
If we would ever get this, it would be very likely a zfcp bug in 
hardcoded parts affecting all IO paths to all our LUNs. Also, retrying 
would likely repeat the error.

IIRC, it's always been an adapter shutdown in git history. It's not that 
the type of recovery has changed at some point. A previous version of 
the message even had the correct recovery description part
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/s390/scsi?id=553448f6c4838a1e4bed2bc9301c748278d7d9ce
v2.6.27 ("[SCSI] zfcp: Message cleanup")
but broke with
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/s390/scsi?id=ff3b24fa5370a7ca618f212284d9b36fcedb9c0e
v2.6.28 ("[SCSI] zfcp: Update message with input from review")

Is this what you would like to see as clarification?

-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
