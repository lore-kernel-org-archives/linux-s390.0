From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 08 Nov 2018 14:44:35 +0000
Subject: [PATCH 00/23] zfcp updates for v4.21
Message-Id: <20181108144458.29012-1-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

James, Martin,

this is the zfcp patch set for the v4.21 merge window.
The patches apply to Martin's 4.21/scsi-queue
and to James' misc branch.

Patch 1 is a small feature to select DIF only without DIX.

Patches 2-23 are cleanups including resolving new build warnings.

Fedor Loshakov (1):
  zfcp: make DIX experimental, disabled, and independent of DIF

Steffen Maier (21):
  zfcp: move SG table helper from aux to fc and make them static
  zfcp: drop unnecessary forward prototype for struct zfcp_reqlist
  zfcp: move scsi_eh & non-ERP timeout defines owned by and local to
    zfcp_fsf.c
  zfcp: update width in comment for ZFCP_COMMON_FLAGS mask
  zfcp: namespace prefix for internal latency data structures
  zfcp: group sort internal structure definitions for proximity
  zfcp: drop unnecessary forward prototype for struct zfcp_fsf_req
  zfcp: drop duplicate fsf_command from zfcp_fsf_req which is also in
    QTCB header
  zfcp: drop duplicate seq_no from zfcp_fsf_req which is also in QTCB
    header
  zfcp: update kernel message for invalid FCP_CMND length, it's not the
    CDB
  zfcp: ERP thread setup kdoc update
  zfcp: clarify function argument name for trace tag string
  zfcp: the action field of zfcp_erp_action is actually the type
  zfcp: use enum zfcp_erp_steps for struct zfcp_erp_action.step
  zfcp: use enum zfcp_erp_act_result for argument/return of affected
    functions
  zfcp: properly format LUN (and WWPN) for LUN sharing violation kmsg
  zfcp: silence all W=1 build warnings for existing kdoc
  zfcp: silence remaining kdoc warnings in header files
  zfcp: silence -Wimplicit-fallthrough in zfcp_erp_lun_strategy()
  zfcp: drop default switch case which might paper over missing case
  zfcp: drop old default switch case which might paper over missing case

zhong jiang (1):
  zfcp: remove unnecessary null pointer check before mempool_destroy

-- 
2.16.4
