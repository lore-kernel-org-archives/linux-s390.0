From: Stefan Raspl <raspl@linux.vnet.ibm.com>
Subject: [PATCH ethtool] Display adjacent switch port's attributes
Date: Wed, 11 Dec 2013 14:32:27 +0100
Message-ID: <1386768748-57530-1-git-send-email-raspl@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: bhutchings@solarflare.com
Cc: davem@davemloft.net, blaschka@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Raspl <raspl@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch adds a new option to ethtool to display the adjacent switch
port's attributes, as perceived by the NIC, e.g. through respective LLDP
message exchanges.

Best regards,
Stefan Raspl

Stefan Raspl (1):
  ethtool: Add option '-q' to display adjacent switch port's attributes

 ethtool-copy.h | 35 ++++++++++++++++++++++++++++++
 ethtool.8.in   |  6 ++++++
 ethtool.c      | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

-- 
1.8.3.4
