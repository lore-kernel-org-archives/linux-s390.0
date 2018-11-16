From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:19:20 +0000
Subject: Re: [PATCH 17/23] zfcp: use enum zfcp_erp_act_result for argument/return of affected functions
Message-Id: <30510d8c-90c6-a5e9-2e02-816b3c600b59@suse.de>
In-Reply-To: <20181108144458.29012-18-maier@linux.ibm.com>
References: <20181108144458.29012-18-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> With that instead of just "int" it becomes clear which functions return
> this type and which ones also accept it as argument they just pass through
> in some cases or modify in other cases.
> v2.6.27 commit 287ac01acf22 ("[SCSI] zfcp: Cleanup code in zfcp_erp.c")
> introduced the enum which was cpp defines previously.
> 
> Silence some false -Wswitch compiler warning cases with individual
> NOP cases. When adding more enum values and building with W=1 we
> would get compiler warnings about missed new cases.
> 
> Consistently use the variable name "result", so change "retval" in
> zfcp_erp_strategy() to "result". This avoids confusion with other
> compile unit variables "retval" having different semantics and type.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_erp.c | 124 +++++++++++++++++++++++++++++--------------
>   1 file changed, 84 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
> index 3da870e55ab5..5c7fb64111fe 100644
> --- a/drivers/s390/scsi/zfcp_erp.c
> +++ b/drivers/s390/scsi/zfcp_erp.c
> @@ -713,7 +713,8 @@ static void zfcp_erp_enqueue_ptp_port(struct zfcp_adapter *adapter)
>   	_zfcp_erp_port_reopen(port, 0, "ereptp1");
>   }
>   
> -static int zfcp_erp_adapter_strat_fsf_xconf(struct zfcp_erp_action *erp_action)
> +static enum zfcp_erp_act_result zfcp_erp_adapter_strat_fsf_xconf(
> +	struct zfcp_erp_action *erp_action)
>   {
>   	int retries;
>   	int sleep = 1;
> @@ -758,7 +759,8 @@ static int zfcp_erp_adapter_strat_fsf_xconf(struct zfcp_erp_action *erp_action)
>   	return ZFCP_ERP_SUCCEEDED;
>   }
>   
> -static int zfcp_erp_adapter_strategy_open_fsf_xport(struct zfcp_erp_action *act)
> +static enum zfcp_erp_act_result zfcp_erp_adapter_strategy_open_fsf_xport(
> +	struct zfcp_erp_action *act)
>   {
>   	int ret;
>   	struct zfcp_adapter *adapter = act->adapter;
> @@ -783,7 +785,8 @@ static int zfcp_erp_adapter_strategy_open_fsf_xport(struct zfcp_erp_action *act)
>   	return ZFCP_ERP_SUCCEEDED;
>   }
>   
> -static int zfcp_erp_adapter_strategy_open_fsf(struct zfcp_erp_action *act)
> +static enum zfcp_erp_act_result zfcp_erp_adapter_strategy_open_fsf(
> +	struct zfcp_erp_action *act)
>   {
>   	if (zfcp_erp_adapter_strat_fsf_xconf(act) == ZFCP_ERP_FAILED)
>   		return ZFCP_ERP_FAILED;
> @@ -822,7 +825,8 @@ static void zfcp_erp_adapter_strategy_close(struct zfcp_erp_action *act)
>   			  ZFCP_STATUS_ADAPTER_LINK_UNPLUGGED, &adapter->status);
>   }
>   
> -static int zfcp_erp_adapter_strategy_open(struct zfcp_erp_action *act)
> +static enum zfcp_erp_act_result zfcp_erp_adapter_strategy_open(
> +	struct zfcp_erp_action *act)
>   {
>   	struct zfcp_adapter *adapter = act->adapter;
>   
> @@ -843,7 +847,8 @@ static int zfcp_erp_adapter_strategy_open(struct zfcp_erp_action *act)
>   	return ZFCP_ERP_SUCCEEDED;
>   }
>   
> -static int zfcp_erp_adapter_strategy(struct zfcp_erp_action *act)
> +static enum zfcp_erp_act_result zfcp_erp_adapter_strategy(
> +	struct zfcp_erp_action *act)
>   {
>   	struct zfcp_adapter *adapter = act->adapter;
>   
> @@ -861,7 +866,8 @@ static int zfcp_erp_adapter_strategy(struct zfcp_erp_action *act)
>   	return ZFCP_ERP_SUCCEEDED;
>   }
>   
> -static int zfcp_erp_port_forced_strategy_close(struct zfcp_erp_action *act)
> +static enum zfcp_erp_act_result zfcp_erp_port_forced_strategy_close(
> +	struct zfcp_erp_action *act)
>   {
>   	int retval;
>   
> @@ -875,7 +881,8 @@ static int zfcp_erp_port_forced_strategy_close(struct zfcp_erp_action *act)
>   	return ZFCP_ERP_CONTINUES;
>   }
>   
> -static int zfcp_erp_port_forced_strategy(struct zfcp_erp_action *erp_action)
> +static enum zfcp_erp_act_result zfcp_erp_port_forced_strategy(
> +	struct zfcp_erp_action *erp_action)
>   {
>   	struct zfcp_port *port = erp_action->port;
>   	int status = atomic_read(&port->status);
> @@ -902,7 +909,8 @@ static int zfcp_erp_port_forced_strategy(struct zfcp_erp_action *erp_action)
>   	return ZFCP_ERP_FAILED;
>   }
>   
> -static int zfcp_erp_port_strategy_close(struct zfcp_erp_action *erp_action)
> +static enum zfcp_erp_act_result zfcp_erp_port_strategy_close(
> +	struct zfcp_erp_action *erp_action)
>   {
>   	int retval;
>   
> @@ -915,7 +923,8 @@ static int zfcp_erp_port_strategy_close(struct zfcp_erp_action *erp_action)
>   	return ZFCP_ERP_CONTINUES;
>   }
>   
> -static int zfcp_erp_port_strategy_open_port(struct zfcp_erp_action *erp_action)
> +static enum zfcp_erp_act_result zfcp_erp_port_strategy_open_port(
> +	struct zfcp_erp_action *erp_action)
>   {
>   	int retval;
>   
> @@ -941,7 +950,8 @@ static int zfcp_erp_open_ptp_port(struct zfcp_erp_action *act)
>   	return zfcp_erp_port_strategy_open_port(act);
>   }
>   
> -static int zfcp_erp_port_strategy_open_common(struct zfcp_erp_action *act)
> +static enum zfcp_erp_act_result zfcp_erp_port_strategy_open_common(
> +	struct zfcp_erp_action *act)
>   {
>   	struct zfcp_adapter *adapter = act->adapter;
>   	struct zfcp_port *port = act->port;
> @@ -982,7 +992,8 @@ static int zfcp_erp_port_strategy_open_common(struct zfcp_erp_action *act)
>   	return ZFCP_ERP_FAILED;
>   }
>   
> -static int zfcp_erp_port_strategy(struct zfcp_erp_action *erp_action)
> +static enum zfcp_erp_act_result zfcp_erp_port_strategy(
> +	struct zfcp_erp_action *erp_action)
>   {
>   	struct zfcp_port *port = erp_action->port;
>   	int p_status = atomic_read(&port->status);
> @@ -1024,7 +1035,8 @@ static void zfcp_erp_lun_strategy_clearstati(struct scsi_device *sdev)
>   			  &zfcp_sdev->status);
>   }
>   
> -static int zfcp_erp_lun_strategy_close(struct zfcp_erp_action *erp_action)
> +static enum zfcp_erp_act_result zfcp_erp_lun_strategy_close(
> +	struct zfcp_erp_action *erp_action)
>   {
>   	int retval = zfcp_fsf_close_lun(erp_action);
>   	if (retval == -ENOMEM)
> @@ -1035,7 +1047,8 @@ static int zfcp_erp_lun_strategy_close(struct zfcp_erp_action *erp_action)
>   	return ZFCP_ERP_CONTINUES;
>   }
>   
> -static int zfcp_erp_lun_strategy_open(struct zfcp_erp_action *erp_action)
> +static enum zfcp_erp_act_result zfcp_erp_lun_strategy_open(
> +	struct zfcp_erp_action *erp_action)
>   {
>   	int retval = zfcp_fsf_open_lun(erp_action);
>   	if (retval == -ENOMEM)
> @@ -1046,7 +1059,8 @@ static int zfcp_erp_lun_strategy_open(struct zfcp_erp_action *erp_action)
>   	return ZFCP_ERP_CONTINUES;
>   }
>   
> -static int zfcp_erp_lun_strategy(struct zfcp_erp_action *erp_action)
> +static enum zfcp_erp_act_result zfcp_erp_lun_strategy(
> +	struct zfcp_erp_action *erp_action)
>   {
>   	struct scsi_device *sdev = erp_action->sdev;
>   	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
> @@ -1077,7 +1091,8 @@ static int zfcp_erp_lun_strategy(struct zfcp_erp_action *erp_action)
>   	return ZFCP_ERP_FAILED;
>   }
>   
> -static int zfcp_erp_strategy_check_lun(struct scsi_device *sdev, int result)
> +static enum zfcp_erp_act_result zfcp_erp_strategy_check_lun(
> +	struct scsi_device *sdev, enum zfcp_erp_act_result result)
>   {
>   	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
>   
> @@ -1098,6 +1113,12 @@ static int zfcp_erp_strategy_check_lun(struct scsi_device *sdev, int result)
>   						ZFCP_STATUS_COMMON_ERP_FAILED);
>   		}
>   		break;
> +	case ZFCP_ERP_CONTINUES:
> +	case ZFCP_ERP_EXIT:
> +	case ZFCP_ERP_DISMISSED:
> +	case ZFCP_ERP_NOMEM:
> +		/* NOP */
> +		break;
>   	}
>   
>   	if (atomic_read(&zfcp_sdev->status) & ZFCP_STATUS_COMMON_ERP_FAILED) {

Cf my comment to the previous patch.
Please use 'default:' here.

> @@ -1107,7 +1128,8 @@ static int zfcp_erp_strategy_check_lun(struct scsi_device *sdev, int result)
>   	return result;
>   }
>   
> -static int zfcp_erp_strategy_check_port(struct zfcp_port *port, int result)
> +static enum zfcp_erp_act_result zfcp_erp_strategy_check_port(
> +	struct zfcp_port *port, enum zfcp_erp_act_result result)
>   {
>   	switch (result) {
>   	case ZFCP_ERP_SUCCEEDED :
> @@ -1129,6 +1151,12 @@ static int zfcp_erp_strategy_check_port(struct zfcp_port *port, int result)
>   					 ZFCP_STATUS_COMMON_ERP_FAILED);
>   		}
>   		break;
> +	case ZFCP_ERP_CONTINUES:
> +	case ZFCP_ERP_EXIT:
> +	case ZFCP_ERP_DISMISSED:
> +	case ZFCP_ERP_NOMEM:
> +		/* NOP */
> +		break;
>   	}
>   
>   	if (atomic_read(&port->status) & ZFCP_STATUS_COMMON_ERP_FAILED) {

And here

> @@ -1138,8 +1166,8 @@ static int zfcp_erp_strategy_check_port(struct zfcp_port *port, int result)
>   	return result;
>   }
>   
> -static int zfcp_erp_strategy_check_adapter(struct zfcp_adapter *adapter,
> -					   int result)
> +static enum zfcp_erp_act_result zfcp_erp_strategy_check_adapter(
> +	struct zfcp_adapter *adapter, enum zfcp_erp_act_result result)
>   {
>   	switch (result) {
>   	case ZFCP_ERP_SUCCEEDED :
> @@ -1157,6 +1185,12 @@ static int zfcp_erp_strategy_check_adapter(struct zfcp_adapter *adapter,
>   					    ZFCP_STATUS_COMMON_ERP_FAILED);
>   		}
>   		break;
> +	case ZFCP_ERP_CONTINUES:
> +	case ZFCP_ERP_EXIT:
> +	case ZFCP_ERP_DISMISSED:
> +	case ZFCP_ERP_NOMEM:
> +		/* NOP */
> +		break;
>   	}
>   
>   	if (atomic_read(&adapter->status) & ZFCP_STATUS_COMMON_ERP_FAILED) {

And here.

> @@ -1166,8 +1200,8 @@ static int zfcp_erp_strategy_check_adapter(struct zfcp_adapter *adapter,
>   	return result;
>   }
>   
> -static int zfcp_erp_strategy_check_target(struct zfcp_erp_action *erp_action,
> -					  int result)
> +static enum zfcp_erp_act_result zfcp_erp_strategy_check_target(
> +	struct zfcp_erp_action *erp_action, enum zfcp_erp_act_result result)
>   {
>   	struct zfcp_adapter *adapter = erp_action->adapter;
>   	struct zfcp_port *port = erp_action->port;
> @@ -1206,7 +1240,8 @@ static int zfcp_erp_strat_change_det(atomic_t *target_status, u32 erp_status)
>   	return 0;
>   }
>   
> -static int zfcp_erp_strategy_statechange(struct zfcp_erp_action *act, int ret)
> +static enum zfcp_erp_act_result zfcp_erp_strategy_statechange(
> +	struct zfcp_erp_action *act, enum zfcp_erp_act_result result)
>   {
>   	enum zfcp_erp_act_type type = act->type;
>   	struct zfcp_adapter *adapter = act->adapter;
> @@ -1245,7 +1280,7 @@ static int zfcp_erp_strategy_statechange(struct zfcp_erp_action *act, int ret)
>   		}
>   		break;
>   	}
> -	return ret;
> +	return result;
>   }
>   
>   static void zfcp_erp_action_dequeue(struct zfcp_erp_action *erp_action)
> @@ -1338,7 +1373,8 @@ static void zfcp_erp_try_rport_unblock(struct zfcp_port *port)
>   	write_unlock_irqrestore(&adapter->erp_lock, flags);
>   }
>   
> -static void zfcp_erp_action_cleanup(struct zfcp_erp_action *act, int result)
> +static void zfcp_erp_action_cleanup(struct zfcp_erp_action *act,
> +				    enum zfcp_erp_act_result result)
>   {
>   	struct zfcp_adapter *adapter = act->adapter;
>   	struct zfcp_port *port = act->port;
> @@ -1378,7 +1414,8 @@ static void zfcp_erp_action_cleanup(struct zfcp_erp_action *act, int result)
>   	}
>   }
>   
> -static int zfcp_erp_strategy_do_action(struct zfcp_erp_action *erp_action)
> +static enum zfcp_erp_act_result zfcp_erp_strategy_do_action(
> +	struct zfcp_erp_action *erp_action)
>   {
>   	switch (erp_action->type) {
>   	case ZFCP_ERP_ACTION_REOPEN_ADAPTER:
> @@ -1393,9 +1430,10 @@ static int zfcp_erp_strategy_do_action(struct zfcp_erp_action *erp_action)
>   	return ZFCP_ERP_FAILED;
>   }
>   
> -static int zfcp_erp_strategy(struct zfcp_erp_action *erp_action)
> +static enum zfcp_erp_act_result zfcp_erp_strategy(
> +	struct zfcp_erp_action *erp_action)
>   {
> -	int retval;
> +	enum zfcp_erp_act_result result;
>   	unsigned long flags;
>   	struct zfcp_adapter *adapter = erp_action->adapter;
>   
> @@ -1406,12 +1444,12 @@ static int zfcp_erp_strategy(struct zfcp_erp_action *erp_action)
>   
>   	if (erp_action->status & ZFCP_STATUS_ERP_DISMISSED) {
>   		zfcp_erp_action_dequeue(erp_action);
> -		retval = ZFCP_ERP_DISMISSED;
> +		result = ZFCP_ERP_DISMISSED;
>   		goto unlock;
>   	}
>   
>   	if (erp_action->status & ZFCP_STATUS_ERP_TIMEDOUT) {
> -		retval = ZFCP_ERP_FAILED;
> +		result = ZFCP_ERP_FAILED;
>   		goto check_target;
>   	}
>   
> @@ -1419,13 +1457,13 @@ static int zfcp_erp_strategy(struct zfcp_erp_action *erp_action)
>   
>   	/* no lock to allow for blocking operations */
>   	write_unlock_irqrestore(&adapter->erp_lock, flags);
> -	retval = zfcp_erp_strategy_do_action(erp_action);
> +	result = zfcp_erp_strategy_do_action(erp_action);
>   	write_lock_irqsave(&adapter->erp_lock, flags);
>   
>   	if (erp_action->status & ZFCP_STATUS_ERP_DISMISSED)
> -		retval = ZFCP_ERP_CONTINUES;
> +		result = ZFCP_ERP_CONTINUES;
>   
> -	switch (retval) {
> +	switch (result) {
>   	case ZFCP_ERP_NOMEM:
>   		if (!(erp_action->status & ZFCP_STATUS_ERP_LOWMEM)) {
>   			++adapter->erp_low_mem_count;
> @@ -1435,7 +1473,7 @@ static int zfcp_erp_strategy(struct zfcp_erp_action *erp_action)
>   			_zfcp_erp_adapter_reopen(adapter, 0, "erstgy1");
>   		else {
>   			zfcp_erp_strategy_memwait(erp_action);
> -			retval = ZFCP_ERP_CONTINUES;
> +			result = ZFCP_ERP_CONTINUES;
>   		}
>   		goto unlock;
>   
> @@ -1445,27 +1483,33 @@ static int zfcp_erp_strategy(struct zfcp_erp_action *erp_action)
>   			erp_action->status &= ~ZFCP_STATUS_ERP_LOWMEM;
>   		}
>   		goto unlock;
> +	case ZFCP_ERP_SUCCEEDED:
> +	case ZFCP_ERP_FAILED:
> +	case ZFCP_ERP_EXIT:
> +	case ZFCP_ERP_DISMISSED:
> +		/* NOP */
> +		break;
>   	}
>   
Here, too.

>   check_target:
> -	retval = zfcp_erp_strategy_check_target(erp_action, retval);
> +	result = zfcp_erp_strategy_check_target(erp_action, result);
>   	zfcp_erp_action_dequeue(erp_action);
> -	retval = zfcp_erp_strategy_statechange(erp_action, retval);
> -	if (retval == ZFCP_ERP_EXIT)
> +	result = zfcp_erp_strategy_statechange(erp_action, result);
> +	if (result == ZFCP_ERP_EXIT)
>   		goto unlock;
> -	if (retval == ZFCP_ERP_SUCCEEDED)
> +	if (result == ZFCP_ERP_SUCCEEDED)
>   		zfcp_erp_strategy_followup_success(erp_action);
> -	if (retval == ZFCP_ERP_FAILED)
> +	if (result == ZFCP_ERP_FAILED)
>   		zfcp_erp_strategy_followup_failed(erp_action);
>   
>    unlock:
>   	write_unlock_irqrestore(&adapter->erp_lock, flags);
>   
> -	if (retval != ZFCP_ERP_CONTINUES)
> -		zfcp_erp_action_cleanup(erp_action, retval);
> +	if (result != ZFCP_ERP_CONTINUES)
> +		zfcp_erp_action_cleanup(erp_action, result);
>   
>   	kref_put(&adapter->ref, zfcp_adapter_release);
> -	return retval;
> +	return result;
>   }
>   
>   static int zfcp_erp_thread(void *data)
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
