Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE85AC;
	Tue, 12 Dec 2023 00:52:36 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VyLva1l_1702371151;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyLva1l_1702371151)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 16:52:33 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	lzinux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 00/10] net/smc: implement SMCv2.1 virtual ISM device support
Date: Tue, 12 Dec 2023 16:52:21 +0800
Message-Id: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
OS or hypervisor software, comparable to IBM ISM which is based on platform
firmware or hardware.

With the introduction of virtual ISM, SMCv2.1 makes some updates:

- Introduce feature bitmask to indicate supplemental features.
- Reserve a range of CHIDs for virtual ISM.
- Support extended GIDs (128 bits) in CLC handshake.

So this patch set aims to implement these updates in Linux kernel. And it
acts as the first part of SMC-D virtual ISM extension & loopback-ism [1].

[1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/

v6->v5:
- Add 'Reviewed-by' label given in the previous versions:
  * Patch #4, #6, #9, #10 have nothing changed since v3;
- Patch #2:
  * fix the format issue (Alignment should match open parenthesis) compared to v5;
  * remove useless clc->hdr.length assignment in smcr_clc_prep_confirm_accept()
    compared to v5;
- Patch #3: new added compared to v5.
- Patch #7: some minor changes like aclc_v2->aclc or clc_v2->clc compared to v5
  due to the introduction of Patch #3. Since there were no major changes, I kept
  the 'Reviewed-by' label.

Other changes in previous versions but not yet acked:
- Patch #1: Some minor changes in subject and fix the format issue
  (length exceeds 80 columns) compared to v3.
- Patch #5: removes useless ini->feature_mask assignment in __smc_connect()
  and smc_listen_v2_check() compared to v4.
- Patch #8: new added, compared to v3.

v5->v4:
- Patch #6: improve the comment of SMCD_CLC_MAX_V2_GID_ENTRIES;
- Patch #4: remove useless ini->feature_mask assignment;

v4->v3:
- Patch #6: use SMCD_CLC_MAX_V2_GID_ENTRIES to indicate the max gid
  entries in CLC proposal and using SMC_MAX_V2_ISM_DEVS to indicate the
  max devices to propose;
- Patch #6: use i and i+1 in smc_find_ism_v2_device_serv();
- Patch #2: replace the large if-else block in smc_clc_send_confirm_accept()
  with 2 subfunctions;
- Fix missing byte order conversion of GID and token in CLC handshake,
  which is in a separate patch sending to net:
  https://lore.kernel.org/netdev/1701882157-87956-1-git-send-email-guwen@linux.alibaba.com/
- Patch #7: add extended GID in SMC-D lgr netlink attribute;

v3->v2:
- Rename smc_clc_fill_fce as smc_clc_fill_fce_v2x;
- Remove ISM_IDENT_MASK from drivers/s390/net/ism.h;
- Add explicitly assigning 'false' to ism_v2_capable in ism_dev_init();
- Remove smc_ism_set_v2_capable() helper for now, and introduce it in
  later loopback-ism implementation;

v2->v1:
- Fix sparse complaint;
- Rebase to the latest net-next;

Wen Gu (10):
  net/smc: rename some 'fce' to 'fce_v2x' for clarity
  net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
  net/smc: unify the structs of accept or confirm message for v1 and v2
  net/smc: support SMCv2.x supplemental features negotiation
  net/smc: introduce virtual ISM device support feature
  net/smc: define a reserved CHID range for virtual ISM devices
  net/smc: compatible with 128-bits extended GID of virtual ISM device
  net/smc: support extended GID in SMC-D lgr netlink attribute
  net/smc: disable SEID on non-s390 archs where virtual ISM may be used
  net/smc: manage system EID in SMC stack instead of ISM driver

 drivers/s390/net/ism.h        |   7 -
 drivers/s390/net/ism_drv.c    |  57 +++-----
 include/linux/ism.h           |   1 -
 include/net/smc.h             |  16 ++-
 include/uapi/linux/smc.h      |   2 +
 include/uapi/linux/smc_diag.h |   2 +
 net/smc/af_smc.c              | 116 +++++++++------
 net/smc/smc.h                 |  10 +-
 net/smc/smc_clc.c             | 318 +++++++++++++++++++++++++-----------------
 net/smc/smc_clc.h             |  58 ++++----
 net/smc/smc_core.c            |  37 +++--
 net/smc/smc_core.h            |  18 ++-
 net/smc/smc_diag.c            |   9 +-
 net/smc/smc_ism.c             |  50 +++++--
 net/smc/smc_ism.h             |  30 +++-
 net/smc/smc_pnet.c            |   4 +-
 16 files changed, 445 insertions(+), 290 deletions(-)

-- 
1.8.3.1

