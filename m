From: Joe Perches <joe@perches.com>
Subject: Re: [patch 4/4] s390/net: fix format string mismatches
Date: Wed, 28 May 2014 09:22:31 -0700
Message-ID: <1401294151.19335.6.camel@joe-AO725>
References: <20140528082227.024995099@de.ibm.com>
	 <20140528082239.994360709@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20140528082239.994360709@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>, Toralf Foerster <toralf.foerster@gmx.de>
List-ID: <linux-s390.vger.kernel.org>

Hi Frank:

A trivial note:

On Wed, 2014-05-28 at 10:22 +0200, frank.blaschka@de.ibm.com wrote:

(submitting a patch containing changes like)

+	rc = sscanf(buf, "%u", &bs1);
+	if (rc != 1)
+		goto einval;

All of these single var sscanf uses could be
changed to kstrto<foo>
