Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 25 Jul 2018 22:26:10 -0700 (PDT)
Message-Id: <20180725.222610.2089956256497101095.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/4] net/smc: patches 2018-07-25
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180725143533.7082-1-ubraun@linux.ibm.com>
References: <20180725143533.7082-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Wed, 25 Jul 2018 16:35:29 +0200

> here are 4 more patches for SMC: The first one is just a small
> code cleanup in preparation for patch 2. Patch 2 switches to the
> use of the vlan-gid for VLAN traffic. Patch 3 improves diagnosis
> when creating SMC connections. Patch 4 improves synchronization
> between local and remote link groups.

Series applied.
