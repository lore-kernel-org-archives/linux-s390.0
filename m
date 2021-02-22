Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47425C433E0
	for <linux-s390@archiver.kernel.org>; Mon, 22 Feb 2021 15:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CCD64ED6
	for <linux-s390@archiver.kernel.org>; Mon, 22 Feb 2021 15:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhBVPP0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhBVPPC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Feb 2021 10:15:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E63C0611C2;
        Mon, 22 Feb 2021 07:12:59 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i9so3927156wml.5;
        Mon, 22 Feb 2021 07:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7hFnLRkgd4Q0qw+7HAuuUUWLWJVPby5EiSXIS4L9oGQ=;
        b=dT612FLTVPEz8XRs6mxabgghhhSms68v480SapGnLo7hxIioNIX+ObgFDoRQuVg5S4
         vAVjOP6C0XlZwDHg1qPCuB3tf2Pelmamb5mfcceNfCa1UKyeyViUmHUDJLgRyS1ut308
         d6TQwzb2cIwABwhaJE0AC9Ea3QBZmVSiWT6J9nwYqR8z6JVLP5fJE5i7M0yDxSmIXt05
         jb6IJgXvyo1XkwSxbrpfoSdTcvnYX3nSJuSSWWDgrOrB/SDGqpZr0xz1rKH6bR7QMYGV
         4nNuhf2kPoPdYm6w3edgiTNVx81wadjOmh2Nx8odGuQJ8uG/3NxzX2wbLm4vQfJ9UCZD
         5FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7hFnLRkgd4Q0qw+7HAuuUUWLWJVPby5EiSXIS4L9oGQ=;
        b=bpcxzSc0pr2OcEErsB7fYom43qnA5nvEr1rNXAGOEDWWf2j5nil1JJ6fV6S4PmtT5i
         9IRSp6s1lgLuW4NTTg8a9Hw4CLwV0Do1skZ531RLPlFHYbJZRXZmh27REhgje+QJ92Ni
         IFKua2iDkLjOApULugUtkRw+11aROfsTfoBOv23ArqxH8TixheQFqgf1D/YYdMKcLerm
         +fr8xfW46M+PaWV223PScC3G1ZfBA6w4M4pE3gQ/xrjR77gIDnxEDXP6x8WSZ7GiejHQ
         zod2c8HWe1Sn1HDp7I59HESMZZ9IkNBvRTHO+GAOJtVq9kfHSiBKjhoPjiEZ6eKOKu7M
         1ctw==
X-Gm-Message-State: AOAM531dD8E/dtlYTzxT0o+qII2FBj4w98vES4vHrNzKq/URXx9dP2g0
        9gyDPNfumFAvUixG/Yg/FYHnkIf5sBXZFmTt18k=
X-Google-Smtp-Source: ABdhPJzVilHCS3gxDmaUXrsQs/QpvPLFYyKQGlIV5aFkTOiZdT7NP4nfll4p9JTad+ZeVYS+ou+FOA==
X-Received: by 2002:a05:600c:3399:: with SMTP id o25mr20222396wmp.13.1614006777981;
        Mon, 22 Feb 2021 07:12:57 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id p17sm15671076wmq.27.2021.02.22.07.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:57 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>
Cc:     Romain Perier <romain.perier@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] scsi: zfcp: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:24 +0100
Message-Id: <20210222151231.22572-14-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/s390/scsi/zfcp_fc.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index d24cafe02708..8a65241011b9 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -877,14 +877,16 @@ static void zfcp_fc_rspn(struct zfcp_adapter *adapter,
 	struct zfcp_fsf_ct_els *ct_els = &fc_req->ct_els;
 	struct zfcp_fc_rspn_req *rspn_req = &fc_req->u.rspn.req;
 	struct fc_ct_hdr *rspn_rsp = &fc_req->u.rspn.rsp;
-	int ret, len;
+	int ret;
+	ssize_t len;
 
 	zfcp_fc_ct_ns_init(&rspn_req->ct_hdr, FC_NS_RSPN_ID,
 			   FC_SYMBOLIC_NAME_SIZE);
 	hton24(rspn_req->rspn.fr_fid.fp_fid, fc_host_port_id(shost));
-	len = strlcpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
+	len = strscpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
 		      FC_SYMBOLIC_NAME_SIZE);
-	rspn_req->rspn.fr_name_len = len;
+	if (len != -E2BIG)
+		rspn_req->rspn.fr_name_len = len;
 
 	sg_init_one(&fc_req->sg_req, rspn_req, sizeof(*rspn_req));
 	sg_init_one(&fc_req->sg_rsp, rspn_rsp, sizeof(*rspn_rsp));

