Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbhAFNqA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Jan 2021 08:46:00 -0500
Date: Wed, 6 Jan 2021 15:45:16 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [RFC PATCH v2 net-next 00/12] Make .ndo_get_stats64 sleepable
Message-ID: <20210106134516.jnh2b5p5oww4cghz@skbuf>
References: <20210105185902.3922928-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105185902.3922928-1-olteanv@gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Benc <jbenc@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet <edumazet@google.com>, George McCollister <george.mccollister@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Jay Vosburgh <j.vosburgh@gmail.com>, Veaceslav Falico <vfalico@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Taehee Yoo <ap420073@gmail.com>, Jiri Pirko <jiri@mellanox.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>, Paolo Abeni <pabeni@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Florian Westphal <fw@strlen.de>, linux-s390@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-parisc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, dev@openvswitch.org

On Tue, Jan 05, 2021 at 08:58:50PM +0200, Vladimir Oltean wrote:
> This is marked as Request For Comments for a reason.

If nobody has any objections, I will remove the memory leaks I
introduced to check if anybody is paying attention, and I will resubmit
this as a non-RFC series.
