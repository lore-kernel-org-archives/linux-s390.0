Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814C8F48;
	Sun, 31 Dec 2023 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cwr6EcAq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704034522; x=1704639322; i=markus.elfring@web.de;
	bh=sPbGqZwafLmtEVIaH8Z0WnNMA+uOieKky2NsYhgEBh0=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=cwr6EcAqvvbLEgTJSCXhxgnhD6vJ3RUoLFFClVCYcn6vPZYrcD99r7om7I9JkfWp
	 gMrG2w2qyZJgj9mnIGzlNFX/zWPzNc2T58oz7yXm9BeA7skKbGm+INo2UlleT3Ebc
	 yk0ztsK32Ocgjc6lcjTM+6Zz8AEeozL6nKxULQuYjDf2DiWOB0s+YbF4JDmA2JCJv
	 yjtmxv2HNpCrjhlHrfNxt2vbtHW3W2IU4oircNaQ8fyZy/izmol7usaEgvhLKMZRa
	 7P5GXKBj8yW/XzJhGkFzts14YX23IKxWZin+9XAeOHQUINDsjCu8OAgcmiuXw3tyK
	 WPb4pFaPtgZdMn9mBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1rTcPH3FjR-00A8yI; Sun, 31
 Dec 2023 15:55:22 +0100
Message-ID: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
Date: Sun, 31 Dec 2023 15:55:15 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] net/smc: Adjustments for two function implementations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fMt6aL0td+jOUlHgZcHRKvPvhNP4ynrk9DKe8/vJO8JS/KSguym
 6TSeU5vmD19bWtL9VmfNaKA1betfa4Bg58SwJWaDfdkpIcqGG7OxvH5IbzgY8bBs7fJbfK+
 KJZymviWlFgRVJfnRRBJjnrXeSOgNF+3ue0/FkUpkgRJnG/OwsbIKk4fvIgFH/+zJ/iQl7b
 bOuYR9PNRxaWB/ROPcN0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1PMvN/iqWjE=;s/6PrCzXY3EPFFVTSdcrWeBOscN
 CuC69C1DSZwbuqkBSCPyQq3G6gWp1oB4BnJF07e19TKtVdqoUT7JgUQtmBrZXGNFs80CdGW+2
 OBBVE/YYLzYlcagERj/5R/JsW8zaE+Z2rROHkfaLW7mX5aRx8VqiQO7GpSvqzp1+lnsQ37LG+
 yTuApcsLyYeRxKUIfyGJtp19Od0bCyD+XnhhwamR5BlJif+r2mO/Dhd3GJh/afcfwpHPchuEs
 9Zw+6ug8qV1WcIJ5TVEM3Is0896mr7hv1yd6NDbqbXTXc6y5YH4PTKyqEIMNjS1AXHdXSWcbd
 sh4ndH1DBdr55VCkgVpyREKtsakhLLRotCttmo4l9ZNM6rbAAqEyv3uCYu+yBAhNoQMaENifE
 ostOhqHAWlRfoiISU9X5m7LvgBltcxpld220PDY9l8n9EJO3kSahE+RFnuv12eNoHWOLyOm/Q
 Qq/ENtmvn4M+rxOf8bIo8LU73i2hSdpvFHUg5X8DNQqGvqlh9fVYDKYJ7i3oGHOGtIUY8UsVc
 6DZ5xE0nHZhcUNHW6FzP4LIlHigVCNcy6dv3zC2eqFGnxgZYVnsnrRpngTK1bASMeC3KPUz+f
 hAipBB9+34c0sigPVbc++a1WRLhheVWVY4IjEgrPEubwzPK61+43g9oEL4TXDxA/2leojlEIS
 wD5RRqG5PgmBUe1qouie9AQc5ZylADqosVIq9ykt1Q5DL8yCr2RhwKu2AOowzidPPAI07/+iZ
 1geYmKzVIFCccsxw8Od64qgW98LwLz4kDBHYhKtVdWP4N5AjTa/ErRlaHl+GXgOcsHN9Fc3ql
 Q3wbLJcresGU1Zmb5nIBkWUkOBJFewr3zrDpUjp/oyEl73iHOPLCaDAMjP30XX8uEr3ywkSs3
 1q/wC/iPaS0G2uhVQEjLHjbXoC7U/hN/8khP/ZTwNz59j1Hw8bgt2mu7iZ2rtppi/Nc2cl6IM
 gfn9ZXdJp2aj8XI8ctId8endSuU=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 15:48:45 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Return directly after a failed kzalloc() in smc_fill_gid_list()
  Improve exception handling in smc_llc_cli_add_link_invite()

 net/smc/af_smc.c  |  2 +-
 net/smc/smc_llc.c | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

=2D-
2.43.0

