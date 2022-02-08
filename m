Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE0C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  8 Feb 2022 07:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiBHHc3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Feb 2022 02:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBHHc0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Feb 2022 02:32:26 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A14C0401EF
        for <linux-s390@vger.kernel.org>; Mon,  7 Feb 2022 23:32:25 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id j2so47564912ybu.0
        for <linux-s390@vger.kernel.org>; Mon, 07 Feb 2022 23:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0oC4XUbECD/qvF22MkjA7nF4kwTby47BOyjmpZS5UA=;
        b=sgFct79DnWpFV4iCb7cLtGeIz0K2LA72D0iGMTMr9IVbHA5DwLrQTTNekdSywWXcLY
         pKvHP/afQrlMhFm/dqlkDiqrPepB9oLN7345NsNYeexBHrS3RnarN2w1m+v7Po3j9e+b
         etvKbBhNT/2YVbfiPnUOi8a6rxMBvaBn3nPe4J0BK74sjuLqL5RvYvQHbJ2SG/eaHCZN
         601iUzQBCL+UL6bI4N4ucDN0TGjpuQ28A84q635zg8uoiFk60TjWKw8e13NZMYLO97Wf
         RDU+u3prW60S5UTg3qcGJsTi8p2/dFxAALzCUUja0pJzu+7asYZV44jjjMfDNWRUC/vu
         HBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0oC4XUbECD/qvF22MkjA7nF4kwTby47BOyjmpZS5UA=;
        b=CJRiJerlr7GbFwObi8tn0zHjeRXkeapNMgISo2krD0Q8UpzvUkYXlLMm7EtpTCrj/o
         yjgmeljYSWWMM1Lka5Jy5qRTglvEqV83djviu2y4ntefTQfNCtqB8J/XHjQFF00+KR+b
         WfEAPqvGsYQucXdHKEinSDx9oq7/KgxQ9kxuDmysI3KPImbwX5C1EuaFXilJYjMuNbFR
         bLFUl5Jaoe8xQLIYfqSOEt4VHVTlXhtoURVQS9Ay2qItQagTCD4+h+YcuX7stccdSMVn
         ai0ExYfj0uPc4VPupq8v4dO8UYP6eW1UDUtMI5tLxG4k1ECWwclvySRAUX3JQlYxkp6v
         slqg==
X-Gm-Message-State: AOAM533rT9ULJRtbhvaLoAjt8sGmBf0gS2w0YJEfoV7eFRpQA0yqEY5t
        F9kF7CzEzQrm0IfBhyRntUED2WfcZYzfBi0YjPAVs0tvfQf0Juoy
X-Google-Smtp-Source: ABdhPJxcos1HVx99nhkA+E/Zo59wmDwpVfaeaQ6ggCOn8Xv6R4iTBW3pF+cgVUSq6+vYxu3C0QMOEdvfwr/mnB5Wf+I=
X-Received: by 2002:a81:a241:: with SMTP id z1mr3770480ywg.250.1644305544335;
 Mon, 07 Feb 2022 23:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20220208071502.GA10495@kili>
In-Reply-To: <20220208071502.GA10495@kili>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 7 Feb 2022 23:32:13 -0800
Message-ID: <CANn89iKWpYJCiF1N1nb1nATF1NnJf2oV+JHkgnnT5BiB+MuVSw@mail.gmail.com>
Subject: Re: [bug report] net/smc: fix ref_tracker issue in smc_pnet_add()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Feb 7, 2022 at 11:15 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Eric Dumazet,
>
> The patch 28f922213886: "net/smc: fix ref_tracker issue in
> smc_pnet_add()" from Feb 5, 2022, leads to the following Smatch
> static checker warning:
>
>         net/smc/smc_pnet.c:384 smc_pnet_add_eth()
>         warn: sleeping in atomic context
>
> net/smc/smc_pnet.c
>     342 static int smc_pnet_add_eth(struct smc_pnettable *pnettable, struct net *net,
>     343                             char *eth_name, char *pnet_name)
>     344 {
>     345         struct smc_pnetentry *tmp_pe, *new_pe;
>     346         struct net_device *ndev, *base_ndev;
>     347         u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
>     348         bool new_netdev;
>     349         int rc;
>     350
>     351         /* check if (base) netdev already has a pnetid. If there is one, we do
>     352          * not want to add a pnet table entry
>     353          */
>     354         rc = -EEXIST;
>     355         ndev = dev_get_by_name(net, eth_name);        /* dev_hold() */
>     356         if (ndev) {
>     357                 base_ndev = pnet_find_base_ndev(ndev);
>     358                 if (!smc_pnetid_by_dev_port(base_ndev->dev.parent,
>     359                                             base_ndev->dev_port, ndev_pnetid))
>     360                         goto out_put;
>     361         }
>     362
>     363         /* add a new netdev entry to the pnet table if there isn't one */
>     364         rc = -ENOMEM;
>     365         new_pe = kzalloc(sizeof(*new_pe), GFP_KERNEL);
>     366         if (!new_pe)
>     367                 goto out_put;
>     368         new_pe->type = SMC_PNET_ETH;
>     369         memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
>     370         strncpy(new_pe->eth_name, eth_name, IFNAMSIZ);
>     371         rc = -EEXIST;
>     372         new_netdev = true;
>     373         write_lock(&pnettable->lock);
>     374         list_for_each_entry(tmp_pe, &pnettable->pnetlist, list) {
>     375                 if (tmp_pe->type == SMC_PNET_ETH &&
>     376                     !strncmp(tmp_pe->eth_name, eth_name, IFNAMSIZ)) {
>     377                         new_netdev = false;
>     378                         break;
>     379                 }
>     380         }
>     381         if (new_netdev) {
>     382                 if (ndev) {
>     383                         new_pe->ndev = ndev;
> --> 384                         netdev_tracker_alloc(ndev, &new_pe->dev_tracker,
>     385                                              GFP_KERNEL);
>
> We can't do a GFP_KERNEL allocation here
>
>     386                 }
>     387                 list_add_tail(&new_pe->list, &pnettable->pnetlist);
>     388                 write_unlock(&pnettable->lock);
>
> because we're holding this write lock
>

Sure, the fix is already in net tree, and should reach your tree eventually.

Thanks.

commit 94fdd7c02a56d0316d20e417a1141b71a8dcee82 (HEAD -> net-1, net/master)
Author: Eric Dumazet <edumazet@google.com>
Date:   Sun Feb 6 06:33:48 2022 -0800

    net/smc: use GFP_ATOMIC allocation in smc_pnet_add_eth()

    My last patch moved the netdev_tracker_alloc() call to a section
    protected by a write_lock().

    I should have replaced GFP_KERNEL with GFP_ATOMIC to avoid the infamous:

    BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:256

    Fixes: 28f922213886 ("net/smc: fix ref_tracker issue in smc_pnet_add()")
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index fb6331d97185a5db9b4539e7f081e9fa469bc44b..0599246c037690b4b01813956e4af74519277bea
100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -382,7 +382,7 @@ static int smc_pnet_add_eth(struct smc_pnettable
*pnettable, struct net *net,
                if (ndev) {
                        new_pe->ndev = ndev;
                        netdev_tracker_alloc(ndev, &new_pe->dev_tracker,
-                                            GFP_KERNEL);
+                                            GFP_ATOMIC);
                }
                list_add_tail(&new_pe->list, &pnettable->pnetlist);
                write_unlock(&pnettable->lock);
