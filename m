Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sun, 7 Oct 2018 18:34:57 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
Subject: [RFC PATCH net 0/3] net/smc: move some definitions to UAPI
Message-ID: <cover.1538929504.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Hans Wippel <hwippel@linux.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello.

As of now, it's a bit difficult to use SMC protocol, as significant part
of definitions related to it are defined in private headers and are not
part of UAPI. The following commits move some definitions to UAPI,
making them readily available to user space.


Eugene Syromiatnikov (3):
  uapi, net/smc: move protocol constant definitions to UAPI
  uapi, net/smc: provide fallback diagnosis codes in UAPI
  uapi, net/smc: provide socket state constants in UAPI

 include/uapi/linux/smc.h      | 26 +++++++++++++++++++++++++-
 include/uapi/linux/smc_diag.h | 17 +++++++++++++++++
 net/smc/smc.h                 | 22 ++--------------------
 net/smc/smc_clc.h             | 16 ----------------
 4 files changed, 44 insertions(+), 37 deletions(-)

-- 
2.1.4
