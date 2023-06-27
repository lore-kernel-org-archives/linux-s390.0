Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FFDEB64D9
	for <linux-s390@archiver.kernel.org>; Tue, 27 Jun 2023 05:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjF0FPe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 27 Jun 2023 01:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjF0FPc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 27 Jun 2023 01:15:32 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jun 2023 22:15:27 PDT
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C31734;
        Mon, 26 Jun 2023 22:15:27 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id B349A16081C;
        Tue, 27 Jun 2023 05:09:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 846C12002D;
        Tue, 27 Jun 2023 05:09:47 +0000 (UTC)
Message-ID: <7c9690c70c89aac590de139766b5be3bc9162725.camel@perches.com>
Subject: Re: [PATCH net-next v2 1/4] s390/lcs: Convert sysfs sprintf to
 sysfs_emit
From:   Joe Perches <joe@perches.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        Simon Horman <simon.horman@corigine.com>
Date:   Mon, 26 Jun 2023 22:09:46 -0700
In-Reply-To: <20230621134921.904217-2-wintera@linux.ibm.com>
References: <20230621134921.904217-1-wintera@linux.ibm.com>
         <20230621134921.904217-2-wintera@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: eirzumqgfygyyrq7tdyz5x8ec17s86x1
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 846C12002D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+UlTz8Y1Y/SRQgUNG2scYIhZ3r6zhBXuI=
X-HE-Tag: 1687842587-193108
X-HE-Meta: U2FsdGVkX1+XIntmyHlManxmIgRJyEzIipNGHob23LeNoeBwCf86ZTKfA1HdPhLctu1EkGId3ZDBJYiDD1rns9JBc7hBvFePDwQYt2rfk/Q5GSIzdr3KkP157TdjZZhafX3wJ52HOwduiTd5sRV5C4q0CvNMKLxJ9rm2J6IrX4Rf0kPYD+D6bnFZHpFxuIa68J8lyd2ekNdjYYXtt4IPSR9btg2ZgT1ul51ZBQaE79M3psEB0Ae4/o/hTRZ4pNDnju0hL+JoIIenXOW6ykJwwiV60ww770uq4xmtzxCf8BGHAmZxiBc5PoqIkfjlA8GZ0WpkWBMP8ebRBvTzJyb9gy+33pXHye6n
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2023-06-21 at 15:49 +0200, Alexandra Winter wrote:
> From: Thorsten Winkler <twinkler@linux.ibm.com>
> 
> Following the advice of the Documentation/filesystems/sysfs.rst.
> All sysfs related show()-functions should only use sysfs_emit() or
> sysfs_emit_at() when formatting the value to be returned to user space.
> 
> While at it, follow Linux kernel coding style and unify indentation
[]
> diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
[]
> @@ -1901,14 +1901,14 @@ lcs_open_device(struct net_device *dev)
>  static ssize_t
>  lcs_portno_show (struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -        struct lcs_card *card;
> +	struct lcs_card *card;
>  
>  	card = dev_get_drvdata(dev);
>  
> -        if (!card)
> -                return 0;
> +	if (!card)
> +		return 0;
>  
> -        return sprintf(buf, "%d\n", card->portno);
> +	return sysfs_emit(buf, "%d\n", card->portno);
[]
> @@ -1970,7 +1971,7 @@ lcs_timeout_show(struct device *dev, struct device_attribute *attr, char *buf)
>  
>  	card = dev_get_drvdata(dev);
>  
> -	return card ? sprintf(buf, "%u\n", card->lancmd_timeout) : 0;
> +	return card ? sysfs_emit(buf, "%u\n", card->lancmd_timeout) : 0;

Like the other show function
I think it'd be nicer to use:

	card = dev_get_drvdata(dev);
	if (!card)
		return 0;

	return sysfs_emit(buf, "%u\n", card->lancmd_timeout);

