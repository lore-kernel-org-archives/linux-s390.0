Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E05C2FC29
	for <linux-s390@archiver.kernel.org>; Thu, 17 Aug 2023 13:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351360AbjHQNUz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Aug 2023 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351355AbjHQNUm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Aug 2023 09:20:42 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5F11FF3;
        Thu, 17 Aug 2023 06:20:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vq.3QOU_1692278434;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vq.3QOU_1692278434)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 21:20:36 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/6] net/smc: several features's implementation for smc v2.1
Date:   Thu, 17 Aug 2023 21:20:26 +0800
Message-Id: <20230817132032.23397-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch set implement several new features in SMC v2.1(https://
www.ibm.com/support/pages/node/7009315), including vendor unique
experimental options, max connections per lgr negotiation, max links
per lgr negotiation.

v1 - v2:
 - rename field fce_v20 to fce_v2_base in struct
   smc_clc_first_contact_ext_v2x
 - use smc_get_clc_first_contact_ext in smc_connect
   _rdma_v2_prepare
 - adding comment about field vendor_oui in struct
   smc_clc_msg_smcd
 - remove comment about SMC_CONN_PER_LGR_MAX in smc_
   clc_srv_v2x_features_validate
 - rename smc_clc_clnt_v2x_features_validate

RFC v2 - v1:
 - more description in commit message
 - modify SMC_CONN_PER_LGR_xxx and SMC_LINKS_ADD_LNK_xxx
   macro defination and usage
 - rename field release_ver to release_nr
 - remove redundant release version check in client
 - explicitly set the rc value in smc_llc_cli/srv_add_link

RFC v1 - RFC v2:
 - Remove ini pointer NULL check and fix code style in
   smc_clc_send_confirm_accept.
 - Optimize the max_conns check in smc_clc_xxx_v2x_features_validate.

Guangguan Wang (6):
  net/smc: support smc release version negotiation in clc handshake
  net/smc: add vendor unique experimental options area in clc handshake
  net/smc: support smc v2.x features validate
  net/smc: support max connections per lgr negotiation
  net/smc: support max links per lgr negotiation in clc handshake
  net/smc: Extend SMCR v2 linkgroup netlink attribute

 include/uapi/linux/smc.h |   2 +
 net/smc/af_smc.c         |  86 +++++++++++++++++------
 net/smc/smc.h            |   5 +-
 net/smc/smc_clc.c        | 147 ++++++++++++++++++++++++++++++++-------
 net/smc/smc_clc.h        |  53 ++++++++++++--
 net/smc/smc_core.c       |  13 +++-
 net/smc/smc_core.h       |  25 +++++++
 net/smc/smc_llc.c        |  25 +++++--
 8 files changed, 299 insertions(+), 57 deletions(-)

-- 
2.24.3 (Apple Git-128)

