From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 1/7] s390: ungrouping a device must not be interruptible
Date: Fri, 31 Aug 2007 06:55:09 -0400
Message-ID: <46D7F38D.6010500@pobox.com>
References: <20070829092651.411517000@linux.vnet.ibm.com> <20070829101843.286542000@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20070829101843.286542000@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ursula Braun <braunu@de.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, frank.blaschka@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Applied patches 1-7, after changing the prefix back to "qeth: "

"s390: " prefix should be applied to changes that affect S/390 
architecture platform in general.

This was a patchset specific to a single driver, thus the "qeth: " 
prefix is more informative when looking at a long list of one-line 
change summaries.
