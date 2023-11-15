Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7868C072A2
	for <linux-s390@archiver.kernel.org>; Wed, 15 Nov 2023 20:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjKOUnd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Nov 2023 15:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjKOUnc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 15:43:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EEAE5;
        Wed, 15 Nov 2023 12:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qfvpVy7oscEPa2fig06HQWlFHR2nFdfV8IbvwiE3Aaw=; b=YY3g41TTWKnLmh1mdwWzhIhO4h
        VkUDm2AQ4M/++mJDYmYPYZlW9BoAgkvFahMvtJzJGs5DV2saCvgdS6BoIBSAXNMAllGbFUzf5r8Rn
        ZcMsLEF4BW+p9Suqp/QYAJf0+j3CcHuAeoXOwM3juim1ezQt03w94iajNV8oioX1gpLSb/YjRIybx
        Ajnf5ZWiieS0kqFNCEGpU9Zh1Kfx/TEhMaFhWiTE1uyPgWF29kbb++AMULZ3owXj7LdGS7Y8+1hAM
        yuSvgZiBvDk+xCPhaKVCrS6R7wMMvi07gm4CUfx35MuM2RkoguzHNYgC94LKK9v35HAER4mle9geO
        PaUwogBQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3MjL-001gz0-1S;
        Wed, 15 Nov 2023 20:43:23 +0000
Message-ID: <9af0e158-e2c6-418a-8081-972460012ee7@infradead.org>
Date:   Wed, 15 Nov 2023 12:43:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] s390/ism: ism driver implies smc protocol
Content-Language: en-US
To:     Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wen Gu <guwen@linux.alibaba.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, dust.li@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20231115102304.GN74656@kernel.org>
 <20231115155958.3249645-1-gbayer@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231115155958.3249645-1-gbayer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 11/15/23 07:59, Gerd Bayer wrote:
