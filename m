From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 15:00:37 +0000
Subject: Re: [PATCH 16/23] zfcp: use enum zfcp_erp_steps for struct zfcp_erp_action.step
Message-Id: <2482aa10-3b5e-2486-9657-33d10661519f@suse.de>
In-Reply-To: <192095ee-862c-afc5-d900-d24d964e609c@linux.ibm.com>
References: <192095ee-862c-afc5-d900-d24d964e609c@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/16/18 3:19 PM, Steffen Maier wrote:
> On 11/16/2018 12:17 PM, Hannes Reinecke wrote:
>> On 11/8/18 3:44 PM, Steffen Maier wrote:
>>> Use the already defined enum for this purpose to get at least some build
>>> checking (even though an enum is type equivalent to an int in C).
>>> v2.6.27 commit 287ac01acf22 ("[SCSI] zfcp: Cleanup code in zfcp_erp.c")
>>> introduced the enum which was cpp defines previously.
>>>
>>> Since struct zfcp_erp_action type is embedded into other structures
>>> living in zfcp_def.h, we have to move enum zfcp_erp_act_type from
>>> its private definition in zfcp_erp.c to the zfcp-global zfcp_def.h
>>>
>>> Silence some false -Wswitch compiler warning cases with individual
>>> NOP cases. When adding more enum values and building with W=1 we
>>> would get compiler warnings about missed new cases.
>>>
>>> Add missing break statements in some of the above switch cases.
>>> No functional change, but making it future-proof.
>>> I think all of these should have had a break statement ever since,
>>> even if these switch cases happened to be the last ones in the switch
>>> statement body.
>>>
>>> "Fall through" in the context of switch case usually means not to have a
>>> break and fall through to the subsequent switch case. However, I think
>>> this old comment meant that here we do not have an _early return_ in the
>>> switch case but the code path continues after the switch case body.
>>>
>>> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
>>> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
>>> ---
>>> � drivers/s390/scsi/zfcp_def.h |�� 16 +++++++++++++++-
>>> � drivers/s390/scsi/zfcp_erp.c |�� 35 
>>> +++++++++++++++++++++++++----------
>>> � 2 files changed, 40 insertions(+), 11 deletions(-)
>>>
>>> --- a/drivers/s390/scsi/zfcp_def.h
>>> +++ b/drivers/s390/scsi/zfcp_def.h
>>> @@ -107,6 +107,20 @@ enum zfcp_erp_act_type {
>>> ����� ZFCP_ERP_ACTION_REOPEN_ADAPTER������ = 4,
>>> � };
>>> +/*
>>> + * Values must fit into u16 because of code dependencies:
>>> + * zfcp_dbf_rec_run_lvl(), zfcp_dbf_rec_run(), zfcp_dbf_rec_run_wka(),
>>> + * &zfcp_dbf_rec_running.rec_step.
>>> + */
>>> +enum zfcp_erp_steps {
>>> +��� ZFCP_ERP_STEP_UNINITIALIZED��� = 0x0000,
>>> +��� ZFCP_ERP_STEP_PHYS_PORT_CLOSING��� = 0x0010,
>>> +��� ZFCP_ERP_STEP_PORT_CLOSING��� = 0x0100,
>>> +��� ZFCP_ERP_STEP_PORT_OPENING��� = 0x0800,
>>> +��� ZFCP_ERP_STEP_LUN_CLOSING��� = 0x1000,
>>> +��� ZFCP_ERP_STEP_LUN_OPENING��� = 0x2000,
>>> +};
>>> +
>>> � struct zfcp_erp_action {
>>> ����� struct list_head list;
>>> ����� enum zfcp_erp_act_type type;� /* requested action code */
>>> @@ -114,7 +128,7 @@ struct zfcp_erp_action {
>>> ����� struct zfcp_port *port;
>>> ����� struct scsi_device *sdev;
>>> ����� u32������� status;��������� /* recovery status */
>>> -��� u32 step;����������������� /* active step of this erp action */
>>> +��� enum zfcp_erp_steps��� step;��� /* active step of this erp 
>>> action */
>>> ����� unsigned long������� fsf_req_id;
>>> ����� struct timer_list timer;
>>> � };
>>> --- a/drivers/s390/scsi/zfcp_erp.c
>>> +++ b/drivers/s390/scsi/zfcp_erp.c
>>> @@ -24,15 +24,6 @@ enum zfcp_erp_act_flags {
>>> ����� ZFCP_STATUS_ERP_NO_REF������� = 0x00800000,
>>> � };
>>> -enum zfcp_erp_steps {
>>> -��� ZFCP_ERP_STEP_UNINITIALIZED��� = 0x0000,
>>> -��� ZFCP_ERP_STEP_PHYS_PORT_CLOSING��� = 0x0010,
>>> -��� ZFCP_ERP_STEP_PORT_CLOSING��� = 0x0100,
>>> -��� ZFCP_ERP_STEP_PORT_OPENING��� = 0x0800,
>>> -��� ZFCP_ERP_STEP_LUN_CLOSING��� = 0x1000,
>>> -��� ZFCP_ERP_STEP_LUN_OPENING��� = 0x2000,
>>> -};
>>> -
>>> � /*
>>> �� * Eyecatcher pseudo flag to bitwise or-combine with enum 
>>> zfcp_erp_act_type.
>>> �� * Used to indicate that an ERP action could not be set up despite 
>>> a detected
>>> @@ -900,6 +891,13 @@ static int zfcp_erp_port_forced_strategy
>>> ����� case ZFCP_ERP_STEP_PHYS_PORT_CLOSING:
>>> ��������� if (!(status & ZFCP_STATUS_PORT_PHYS_OPEN))
>>> ������������� return ZFCP_ERP_SUCCEEDED;
>>> +������� break;
>>> +��� case ZFCP_ERP_STEP_PORT_CLOSING:
>>> +��� case ZFCP_ERP_STEP_PORT_OPENING:
>>> +��� case ZFCP_ERP_STEP_LUN_CLOSING:
>>> +��� case ZFCP_ERP_STEP_LUN_OPENING:
>>> +������� /* NOP */
>>> +������� break;
>>> ����� }
>>> ����� return ZFCP_ERP_FAILED;
>>> � }
>>> @@ -974,7 +972,12 @@ static int zfcp_erp_port_strategy_open_c
>>> ������������� port->d_id = 0;
>>> ������������� return ZFCP_ERP_FAILED;
>>> ��������� }
>>> -������� /* fall through otherwise */
>>> +������� /* no early return otherwise, continue after switch case */
>>> +������� break;
>>> +��� case ZFCP_ERP_STEP_LUN_CLOSING:
>>> +��� case ZFCP_ERP_STEP_LUN_OPENING:
>>> +������� /* NOP */
>>> +������� break;
>>> ����� }
>>> ����� return ZFCP_ERP_FAILED;
>>> � }
>>> @@ -998,6 +1001,12 @@ static int zfcp_erp_port_strategy(struct
>>> ��������� if (p_status & ZFCP_STATUS_COMMON_OPEN)
>>> ������������� return ZFCP_ERP_FAILED;
>>> ��������� break;
>>> +��� case ZFCP_ERP_STEP_PHYS_PORT_CLOSING:
>>> +��� case ZFCP_ERP_STEP_PORT_OPENING:
>>> +��� case ZFCP_ERP_STEP_LUN_CLOSING:
>>> +��� case ZFCP_ERP_STEP_LUN_OPENING:
>>> +������� /* NOP */
>>> +������� break;
>>> ����� }
>>> � close_init_done:
>>> @@ -1058,6 +1067,12 @@ static int zfcp_erp_lun_strategy(struct
>>> ����� case ZFCP_ERP_STEP_LUN_OPENING:
>>> ��������� if (atomic_read(&zfcp_sdev->status) & ZFCP_STATUS_COMMON_OPEN)
>>> ������������� return ZFCP_ERP_SUCCEEDED;
>>> +������� break;
>>> +��� case ZFCP_ERP_STEP_PHYS_PORT_CLOSING:
>>> +��� case ZFCP_ERP_STEP_PORT_CLOSING:
>>> +��� case ZFCP_ERP_STEP_PORT_OPENING:
>>> +������� /* NOP */
>>> +������� break;
>>> ����� }
>>> ����� return ZFCP_ERP_FAILED;
>>> � }
>>>
>> Why don't you use 'default:' here?
> 
> I had it with default case in the first place.
> Then I happened to see this and changed it:
>> ��� https://lkml.org/lkml/2018/10/4/935
>> ��� Re: [PATCH RESEND] drbd: avoid clang warning about pointless 
>> switch statement
>> ��� > There is nothing wrong with the code, and adding 'default:' labels
>> ��� > in the right place is enough to let clang shut up about the 
>> warning.
>> ��� Actually, I think I'd prefer a "case 0:" instead of the "default:",
> 
> 
>> Clearly the compiler would warn you if the didn't specify all 
>> remaining cases, so 'default:' seems to match here pretty well ...
> 
> Does it? I did not know that.
> 
> What would be the point of a default case for an enum switch, if each 
> enum value needs a case anyway to stay without warning? Sounds a bit 
> like the default case would be superfluous then to me.
> 

I've spoken to our compiler team, and it boils down the programming 
style. While your way is obviously correct, it just signals that
"I've looked at the other enum values, and there's nothing to be done"

The same can be set for the 'default' case, only it's less lines, but 
you lose the actual values.

In the end, I don't mind, and there reasons for and against it.
But probably needs to be discussed with a larger audience anyway.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
