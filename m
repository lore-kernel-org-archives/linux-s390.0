Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F8CEB64D7
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jun 2023 09:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFWJ4S (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jun 2023 05:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjFWJ4R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 05:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306E51BFC
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687514126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+rCHgBZXwzSmj/STn5W38YpN6tVz7SEoQeGCi2DiQY=;
        b=iEpetDCekUeEcqdUeR3wXWC9UEeTP7hrte55Sxj0tpRlakVZNtOmFfA9Hcyj9CrjCmqyMx
        YrJkXackxgeIEHeC0wt0Y1ZD27n9c8QJlj13EAE2PmOA9M2jKIWmqKA/aRwrRs6/v4UDBC
        /YiBEsjG2DRnzTwU8bw33Sg3pcdg/O0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-KlxdWpiBOxC7weaEWDrcOQ-1; Fri, 23 Jun 2023 05:55:23 -0400
X-MC-Unique: KlxdWpiBOxC7weaEWDrcOQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62ffa1214edso1098706d6.0
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 02:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514123; x=1690106123;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+rCHgBZXwzSmj/STn5W38YpN6tVz7SEoQeGCi2DiQY=;
        b=TrWbnFUUAXQ8mY6ZnNbQOU1lNHMa1yeMQjy5F9HEFbHpp+uZVpt2nw9RqgEiq/NzhW
         uOX/i+zqrNi6OjwB8ksm7wcKur3zZ5c5cgPBs8EDZopwmkv/POgGc2bmfBjApTgfvGVT
         6dq0i/6DTLRKGXdtwfoHrIMchkQq7aAN6JI1hJQockhHq6I86jsbTvjiIJBeH+VyrfVQ
         ysJjJn9sNjEkS1xtqCr1AyTqFdunJtQm4krKg8VVSCMtA+vGa9BKzlTqSYnbllcrNYHx
         n9w6AQX8A5gvVMX9wf8XmGvkLAiwwr84Gmizmqm++3XUKjrQzeQeWlMqVDbRWkFZW3KC
         RXew==
X-Gm-Message-State: AC+VfDx5e5iN4EJpcoSOE+aMbTtpBvDyapk0WqoRSYuR53sZ0lW+wF/V
        3+GNheEyWGkWacThBpius8dCnKi9DbbBb210faLzMoHJidufPZrIzB5gI/3JaNepmvoLyLUjRob
        Zu2RKbcDuHanHrk5iKrAjHA==
X-Received: by 2002:ad4:5b8a:0:b0:62f:e4de:5bed with SMTP id 10-20020ad45b8a000000b0062fe4de5bedmr24452265qvp.5.1687514123429;
        Fri, 23 Jun 2023 02:55:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45AUoj/3U7k967I1M5mqc3bFy2kN55oADryfQXBLtAKW7CgktYJ9ngBOhcfz9mvtaJ/ToYJw==
X-Received: by 2002:ad4:5b8a:0:b0:62f:e4de:5bed with SMTP id 10-20020ad45b8a000000b0062fe4de5bedmr24452248qvp.5.1687514123066;
        Fri, 23 Jun 2023 02:55:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id f22-20020a0caa96000000b0062deea179aesm4844225qvb.22.2023.06.23.02.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:55:22 -0700 (PDT)
Message-ID: <852bbc8eb36211cef6c3650ac1562c897e763084.camel@redhat.com>
Subject: Re: [PATCH net-next v2 4/4] s390/ctcm: Convert sprintf/snprintf to
 scnprintf
From:   Paolo Abeni <pabeni@redhat.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Date:   Fri, 23 Jun 2023 11:55:19 +0200
In-Reply-To: <20230621134921.904217-5-wintera@linux.ibm.com>
References: <20230621134921.904217-1-wintera@linux.ibm.com>
         <20230621134921.904217-5-wintera@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2023-06-21 at 15:49 +0200, Alexandra Winter wrote:
> From: Thorsten Winkler <twinkler@linux.ibm.com>
>=20
> This LWN article explains the why scnprintf is preferred over snprintf
> in general
> https://lwn.net/Articles/69419/
> Ie. snprintf() returns what *would* be the resulting length, while
> scnprintf() returns the actual length.
>=20
> Note that ctcm_print_statistics() writes the data into the kernel log
> and is therefore not suitable for sysfs_emit(). Observable behavior is
> not changed, as there may be dependencies.
>=20
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  drivers/s390/net/ctcm_dbug.c  |  2 +-
>  drivers/s390/net/ctcm_main.c  |  6 +++---
>  drivers/s390/net/ctcm_main.h  |  1 +
>  drivers/s390/net/ctcm_mpc.c   | 18 ++++++++++--------
>  drivers/s390/net/ctcm_sysfs.c | 36 +++++++++++++++++------------------
>  5 files changed, 33 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/s390/net/ctcm_dbug.c b/drivers/s390/net/ctcm_dbug.c
> index f7ec51db3cd6..b6f0e2f114b4 100644
> --- a/drivers/s390/net/ctcm_dbug.c
> +++ b/drivers/s390/net/ctcm_dbug.c
> @@ -70,7 +70,7 @@ void ctcm_dbf_longtext(enum ctcm_dbf_names dbf_nix, int=
 level, char *fmt, ...)
>  	if (!debug_level_enabled(ctcm_dbf[dbf_nix].id, level))
>  		return;
>  	va_start(args, fmt);
> -	vsnprintf(dbf_txt_buf, sizeof(dbf_txt_buf), fmt, args);
> +	vscnprintf(dbf_txt_buf, sizeof(dbf_txt_buf), fmt, args);
>  	va_end(args);
> =20
>  	debug_text_event(ctcm_dbf[dbf_nix].id, level, dbf_txt_buf);
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index e0fdd54bfeb7..79fac5314e67 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -1340,7 +1340,7 @@ static int add_channel(struct ccw_device *cdev, enu=
m ctcm_channel_types type,
>  					goto nomem_return;
> =20
>  	ch->cdev =3D cdev;
> -	snprintf(ch->id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev->dev));
> +	scnprintf(ch->id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev->dev));
>  	ch->type =3D type;
> =20
>  	/*
> @@ -1505,8 +1505,8 @@ static int ctcm_new_device(struct ccwgroup_device *=
cgdev)
> =20
>  	type =3D get_channel_type(&cdev0->id);
> =20
> -	snprintf(read_id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev0->dev));
> -	snprintf(write_id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev1->dev));
> +	scnprintf(read_id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev0->dev));
> +	scnprintf(write_id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev1->dev));
> =20
>  	ret =3D add_channel(cdev0, type, priv);
>  	if (ret) {
> diff --git a/drivers/s390/net/ctcm_main.h b/drivers/s390/net/ctcm_main.h
> index 90bd7b3f80c3..25164e8bf13d 100644
> --- a/drivers/s390/net/ctcm_main.h
> +++ b/drivers/s390/net/ctcm_main.h
> @@ -100,6 +100,7 @@ enum ctcm_channel_types {
>  #define CTCM_PROTO_MPC		4
>  #define CTCM_PROTO_MAX		4
> =20
> +#define CTCM_STATSIZE_LIMIT	64
>  #define CTCM_BUFSIZE_LIMIT	65535
>  #define CTCM_BUFSIZE_DEFAULT	32768
>  #define MPC_BUFSIZE_DEFAULT	CTCM_BUFSIZE_LIMIT
> diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
> index 8ac213a55141..64996c86defc 100644
> --- a/drivers/s390/net/ctcm_mpc.c
> +++ b/drivers/s390/net/ctcm_mpc.c
> @@ -144,9 +144,9 @@ void ctcmpc_dumpit(char *buf, int len)
> =20
>  	for (ct =3D 0; ct < len; ct++, ptr++, rptr++) {
>  		if (sw =3D=3D 0) {
> -			sprintf(addr, "%16.16llx", (__u64)rptr);
> +			scnprintf(addr, sizeof(addr), "%16.16llx", (__u64)rptr);
> =20
> -			sprintf(boff, "%4.4X", (__u32)ct);
> +			scnprintf(boff, sizeof(boff), "%4.4X", (__u32)ct);
>  			bhex[0] =3D '\0';
>  			basc[0] =3D '\0';
>  		}
> @@ -155,7 +155,7 @@ void ctcmpc_dumpit(char *buf, int len)
>  		if (sw =3D=3D 8)
>  			strcat(bhex, "	");
> =20
> -		sprintf(tbuf, "%2.2llX", (__u64)*ptr);
> +		scnprintf(tbuf, sizeof(tbuf), "%2.2llX", (__u64)*ptr);
> =20
>  		tbuf[2] =3D '\0';
>  		strcat(bhex, tbuf);
> @@ -171,8 +171,8 @@ void ctcmpc_dumpit(char *buf, int len)
>  			continue;
>  		if ((strcmp(duphex, bhex)) !=3D 0) {
>  			if (dup !=3D 0) {
> -				sprintf(tdup,
> -					"Duplicate as above to %s", addr);
> +				scnprintf(tdup, sizeof(tdup),
> +					  "Duplicate as above to %s", addr);
>  				ctcm_pr_debug("		       --- %s ---\n",
>  						tdup);
>  			}
> @@ -197,14 +197,16 @@ void ctcmpc_dumpit(char *buf, int len)
>  			strcat(basc, " ");
>  		}
>  		if (dup !=3D 0) {
> -			sprintf(tdup, "Duplicate as above to %s", addr);
> +			scnprintf(tdup, sizeof(tdup),
> +				  "Duplicate as above to %s", addr);
>  			ctcm_pr_debug("		       --- %s ---\n", tdup);
>  		}
>  		ctcm_pr_debug("   %s (+%s) : %s  [%s]\n",
>  					addr, boff, bhex, basc);
>  	} else {
>  		if (dup >=3D 1) {
> -			sprintf(tdup, "Duplicate as above to %s", addr);
> +			scnprintf(tdup, sizeof(tdup),
> +				  "Duplicate as above to %s", addr);
>  			ctcm_pr_debug("		       --- %s ---\n", tdup);
>  		}
>  		if (dup !=3D 0) {
> @@ -291,7 +293,7 @@ static struct net_device *ctcmpc_get_dev(int port_num=
)
>  	struct net_device *dev;
>  	struct ctcm_priv *priv;
> =20
> -	sprintf(device, "%s%i", MPC_DEVICE_NAME, port_num);
> +	scnprintf(device, sizeof(device), "%s%i", MPC_DEVICE_NAME, port_num);
> =20
>  	dev =3D __dev_get_by_name(&init_net, device);
> =20
> diff --git a/drivers/s390/net/ctcm_sysfs.c b/drivers/s390/net/ctcm_sysfs.=
c
> index 98680c2cc4e4..0c5d8a3eaa2e 100644
> --- a/drivers/s390/net/ctcm_sysfs.c
> +++ b/drivers/s390/net/ctcm_sysfs.c
> @@ -86,24 +86,24 @@ static void ctcm_print_statistics(struct ctcm_priv *p=
riv)
>  		return;
>  	p =3D sbuf;
> =20
> -	p +=3D sprintf(p, "  Device FSM state: %s\n",
> -		     fsm_getstate_str(priv->fsm));
> -	p +=3D sprintf(p, "  RX channel FSM state: %s\n",
> -		     fsm_getstate_str(priv->channel[CTCM_READ]->fsm));
> -	p +=3D sprintf(p, "  TX channel FSM state: %s\n",
> -		     fsm_getstate_str(priv->channel[CTCM_WRITE]->fsm));
> -	p +=3D sprintf(p, "  Max. TX buffer used: %ld\n",
> -		     priv->channel[WRITE]->prof.maxmulti);
> -	p +=3D sprintf(p, "  Max. chained SKBs: %ld\n",
> -		     priv->channel[WRITE]->prof.maxcqueue);
> -	p +=3D sprintf(p, "  TX single write ops: %ld\n",
> -		     priv->channel[WRITE]->prof.doios_single);
> -	p +=3D sprintf(p, "  TX multi write ops: %ld\n",
> -		     priv->channel[WRITE]->prof.doios_multi);
> -	p +=3D sprintf(p, "  Netto bytes written: %ld\n",
> -		     priv->channel[WRITE]->prof.txlen);
> -	p +=3D sprintf(p, "  Max. TX IO-time: %u\n",
> -		     jiffies_to_usecs(priv->channel[WRITE]->prof.tx_time));
> +	p +=3D scnprintf(p, CTCM_STATSIZE_LIMIT, "  Device FSM state: %s\n",
> +		       fsm_getstate_str(priv->fsm));
> +	p +=3D scnprintf(p, CTCM_STATSIZE_LIMIT, "  RX channel FSM state: %s\n"=
,
> +		       fsm_getstate_str(priv->channel[CTCM_READ]->fsm));
> +	p +=3D scnprintf(p, CTCM_STATSIZE_LIMIT, "  TX channel FSM state: %s\n"=
,
> +		       fsm_getstate_str(priv->channel[CTCM_WRITE]->fsm));
> +	p +=3D scnprintf(p, CTCM_STATSIZE_LIMIT, "  Max. TX buffer used: %ld\n"=
,
> +		       priv->channel[WRITE]->prof.maxmulti);
> +	p +=3D scnprintf(p, CTCM_STATSIZE_LIMIT, "  Max. chained SKBs: %ld\n",
> +		       priv->channel[WRITE]->prof.maxcqueue);
> +	p +=3D scnprintf(p, CTCM_STATSIZE_LIMIT, "  TX single write ops: %ld\n"=
,
> +		       priv->channel[WRITE]->prof.doios_single);
> +	p +=3D scnprintf(p, CTCM_STATSIZE_LIMIT, "  TX multi write ops: %ld\n",
> +		       priv->channel[WRITE]->prof.doios_multi);
> +	p +=3D scnprintf(p, CTCM_STATSIZE_LIMIT, "  Netto bytes written: %ld\n"=
,
> +		       priv->channel[WRITE]->prof.txlen);
> +	p +=3D scnprintf(p, CTCM_STATSIZE_LIMIT, "  Max. TX IO-time: %u\n",
> +		       jiffies_to_usecs(priv->channel[WRITE]->prof.tx_time));
> =20
>  	printk(KERN_INFO "Statistics for %s:\n%s",
>  				priv->channel[CTCM_WRITE]->netdev->name, sbuf);

Not strictly related to this series, but it looks like there is
opportunity for more cleanups? e.g. move legacy printk to pr_info(),
etc...

The series LGTM.

Thanks,

Paolo


