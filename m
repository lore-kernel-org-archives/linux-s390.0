From: raspl@linux.vnet.ibm.com
Subject: [PATCH ethtool 0/3] Display adjacent switch port's attributes
Date: Mon, 09 Dec 2013 09:11:40 +0100
Message-ID: <20131209081140.196136547@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ben Hutchings <bhutchings@solarflare.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>
Cc: David Miller <davem@davemloft.net>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

This patch series adds a new option to ethtool to display the adjacent switch
port's attributes, as perceived by the NIC, e.g. through respective LLDP
message exchanges.
A patch for the qeth device driver provides a sample exploiter for the new
functionality.

Best regards,
Stefan Raspl