> Since commit a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> you can build the ism code without selecting the SMC network protocol.
> That leaves some ism functions be reported as unused. Move these
> functions under the conditional compile with CONFIG_SMC.
> 
> Also codify the suggestion to also configure the SMC protocol in ism's
> Kconfig - but with an "imply" rather than a "select" as SMC depends on
> other config options and allow for a deliberate decision not to build
> SMC. Also, mention that in ISM's help.
> 
> Fixes: a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/netdev/afd142a2-1fa0-46b9-8b2d-7652d41d3ab8@infradead.org/
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/s390/net/Kconfig   |  3 +-
>  drivers/s390/net/ism_drv.c | 93 +++++++++++++++++++-------------------
>  2 files changed, 48 insertions(+), 48 deletions(-)
> 
> Hi Simon,
> 
> this is version 2, that removes the unused forward declaration that you
> found in v1 per:
> https://lore.kernel.org/netdev/20231115102304.GN74656@kernel.org/#t
> Other than that the patch is unchanged.
> 
> Thanks,
> Gerd
> 
> 
> diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> index 4902d45e929c..c61e6427384c 100644
> --- a/drivers/s390/net/Kconfig
> +++ b/drivers/s390/net/Kconfig
> @@ -103,10 +103,11 @@ config CCWGROUP
>  config ISM
>  	tristate "Support for ISM vPCI Adapter"
>  	depends on PCI
> +	imply SMC
>  	default n
>  	help
>  	  Select this option if you want to use the Internal Shared Memory
> -	  vPCI Adapter.
> +	  vPCI Adapter. The adapter can be used with the SMC network protocol.
>  
>  	  To compile as a module choose M. The module name is ism.
>  	  If unsure, choose N.
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index 6df7f377d2f9..81aabbfbbe2c 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -30,7 +30,6 @@ static const struct pci_device_id ism_device_table[] = {
>  MODULE_DEVICE_TABLE(pci, ism_device_table);
>  
>  static debug_info_t *ism_debug_info;
> -static const struct smcd_ops ism_ops;
>  
>  #define NO_CLIENT		0xff		/* must be >= MAX_CLIENTS */
>  static struct ism_client *clients[MAX_CLIENTS];	/* use an array rather than */
> @@ -289,22 +288,6 @@ static int ism_read_local_gid(struct ism_dev *ism)
>  	return ret;
>  }
>  
> -static int ism_query_rgid(struct ism_dev *ism, u64 rgid, u32 vid_valid,
> -			  u32 vid)
> -{
> -	union ism_query_rgid cmd;
> -
> -	memset(&cmd, 0, sizeof(cmd));
> -	cmd.request.hdr.cmd = ISM_QUERY_RGID;
> -	cmd.request.hdr.len = sizeof(cmd.request);
> -
> -	cmd.request.rgid = rgid;
> -	cmd.request.vlan_valid = vid_valid;
> -	cmd.request.vlan_id = vid;
> -
> -	return ism_cmd(ism, &cmd);
> -}
> -
>  static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
>  {
>  	clear_bit(dmb->sba_idx, ism->sba_bitmap);
> @@ -429,23 +412,6 @@ static int ism_del_vlan_id(struct ism_dev *ism, u64 vlan_id)
>  	return ism_cmd(ism, &cmd);
>  }
>  
> -static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32 trigger_irq,
> -			  u32 event_code, u64 info)
> -{
> -	union ism_sig_ieq cmd;
> -
> -	memset(&cmd, 0, sizeof(cmd));
> -	cmd.request.hdr.cmd = ISM_SIGNAL_IEQ;
> -	cmd.request.hdr.len = sizeof(cmd.request);
> -
> -	cmd.request.rgid = rgid;
> -	cmd.request.trigger_irq = trigger_irq;
> -	cmd.request.event_code = event_code;
> -	cmd.request.info = info;
> -
> -	return ism_cmd(ism, &cmd);
> -}
> -
>  static unsigned int max_bytes(unsigned int start, unsigned int len,
>  			      unsigned int boundary)
>  {
> @@ -503,14 +469,6 @@ u8 *ism_get_seid(void)
>  }
>  EXPORT_SYMBOL_GPL(ism_get_seid);
>  
> -static u16 ism_get_chid(struct ism_dev *ism)
> -{
> -	if (!ism || !ism->pdev)
> -		return 0;
> -
> -	return to_zpci(ism->pdev)->pchid;
> -}
> -
>  static void ism_handle_event(struct ism_dev *ism)
>  {
>  	struct ism_event *entry;
> @@ -569,11 +527,6 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static u64 ism_get_local_gid(struct ism_dev *ism)
> -{
> -	return ism->local_gid;
> -}
> -
>  static int ism_dev_init(struct ism_dev *ism)
>  {
>  	struct pci_dev *pdev = ism->pdev;
> @@ -774,6 +727,22 @@ module_exit(ism_exit);
>  /*************************** SMC-D Implementation *****************************/
>  
>  #if IS_ENABLED(CONFIG_SMC)
> +static int ism_query_rgid(struct ism_dev *ism, u64 rgid, u32 vid_valid,
> +			  u32 vid)
> +{
> +	union ism_query_rgid cmd;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.request.hdr.cmd = ISM_QUERY_RGID;
> +	cmd.request.hdr.len = sizeof(cmd.request);
> +
> +	cmd.request.rgid = rgid;
> +	cmd.request.vlan_valid = vid_valid;
> +	cmd.request.vlan_id = vid;
> +
> +	return ism_cmd(ism, &cmd);
> +}
> +
>  static int smcd_query_rgid(struct smcd_dev *smcd, u64 rgid, u32 vid_valid,
>  			   u32 vid)
>  {
> @@ -811,6 +780,23 @@ static int smcd_reset_vlan_required(struct smcd_dev *smcd)
>  	return ism_cmd_simple(smcd->priv, ISM_RESET_VLAN);
>  }
>  
> +static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32 trigger_irq,
> +			  u32 event_code, u64 info)
> +{
> +	union ism_sig_ieq cmd;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.request.hdr.cmd = ISM_SIGNAL_IEQ;
> +	cmd.request.hdr.len = sizeof(cmd.request);
> +
> +	cmd.request.rgid = rgid;
> +	cmd.request.trigger_irq = trigger_irq;
> +	cmd.request.event_code = event_code;
> +	cmd.request.info = info;
> +
> +	return ism_cmd(ism, &cmd);
> +}
> +
>  static int smcd_signal_ieq(struct smcd_dev *smcd, u64 rgid, u32 trigger_irq,
>  			   u32 event_code, u64 info)
>  {
> @@ -830,11 +816,24 @@ static int smcd_supports_v2(void)
>  		SYSTEM_EID.type[0] != '0';
>  }
>  
> +static u64 ism_get_local_gid(struct ism_dev *ism)
> +{
> +	return ism->local_gid;
> +}
> +
>  static u64 smcd_get_local_gid(struct smcd_dev *smcd)
>  {
>  	return ism_get_local_gid(smcd->priv);
>  }
>  
> +static u16 ism_get_chid(struct ism_dev *ism)
> +{
> +	if (!ism || !ism->pdev)
> +		return 0;
> +
> +	return to_zpci(ism->pdev)->pchid;
> +}
> +
>  static u16 smcd_get_chid(struct smcd_dev *smcd)
>  {
>  	return ism_get_chid(smcd->priv);

-- 
~Randy
