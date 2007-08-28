From: James Smart <James.Smart@Emulex.Com>
Date: Tue, 28 Aug 2007 11:14:42 +0000
Subject: Re: [PATCH 8/10] Introduce disable_target_scan flag in FC transport
Message-Id: <46D403A2.70706@emulex.com>
In-Reply-To: <200708280931.21488.swen@vnet.ibm.com>
References: <200708280931.21488.swen@vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

ACK

In the future, if the patch has already been pushed upstream independently
I would not embed it again in a set of zfcp patches- I would simply reference it.

-- james s

Swen Schillig wrote:
> From: Christof Schmitt <christof.schmitt@de.ibm.com>
> 
> This change has already been discussed on linux-scsi:
> http://marc.info/?t=118771096400003
> http://marc.info/?t=118760913100005
> 
> Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
> Signed-off-by: Swen Schillig <swen@vnet.ibm.com>
> ---
> 
>  drivers/scsi/scsi_transport_fc.c |    4 +++-
>  include/scsi/scsi_transport_fc.h |    2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff -urpN linux-2.6/drivers/scsi/scsi_transport_fc.c linux-2.6-patched/drivers/scsi/scsi_transport_fc.c
> --- linux-2.6/drivers/scsi/scsi_transport_fc.c	2007-08-27 13:21:50.000000000 +0200
> +++ linux-2.6-patched/drivers/scsi/scsi_transport_fc.c	2007-08-27 13:22:22.000000000 +0200
> @@ -2988,10 +2988,12 @@ fc_scsi_scan_rport(struct work_struct *w
>  	struct fc_rport *rport =
>  		container_of(work, struct fc_rport, scan_work);
>  	struct Scsi_Host *shost = rport_to_shost(rport);
> +	struct fc_internal *i = to_fc_internal(shost->transportt);
>  	unsigned long flags;
>  
>  	if ((rport->port_state == FC_PORTSTATE_ONLINE) &&
> -	    (rport->roles & FC_PORT_ROLE_FCP_TARGET)) {
> +	    (rport->roles & FC_PORT_ROLE_FCP_TARGET) &&
> +	    !(i->f->disable_target_scan)) {
>  		scsi_scan_target(&rport->dev, rport->channel,
>  			rport->scsi_target_id, SCAN_WILD_CARD, 1);
>  	}
> diff -urpN linux-2.6/include/scsi/scsi_transport_fc.h linux-2.6-patched/include/scsi/scsi_transport_fc.h
> --- linux-2.6/include/scsi/scsi_transport_fc.h	2007-08-27 13:21:52.000000000 +0200
> +++ linux-2.6-patched/include/scsi/scsi_transport_fc.h	2007-08-27 13:22:22.000000000 +0200
> @@ -632,6 +632,8 @@ struct fc_function_template {
>  	unsigned long	show_host_fabric_name:1;
>  	unsigned long	show_host_symbolic_name:1;
>  	unsigned long	show_host_system_hostname:1;
> +
> +	unsigned long	disable_target_scan:1;
>  };
>  
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
