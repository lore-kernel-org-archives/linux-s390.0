Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F479DB;
	Tue,  2 Jan 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VzpAqHk_1704185086;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VzpAqHk_1704185086)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 16:44:46 +0800
Date: Tue, 2 Jan 2024 16:44:45 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH 0/2] net/smc: Adjustments for two function implementations
Message-ID: <ZZPM_bOQrRt0gaMa@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
 <93033352-4b9c-bf52-1920-6ccf07926a21@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93033352-4b9c-bf52-1920-6ccf07926a21@linux.alibaba.com>

On Tue, Jan 02, 2024 at 04:13:09PM +0800, Wen Gu wrote:
> 
> 
> On 2023/12/31 22:55, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 31 Dec 2023 15:48:45 +0100
> > 
> > A few update suggestions were taken into account
> > from static source code analysis.
> > 
> > Markus Elfring (2):
> >    Return directly after a failed kzalloc() in smc_fill_gid_list()
> >    Improve exception handling in smc_llc_cli_add_link_invite()
> > 
> >   net/smc/af_smc.c  |  2 +-
> >   net/smc/smc_llc.c | 15 +++++++--------
> >   2 files changed, 8 insertions(+), 9 deletions(-)
> > 
> > --
> > 2.43.0
> 
> Hi Markus. I see you want to fix the kfree(NULL) issues in these two patches.
> 
> But I am wondering if this is necessary, since kfree() can handle NULL correctly.

I think the key point is that there are no necessary to call kfree() if
we can avoid this in normal logic.

Tony Lu
